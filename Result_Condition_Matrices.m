clear all;
close all;
clc;
load Data\AllData;

%Experimental Condition Matrix Generator

expProtocol = Con_Data(:,2);
[ gamma_d_1_r,gamma_s_1_r,pos_r,vel_r,number_of_runs ] = protocol_reader( expProtocol );

expCondition=zeros(3000,8);
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
S= size(expCondition);

IndDynamic= length(gamma_d_1_r);
IndStatic= length(gamma_s_1_r);
IndPos= length(pos_r);
IndVel= length(vel_r);
Rep=9;
Matrix_5D_B= zeros(IndDynamic,IndStatic,IndPos,IndVel,Rep);
Matrix_5D_E= zeros(IndDynamic,IndStatic,IndPos,IndVel,Rep);




for a=2:S(1)
    SpCondition=expCondition(a,:);
    Indices= experimentalConditionFinder(expProtocol,SpCondition);
    In1=Indices(1);
    In2=Indices(2);
    IntervalMatrix= PerFinder(expProtocol,In1,In2);
    for i=1:IndDynamic;
        for j=1:IndStatic;
            for k=1:IndPos;
                for l=1:IndVel;
                    for m=1:Rep;
                        Matrix_5D_B(i,j,k,l,m)=IntervalMatrix(m,1);
                        Matrix_5D_E(i,j,k,l,m)=IntervalMatrix(m,2);
                    end
                end
            end
        end
    end
end
                  
              





