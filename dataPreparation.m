numFiles = 1;
fileName = cell(numFiles,1);
fileName{1} = 'data/realTimeData2016_09_20_14_29_48.txt';
fileName{2} = 'data/test1.txt';
fileName{3} = 'data/test1.txt';

extensorLength = [];
extensorMeasuredForce = [];
extensorDesiredForce = [];
extensorGammaStatic = [];
extensorGammaDynamic = [];
extensorCorticalDrive = [];

flexorLength = [];
flexorMeasuredForce = [];
flexorDesiredForce = [];
flexorGammaStatic = [];
flexorGammaDynamic = [];
flexorCorticalDrive = [];

newTrial = [];
time = [];
%Check column number from the header
%%
for fileIndex = 1 : numFiles
    disp('Concatinating dataTemp 1')
    dataTemp = dlmread(fileName{fileIndex},',',1,0);
    time = [time;dataTemp(:,1)];
    extensorLength = [extensorLength; dataTemp(:,2)];
    extensorDesiredForce = [extensorDesiredForce; dataTemp(:,11)];
    extensorMeasuredForce = [extensorMeasuredForce; dataTemp(:,4)];
    extensorGammaStatic = [extensorGammaStatic; dataTemp(:,19)];
    extensorGammaDynamic = [extensorGammaDynamic; dataTemp(:,20)];
    extensorCorticalDrive = [extensorCorticalDrive;dataTemp(:,17)];

    flexorLength = [flexorLength; dataTemp(:,3)];
    flexorDesiredForce = [flexorDesiredForce; dataTemp(:,12)];
    flexorMeasuredForce = [flexorMeasuredForce; dataTemp(:,5)];
    flexorGammaStatic = [flexorGammaStatic; dataTemp(:,21)];
    flexorGammaDynamic = [flexorGammaDynamic; dataTemp(:,22)];
    flexorCorticalDrive = [flexorCorticalDrive;dataTemp(:,18)];
    newTrial = [newTrial;dataTemp(:,19)];
end

data.time = time;
data.extensorLength = extensorLength;
data.extensorDesiredForce = extensorDesiredForce;
data.extensorMeasuredForce = extensorMeasuredForce;
data.extensorGammaStatic = extensorGammaStatic;
data.extensorGammaDynamic = extensorGammaDynamic;
data.extensorCorticalDrive = extensorCorticalDrive;

data.flexorLength = flexorLength;
data.flexorDesiredForce = flexorDesiredForce;
data.flexorMeasuredForce = flexorMeasuredForce;
data.flexorGammaStatic = flexorGammaStatic;
data.flexorGammaDynamic = flexorGammaDynamic;
data.flexorCorticalDrive = flexorCorticalDrive;
data.newTrial = newTrial;
data.time = time;
save data/dataAllFiles data
