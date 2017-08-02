function [ AIC, R2, nLLPerTrial, BIC ] = AICR2( negLL,k,numTrials )
% This function calculates AIC, R2, negative log likelihood per trial, and
% BIC for fitted models
numIter = length(negLL);
r = numTrials*log(0.5);
R2 = zeros(numIter,1);
AIC = zeros(numIter,1);
nLLPerTrial = zeros(numIter,1);
BIC = zeros(numIter,1);
for i=1:length(negLL)
    AIC(i) = 2*negLL(i) + (2*k);
    R2(i) =1 - (-1*negLL(i)/r);
    nLLPerTrial(i) = (negLL(i))/numTrials;
    BIC(i) = (-1 * negLL) - (k/2)*log(numTrials);
end
end

