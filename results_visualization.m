function [ ] = results_visualization( reflexAmplitude, which_gamma,other_gamma,which_variable,other_variable,positionRange,velocityRange)
%This function is to visualize results of the gamma swipe experiment
%
%   Inputs for this function are:
%
%   reflexAmplitude: the main output of the rest of the code. This matrix
%   contains reflex amplitudes
%
%   which_gamma: The gamma which we want to have the sweep on. It can be
%   either 'gamma_d' or 'gamma_s' (as a string) which stand for gamma
%   dynamic and gamma static respectedly.
%
%   other_gamma: The value of the other gamma. It should be an integer
%   corresponding to the column of the gamma vector.
%
%   which_variable: The variable which we want to have the gamma sweep as a function of it. It can be
%   either 'vel' or 'pos' (as a string) which stand for position
%   and velocity respectedly.
%
%   other_variable: The value of the other variable (position or velocity). It should be an integer
%   corresponding to the column of the variable vector.
%
%Example:
%
%results_visualization(reflexAmplitude,'gamma_d',2,'vel',2,positionRange,velocityRange)
%will show the resulsts for the gamma dynamic as a function of the velocity while the gamma static and the position both are in their second configurations.

    mode=[which_gamma which_variable];
    switch mode
        case 'gamma_dvel'
            gamma000_out=squeeze(reflexAmplitude(1,other_gamma,other_variable,:)); %gamma=0    veloc=40
            gamma100_out=squeeze(reflexAmplitude(2,other_gamma,other_variable,:)); %gamma=100  veloc=40
            gamma200_out=squeeze(reflexAmplitude(3,other_gamma,other_variable,:)); %gamma=200  veloc=40
            plot(velocityRange,gamma000_out);hold on
            plot(velocityRange,gamma100_out);
            plot(velocityRange,gamma200_out);
            legend('gamma_d=0','gamma_d=100','gamma_d=200')
            xlabel('vel');ylabel('Ref_Amp')        
        case 'gamma_dpos'
            gamma000_out=squeeze(reflexAmplitude(1,other_gamma,:,other_variable)); %gamma=0    veloc=40
            gamma100_out=squeeze(reflexAmplitude(2,other_gamma,:,other_variable)); %gamma=100  veloc=40
            gamma200_out=squeeze(reflexAmplitude(3,other_gamma,:,other_variable)); %gamma=200  veloc=40
            plot(positionRange,gamma000_out);hold on
            plot(positionRange,gamma100_out);
            plot(positionRange,gamma200_out);
            legend('gamma_d=0','gamma_d=100','gamma_d=200')
            xlabel('pos');ylabel('Ref_Amp')        
        case 'gamma_svel'
            gamma000_out=squeeze(reflexAmplitude(other_gamma,1,other_variable,:)); %gamma=0    veloc=40
            gamma100_out=squeeze(reflexAmplitude(other_gamma,2,other_variable,:)); %gamma=100  veloc=40
            gamma200_out=squeeze(reflexAmplitude(other_gamma,3,other_variable,:)); %gamma=200  veloc=40
            plot(velocityRange,gamma000_out);hold on
            plot(velocityRange,gamma100_out);
            plot(velocityRange,gamma200_out);
            legend('gamma_s=0','gamma_s=100','gamma_s=200')
            xlabel('vel');ylabel('Ref_Amp')        
        case 'gamma_spos'
            gamma000_out=squeeze(reflexAmplitude(other_gamma,1,:,other_variable)); %gamma=0    veloc=40
            gamma100_out=squeeze(reflexAmplitude(other_gamma,2,:,other_variable)); %gamma=100  veloc=40
            gamma200_out=squeeze(reflexAmplitude(other_gamma,3,:,other_variable)); %gamma=200  veloc=40
            plot(positionRange,gamma000_out);hold on
            plot(positionRange,gamma100_out);
            plot(positionRange,gamma200_out);
            legend('gamma_s=0','gamma_s=100','gamma_s=200')
            xlabel('pos');ylabel('Ref_Amp')
    end    
end

