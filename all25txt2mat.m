for i =1:25
    data = dlmread(['data/finalProtocol',num2str(i),'Data.txt'],',',3,0); % reads the txt file
    save (['data/sweep_',num2str(i)], 'data')                                                % saves the MATLAB file
    i
end