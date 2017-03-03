%% 
%This fuction finds the index for each condition in the 25 protocol files
%(Exprimental Condition).
% The first input is the data's second column which shows the status of the
% experiment. The second input is the condition of which we desire to find
% the interval indices.
%% 
function indexFound = experimentalConditionFinder(ExpProtocol,ExpCondition)
    ExpProtocol = ExpProtocol(:);
    ExpCondition = ExpCondition(:);
    trialIndices = find(ExpProtocol==-1000);
    numTrials = length(trialIndices);
    indexFound = [];
    trialCounter = 0;
    for i = 1 : numTrials
        trialCounter = trialCounter + 1;
        iseq = isequal(ExpProtocol(trialIndices(trialCounter)+1:trialIndices(trialCounter)+8),ExpCondition);
        if iseq
            if i == numTrials
                indexFound = [indexFound;trialIndices(trialCounter)+1 length(ExpProtocol)];
            else
                indexFound = [indexFound;trialIndices(trialCounter)+1 trialIndices(trialCounter+1)];
            end
        end
    end
end