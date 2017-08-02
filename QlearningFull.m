function negLL  = QlearningFull( alphaG, alphaL, beta, choices, rewards )
% q learning algorith with seperate alphas (learning rates) for gains and
% losses (rewards and absense of rewards).  Assumes 2 sets of stimuli are
% presented (AB & CD). Q values for all stimuli start at 0.
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
        prob = exp(Qvalues(choices(i))*beta) / (exp(Qvalues(1)*beta) + exp(Qvalues(2)*beta));
    else
        prob = exp(Qvalues(choices(i))*beta) / (exp(Qvalues(3)*beta) + exp(Qvalues(4)*beta));
    end
    negLL = negLL + log(prob);  
end
negLL=-1 * negLL;
end