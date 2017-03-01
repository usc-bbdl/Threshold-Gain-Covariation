%This function finds the starting and ending indices of each repetition between Index1 and Index two.
%Index1 and Index2 show the begining and ending of a perturbation with a
%specific experimental condition.
%Its inputs are the second column of the AllData (status) the begining of the perturbation and the ending of it.
function PerInFound= PerturbationFinder(expProtocol,In1,In2)
expProtocol=expProtocol(:);
PerIndeces=find(expProtocol(In1:In2)==-1);
PerIndeces = PerIndeces(2:end);
for i=1:8;
    PerIndeces2(i)=find(expProtocol(In1+PerIndeces(i):In1+PerIndeces(i+1))==-2);
end
PerIndeces2(9)=find(expProtocol(In1+PerIndeces(9):In2-700)==-2);
for i=1:8;
    PerInFound(i,:)=[In1+PerIndeces(i),In1+PerIndeces(i)+PerIndeces2(i)];
end
 PerInFound(9,:)=[In1+PerIndeces(9),In1+PerIndeces(9)+PerIndeces2(9)];
end
%beine -1 o -2 mikhad
