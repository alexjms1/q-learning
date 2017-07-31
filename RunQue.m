x0 = [.5 .5 .5];
lb = [0  0 .00000001];
ub = [1  1 +inf];
numParams = 3;
numberRandomStarts=100;

fittedParams = zeros(numSubjects,numParams);
negLogLLs = zeros(numSubjects);
exitFlags = zeros(numSubjects);
runSummary = zeros(numSubjects);
AICs = zeros(numSubjects);
BICs = zeros(numSubjects);
R2s = zeros(numSubjects);
nLLperTrial = zeros(numSubjects);
allMins = cell(numSubjects,1);

opts = optimoptions(@fmincon,'Algorithm','interior-point','MaxFunEvals',3000,'MaxIter',2000);

for i = 1:numSubjects
    Q=@(x)QlearningFull(x(1),x(2),x(3),allChoicesInts{i,:},allReinfs{i,:});
    problem = createOptimProblem('fmincon,',Q,'x0',x0,'lb',lb,'ub','options',opts);
    ms = MultiStart('Display','iter','PlotFcns','objective',@gsplotbestf,'UseParallel',true);
    [xvalue, fvalue, exit, output, everything] = run(ms,problem,numberRandomStarts);%(Q,'fmincon',x0,lb,ub,'options',opts);
    fittedParams(i,:)=xvalue(:);
    negLogLLs(i)=fvalue;
    exitFlags(i)=exit;
    runSummary(i)=output;
    allMins{i} = everything; 
    %[AICs(i,:), R2s(i,:), nLLperTrial(i,:), BICs(i,:)]=AICR2(fvalues,numParams,size(allChoicesInts{i},2));
    
end
%for i = 1:numSubjects
% Q=@(x)QlearningFull(x(1),x(2),x(3),allChoicesInts{i,:},allReinfs{i,:});  




%active-set','Simplex','on','MaxFunEvals',1000,'MaxIter',1000);
%opts.Simplex = 'on';
%opts.MaxFunEvals = 1000;
%opts.MaxIter=1000;
%opts.Algorithm = 'active-set';
%{
for i = 1:numSubjects
    Q=@(x)QlearningFull(x(1),x(2),x(3),allChoicesInts{i,:},allReinfs{i,:});  
    [xvalue fvalues exits output] = rmsearch(Q,'fmincon',x0,lb,ub,'options',opts)
    fittedParams(i,:,:)=xvalue(:,:);
    negLogLLs(i,:)=fvalues(:);
    exitFlags(i,:)=exits(:);
    details(i,:)=output(:);
   % [AICs(i,:) R2s(i,:)]=AICR2(fvalues,numParams,size(allChoicesInts{i},2));
    
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
%}