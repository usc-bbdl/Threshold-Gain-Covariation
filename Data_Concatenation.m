%This script is for concatenating all 25 .txt files, into 1 huge .mat file
%called AllData.mat .

AllData=[];
for i =1:25
    data = dlmread(['dataProtocolRev2_',num2str(i),'.txt'],',',2,0); % reads the txt file
   
   AllData=[AllData;data(:,1:8)];
end
