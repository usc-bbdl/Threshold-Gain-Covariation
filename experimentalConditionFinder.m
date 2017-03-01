%This fuction finds the index for each condition in the 25 protocol files
%(Exprimental Condition).
% The first input is the data's second column which shows the status of the
% experiment. The second input is the condition of which we desire to find the
% interval indices.
function indexFound = experimentalConditionFinder(expProtocol,expCondition)
    expProtocol = expProtocol(:);
    expCondition = expCondition(:);
    trialIndices = find(expProtocol==-1000);
    numTrials = length(trialIndices);
    indexFound = [];
    trialCounter = 0;
    for i = 1 : numTrials
        trialCounter = trialCounter + 1;
        iseq = isequal(expProtocol(trialIndices(trialCounter)+1:trialIndices(trialCounter)+8),expCondition);
        if iseq
            if i == numTrials
                indexFound = [indexFound;trialIndices(trialCounter)+1 length(expProtocol)];
            else
                indexFound = [indexFound;trialIndices(trialCounter)+1 trialIndices(trialCounter+1)];
            end
        end
    end
end