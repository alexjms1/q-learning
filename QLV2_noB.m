function negLL  = QLV2_noB( alphaG, alphaL,  choices, rewards )
% q learning algorith with seperate alphas for gains and losses
negLL=0;
numStimuli = 4;
numTrials = length(choices);
%Qrecord = zeros(numTrials,numStimuli);
Qvalues = zeros(1,numStimuli);
alpha = [alphaL alphaG];

for i=1:numTrials
    Qvalues(choices(i)) = Qvalues(choices(i)) + alpha(rewards(i)+1)*(rewards(i)-Qvalues(choices(i)));
    %Qrecord(i,:) = Qvalues;
    if choices(i) < 3
        prob = exp(Qvalues(choices(i))) / (exp(Qvalues(1)) + exp(Qvalues(2)));
    else
        prob = exp(Qvalues(choices(i))) / (exp(Qvalues(3)) + exp(Qvalues(4)));
    end
    negLL = negLL + log(prob);  
end
negLL=-1 * negLL;
end