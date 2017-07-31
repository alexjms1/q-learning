%Program for importing and analyzing data from the multi-stage decision
%making task
%Author: Stephanie Groman, December 2013

[num, text]=xlsread(fName);
[m,n]=size(num);
for j=1:n
    subject(j)=num(1,j);
    box(j)=num(7,j);
    program(j)=text(2,j+1);
    date(j)=num(3,j);
    experiment(j)=text(5,j+1);
    group(j)=num(6,j);

    NPChoice(:,j)=num(19:218,j);
    NPPresented(:,j)=num(221:420,j);
    NP1_ReinfProb(:,j)=num(422,j);
    NP2_ReinfProb(:,j)=num(423,j);
    NP4_ReinfProb(:,j)=num(424,j);
    NP5_ReinfProb(:,j)=num(425,j);
    
    HighReinfLever(:,j)=num(1443,j); 
    LeverPresented(:,j)=num(831:1030,j);
    LeverChoice(:,j)=num(1444:1643,j);
    
    RewardDelivery(:,j)=num(629:828,j);
     
    TrialStartTime(:,j)=num(1646:1845,j);
    RewRetrievalLatency(:,j)=num(1848:2047,j);
    LeverPressLatency(:,j)=num(2050:2249,j);
    NosepokeLatency(:,j)=num(2252:2451,j);
    TrialInitiationLatency(:,j)=num(2656:2855,j);

    NumTrials(:,j)=num(2454,j);
    NumofMagOmissions(:,j)=num(2482,j);
    NumofLeverOmissions(:,j)=num(2484,j);
    NumofNPOmissions(:,j)=num(2483,j);
    NumofNP1Errors(:,j)=num(2493,j);
    NumofNP2Errors(:,j)=num(2494,j);
    NumofNP3Errors(:,j)=num(2495,j);
    NumofNP4Errors(:,j)=num(2496,j);
    NumofNP5Errors(:,j)=num(2497,j);
    
    %Determine which trials the subjects made a correct choice (i.e. didn't
    %pick a nosport that wasn't an option)
    for i=1:NumTrials-1
        if NPPresented(i,j)>13 & (NPChoice(i,j)==4 | NPChoice(i,j)==5)
            CorChoiceTrials(i,j)=1; IncorChoiceTrials(i,j)=0;
        elseif (NPPresented(i,j)<13 & NPPresented(i,j)>6)  & (NPChoice(i,j)==1 | NPChoice(i,j)==2)
            CorChoiceTrials(i,j)=1; IncorChoiceTrials(i,j)=0;
        elseif NPPresented(i,j)==1 | NPPresented(i,j)==2 | NPPresented(i,j)==4 | NPPresented(i,j)==5;
            if NPChoice(i,j)==NPPresented(i,j);
                CorForcedTrials(i,j)=1; IncorForcedTrials(i,j)=0; CorChoiceTrials(i,j)=0; IncorChoiceTrials(i,j)=0; 
            else
                CorForcedTrials(i,j)=0; IncorForcedTrials(i,j)=1; CorChoiceTrials(i,j)=0; IncorChoiceTrials(i,j)=0;
            end
        elseif NPPresented(i,j)>6 & NPChoice(i,j)>0
            CorChoiceTrials(i,j)=0; IncorChoiceTrials(i,j)=1;
        else
            CorChoiceTrials(i,j)=NaN; IncorChoiceTrials(i,j)=NaN; 
        end
    end
    
    CorNPChoice(:,j)=NPChoice(:,j).*(CorChoiceTrials(:,j));
    CorLeverChoice(:,j)=LeverChoice(:,j).*(CorChoiceTrials(:,j)); 
    
    %Create a data matrix for computational analysis
    %datx(1,:) = LeverPresented(:); 
    %datx(2,:) = LeverChoice(:);
    %datx(3,:) = NPPresented(:); 
    %datx(4,:) = NPChoice(:); 
    %datx(5,:) = RewardDelivery(:); 
    %datx(6,1) = HighestReinfLever; datx(6,2) = NP1ReinfProb; datx(6,3) =
    %NP2ReinfProb; datx(6,4) = NP4ReinfProb; datx(6,5) = NP5ReinfProb
          
    data=[LeverPresented(:,j)'; CorLeverChoice(:,j)'; NPPresented(:,j)'; CorNPChoice(:,j)'; RewardDelivery(:,j)']; 
    data(6,1) = HighReinfLever(1,j); data(6,2) = NP1_ReinfProb(1,j); data(6,3) = NP2_ReinfProb(1,j); 
    data(6,4) = NP4_ReinfProb(1,j); data(6,5) = NP5_ReinfProb(1,j); 
    
    maxit=300000;
    maxeval=300000;
    maxlike=30; % number of searches
        
    op=optimset('fminsearch');
    op.MaxIter=maxit;
    op.MaxFunEvals=maxeval;
    op.TolX=1e-10;
    op.TolFun=1e-10;
    %op.Display='iter'; 
    
    mlik=-1;
    xpar_f2 = [];
    like_f2 = 0;
    LBnd=[0,0,0,0,0,0,0,-inf]; 
    UBnd=[+inf,+inf,1,1,1,1,1,+inf]; 
    for klike=1:maxlike,
        ipar=rand(1,8);
        [xpar like exitflag output]=fminsearchbnd(@DAW_MFMB_Model_032014,ipar,LBnd, UBnd, op, data);
        if mlik<0 | like<mlik,
            mlik=like;
            xpar_f2=xpar;
            like_f2=like;
        end;
    end;
    params(1:length(ipar),j) = xpar_f2';
    like_all(1,j) = like_f2;
    params(length(ipar)+1,j) = 2*length(ipar) + 2*like_all(1,j);
    params(length(ipar)+2,j) = 2*like_all(1,j) + length(ipar)*log(NumTrials(1,j)-1);
    
    %We have the lever and noseport choice probabilities determined by the computational
    %model. Determine the actual choice probabilities to compare how SARSA
    %algorithm actually fits the data in 20 trial bins
    
    for i=1:NumTrials-22
            Rat_pNP1(i,j)=(sum(data(4, i:i+20)==1))/(sum(data(3,i:i+20)==12));
            Rat_pNP2(i,j)=(sum(data(4, i:i+20)==2))/(sum(data(3,i:i+20)==12));
            Rat_pNP4(i,j)=(sum(data(4, i:i+20)==4))/(sum(data(3,i:i+20)==45));
            Rat_pNP5(i,j)=(sum(data(4, i:i+20)==5))/(sum(data(3,i:i+20)==45));
            Rat_pLeft(i,j)=(sum(data(2,i:i+20)==1))/(sum(data(1,i:i+20)==12));
            Rat_pRight(i,j)=(sum(data(2,i:i+20)==2))/(sum(data(1,i:i+20)==12));
        
    
            Mat_pS1A1(i,j)=mean(p_S1A1(1,i:i+20)); 
            Mat_pS1A2(i,j)=mean(p_S1A2(1,i:i+20)); 
            Mat_pS2A1(i,j)=mean(p_S2A1(1,i:i+20)); 
            Mat_pS2A2(i,j)=mean(p_S2A2(1,i:i+20)); 
            Mat_pS2B1(i,j)=mean(p_S2B1(1,i:i+20)); 
            Mat_pS2B2(i,j)=mean(p_S2B2(1,i:i+20)); 
            
            Trans_pS1A1S2A(i,j)=(sum((data(2,i:i+20)==1)&(data(3,i:i+20)==12)))/(sum((data(2,i:i+20)==1)&(data(3,i:i+20)==12))+sum((data(2,i:i+20)==1)&(data(3,i:i+20)==45))); 
            Trans_pS1A1S2B(i,j)=(sum((data(2,i:i+20)==1)&(data(3,i:i+20)==45)))/(sum((data(2,i:i+20)==1)&(data(3,i:i+20)==12))+sum((data(2,i:i+20)==1)&(data(3,i:i+20)==45)));
            Trans_pS1A2S2A(i,j)=(sum((data(2,i:i+20)==2)&(data(3,i:i+20)==12)))/(sum((data(2,i:i+20)==2)&(data(3,i:i+20)==12))+sum((data(2,i:i+20)==2)&(data(3,i:i+20)==45)));
            Trans_pS1A2S2B(i,j)=(sum((data(2,i:i+20)==2)&(data(3,i:i+20)==45)))/(sum((data(2,i:i+20)==2)&(data(3,i:i+20)==12))+sum((data(2,i:i+20)==2)&(data(3,i:i+20)==45)));
    end
    
    figure(1) 
    plot(Rat_pNP1(:,j),'r'); hold on; plot(Mat_pS2A1(:,j)); 
    figure(2)
    plot(Rat_pNP2(:,j),'r'); hold on; plot(Mat_pS2A2(:,j)); 
    figure(3)
    plot(Rat_pNP4(:,j),'r'); hold on; plot(Mat_pS2B1(:,j)); 
    figure(4)
    plot(Rat_pNP5(:,j),'r'); hold on; plot(Mat_pS2B2(:,j)); 
    
    figure(5) 
    plot(Rat_pLeft(:,j),'r'); hold on; plot(Mat_pS1A1(:,j)); 
    figure(6)
    plot(Rat_pRight(:,j),'r'); hold on; plot(Mat_pS1A2(:,j)); 
end
    
            
    
    