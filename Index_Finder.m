function Interval= Index_Finder(GD,GS,P,V,Rep)
load Data\Matrix_5D;
gamma_d_1_r=[0 25 50 75 100];
gamma_s_1_r=[0 25 50 75 100];
pos_r=[30 35 40 45 50 55 60 65 70 75 80 85];
vel_r=[10 20 30 40 50 60 70 80 90 100];

a=find(gamma_d_1_r==GD);
b=find(gamma_s_1_r==GS);
c=find(pos_r==P);
d=find(vel_r==V);
r=Rep;
Interval = [Matrix_5D_B(a,b,c,d,r),Matrix_5D_E(a,b,c,d,r)];
end
