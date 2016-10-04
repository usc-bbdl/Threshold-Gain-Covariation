numFiles = 8;
gammaStatic = [0;25;50;75;100;125;150;175;200];
gammaDynamic = [0;25;50;75;100;125;150;175;200];
velocities = [50;100;200;300];
corticalDrive = [0;900;1250];
reps = 5;
trialLength = 3;
initPos = -24;
finalPos = 18;
outputMatrix = zeros(length(gammaStatic)*length(gammaDynamic)*length(velocities)*length(corticalDrive),11);
m = 0;
for i = 1 : length(gammaDynamic)
    for j = 1 : length(gammaStatic)
        for k = 1 : length(corticalDrive)
            for l = 1 : length(velocities)
                m = m + 1;
                outputMatrix(m,:) = [gammaDynamic(i) gammaStatic(j) gammaDynamic(i) gammaStatic(j) corticalDrive(k) corticalDrive(k) initPos finalPos velocities(l) trialLength reps];
            end
        end
    end
end
p = randperm(size(outputMatrix,1));
outputMatrixPermut = outputMatrix(p,:);
numRows = size(outputMatrix,1);
trialsPerFile = floor(numRows/numFiles);
for i = 1 :numFiles
    fileName = strcat(['servoPerturb',num2str(i),'.txt']);
    dlmwrite(fileName,trialsPerFile,'delimiter',',','newline', 'pc');
    dlmwrite(fileName,outputMatrixPermut((i-1)*trialsPerFile+1:i*trialsPerFile,:),'delimiter',',','newline', 'pc','-append');
end
i = i + 1;
fileName = strcat(['servoPerturb',num2str(i),'.txt']);
dlmwrite(fileName,size(outputMatrixPermut((i-1)*trialsPerFile+1:end,:),1),'delimiter',',','newline', 'pc');
dlmwrite(fileName,outputMatrixPermut((i-1)*trialsPerFile+1:end,:),'delimiter',',','newline', 'pc','-append');


%%
numFiles = 1;
gammaStatic = [0;50;100];
gammaDynamic = [0;50;100];
corticalDrive = [900;1250];
outputMatrix = zeros(length(gammaStatic)*length(gammaDynamic)*length(corticalDrive),6);
m = 0;
for i = 1 : length(gammaDynamic)
    for j = 1 : length(gammaStatic)
        for k = 1 : length(corticalDrive)
                m = m + 1;
                outputMatrix(m,:) = [gammaDynamic(i) gammaStatic(j) gammaDynamic(i) gammaStatic(j) corticalDrive(k) corticalDrive(k)];
        end
    end
end
numRows = size(outputMatrix,1);
trialsPerFile = floor(numRows/numFiles);
fileName = strcat(['manualPerturb2.txt']);
dlmwrite(fileName,trialsPerFile,'delimiter',',','newline', 'pc');
dlmwrite(fileName,outputMatrix,'delimiter',',','newline', 'pc','-append');
