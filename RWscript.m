%% 2 pairs 1, Q's = 0
[numSubjects allChoicesInts allReinfs]=importData('2pairs1.xlsx');
RunQue
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs1','B3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs1','E3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs1','F3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs1','G3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('2pairs1.xlsx');
RunQueReduced
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs1','I3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs1','K3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs1','L3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs1','M3');
clear all

%% 2pairs1 - Q's .5
[numSubjects allChoicesInts allReinfs]=importData('2pairs1.xlsx');
RunQue05
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs1','O3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs1','R3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs1','S3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs1','T3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('2pairs1.xlsx');
RunQueReduced05
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs1','V3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs1','X3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs1','Y3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs1','Z3');
clear all;

%% 2pairs2 - Q's 0
[numSubjects allChoicesInts allReinfs]=importData('2pairs2.xlsx');
RunQue
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs2','B3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs2','E3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs2','F3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs2','G3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('2pairs2.xlsx');
RunQueReduced
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs2','I3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs2','K3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs2','L3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs2','M3');
clear all

%% 2pairs2 - Qs .5
[numSubjects allChoicesInts allReinfs]=importData('2pairs2.xlsx');
RunQue05
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs2','O3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs2','R3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs2','S3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs2','T3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('2pairs2.xlsx');
RunQueReduced05
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs2','V3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs2','X3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs2','Y3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs2','Z3');
clear all;

%% 2pairs3 - Qs 0
[numSubjects allChoicesInts allReinfs]=importData('2pairs3.xlsx');
RunQue
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs3','B3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs3','E3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs3','F3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs3','G3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('2pairs3.xlsx');
RunQueReduced
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs3','I3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs3','K3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs3','L3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs3','M3');
clear all

%% 2pairs3 - Qs .5
[numSubjects allChoicesInts allReinfs]=importData('2pairs3.xlsx');
RunQue05
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs3','O3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs3','R3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs3','S3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs3','T3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('2pairs3.xlsx');
RunQueReduced05
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs3','V3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs3','X3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs3','Y3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs3','Z3');
clear all;

%% 2pairs4 - Qs 0
[numSubjects allChoicesInts allReinfs]=importData('2pairs4.xlsx');
RunQue
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs4','B3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs4','E3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs4','F3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs4','G3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('2pairs4.xlsx');
RunQueReduced
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs4','I3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs4','K3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs4','L3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs4','M3');
clear all

%% 2pairs4 - Qs .5
[numSubjects allChoicesInts allReinfs]=importData('2pairs4.xlsx');
RunQue05
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs4','O3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs4','R3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs4','S3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs4','T3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('2pairs4.xlsx');
RunQueReduced05
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'2pairs4','V3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'2pairs4','X3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'2pairs4','Y3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'2pairs4','Z3');
clear all;

%% 3pairs1 - Qs 0
[numSubjects allChoicesInts allReinfs]=importData('3pairs1.xlsx');
RunQue3Pair
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'3pairs1','B3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'3pairs1','E3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'3pairs1','F3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'3pairs1','G3');
clear all

[numSubjects allChoicesInts allReinfs]=importData('3pairs1.xlsx');
RunQueReduced3Pair
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'3pairs1','I3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'3pairs1','K3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'3pairs1','L3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'3pairs1','M3');
clear all

%% 3pairs1 - Qs .5
[numSubjects allChoicesInts allReinfs]=importData('3pairs1.xlsx');
RunQue3Pair05
success(1,1) = xlswrite('analyses.xlsx',optimalParams,'3pairs1','O3');
success(1,2) = xlswrite('analyses.xlsx',optimalLLs,'3pairs1','R3');
success(1,3) = xlswrite('analyses.xlsx',optimalAICs,'3pairs1','S3');
success(1,4) = xlswrite('analyses.xlsx',optimalR2s,'3pairs1','T3');
%clear all

[numSubjects allChoicesInts allReinfs]=importData('3pairs1.xlsx');
RunQueReduced3Pair05
success(2,1) = xlswrite('analyses.xlsx',optimalParams,'3pairs1','V3');
success(2,2) = xlswrite('analyses.xlsx',optimalLLs,'3pairs1','X3');
success(2,3) = xlswrite('analyses.xlsx',optimalAICs,'3pairs1','Y3');
success(2,4) = xlswrite('analyses.xlsx',optimalR2s,'3pairs1','Z3');
clear all;