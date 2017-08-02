function [ negLL, Qvalues, probs ] = QlearningReduced3Pair(alpha, beta, choices, rewards )
% q learning algorith with a single alpha (learning rate) for gains and
% losses (rewards and absense of rewards).  Assumes 3 sets of stimuli are
% presented (AB & CD & EF). Q values for all stimuli start at 0.
negLL=0;
numStimuli=4;
numTrials = length(choices);
%Qrecord = zeros(numTrials,numStimuli);
Qvalues = zeros(1,numStimuli);


for i=1:numTrials
    Qvalues(choices(i)) = Qvalues(choices(i)) + alpha*(rewards(i)-Qvalues(choices(i)));
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