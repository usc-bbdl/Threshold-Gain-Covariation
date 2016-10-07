perturbationAmp = 20; %p-p amplitude of perturbations
holdTime = 3 / 2;%hold time is trial length/2
gammaRange = [0 100 200]';
velocityRange = [10 100 250]';
positionRange = [75,-75]';
expProtChan = 2;
forceChannel = 7;
reflexAmplitude = zeros(length(gammaRange),length(gammaRange),...
    length(positionRange),length(velocityRange));
for gammaDynamicIndex = 1 : length(gammaRange)
    for gammaStaticIndex = 1 : length(gammaRange)
        for positionIndex = 1 : length(positionRange)
            for velocityIndex = 1 : length(velocityRange)
                disp(['Gd: ',num2str(gammaRange(gammaDynamicIndex)),', Gs: ',num2str(gammaRange(gammaStaticIndex))...
                    ', Pos: ',num2str(positionRange(positionIndex)),', vel: ',num2str(velocityRange(velocityIndex))])
                expCondition = [gammaRange(gammaDynamicIndex),gammaRange(gammaStaticIndex),...
                    0,gammaRange(gammaDynamicIndex),gammaRange(gammaStaticIndex),0,...
                    positionRange(positionIndex),velocityRange(velocityIndex)];
                indexFound = experimentalConditionFinder(data(:,expProtChan),expCondition);
                %plot(data(indexFound(1):indexFound(2),7))
                %pause
                if isempty(indexFound)
                    warning('No experimental condition found')
                else
                    forceThisTrial = data(indexFound(1):indexFound(2),forceChannel);
                    expProtThisTrial = data(indexFound(1):indexFound(2),expProtChan);
                    reflexAmplitude(gammaDynamicIndex,gammaStaticIndex,positionIndex...
                        ,velocityIndex) = reflexAmplitudeCalculator(expProtThisTrial,...
                        forceThisTrial,perturbationAmp,velocityRange(velocityIndex),trialLength/2);
                end
            end
        end
    end
end


