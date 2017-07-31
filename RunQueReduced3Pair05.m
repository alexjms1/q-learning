x0 = [.5 .5];
lb = [0 .0001];
ub = [1 .9999];
numParams = 2;
opts = optimset('fmincon');
opts.Simplex = 'on';
opts.MaxFunEvals = 1000;
opts.MaxIter=1000;
opts.Algorithm = 'active-set';
for i = 1:numSubjects
    Q=@(x)QlearningReduced3Pair05(x(1),x(2),allChoicesInts{i,:},allReinfs{i,:});  
    [xvalues fvalues exits starts]= rmsearch(Q,'fmincon',x0,lb,ub,'options',opts)
    fittedParams(i,:,:)=xvalues(:,:);
    negLogLLs(i,:)=fvalues(:);
    exitFlags(i,:)=exits(:);
    startingParams(i,:)=starts(:);
    [AICs(i,:) R2s(i,:)]=AICR2(fvalues,numParams,size(allChoicesInts{i},2));
end
clear xvalues fvalues exits starts lb ub x0 i numParams opts;

[optimalLLs optimalIndices]=nanmin(negLogLLs,[],2);
for i=1:numSubjects
    optimalAICs(i)=AICs(i,optimalIndices(i));
    optimalR2s(i)=R2s(i,optimalIndices(i));
    optimalParams(i,:)=fittedParams(i,optimalIndices(i),:);
end
optimalAICs=optimalAICs';
optimalR2s=optimalR2s';
clear i j

        