% Objective: The goal of this routine is to quantify the position threshold,
% velocity threshold, and gain of the stretch reflex loop 
% as functions of dynamic and static Gamma drive
% 
% Data: The data files must be located inside the folder data/
% The name of the data files must be sweep_i where i is an integer between 
% 1 and trialNum (defined below)
%
%
clear
clc
%%
%Experimental constants
saveResults = 0; %set to 1 to save the results
visualization = 1; % set to 1 to plot the results
trialNum = 1;
perturbationAmp = 10; %p-p amplitude of perturbations (in degrees)
holdTime = 2 / 2;%hold time is trial length/2
%%
%results variables
reflexAmplitude = cell(trialNum,1);
muscleLength = cell(trialNum,1);
gammaTested = cell(trialNum,1);
%%
for protocolNumber = 1 : trialNum
%load (['data/sweep_',num2str(protocolNumber)]);
load ('data/fastProtocol')
[gammaDRange,gammaSRange,positionRange,velocityRange,~ ] = protocol_reader(data(:,2));
gammaDynamicRange = gammaDRange;
gammaStaticRange = gammaSRange;
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
reflexAmplitudeTemp = zeros(length(gammaDynamicRange),length(gammaStaticRange),...
    length(positionRange),length(velocityRange));
muscleLengthTemp = zeros(length(gammaDynamicRange),length(gammaStaticRange),...
    length(positionRange),length(velocityRange));

totalSteps = length(reflexAmplitudeTemp(:));
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
                    
                    reflexAmplitudeTemp(gammaDynamicIndex,gammaStaticIndex,positionIndex...
                        ,velocityIndex) = reflexAmplitudeThisTrial;
                    muscleLengthTemp(gammaDynamicIndex,gammaStaticIndex,positionIndex...
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
muscleLength{protocolNumber} = muscleLengthTemp;
reflexAmplitude{protocolNumber} = reflexAmplitudeTemp;
gammaTested{protocolNumber} = [gammaDynamicRange;gammaStaticRange];
end

fullSweepResults.muscleLength = muscleLength;
fullSweepResults.reflexAmplitude = reflexAmplitude;
fullSweepResults.gammaTested = gammaTested;
%%
if visualization
    maxReflex = max(reflexAmplitudeTemp(:));
    i = 1;
    for gammaDynamicIndex = 1 : size(reflexAmplitudeTemp,1)
        for gammaStaticIndex = 1 : size(reflexAmplitudeTemp,2)
            subplot(size(reflexAmplitudeTemp,1),size(reflexAmplitudeTemp,2),i)
            reflexTemp = reflexAmplitudeTemp(gammaDynamicIndex,gammaStaticIndex,:,:);
            reflexTemp = squeeze(reflexTemp);
            imagesc(reflexTemp,[0,maxReflex])
            xlabel('velocity')
            ylabel('position')
            i = i + 1;
        end
    end
end
%%
subplot(5,5,protocolNumber)
XV_RA_forplot=squeeze(reflexAmplitudeTemp);%%Reflex amplitude matrix as a function of X and V for plotting
surf(velocityRange,positionRange,XV_RA_forplot)
%[X,Y] = meshgrid(positionRange,velocityRange);
surf(velocityRange,positionRange,XV_RA_forplot)
xlabel('Vel.')
ylabel('Pos.')

zlabel('Ref. Amp.')
title(['G_d= ',num2str(gammaDynamicRange),'  G_s= ',num2str(gammaStaticRange)])
%camlight;lighting gouraud

if saveResults
    save data/fullSweepResults fullSweepResults
end