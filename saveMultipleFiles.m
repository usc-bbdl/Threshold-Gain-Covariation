% This file does the followings:
% 1- loads each of the 25 experimental data files
% 2- Identifies which experimental conditions were tested
% 3- Save multiple file, one for each experimental condition

clear
clc
numberOfFiles = 25;
saveDirectory = 'dataSplit';
h = waitbar(0,'Working very hard to prepare data');

for i = 1 : numberOfFiles
    waitbar(i / numberOfFiles)
    dataThisExperiment = dlmread(['data/dataProtocolRev2_',num2str(i),'.txt'],',',2,0); % reads the txt file
    experimentalProtocol = dataThisExperiment(:,2);
    [gammaDynamic,gammaStatic,position,velocity,numberRuns] = protocol_reader(experimentalProtocol);
    expCondition=zeros(3000,8);
    for gammaDynamicIndex = 1 : length(gammaDynamic)                              % Gamma range for dynamic - 1st dim
        for gammaStaticIndex = 1 : length(gammaStatic)                           % Gamma range for static - 2nd dim
            for positionIndex = 1 : length(position)                       % position range - 3nd dim
                for velocityIndex = 1 : length(velocity)                   % velocity range - 4th dim
                    experimentalCondition = [gammaDynamic(gammaDynamicIndex),gammaStatic(gammaStaticIndex),...
                                         0,gammaDynamic(gammaDynamicIndex),gammaStatic(gammaStaticIndex),0,...
                                         position(positionIndex),velocity(velocityIndex)];
                    indecesThisCondition= experimentalConditionFinder(experimentalProtocol,experimentalCondition);
                    dataThisCondition = dataThisExperiment(indecesThisCondition(1):indecesThisCondition(2),:);
                    fileName = [saveDirectory,'/dataGammaD',num2str(gammaDynamic(gammaDynamicIndex)),...
                        'GammaS',num2str(gammaStatic(gammaStaticIndex)),...
                        'Position',num2str(position(positionIndex)),...
                        'Velocity',num2str(position(velocityIndex)),'.mat'];
                    save (fileName,'dataThisCondition');


                end
            end
        end
    end

end
close(h)