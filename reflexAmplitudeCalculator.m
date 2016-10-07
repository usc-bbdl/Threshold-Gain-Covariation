function reflexAmplitude = reflexAmplitudeCalculator(expProt,force,perturbationAmplitude,perturbationVelocity,holdTime)
    plotFlag = 0;
    samplingFreq = 1000;
    perturbationDuration = floor(samplingFreq * (perturbationAmplitude / perturbationVelocity));
    holdTime = floor(samplingFreq * holdTime);
    perturbationOnetIndex = find(expProt == -1);
    perturbationOnetIndex = perturbationOnetIndex(2:end);
    xAxis = 1: length(force);
    for i = 1 : length(perturbationOnetIndex)
        forcePhasic = force(perturbationOnetIndex(i):perturbationOnetIndex(i)+perturbationDuration+holdTime);
        forceTonic = force(perturbationOnetIndex(i)+perturbationDuration:perturbationOnetIndex(i)+perturbationDuration+holdTime);
        reflexAmplitude = max(forcePhasic) - mean(forceTonic);
        if plotFlag == 1
            figure(100)
            plot(force)
            hold on
            plot(xAxis(perturbationOnetIndex(i):perturbationOnetIndex(i)+perturbationDuration+holdTime),force(perturbationOnetIndex(i):perturbationOnetIndex(i)+perturbationDuration+holdTime),'r')
            pause
            close(100)
        end
    end
end