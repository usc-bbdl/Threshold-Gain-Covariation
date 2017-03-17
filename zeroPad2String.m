
function stringOut = zeroPad2String(inputNumber,desiredStringLength)
    stringOut = num2str(inputNumber);
    while (length(stringOut) < desiredStringLength)
        stringOut = strcat('0',stringOut);
    end
end
