clear all;
close all;
clc;
load Data\AllData;

%Experimental Condition Matrix Generator: These "For loops" generate a
%matrix that each of its row is a set of experimental condition.

expProtocol = Con_Data(:,2);     %Set the second column of Data, equal to expProtocol.

[ gamma_d_1_r,gamma_s_1_r,pos_r,vel_r,number_of_runs ] = protocol_reader( expProtocol );   %Find a set of values in Data's second column for each of our variables (GammaDynamic, GammaStatic, Position, Velocity).

ExpConditionSize= length(gamma_d_1_r)*length(gamma_s_1_r)*length(pos_r)*length(vel_r);
expCondition=zeros(ExpConditionSize,8);
i=0;
       for gammaDynamicIndex = 1 : length(gamma_d_1_r)                              % Gamma range for dynamic - 1st dim
            for gammaStaticIndex = 1 : length(gamma_s_1_r)                           % Gamma range for static - 2nd dim
                for positionIndex = 1 : length(pos_r)                       % position range - 3nd dim
                    for velocityIndex = 1 : length(vel_r)                   % velocity range - 4th dim
               
                        i=i+1;
                        expCondition(i,:) = [gamma_d_1_r(gammaDynamicIndex),gamma_s_1_r(gammaStaticIndex),...
                                             0,gamma_d_1_r(gammaDynamicIndex),gamma_s_1_r(gammaStaticIndex),0,...
                                             pos_r(positionIndex),vel_r(velocityIndex)];
                            
                           
                     
                    end
                end
            end
       end
            


%Indices Matrix Generator


IndDynamic= length(gamma_d_1_r);
IndStatic= length(gamma_s_1_r);
IndPos= length(pos_r);
IndVel= length(vel_r);
Rep=9;
Matrix_5D_B= zeros(IndDynamic,IndStatic,IndPos,IndVel,Rep);
Matrix_5D_E= zeros(IndDynamic,IndStatic,IndPos,IndVel,Rep);




for ConditionRow=2:ExpConditionSize;        %First row is zeros.
    Condition_des=expCondition(ConditionRow,:);
    Indices= experimentalConditionFinder(expProtocol,Condition_des);
    In1=Indices(1);
    In2=Indices(2);
    IntervalMatrix= PerturbationFinder(expProtocol,In1,In2);
    for i=1:IndDynamic;
        for j=1:IndStatic;
            for k=1:IndPos;
                for l=1:IndVel;
                    for m=1:Rep;
                        Matrix_5D_B(i,j,k,l,m)=IntervalMatrix(m,1);     %This Matrix contains all of the staring point indices of a repetionion.
                        Matrix_5D_E(i,j,k,l,m)=IntervalMatrix(m,2);     %This Matrix contains all of the ending point indices of a repetition.
                    end
                end
            end
        end
    end
end
                  
              





