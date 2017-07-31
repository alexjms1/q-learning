function loglike = DAW_MFMB_Model_032014(beta1, beta2, alpha1, alpha2, lambda, epsilon, omega, rho,data) 

%datx(1,:) = State one option (LeverPresented(:) 
%datx(2,:) = State one choice (LeverChoice(:))
%datx(3,:) = State two option (NPPresented(:)) 
%datx(4,:) = State two choice (NPChoice(:)) 
%datx(5,:) = Reward from state two action (RewardDelivery(:)) 
%datx(6,1) = HighestReinfLever datx(6,2) = NP1ReinfProb datx(6,3) =
%NP2ReinfProb datx(6,4) = NP4ReinfProb datx(6,5) = NP5ReinfProb

%beta1 = params(1);      %inverse temperature for State 1
%beta2 = params(2);      %inverse temperature for State 2 (noseports 1 and 2)
%alpha1 = params(3);     %learning rate for State 1 (S1) - lever
%alpha2 = params(4);     %learning rate for State 2 (S2) - noseports 1 and 2
%lambda = params(5);     %Eligibility trace for State 1
%epsilon = params(6);    %Learning rate for transition probabilities
%omega = params(7);      %Mf/Mb ratio (omega-->1, greater MB learning; omega--->0, greater MF learning)
%rho = params(8);       %Perseveration/Switching parameter

NumTrials=length(data(2,:));

QTD_S1A1 = 0; p_QTDS1A1=[];
QTD_S1A2 = 0; p_QTDS1A2=[];
QTD_S2A1 = 0; p_S2A1=[]; 
QTD_S2A2 = 0; p_S2A2=[];
QTD_S2B1 = 0; p_S2B1=[]; 
QTD_S2B2 = 0; p_S2B2=[];
T_S1A1S2A = 0; p_S1A1S2A=[]; 
T_S1A1S2B = 0; p_S1A1S2B=[]; 
T_S1A2S2A = 0; p_S1A2S2A=[];
T_S1A2S2B = 0; p_S1A2S2B=[]; 
QNET_S1A1 = 0; p_S1A1=[];
QNET_S1A2 = 0; p_S1A2=[];
QNET_S2A1 = 0; p_S2A1=[]; 
QNET_S2A2 = 0; p_S2A2=[];
QNET_S2B1 = 0; p_S2B1=[]; 
QNET_S2B2 = 0; p_S2B2=[]; 
QMB_S1A1 = 0; p_QMBS1A1=[]; 
QMB_S1A2 = 0; p_QMBS1A2=[];  

loglike = 0; 
index = 1; 

for t=1:NumTrials-1 
    
    if t==NumTrials
        index=index + 1;        
    end
    
    if t>1
        if data(2,t)==data(2,t-1); a=1;
        else a=0; 
        end
    else
        a=0; 
    end
    
    p_S1A1(t) = exp(beta1*(QNET_S1A1 + rho*a))/(exp(beta1*(QNET_S1A1 + rho*a)) + exp(beta1*(QNET_S1A2 + rho*a))); 
    p_S1A2(t) = exp(beta1*(QNET_S1A2 + rho*a))/(exp(beta1*(QNET_S1A1 + rho*a)) + exp(beta1*(QNET_S1A2 + rho*a)));
    p_S2A1(t) = exp(beta2*(QTD_S2A1))/(exp(beta2*(QTD_S2A1)) + exp(beta2*(QTD_S2A2))); 
    p_S2A2(t) = exp(beta2*(QTD_S2A2))/(exp(beta2*(QTD_S2A1)) + exp(beta2*(QTD_S2A2)));
    p_S2B1(t) = exp(beta2*(QTD_S2B1))/(exp(beta2*(QTD_S2B1)) + exp(beta2*(QTD_S2B2))); 
    p_S2B2(t) = exp(beta2*(QTD_S2B2))/(exp(beta2*(QTD_S2B1)) + exp(beta2*(QTD_S2B2)));
    p_S1A1S2A(t) = exp(T_S1A1S2A)/(exp(T_S1A1S2A) + exp(T_S1A1S2B)); 
    p_S1A1S2B(t) = exp(T_S1A1S2B)/(exp(T_S1A1S2A) + exp(T_S1A1S2B)); 
    p_S1A2S2A(t) = exp(T_S1A2S2A)/(exp(T_S1A2S2A) + exp(T_S1A2S2B)); 
    p_S1A2S2B(t) = exp(T_S1A2S2B)/(exp(T_S1A2S2A) + exp(T_S1A2S2B));
           
    if data(1,t)>0
        if data(2,t)>0 & data(4,t)>0
            if data(2,t)==1,   
                if data(3,t)==12 || data(3,t)==1 || data(3,t)==2
                    if data(4,t)==1, loglike = loglike - log(p_S1A1(t)) - log(p_S2A1(t));  
                    elseif data(4,t)==2, loglike = loglike - log(p_S1A1(t)) -  log(p_S2A2(t)); 
                    end
                elseif data(3,t)==45 || data(3,t)==4 || data(3,t)==5
                    if data(4,t)==4, loglike = loglike - log(p_S1A1(t)) - log(p_S2B1(t));  
                    elseif data(4,t)==5 loglike = loglike - log(p_S1A1(t)) - log(p_S2B2(t)); 
                    end
                end
            else 
                if data(3,t)==12 || data(3,t)==1 || data(3,t)==2
                    if data(4,t)==1, loglike = loglike - log(p_S1A2(t)) - log(p_S2A1(t)); 
                    elseif data(4,t)==2, loglike = loglike - log(p_S1A2(t)) - log(p_S2A2(t)); 
                    end
                elseif data(3,t)==45 || data(3,t)==4 || data(3,t)==5
                    if data(4,t)==4, loglike = loglike - log(p_S1A2(t)) - log(p_S2B1(t)); 
                    elseif data(4,t)==5, loglike = loglike - log(p_S1A2(t)) - log(p_S2B2(t));
                    end
                end
            end
       end 
    end
    
     if data(2,t)>0 & data(4,t)>0 %trial was not omitted
        if data(2,t)==1 %rat made a left lever response
            if data(3,t)==12 || data(3,t)==1 || data(3,t)==2 %Noseports #1 and #2 were illuminated
                T_S1A1S2A = T_S1A1S2A + epsilon*(1 - T_S1A1S2A); %updating the transition matrix
                T_S1A1S2B = T_S1A1S2B*(1 - epsilon);                
                if data(4,t)==1 %Noseport 1 was chosen
                    QTD_S1A1 = QTD_S1A1 + alpha1*(QTD_S2A1 - QTD_S1A1); %Updating the QTD for state 1
                    QTD_S1A1 = QTD_S1A1 + alpha1*lambda*(data(5,t) - QTD_S2A1); %Applying eligibility trace to state 1
                    QTD_S2A1 = QTD_S2A1 + alpha2*(data(5,t) - QTD_S2A1); %Updating the QTD for state 2
                                                          
                    QMB_S1A1 = p_S1A1S2A(t)*max(QTD_S2A1,QTD_S2A2) + p_S1A1S2B(t)*max(QTD_S2B1,QTD_S2B2); %Updating the QMB for state 1
                                        
                    QNET_S1A1 = omega*QMB_S1A1 + (1 - omega)*QTD_S1A1; %Updating the QNET for state 1 (combining QTD and QMB)
                                    
                else %Noseport 2 was chosen
                    QTD_S1A1 = QTD_S1A1 + alpha1*(QTD_S2A2 - QTD_S1A1); %Updating the QTD for state 1
                    QTD_S1A1 = QTD_S1A1 + alpha1*lambda*(data(5,t) - QTD_S2A2); %Applying eligibility trace to state 1
                    QTD_S2A2 = QTD_S2A2 + alpha2*(data(5,t) - QTD_S2A2); %Updating the QTD for state 2                   
                                                            
                    QMB_S1A1 = p_S1A1S2A(t)*max(QTD_S2A1,QTD_S2A2) + p_S1A1S2B(t)*max(QTD_S2B1,QTD_S2B2); %Updating the QMB for state 1
                                        
                    QNET_S1A1 = omega*QMB_S1A1 + (1 - omega)*QTD_S1A1; %Updating the QNET for state 1 (combining QTD and QMB)
                                                          
                end
                
            elseif data(3,t)==45 || data(3,t)==4 || data(3,t)==5
                T_S1A1S2B = T_S1A1S2B + epsilon*(1 - T_S1A1S2B);%updating the transition matrix
                T_S1A1S2A = T_S1A1S2A*(1 - epsilon); 
                
                if data(4,t)==4 %Noseport 4 was chosen
                    QTD_S1A1 = QTD_S1A1 + alpha1*(QTD_S2B1 - QTD_S1A1); %Updating the QTD for state 1
                    QTD_S1A1 = QTD_S1A1 + alpha1*lambda*(data(5,t) - QTD_S2B1); %Applying eligibility trace to state 1
                    QTD_S2B1 = QTD_S2B1 + alpha2*(data(5,t) - QTD_S2B1);  %Updating the QTD for state 2                   
                                                           
                    QMB_S1A1 = p_S1A1S2A(t)*max(QTD_S2A1,QTD_S2A2) + p_S1A1S2B(t)*max(QTD_S2B1,QTD_S2B2); %Updating the QMB for state 1
                                        
                    QNET_S1A1 = omega*QMB_S1A1 + (1 - omega)*QTD_S1A1; %Updating the QNET for state 1 (combining QTD and QMB)
                                       
                elseif data(4,t)==5 %Noseport 5 was chosen
                    QTD_S1A1 = QTD_S1A1 + alpha1*(QTD_S2B2 - QTD_S1A1); %Updating the QTD for state 1
                    QTD_S1A1 = QTD_S1A1 + alpha1*lambda*(data(5,t) - QTD_S2B2); %Applying eligibility trace to state 1
                    QTD_S2B2 = QTD_S2B2 + alpha2*(data(5,t) - QTD_S2B2); %Updating the QTD for state 2                   
                                        
                    QMB_S1A1 = p_S1A1S2A(t)*max(QTD_S2A1,QTD_S2A2) + p_S1A1S2B(t)*max(QTD_S2B1,QTD_S2B2); %Updating the QMB for state 1
                                        
                    QNET_S1A1 = omega*QMB_S1A1 + (1 - omega)*QTD_S1A1; %Updating the QNET for state 1 (combining QTD and QMB)
                                                            
                end
            end
        elseif data(2,t)==2 %%rat made a left lever response
            if data(3,t)==12 || data(3,t)==1 || data(3,t)==2 %Noseports #1 and #2 were illuminated
                T_S1A2S2A = T_S1A2S2A + epsilon*(1 - T_S1A2S2A);%updating the transition matrix
                T_S1A2S2B = T_S1A2S2B*(1 - epsilon); 
                
                if data(4,t)==1 %Noseport 1 was chosen
                    QTD_S1A2 = QTD_S1A2 + alpha1*(QTD_S2A1 - QTD_S1A2);%Updating the QTD for state 1 
                    QTD_S1A2 = QTD_S1A2 + alpha1*lambda*(data(5,t) - QTD_S2A1); %Applying eligibility trace to state 1
                    QTD_S2A1 = QTD_S2A1 + alpha2*(data(5,t) - QTD_S2A1); %Updating the QTD for state 2                     
                                                            
                    QMB_S1A2 = p_S1A2S2A(t)*max(QTD_S2A1,QTD_S2A2) + p_S1A2S2B(t)*max(QTD_S2B1,QTD_S2B2);  %Updating the QMB for state 1
                                        
                    QNET_S1A2 = omega*QMB_S1A2 + (1 - omega)*QTD_S1A2; %Updating the QNET for state 1 (combining QTD and QMB)
                                                            
                elseif data (4,t)==2 %Noseport 2 was chosen
                    QTD_S1A2 = QTD_S1A2 + alpha1*(QTD_S2A2 - QTD_S1A2); %Updating the QTD for state 1  
                    QTD_S1A2 = QTD_S1A2 + alpha1*lambda*(data(5,t) - QTD_S2A2); %Applying eligibility trace to state 1
                    QTD_S2A2 = QTD_S2A2 + alpha2*(data(5,t) - QTD_S2A2); %Updating the QTD for state 2
                                                    
                    QMB_S1A2 = p_S1A2S2A(t)*max(QTD_S2A1,QTD_S2A2) + p_S1A2S2B(t)*max(QTD_S2B1,QTD_S2B2); %Updating the QMB for state 1
                                        
                    QNET_S1A2 = omega*QMB_S1A2 + (1 - omega)*QTD_S1A2; %Updating the QNET for state 1 (combining QTD and QMB)
                                                            
                end
            elseif data(3,t)==45 || data(3,t)==4 || data(3,t)==5 %Noseports #4 and #5 were illuminated
                T_S1A2S2B = T_S1A2S2B + epsilon*(1 - T_S1A2S2B);%updating the transition matrix
                T_S1A2S2A = T_S1A2S2A*(1 - epsilon); 
                
                if data(4,t)==4 %Noseport 4 was chosen
                    QTD_S1A2 = QTD_S1A2 + alpha1*(QTD_S2B1 - QTD_S1A2); %Updating the QTD for state 1 
                    QTD_S1A2 = QTD_S1A2 + alpha1*lambda*(data(5,t) - QTD_S2B1); %Applying eligibility trace to state 1
                    QTD_S2B1 = QTD_S2B1 + alpha2*(data(5,t) - QTD_S2B1); %Updating the QTD for state 2   
                                                                                
                    QMB_S1A2 = p_S1A2S2A(t)*max(QTD_S2A1,QTD_S2A2) + p_S1A2S2B(t)*max(QTD_S2B1,QTD_S2B2); %Updating the QMB for state 1
                                        
                    QNET_S1A2 = omega*QMB_S1A2 + (1 - omega)*QTD_S1A2; %Updating the QNET for state 1 (combining QTD and QMB)
                                                            
                elseif data(4,t)==5 %Noseport 5 was chosen
                    QTD_S1A2 = QTD_S1A2 + alpha1*(QTD_S2B2 - QTD_S1A2); %Updating the QTD for state 1 
                    QTD_S1A2 = QTD_S1A2 + alpha1*lambda*(data(5,t) - QTD_S2B2); %Applying eligibility trace to state 1
                    QTD_S2B2 = QTD_S2B2 + alpha2*(data(5,t) - QTD_S2B2); %Updating the QTD for state 2 
                                                            
                    QMB_S1A2 = p_S1A2S2A(t)*max(QTD_S2A1,QTD_S2A2) + p_S1A2S2B(t)*max(QTD_S2B1,QTD_S2B2); %Updating the QMB for state 1
                                        
                    QNET_S1A2 = omega*QMB_S1A2 + (1 - omega)*QTD_S1A2; %Updating the QNET for state 1 (combining QTD and QMB)
                                        
                end
            end
        end       
     end
end
assignin('base','p_S1A1',p_S1A1); 
assignin('base','p_S1A2',p_S1A2); 
assignin('base','p_S2A1',p_S2A1); 
assignin('base','p_S2A2',p_S2A2); 
assignin('base','p_S2B1',p_S2B1); 
assignin('base','p_S2B2',p_S2B2); 
assignin('base','p_S1A1S2A',p_S1A1S2A); 
assignin('base','p_S1A1S2B',p_S1A1S2B);
assignin('base','p_S1A2S2A',p_S1A2S2A);
assignin('base','p_S1A2S2B',p_S1A2S2B);
assignin('base','T_S1A1S2A',T_S1A1S2A); 
assignin('base','T_S1A1S2B',T_S1A1S2B); 
assignin('base','T_S1A2S2A',T_S1A2S2A); 
assignin('base','T_S1A2S2B',T_S1A2S2B); 




    

