clear
clc
expProtChan = 2;

load data/test1
velocity = 100;
Gd = [0;100;200];
Gs = [0;0;0];
cortex = 0;
pos = 75;
figure
subplot(2,2,1)
hold on
subplot(2,2,2)
hold on
subplot(2,2,3)
hold on
subplot(2,2,4)
hold on
expCondition = [Gd(1),Gs(1),cortex,Gd(1),Gs(1),cortex,pos,velocity];
indexFound = experimentalConditionFinder(data(:,expProtChan),expCondition);
subplot(2,2,1)
plot(data(indexFound(1):indexFound(2),3))
subplot(2,2,2)
plot(data(indexFound(1):indexFound(2),4))
subplot(2,2,3)
plot(data(indexFound(1):indexFound(2),7))
subplot(2,2,4)
plot(data(indexFound(1):indexFound(2),8))

expCondition = [Gd(2),Gs(2),cortex,Gd(2),Gs(2),cortex,pos,velocity];
indexFound = experimentalConditionFinder(data(:,expProtChan),expCondition);
subplot(2,2,1)
plot(data(indexFound(1):indexFound(2),3))
subplot(2,2,2)
plot(data(indexFound(1):indexFound(2),4))
subplot(2,2,3)
plot(data(indexFound(1):indexFound(2),7))
subplot(2,2,4)
plot(data(indexFound(1):indexFound(2),8))

expCondition = [Gd(3),Gs(3),cortex,Gd(3),Gs(3),cortex,pos,velocity];
indexFound = experimentalConditionFinder(data(:,expProtChan),expCondition);
subplot(2,2,1)
plot(data(indexFound(1):indexFound(2),3))
subplot(2,2,2)
plot(data(indexFound(1):indexFound(2),4))
subplot(2,2,3)
plot(data(indexFound(1):indexFound(2),7))
subplot(2,2,4)
plot(data(indexFound(1):indexFound(2),8))