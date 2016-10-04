numFiles = 5-1;
gammaStatic = 0:40:200;
gammaDynamic = 0:40:200;
velocities = 10:40:290;
corticalDrive = [0 900 1250];
reps = 2;
trialLength = 3;
% initPos = -24;
% finalPos = 18;
position=-75:50:75;
outputMatrix = zeros(length(gammaStatic)*length(gammaDynamic)*length(velocities)*length(corticalDrive),11);


perturbation=6;%0.04*180/pi;
m = 0;
for i = 1 : length(gammaDynamic)
    for j = 1 : length(gammaStatic)
        for k = 1 : length(corticalDrive)
            for l = 1 : length(velocities)
                for pos=1:length(position)
                    m = m + 1;
                    initPos=position(pos)-perturbation/2;
                    finalPos=position(pos)+perturbation/2;
                    outputMatrix(m,:) = [gammaDynamic(i) gammaStatic(j) gammaDynamic(i) gammaStatic(j) corticalDrive(k) corticalDrive(k) initPos finalPos velocities(l) trialLength reps];
                end
            end
        end
    end
end
p = 1:size(outputMatrix,1);%randperm(size(outputMatrix,1));
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
