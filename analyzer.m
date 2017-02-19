% The goal of this project is to see how position threshold and velocity threshold change as a function of gamma (both dynamic and static)
clear
clc
load data/dataProtocolRev2_5
%%
[ gammaDynamicRange,gammaStaticRange,positionRange,velocityRange,~ ] = protocol_reader(data(:,2));
perturbationAmp = 10; %p-p amplitude of perturbations
holdTime = 2 / 2;%hold time is trial length/2
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
isReflex = zeros(length(gammaDynamicRange),length(gammaStaticRange),...
    length(positionRange),length(velocityRange));
reflexAmplitude = zeros(length(gammaDynamicRange),length(gammaStaticRange),...
    length(positionRange),length(velocityRange));
muscleLength = zeros(length(gammaDynamicRange),length(gammaStaticRange),...
    length(positionRange),length(velocityRange));
muscleVelocity = zeros(length(gammaDynamicRange),length(gammaStaticRange),...
    length(positionRange),length(velocityRange));

totalSteps = length(isReflex(:));
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
                    [isReflexThisTrial,muscleLengthThisTrial,...
                        muscleVelocityThisTrial,reflexAmplitudeThisTrial] =...
                        isReflexEvoked(dataThisTrial,perturbationParams,muscleChoice);
                    isReflex(gammaDynamicIndex,gammaStaticIndex,positionIndex...
                        ,velocityIndex) = isReflexThisTrial;
                    muscleLength(gammaDynamicIndex,gammaStaticIndex,positionIndex...
                        ,velocityIndex) = muscleLengthThisTrial;
                    muscleVelocity(gammaDynamicIndex,gammaStaticIndex,positionIndex...
                        ,velocityIndex) = muscleVelocityThisTrial;
                    reflexAmplitude(gammaDynamicIndex,gammaStaticIndex,positionIndex...
                        ,velocityIndex) = reflexAmplitudeThisTrial;
                    if displayFlag == 1
                        disp(['Gd: ',num2str(gammaDynamicRange(gammaDynamicIndex)),', Gs: ',num2str(gammaStaticRange(gammaStaticIndex))...
                            ', Pos: ',num2str(positionRange(positionIndex)),', vel: ',num2str(velocityRange(velocityIndex))])
                        disp(['Reflex amplitude was: ',num2str(isReflexThisTrial)])
                    end
                    
                end
            end
        end
    end
end
close(h)
%%
positionThreshold = nan(length(velocityRange),1);
for i = 1 : length(velocityRange)
    for j = length(positionRange) : -1 : 1
        if isReflex(1,1,j,i) == 1
            positionThreshold(i) = muscleLength(1,1,j,i);
            break;
        end
    end
end
subplot(1,3,1)
hold on
plot(mean(squeeze(muscleVelocity)),positionThreshold,'--','marker','o')
xlabel('Muscle Velocity (L_0/s)')
ylabel('Length Threshold (L_0)')
axis square

velocityThreshold = nan(length(positionRange),1);
gain = nan(length(positionRange),1);
for i = 1 : length(positionRange)
    for j = 1 : length(velocityRange)
        if isReflex(1,1,i,j) == 1
            velocityThreshold(i) = muscleVelocity(1,1,i,j);
            reflexPresentVelocities = squeeze(muscleVelocity(1,1,i,j:end));
            reflexPresentAmplitudes = squeeze(reflexAmplitude(1,1,i,j:end));
            if length(reflexPresentVelocities)<2
            else
                p = polyfit(reflexPresentVelocities,reflexPresentAmplitudes,1);
            end
            gain(i) = p(1);
            if p (1) < -0.1
                gain(i) = 0;
            end
            %elseif p(1) > 0.1
            %    gain(i) = 0;
            %else
            %    gain(i) = p(1);
            %end
            
            break;
        end
    end
end
title('Length Threshold')
subplot(1,3,2)
hold on
plot(mean(squeeze(muscleLength)'),velocityThreshold,'--','marker','o')
xlabel('Muscle Length (L_0)')
ylabel('Velocity Threshold (L_0/s)')
axis square
title('Velocity Threshold')

subplot(1,3,3)
hold on
plot(mean(squeeze(muscleLength)'),gain,'--','marker','o')
xlabel('Muscle Length (L_0)')
ylabel('Gain (Ns/L_0)')
axis square
title('Gain')