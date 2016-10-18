% The goal of this project is to see how position threshold and velocity threshold change as a function of gamma (both dynamic and static)
% 


clear all
clc
load data/test1
%%
perturbationAmp = 10; %p-p amplitude of perturbations
holdTime = 3 / 2;%hold time is trial length/2
gammaRange = [0 100 200]';
velocityRange = [10 40 70 100]';
positionRange = [75,25,-25,-75]';
expProtChan = 2;
forceChannel = 7;
lengthChannel = 3;
displayFlag = 0;
reflexAmplitude = zeros(length(gammaRange),length(gammaRange),...
    length(positionRange),length(velocityRange));
totalSteps = length(reflexAmplitude(:));
step = 1;
h = waitbar(0,'Processing');
for gammaDynamicIndex = 1 : length(gammaRange)                              % Gamma range for dynamic - 1st dim
    for gammaStaticIndex = 1 : length(gammaRange)                           % Gamma range for static - 2nd dim
        for positionIndex = 1 : length(positionRange)                       % position range - 3nd dim
            for velocityIndex = 1 : length(velocityRange)                   % velocity range - 4th dim
                waitbar(step/totalSteps);
                step = step + 1;
                
                expCondition = [gammaRange(gammaDynamicIndex),gammaRange(gammaStaticIndex),...
                    0,gammaRange(gammaDynamicIndex),gammaRange(gammaStaticIndex),0,...
                    positionRange(positionIndex),velocityRange(velocityIndex)];
                indexFound = experimentalConditionFinder(data(:,expProtChan),expCondition);
                %plot(data(indexFound(1):indexFound(2),7))
                %pause
                if isempty(indexFound)
                    warning('No experimental condition found')
                else
                    lengthThisTrial = data(indexFound(1):indexFound(2),lengthChannel);
                    forceThisTrial = data(indexFound(1):indexFound(2),forceChannel);
                    expProtThisTrial = data(indexFound(1):indexFound(2),expProtChan);
                    reflexAmplitudeThisTrial = reflexAmplitudeCalculator(expProtThisTrial,...
                        forceThisTrial,perturbationAmp,velocityRange(velocityIndex),holdTime);
                    reflexAmplitude(gammaDynamicIndex,gammaStaticIndex,positionIndex...
                        ,velocityIndex) = reflexAmplitudeThisTrial;
                    if displayFlag == 1
                        disp(['Gd: ',num2str(gammaRange(gammaDynamicIndex)),', Gs: ',num2str(gammaRange(gammaStaticIndex))...
                            ', Pos: ',num2str(positionRange(positionIndex)),', vel: ',num2str(velocityRange(velocityIndex))])
                        disp(['Reflex amplitude was: ',num2str(reflexAmplitudeThisTrial)])
                    end
                    
                end
            end
        end
    end
end
close(h)
%% Visualization
%display('everything is saved in the file named as reflexAmplitude')


results_visualization(reflexAmplitude, 'gamma_d',2,'vel',2,positionRange,velocityRange) % please use help results_visualization for full details
% results_visualization is a function to visualize the results
