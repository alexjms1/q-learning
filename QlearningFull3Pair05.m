function [ negLL, Qvalues, probs ] = QlearningFull3Pair05( alphaG, alphaL, beta, choices, rewards )
% q learning algorith with seperate alphas (learning rates) for gains and
% losses (rewards and absense of rewards).  Assumes 2 sets of stimuli are
% presented (AB & CD & EF).  Initializes Q values for stimuli at 0.5 for
% all stimuli.
negLL=0;
numStimuli=6;
numTrials = length(choices);
%Qrecord = zeros(numTrials,numStimuli);
Qvalues = [.5 .5 .5 .5 .5 .5];
alpha = [alphaL alphaG];

for i=1:numTrials
    Qvalues(choices(i)) = Qvalues(choices(i)) + alpha(rewards(i)+1)*(rewards(i)-Qvalues(choices(i)));
    %Qrecord(i,:) = Qvalues;
    if choices(i) < 3
        prob = exp(Qvalues(choices(i))/beta) / (exp(Qvalues(1)/beta) + exp(Qvalues(2)/beta));
    elseif choices(i) < 5
        prob = exp(Qvalues(choices(i))/beta) / (exp(Qvalues(3)/beta) + exp(Qvalues(4)/beta));
    else
        prob = exp(Qvalues(choices(i))/beta) / (exp(Qvalues(5)/beta) + exp(Qvalues(6)/beta));
    end
    negLL = negLL + log(prob);  
end
negLL=-1 * negLL;
end