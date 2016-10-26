% The goal of this project is to see how position threshold and velocity threshold change as a function of gamma (both dynamic and static)
clear all
clc
for protocolNumber=1:1
load (['data/sweep',num2str(protocolNumber)]);
%%
[ gammaDRange,gammaSRange,positionRange,velocityRange,~ ] = protocol_reader(data(:,2));
perturbationAmp = 10; %p-p amplitude of perturbations
holdTime = 2 / 2;%hold time is trial length/2
gammaDynamicRange = gammaDRange;
gammaStaticRange = gammaSRange;
%velocityRange = [20 100]';
%positionRange = [-30,0,30]';
muscleChoice = 1;
expProtChan = 2;
if muscleChoice == 1
    lengthChannel = 3;
    forceChannel = 7;
elseif muscleChoice == 2
    lengthChannel = 4;
    forceChannel = 8;
else
    error('Muscle choice must be either 1 or 2');
end
displayFlag = 0;
reflexAmplitude = zeros(length(gammaDynamicRange),length(gammaStaticRange),...
    length(positionRange),length(velocityRange));
muscleLength = zeros(length(gammaDynamicRange),length(gammaStaticRange),...
    length(positionRange),length(velocityRange));

totalSteps = length(reflexAmplitude(:));
step = 1;
h = waitbar(0,'Processing');
for gammaDynamicIndex = 1 : length(gammaDynamicRange)                              % Gamma range for dynamic - 1st dim
    for gammaStaticIndex = 1 : length(gammaStaticRange)                           % Gamma range for static - 2nd dim
        for positionIndex = 1 : length(positionRange)                       % position range - 3nd dim
            for velocityIndex = 1 : length(velocityRange)                   % velocity range - 4th dim
                waitbar(step/totalSteps);
                step = step + 1;
                
                expCondition = [gammaDynamicRange(gammaDynamicIndex),gammaStaticRange(gammaStaticIndex),...
                    0,gammaDynamicRange(gammaDynamicIndex),gammaStaticRange(gammaStaticIndex),0,...
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
                    dataThisTrial.Length = lengthThisTrial;
                    dataThisTrial.Force = forceThisTrial;
                    dataThisTrial.expProtocol = expProtThisTrial;
                    perturbationParams.pertAmp = perturbationAmp;
                    perturbationParams.pertVel = velocityRange(velocityIndex);
                    perturbationParams.holdTime = holdTime;
                    [reflexAmplitudeThisTrial,muscleLengthThisTrial] =...
                        reflexAmplitudeCalculator(dataThisTrial,perturbationParams,muscleChoice);
                    
                    reflexAmplitude(gammaDynamicIndex,gammaStaticIndex,positionIndex...
                        ,velocityIndex) = reflexAmplitudeThisTrial;
                    muscleLength(gammaDynamicIndex,gammaStaticIndex,positionIndex...
                        ,velocityIndex) = muscleLengthThisTrial;
                    if displayFlag == 1
                        disp(['Gd: ',num2str(gammaDynamicRange(gammaDynamicIndex)),', Gs: ',num2str(gammaStaticRange(gammaStaticIndex))...
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
% %display('everything is saved in the file named as reflexAmplitude')
% close all
% figure
% subplot(2,1,1)
% results_visualization(muscleLength,'gamma_d',3,'vel',5,positionRange,velocityRange) % please use help results_visualization for full details
% subplot(2,1,2)
% results_visualization(reflexAmplitude,'gamma_d',3,'vel',5,positionRange,velocityRange) % please use help results_visualization for full details
% % results_visualization is a function to visualize the results
% %%
% %test plot responses at some experimental condition
% figure
% dataPlot.expProt = data(:,expProtChan);
% dataPlot.length = data(:,lengthChannel);
% dataPlot.force = data(:,forceChannel);
% experimentCondition.gammaD = 0;
% experimentCondition.gammaS = 0;
% experimentCondition.pos = 41;
% experimentCondition.vel = 100;
% responsePlotter(dataPlot,experimentCondition,muscleChoice);
Xc=1;Tc=1;Vc=1;
%subplot(5,5,protocolNumber)
XV_RA_forplot=squeeze(reflexAmplitude);%%Reflex amplitude matrix as a function of X and V for plotting
surf(positionRange,velocityRange,XV_RA_forplot)
xlabel('Pos.')
ylabel('Vel.')
zlabel('Ref. Amp.')
title(['G_d= ',num2str(gammaDynamicRange),'  G_s= ',num2str(gammaStaticRange)])
%camlight;lighting gouraud
end