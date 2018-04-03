% [lx,ly]=size(mountain);
% x=0:28.34:28.34*(ly-1);
% y=0:28.34:28.34*(lx-1);
% mesh(x,y,mountain);
% %%
% [lx,ly]=size(flat(30:40,30:40));
% x=0:30:30*(ly-1);
% y=0:30:30*(lx-1);
% mesh(x,y,flat(30:40,30:40));
% axis([0 300 0 300 -1000 1000]);
% %%
% [lx,ly]=size(flat);
% x=0:30:30*(ly-1);
% y=0:30:30*(lx-1);
% mesh(x,y,flat);
% axis([0 9000 0 8000 -1000 1000]);
% 
% %%
function integ=ka(lamda,sitai,epsilon)
% lamda=20;
epsilon = 16;
% sitai=30;
l_mountain=3000;
l_flat=500;
deta_mountain=192;
deta_flat=9;
l=l_flat;
deta = deta_flat;
 
c=3*10e8;
f= c/lamda;
k = 2*pi/lamda;



 
theta_s1=0:0.01:pi/2;
psi_s1=0:0.01:2*pi;

sitas=ones(length(psi_s1),1)*theta_s1;
fais=psi_s1'*ones(1,length(theta_s1));
faii = 0;
sitai = sitai * pi/180.0;

 
ro2 = -2/l/l;
 
qx = k*(sin(sitas).*cos(fais)-sin(sitai)*cos(faii));
qy = k*(sin(sitas).*sin(fais)-sin(sitai)*sin(faii));
qz = k*(cos(sitas)+cos(sitai));
q = sqrt(qx.*qx+qy.*qy+qz.*qz);
 
Rh = (cos(sitai)-sqrt(epsilon-sin(sitai)*sin(sitai)))/(cos(sitai)+sqrt(epsilon-sin(sitai)*sin(sitai)));
Rv = (epsilon*cos(sitai)-sqrt(epsilon-sin(sitai)*sin(sitai)))/(epsilon*cos(sitai)+sqrt(epsilon-sin(sitai)*sin(sitai)));
 
vsni = sin(sitai)*cos(sitas).*cos(fais-faii)+cos(sitai)*sin(sitas);
vins = -cos(sitai)*sin(sitas).*cos(fais+faii)+sin(sitai)*cos(sitas);
hsni = -sin(sitai)*sin(fais-faii);
hins = sin(sitas).*sin(fais-faii);
nsni = sin(sitai)*sin(sitas).*cos(fais-faii)-cos(sitai)*cos(sitas);
 
Uhh = q.*abs(qz).*(Rh*hsni.*hins+Rv*vsni.*vins)./(hsni.*hsni+vsni.*vsni)/k./qz;
Uvh = q.*abs(qz).*(Rh*vsni.*hins-Rv*hsni.*vins)./(hsni.*hsni+vsni.*vsni)/k./qz;
Uvv = q.*abs(qz).*(Rh*vsni.*vins+Rv*hsni.*hins)./(hsni.*hsni+vsni.*vsni)/k./qz;
Uhh = q.*abs(qz).*(Rh*hsni.*vins-Rv*vsni.*hins)./(hsni.*hsni+vsni.*vsni)/k./qz;
 
sigma = ((k*q.*abs(Uhh)).^2)/2.0./power(qz,4.0)/deta/deta/abs(ro2).*exp(-(qx.*qx+qy.*qy)/2.0./(qz.^2)/deta/deta/abs(ro2));
overflow=sigma>1;
sigma(overflow)=0;

% x=sin(sitas).*cos(fais);
% y=sin(sitas).*sin(fais);
% z=cos(sitas);
% axis([-1 1 -1 1 0 1]);
% mesh(x,y,z,(sigma));
% colorbar;

weight=sigma.*sin(sitas);
integ=0;
for i=1:length(theta_s1)
    for j=1:length(psi_s1)
        integ=weight(j,i)*0.01*0.01+integ;
    end
end