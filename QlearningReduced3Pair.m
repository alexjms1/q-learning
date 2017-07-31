function [ negLL, Qvalues, probs ] = QlearningReduced3Pair(alpha, beta, choices, rewards )
% q learning algorith with one alpha for gains and losses
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