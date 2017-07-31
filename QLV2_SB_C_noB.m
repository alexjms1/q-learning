
function negLL  = QLV2_SB_C_noB( alphaG, alphaL, c, choices, rewards)

%Qrecord = zeros(numTrials,numStimuli);Qvalues = zeros(1,numStimuli);
alpha = [alphaL alphaG];
Cvalues = zeros(1,numStimuli);


for i=1:numTrials
    Qvalues(choices(i)) = Qvalues(choices(i)) + alpha(rewards(i)+1)*(rewards(i)-Qvalues(choices(i)));
      Cvalues(choices(i)) = Cvalues(choices(i)) + c*(rewards(i)-Cvalues(choices(i)));
    %Qrecord(i,:) = Qvalues;
    if choices(i) < 3
        prob = exp(Qvalues(choices(i))*c) / (exp(Qvalues(1)*c) + exp(Qvalues(2)*beta));
    else
        prob = exp(Qvalues(choices(i))*c) / (exp(Qvalues(3)*beta) + exp(Qvalues(4)*beta));
    end
    negLL = negLL + log(prob);  
end
negLL=-1 * negLL;
end