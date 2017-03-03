clear all;
close all;
clc;

%% 
%This script is for concatenating all 25 .txt files, into 1 huge .mat file
%called AllData.mat .

ConcatenatedData=[];
for i =1:25
    data = dlmread(['data\dataProtocolRev2_',num2str(i),'.txt'],',',2,0); % reads the txt file
   
   ConcatenatedData=[ConcatenatedData;data(:,1:8)];
end
%% 


%Experimental Condition Matrix Generator: These "For loops" generate a
%matrix that each of its row is a set of experimental condition.

ExpProtocol = ConcatenatedData(:,2);     %Set the second column of Data, equal to expProtocol.

[ GammaDynamic,GammaStatic,Position,Velocity,number_of_runs ] = protocol_reader( ExpProtocol );   %Find a set of values in Data's second column for each of our variables (GammaDynamic, GammaStatic, Position, Velocity).

ExpConditionSize= length(GammaDynamic)*length(GammaStatic)*length(Position)*length(Velocity);
ExpCondition=zeros(ExpConditionSize,8);
i=0;
       for gammaDynamicIndex = 1 : length(GammaDynamic)                              % Gamma range for dynamic - 1st dim
            for gammaStaticIndex = 1 : length(GammaStatic)                           % Gamma range for static - 2nd dim
                for positionIndex = 1 : length(Position)                       % position range - 3nd dim
                    for velocityIndex = 1 : length(Velocity)                   % velocity range - 4th dim
               
                        i=i+1;
                        ExpCondition(i,:) = [GammaDynamic(gammaDynamicIndex),GammaStatic(gammaStaticIndex),...
                                             0,GammaDynamic(gammaDynamicIndex),GammaStatic(gammaStaticIndex),0,...
                                             Position(positionIndex),Velocity(velocityIndex)];
                            
                           
                     
                    end
                end
            end
       end
            

       %% 

%Indices Matrix Generator


SizeDynamic= length(GammaDynamic);
SizeStatic= length(GammaStatic);
SizePos= length(Position);
SizeVel= length(Velocity);
Rep=9;
StartingIndices= zeros(SizeDynamic,SizeStatic,SizePos,SizeVel,Rep);
EndingIndices= zeros(SizeDynamic,SizeStatic,SizePos,SizeVel,Rep);




for ConditionRow=2:ExpConditionSize;        %First row is zeros.
    Condition_des=ExpCondition(ConditionRow,:);
    Indices= experimentalConditionFinder(ExpProtocol,Condition_des);
    In1=Indices(1);
    In2=Indices(2);
    IntervalMatrix= PerturbationFinder(ExpProtocol,In1,In2);
    for i=1:SizeDynamic;
        for j=1:SizeStatic;
            for k=1:SizePos;
                for l=1:SizeVel;
                    for m=1:Rep;
                        StartingIndices(i,j,k,l,m)=IntervalMatrix(m,1);     %This Matrix contains all of the staring point indices of a repetionion.
                        EndingIndices(i,j,k,l,m)=IntervalMatrix(m,2);     %This Matrix contains all of the ending point indices of a repetition.
                    end
                end
            end
        end
    end
end
                  
              
%% 






