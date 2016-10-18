function [reflexAmplitude,muscleLengthAmplitude] = reflexAmplitudeCalculator(data,perturbParams,muscleChoice)
    if nargin == 2
        muscleChoice = 1;
    end
    if muscleChoice == 1
        trialOnsetFlag = -1;
    elseif muscleChoice == 2
        trialOnsetFlag = -2;
    else
        error('Muscle choice must be either 1 or 2');
    end
    plotFlag = 0;
    
    expProt = data.expProtocol;
    mLength = data.Length;
    force = data.Force;
    
    perturbationAmplitude = perturbParams.pertAmp;
    perturbationVelocity = perturbParams.pertVel;
    holdTime = perturbParams.holdTime;
%%    
    samplingFreq = 1000;
    perturbationDuration = floor(samplingFreq * (perturbationAmplitude / perturbationVelocity));
    holdTime = floor(samplingFreq * holdTime);
    perturbationOnetIndex = find(expProt == trialOnsetFlag);
    perturbationOnetIndex = perturbationOnetIndex(2:end);
    xAxis = 1: length(force);
    reflexAmplitudeTemp = zeros(length(perturbationOnetIndex),1);
    muscleLengthAmplitudeTemp = zeros(length(perturbationOnetIndex),1);
    for i = 1 : length(perturbationOnetIndex)
        forcePhasic = force(perturbationOnetIndex(i):perturbationOnetIndex(i)+perturbationDuration+holdTime);
        forceTonic = force(perturbationOnetIndex(i)+perturbationDuration+holdTime-200:perturbationOnetIndex(i)+perturbationDuration+holdTime-100);
        lengthAmp = mLength(perturbationOnetIndex(i):perturbationOnetIndex(i)+perturbationDuration+holdTime);
        reflexAmplitudeTemp(i) = max(forcePhasic) - mean(forceTonic);
        muscleLengthAmplitudeTemp(i) = mean(lengthAmp);
    end
    if plotFlag == 1
        figure(100)
        plot(xAxis,force)
        hold on
        for i = 1 : length(perturbationOnetIndex)
            plot(xAxis(perturbationOnetIndex(i):perturbationOnetIndex(i)+perturbationDuration+holdTime),force(perturbationOnetIndex(i):perturbationOnetIndex(i)+perturbationDuration+holdTime),'r')
            plot(xAxis(perturbationOnetIndex(i)+perturbationDuration+holdTime-200:perturbationOnetIndex(i)+perturbationDuration+holdTime-100),force(perturbationOnetIndex(i)+perturbationDuration+holdTime-200:perturbationOnetIndex(i)+perturbationDuration+holdTime-100),'k','lineWidth',2);
        end
        grid on
        pause
        close(100)
    end
    reflexAmplitude = mean(reflexAmplitudeTemp);
    muscleLengthAmplitude = mean(muscleLengthAmplitudeTemp);
end