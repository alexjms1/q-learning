function negLL  = QLV2_SB_C_1A_noB( alpha, beta, c, choices, rewards )
% q learning algorith with seperate alphas for gains and losses
negLL=0;
numStimuli = 4;
numTrials = length(choices);
Qvalues = zeros(1,numStimuli);
Cvalues = zeros(1,numStimuli);

for i=1:numTrials
    Qvalues(choices(i)) = Qvalues(choices(i)) + alpha*(rewards(i)-Qvalues(choices(i)));
    Cvalues(choices(i)) = Cvalues(choices(i)) + c*(rewards(i)-Cvalues(choices(i)));
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