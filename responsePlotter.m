function responsePlotter(data,expCondition,muscleChoice)
if nargin == 2
        muscleChoice = 1;
    end
    if muscleChoice == 1
        trialOnsetFlag = -1;
    elseif muscleChoice == 2
        trialOnsetFlag = -2;
    else
        error('Muscle choice must be either 1 or 2');
    end
gammaD = expCondition.gammaD;
gammaS = expCondition.gammaS;
pos = expCondition.pos;
vel = expCondition.vel;


expProt = data.expProt;
mLength = data.length;
mForce = data.force;

expCondition = [gammaD,gammaS,0,gammaD,gammaS,0,pos,vel];
indexFound = experimentalConditionFinder(expProt,expCondition);
if isempty(indexFound)
    warning('No matched experimental condition found')
else
    mLengthThisTrial = mLength(indexFound(1):indexFound(2));
    mForceThisTrial = mForce(indexFound(1):indexFound(2));
    expProtThisTrial = expProt(indexFound(1):indexFound(2));
    perturbationOnetIndex = find(expProtThisTrial == trialOnsetFlag);
    perturbationOnetIndex = perturbationOnetIndex(2:end);
    subplot(2,1,1)
    hold on
    subplot(2,1,2)
    hold on
    for i = 1 : length(perturbationOnetIndex)-1
            mLengthThisRep = mLengthThisTrial(perturbationOnetIndex(i):perturbationOnetIndex(i+1));
            subplot(2,1,1)
            plot(mLengthThisRep)
            mForceThisRep = mForceThisTrial(perturbationOnetIndex(i):perturbationOnetIndex(i+1));
            subplot(2,1,2)
            plot(mForceThisRep)
    end
end
end