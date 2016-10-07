clear
clc
load data/test1
%%
perturbationAmp = 20; %p-p amplitude of perturbations
holdTime = 3 / 2;%hold time is trial length/2
gammaRange = [0 100 200]';
velocityRange = [10 100 250]';
positionRange = [75,-75]';
expProtChan = 2;
forceChannel = 7;
lengthChannel = 3;
displayFlag = 0;
reflexAmplitude = zeros(length(gammaRange),length(gammaRange),...
    length(positionRange),length(velocityRange));
totalSteps = length(reflexAmplitude(:));
step = 1;
h = waitbar(0,'Processing');
for gammaDynamicIndex = 1 : length(gammaRange)
    for gammaStaticIndex = 1 : length(gammaRange)
        for positionIndex = 1 : length(positionRange)
            for velocityIndex = 1 : length(velocityRange)
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

