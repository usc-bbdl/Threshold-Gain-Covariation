numFiles = 40;
gammaStatic = 0:25:200;
gammaDynamic = 0:25:200;
velocities = 10:10:100;
corticalDrive = [0];
reps = 10;
trialLength = 4;
% initPos = -24;
% finalPos = 18;
position = [-50:10:50];
outputMatrix = zeros(length(gammaStatic)*length(gammaDynamic)*length(velocities)*length(corticalDrive),11);
perturbation = 10;%0.04*180/pi;
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
    fileName = strcat(['protocolFiles/servoPerturb',num2str(i),'.txt']);
    dlmwrite(fileName,trialsPerFile,'delimiter',',','newline', 'pc');
    dlmwrite(fileName,outputMatrixPermut((i-1)*trialsPerFile+1:i*trialsPerFile,:),'delimiter',',','newline', 'pc','-append');
end
i = i + 1;
if ~(size(outputMatrixPermut((i-1)*trialsPerFile+1:end,:),1)==0)
    fileName = strcat(['protocolFiles/servoPerturb',num2str(i),'.txt']);
    dlmwrite(fileName,size(outputMatrixPermut((i-1)*trialsPerFile+1:end,:),1),'delimiter',',','newline', 'pc');
    dlmwrite(fileName,outputMatrixPermut((i-1)*trialsPerFile+1:end,:),'delimiter',',','newline', 'pc','-append');
end

