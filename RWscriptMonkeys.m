%% 2 pairs 1, Q's = 0
[numSubjects allChoicesInts allReinfs]=importData('monkeys.xlsx');
RunQue
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs1','B3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs1','E3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs1','F3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs1','G3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('monkeys.xlsx');
RunQueReduced
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs1','I3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs1','K3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs1','L3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs1','M3');
clear all

%% 2pairs1 - Q's .5
[numSubjects allChoicesInts allReinfs]=importData('monkeys.xlsx');
RunQue05
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs1','O3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs1','R3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs1','S3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs1','T3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('monkeys.xlsx');
RunQueReduced05
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs1','V3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs1','X3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs1','Y3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs1','Z3');
clear all;

