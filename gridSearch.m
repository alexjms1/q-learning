%for i=1:numSubjects
%    i
%    minLLs(i) = 10000000000000000000000000000000000;
%    for j=0:1000
%        for k=0:1000
%            for l=1:999
%                LL=QlearningFull(j/1000,k/1000,l/1000,allChoicesInts{i,:},allReinfs{i,:});
%                if LL<minLL(i)
%                    minLL(i)=LL;
%                    params(i,:)=[j/1000 k/1000 l/1000];
%               end
%            end
%        end
%    end
%end


for i=1:16%numSubjects
    i
    reducedMinLL(i) = 10000000000000000000000000000000000;
    for j=0:1000
        for k=1:999
            
                reducedLL=QlearningReduced(j/1000,k/1000,allChoicesInts{i,:},allReinfs{i,:});
                if reducedLL<reducedMinLL(i)
                    reducedMinLL(i)=reducedLL;
                    reducedParams(i,:)=[j/1000 k/1000];
                end
         end
    end
end