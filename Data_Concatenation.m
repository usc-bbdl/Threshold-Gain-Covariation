clear
clc
allData=[];
for i =1:25
    data = dlmread(['data/dataProtocolRev2_',num2str(i),'.txt'],',',2,0); % reads the txt file
    allData=[allData;data(:,1:8)];
end
save data/allDataCat allData