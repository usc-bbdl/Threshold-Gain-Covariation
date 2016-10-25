numFiles = 16;
gammaStatic = floor(linspace(25,175,4));
gammaDynamic = floor(linspace(25,175,4));
velocities = floor(linspace(10,100,10));
position = floor(linspace(-75,75,10));
corticalDrive = [0];
reps = 10;
trialLength = 2;
% initPos = -24;
% finalPos = 18;

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
header = 'GammDynamic1,GammaStatic1,GammDynamic2,GammaStatic2,CortexDrive1,CortexDrive2,initPos,finalPos,velocity,trialLength,reps\n';
startFileIndex = 26;
for i = 1 :  numFiles
    fileIndex = startFileIndex + i - 1;
    fileName = strcat(['protocolFiles/finalProtocol',num2str(fileIndex),'.txt']);
    fid = fopen(fileName,'wt');
    fprintf(fid, header);
    fclose(fid);
    dlmwrite(fileName,trialsPerFile,'delimiter',',','newline', 'pc','-append');
    dlmwrite(fileName,outputMatrixPermut((i-1)*trialsPerFile+1:i*trialsPerFile,:),'delimiter',',','newline', 'pc','-append');
end
i = i + 1;
fileIndex = fileIndex + 1;
if ~(size(outputMatrixPermut((i-1)*trialsPerFile+1:end,:),1)==0)
    fileName = strcat(['protocolFiles/finalProtocol',num2str(fileIndex),'.txt']);
    fid = fopen(fileName,'wt');
    fprintf(fid, header);
    fclose(fid);
    dlmwrite(fileName,size(outputMatrixPermut((i-1)*trialsPerFile+1:end,:),1),'delimiter',',','newline', 'pc','-append');
    dlmwrite(fileName,outputMatrixPermut((i-1)*trialsPerFile+1:end,:),'delimiter',',','newline', 'pc','-append');
end

