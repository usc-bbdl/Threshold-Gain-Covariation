%load('muscleLength.mat')
load('extensorGammaDynamic.mat')
load('extensorGammaStatic.mat')
load('extensorCorticalDrive.mat')
load('flexorGammaDynamic.mat')
load('flexorGammaStatic.mat')
load('flexorCorticalDrive.mat')
gammaDynamicIterator = 0;
gammaStaticIterator = 0;
steps = 0;
h = waitbar(0,'Locating Gammas');
extensorGIndex = cell(9,9,3);
flexorGIndex = cell(9,9,3);
%row is for gammaDynamic
%column is for gammaStatic
corticalDrive = [0 900 1250];
for i = 1 : 9
    for j = 1 : 9
        for k = 1 : 3
            waitbar(steps/9/9/3,h);
            extensorDynamicStaticIntersect = intersect(find(extensorGammaDynamic == gammaDynamicIterator),find(extensorGammaStatic == gammaStaticIterator));
            extensorDynamicStaticIntersect = intersect(extensorDynamicStaticIntersect,find(extensorCorticalDrive == corticalDrive(k)));
            extensorGIndex{i,j,k} = extensorDynamicStaticIntersect;
        
            flexorDynamicStaticIntersect = intersect(find(flexorGammaDynamic == gammaDynamicIterator),find(flexorGammaStatic == gammaStaticIterator));
            flexorDynamicStaticIntersect = intersect(flexorDynamicStaticIntersect,find(flexorCorticalDrive == corticalDrive(k)));
            flexorGIndex{i,j,k} = flexorDynamicStaticIntersect;
            steps = steps + 1;
        end
        gammaStaticIterator = gammaStaticIterator + 25;
    end 
    gammaDynamicIterator = gammaDynamicIterator + 25;
    gammaStaticIterator = 0;
end
save flexorGIndex flexorGIndex
save extensorGIndex extensorGIndex
close(h)
clear gammaDynamic
clear gammaStatic