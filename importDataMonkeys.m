function [numSubjects, allChoicesInts, allReinfs] = importDataMonkeys(filename)
exl = actxserver('excel.application');
exlWkbk = exl.Workbooks;
exlFile = exlWkbk.Open([pwd '\' filename]);
exlSheet = exlFile.Sheets.Item('summary');
ur = get(exlSheet,'UsedRange');
addr = get(ur,'Address');
cntDollars = 0;
for i=1:size(addr,2)
    if addr(i)=='$'
        cntDollars=cntDollars+1;
    end
    if cntDollars==4
        numRows = str2double(addr(i+1:end));
        break
    end
end
numSessions = numRows-2;
%numRows = robj.row;
rngObj = exlSheet.Range(['A3:A' num2str(numRows)]);
%[subjNum, ~ ] =xlsread(filename,'summary','A3:A82');
%[numTrials] =xlsread(filename,'summary','K3:K82');
%[~, choices] =xlsread(filename,'choice','H3:FK82');
%numRows = length(subjNum);
subjNum = rngObj.Value;
rngObj = exlSheet.Range(['K3:K' num2str(numRows)]);
numTrials = rngObj.Value;
exlSheet = exlFile.Sheets.Item('choice');
rngObj = exlSheet.Range(['H3:' char(ExcelCol(max([numTrials{:}])+7)) num2str(numRows)]);
choices = rngObj.Value;
subjects=unique([subjNum{:}]);
numSubjects=size(subjects,2);
allChoices=cell(numSubjects,1);
for i=1:numSessions
    allChoices{subjNum{i}}=[allChoices{subjNum{i}} choices{i,1:numTrials{i}}];
end
clear choices subjects;
probReinf=cell(2,1);

exlSheet = exlFile.Sheets.Item('prob reinf 1');
rngObj = exlSheet.Range(['H3:' char(ExcelCol(max([numTrials{:}])+7)) num2str(numRows)]);
probReinf{1} = rngObj.Value;

exlSheet = exlFile.Sheets.Item('prob reinf 2');
rngObj = exlSheet.Range(['H3:' char(ExcelCol(max([numTrials{:}])+7)) num2str(numRows)]);
probReinf{2} = rngObj.Value;
exlWkbk.Close;
exl.Quit;
%[~,probReinf{1,1}] =xlsread(filename,'prob reinf 1','H3:FK82');
%[~,probReinf{2,1}] =xlsread(filename,'prob reinf 2','H3:FK82');
allProbReinfs=cell(numSubjects,2);
for i=1:numSessions
    for j=1:2
        allProbReinfs{subjNum{i},j}=[probReinf{j}{i,1:numTrials{i}}];
    end
end
allReinfs=cell(numSubjects,1);
allChoicesInts=cell(numSubjects,1);
for i=1:numSubjects
    allReinfs{i}=zeros(length(allChoices{i}),1);
    for j=1:length(allChoices{i})
        if allChoices{i}(j)==allProbReinfs{i,1}(j) || allChoices{i}(j)==allProbReinfs{i,2}(j)
            allReinfs{i}(j)=1;
        else
            allReinfs{i}(j)=0;
        end
        allChoicesInts{i}(j)=double(allChoices{i}(j)-64);
    end
    allReinfs{i}=allReinfs{i}.';
end
clear probReinf i j  subjNum numRows allProbReinfs numTrials allChoices;
            
           

