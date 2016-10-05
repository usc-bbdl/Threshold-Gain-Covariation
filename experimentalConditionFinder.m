function indexFound = experimentalConditionFinder(expProtocol,expCondition)
    expProtocol = expProtocol(:);
    expCondition = expCondition(:);
    trialIndeces = find(expProtocol==-1000);
    numTrials = length(trialIndeces);
    indexFound = [];
    trialCounter = 0;
    for i = 1 : numTrials
        trialCounter = trialCounter + 1;
        iseq = isequal(expProtocol(trialIndeces(trialCounter)+1:trialIndeces(trialCounter)+8),expCondition);
        if iseq
            if i == numTrials
                indexFound = [indexFound;trialIndeces(trialCounter)+1 length(expProtocol)];
            else
                indexFound = [indexFound;trialIndeces(trialCounter)+1 trialIndeces(trialCounter+1)];
            end
        end
    end
end