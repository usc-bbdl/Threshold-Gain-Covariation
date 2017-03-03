%The output of this function is the indices of each repetiotion's interval.
%Its inputs are GammaDynamic, GammaStatic, Position, Velocity, and
%Repetition.
function Interval= Index_Finder(GammaDynamicD,GammaStaticD,PositionD,VelocityD,Repetition)
load Data\IndMatrices;   %Loading the 5D matrices. Each element of Matrix_5D_B and Matric_5D_E determines the beginning and ending the desired repetition of desired condition respectively. 
gamma_d=[0 25 50 75 100];
gamma_s=[0 25 50 75 100];
pos=[30 35 40 45 50 55 60 65 70 75 80 85];
vel=[10 20 30 40 50 60 70 80 90 100];

a=find(gamma_d==GammaDynamicD);
b=find(gamma_s==GammaStaticD);
c=find(pos==PositionD);
d=find(vel==VelocityD);
r=Repetition;
Interval = [StartingIndices(a,b,c,d,r),EndingIndices(a,b,c,d,r)];
end
