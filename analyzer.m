%The followings were already run. Uncomment to start from scratch 
clear
dataConstruction
gammaLocator
load newTrial

load flexorGIndex
load flexorLength
load flexorDesiredForce


%%
flexorLambdaPhasic = zeros(9,9,3,4,5);
flexorLambdaTonic = zeros(9,9,3,4,5);
flexorPhasicAmplitude = zeros(9,9,3,4,5);
flexorTonicAmplitude = zeros(9,9,3,4,5);
Gd = 0;
Gs = 0;
h = waitbar(0,'Analyzing flexor data');
steps = 0;
for i = 1 : 9
    Gs = 0;
    for j = 1 : 9
        for k = 1 : 3
            %disp(['Gs is:',num2str(Gs),'Gd is:',num2str(Gd),'tonic drive :',num2str(k)])
            waitbar(steps/9/9/3,h);
            if ~isempty(flexorGIndex{i,j})
                newTrialThisGamma = newTrial(flexorGIndex{i,j,k});
                if ((i==1) && (j ==7) && (k==2))
                    newTrialThisGamma(29140) = 1;
                end
                if ((i==2) && (j ==7) && (k==3))
                    newTrialThisGamma(52470) = 1;
                end
                flexorLengthThisGamma = flexorLength(flexorGIndex{i,j,k});
                flexorForceThisGamma = flexorDesiredForce(flexorGIndex{i,j,k});
                if (length(find(newTrialThisGamma==1)) < 4)
                    warning(['There are not enough trials when Gd = ',num2str(Gd),' and Gs = ',num2str(Gs)])
                end
                [l1,l2,phasic,tonic] = lambdaEstimator2(flexorLengthThisGamma,flexorForceThisGamma,newTrialThisGamma);
                if ~isempty(find(isnan(l1) == 1, 1))
                    disp('NAN')
                end
                if ~isempty(find(isnan(l2) == 1, 1))
                    disp('NAN')
                end
                flexorLambdaPhasic(i,j,k,:,:) = l1;
                flexorLambdaTonic(i,j,k,:,:) = l2;
                flexorPhasicAmplitude(i,j,k,:,:) = phasic;
                flexorTonicAmplitude(i,j,k,:,:) = tonic;
            end
            steps = steps + 1;
        end
        Gs = Gs + 25;
    end
    Gd = Gd + 25;
end
save FDP_Results flexorLambdaPhasic flexorLambdaTonic flexorPhasicAmplitude flexorTonicAmplitude
close(h)
%%
%Lambda estimator needs to be modified for extensor perutrbations
%The perturbations start with negative velocity
% load extensorGIndex
% load extensorLength
% load extensorDesiredForce
% 
% extensorLambdaPhasic = zeros(9,9,3,4,5);
% extesnorLambdaTonic = zeros(9,9,3,4,5);
% extensorPhasicAmplitude = zeros(9,9,3,4,5);
% extensorTonicAmplitude = zeros(9,9,3,4,5);
% Gd = 0;
% Gs = 0;
% h = waitbar(0,'Analyzing extensor data');
% steps = 0;
% for i = 1 : 9
%     Gs = 0;
%     for j = 1 : 9
%         for k = 1 : 3
%             %disp(['Gs is:',num2str(Gs),'Gd is:',num2str(Gd),'tonic drive :',num2str(k)])
%             waitbar(steps/9/9/3,h);
%             if ~isempty(extensorGIndex{i,j})
%                 newTrialThisGamma = newTrial(extensorGIndex{i,j,k});
%                 if ((i==1) && (j ==7) && (k==2))
%                     newTrialThisGamma(29140) = 1;
%                 end
%                 if ((i==2) && (j ==7) && (k==3))
%                     newTrialThisGamma(52470) = 1;
%                 end
%                 extensorLengthThisGamma = extensorLength(extensorGIndex{i,j,k});
%                 extensorForceThisGamma = extensorDesiredForce(extensorGIndex{i,j,k});
%                 if (length(find(newTrialThisGamma==1)) < 4)
%                     warning(['There are not enough trials when Gd = ',num2str(Gd),' and Gs = ',num2str(Gs)])
%                 end
%                 [l1,l2,phasic,tonic] = lambdaEstimator2(extensorLengthThisGamma,extensorForceThisGamma,newTrialThisGamma);
%                 if ~isempty(find(isnan(l1) == 1, 1))
%                     disp('NAN')
%                 end
%                 if ~isempty(find(isnan(l2) == 1, 1))
%                     disp('NAN')
%                 end
%                 extensorLambdaPhasic(i,j,k,:,:) = l1;
%                 extesnorLambdaTonic(i,j,k,:,:) = l2;
%                 extensorPhasicAmplitude(i,j,k,:,:) = phasic;
%                 extensorTonicAmplitude(i,j,k,:,:) = tonic;
%             end
%             steps = steps + 1;
%         end
%         Gs = Gs + 25;
%     end
%     Gd = Gd + 25;
% end
% save EIP_Results extensorLambdaPhasic extesnorLambdaTonic extensorPhasicAmplitude extensorTonicAmplitude
% close(h)
%%
plotResults