function [integ]=sanshe(lamda,theta_in,wind_level,accuracy,wave_dir)
% lamda=20;
% theta_in=30;
% wind_level=8;
% accuracy=150;
% wave_dir=0;

k_in=2*pi/lamda;
%入射波数k_in

theta_in=theta_in*pi/180;
%入射沿x方向正向
%入射角度为theta_in
% theta_s1=-pi/2:0.01:pi/2;
% psi_s1=-3*pi/2:0.01:-pi/2;
theta_s1=0:0.005:pi/2;
psi_s1=0:0.005:2*pi;

theta_s=ones(length(psi_s1),1)*theta_s1;
psi_s=psi_s1'*ones(1,length(theta_s1));
%散射角度theta_s,psi_s

[P_M,k_one_d]=bopu(wind_level,accuracy);
%产生一维谱P_M，获得波数k的标值k_one_d

k_ocean_max=max(k_one_d);
k_ocean_step=k_ocean_max/600;
k_ocean_1=(0:k_ocean_step:k_ocean_max);
k_ocean_2=(-k_ocean_max:k_ocean_step:k_ocean_max);
k_ocean_x=ones(length(k_ocean_2),1)*k_ocean_1;
k_ocean_y=k_ocean_2'*ones(1,length(k_ocean_1));
%生成海浪kx值场、ky值场
k2=(k_ocean_x).^2+(k_ocean_y).^2;
k=sqrt(k2);
%生成海浪k值场

wave_dir=wave_dir*pi/180;
%海浪方向
P_M=[P_M,0,0];
overflow=k>k_ocean_max;
k(overflow)=(length(P_M)-1)*k_ocean_max/accuracy;
%海浪k值场限幅
W=2/pi*((k_ocean_x*cos(wave_dir)+k_ocean_y*sin(wave_dir)).^2./k2.*k).*P_M(round(k/k_ocean_max*accuracy)+1);
W=W';
%二维海浪功率谱W
epsilon=81;
lh_=(cos(theta_s)+sqrt(epsilon-sin(theta_s).^2));
lv_=(epsilon*cos(theta_s)+sqrt(epsilon-sin(theta_s).^2));
l_h=(cos(theta_in)+sqrt(epsilon-sin(theta_in).^2));
l_v=(epsilon*cos(theta_in)+sqrt(epsilon-sin(theta_in).^2));
A_hh=(1-epsilon)*cos(psi_s)./(lh_.*l_h);
A_hv=(epsilon-1)*sqrt(epsilon-sin(theta_in).^2).*sin(psi_s)./(lh_.*l_v);
A_vh=-(epsilon-1)*sqrt(epsilon-sin(theta_s).^2).*sin(psi_s)./(lv_.*l_h);
A_vv=(epsilon-1)*(cos(psi_s).*sqrt(epsilon-sin(theta_in).^2).*sqrt(epsilon-sin(theta_s).^2)-epsilon*sin(theta_in).*sin(theta_s))./(lv_.*l_v);

sigma=4/pi*k_in^4*cos(theta_in)^2*sin(theta_s).^2.*W(round(2*k_in*sin(theta_in)/k_ocean_max*601)+1,601).*(A_hh.^2+A_vh.^2);
% amp=4/pi*k_in^4*cos(theta_in)^2*sin(theta_s).^2.*W(round(2*k_in*sin(theta_in)/k_ocean_max*301)+1,301);

% sigma(:,:,1)=amp.*(A_hh.^2+A_vh.^2);
% sigma(:,:,2)=amp.*A_hh.^2;
% sigma(:,:,3)=amp.*A_vh.^2;
% sigma(:,:,4)=amp.*(A_hv.^2+A_vv.^2);
% sigma(:,:,5)=amp.*A_hv.^2;
% sigma(:,:,6)=amp.*A_vv.^2;


% z=sin(pi/2-theta_s).*cos(psi_s);
% y=sin(pi/2-theta_s).*sin(psi_s);
% x=cos(pi/2-theta_s);
% axis([-1 1 -1 1 0 1]);
% mesh(x,y,z,(sigma));

% x=sin(theta_s).*cos(psi_s);
% y=sin(theta_s).*sin(psi_s);
% z=cos(theta_s);
% axis([-1 1 -1 1 0 1]);
% mesh(x,y,z,(sigma));
% colorbar;

% for i=1:6
%     subplot(2,3,i);
%     axis([-1 1 -1 1 0 1]);
%     mesh(x,y,z,(sigma(:,:,i)));
%     xlabel('x');
%     ylabel('y');
%     zlabel('z');
%     colorbar;
%     axis off;
% end

% weight=sigma.*sin(pi/2-theta_s);
% integ=0;
% for i=1:length(theta_s)
%     for j=1:length(psi_s)
%         integ=weight(j,i)*0.01*0.01+integ;
%     end
% end

weight=sigma.*sin(theta_s);
integ=0;
for i=1:length(theta_s1)
    for j=1:length(psi_s1)
        integ=weight(j,i)*0.005*0.005+integ;
    end
end

%theta_s1,psi_s1,