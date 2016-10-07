function reflexAmplitude = reflexAmplitudeCalculator(expProt,force,perturbationAmplitude,perturbationVelocity,holdTime)
    plotFlag = 0;
    samplingFreq = 1000;
    perturbationDuration = floor(samplingFreq * (perturbationAmplitude / perturbationVelocity));
    holdTime = floor(samplingFreq * holdTime);
    perturbationOnetIndex = find(expProt == -1);
    perturbationOnetIndex = perturbationOnetIndex(2:end);
    xAxis = 1: length(force);
    reflexAmplitudeTemp = zeros(length(perturbationOnetIndex),1);
    for i = 1 : length(perturbationOnetIndex)
        forcePhasic = force(perturbationOnetIndex(i):perturbationOnetIndex(i)+perturbationDuration+holdTime);
        forceTonic = force(perturbationOnetIndex(i)+perturbationDuration+holdTime-200:perturbationOnetIndex(i)+perturbationDuration+holdTime-100);
        reflexAmplitudeTemp = max(forcePhasic) - mean(forceTonic);
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
end