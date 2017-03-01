%The output of this function is the indices of each repetiotion's interval.
%Its inputs are GammaDynamic, GammaStatic, Position, Velocity, and
%Repetition.
function Interval= Index_Finder(GammaDynamic,GammaStatic,Position,Velocity,Repetition)
load Data\Matrix_5D;   %Loading the 5D matrices. Each element of Matrix_5D_B and Matric_5D_E determines the beginning and ending the desired repetition of desired condition respectively. 
gamma_d_1_r=[0 25 50 75 100];
gamma_s_1_r=[0 25 50 75 100];
pos_r=[30 35 40 45 50 55 60 65 70 75 80 85];
vel_r=[10 20 30 40 50 60 70 80 90 100];

a=find(gamma_d_1_r==GammaDynamic);
b=find(gamma_s_1_r==GammaStatic);
c=find(pos_r==Position);
d=find(vel_r==Velocity);
r=Repetition;
Interval = [Matrix_5D_B(a,b,c,d,r),Matrix_5D_E(a,b,c,d,r)];
end
