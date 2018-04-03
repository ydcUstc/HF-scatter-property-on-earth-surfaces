function [z,max_height]=erweihailangboxing(fengji,pinpushu,jiaodushu)

% 3 2.438306 16.444115  4.053570
% 5 1.462983 9.866469   2.432142
% 7 1.044989 7.047480   1.737244
% 9 0.812770 5.481373   1.351190
% 11 0.664988 4.484760  1.105519
% 13 0.562683 3.794799  0.935439
% 15 0.487659 3.288826  0.810714
% 17 0.430288 2.901905  0.715336

wavewmin = [2.438306 1.462983 1.044989 0.812770 0.664988 0.562683 0.487659 0.430288];
wavewmax = [16.444115 9.866469 7.047480 5.481373 4.484760 3.794799 3.288826 2.90190];
wavewp=[4.053570 2.432142 1.737244 1.351190 1.105519 0.935439 0.810714 0.715336];

%-----------------------------------------------------
u=[3,5,7,9,11,13,15,17];
%---------------------------------------------------

if fengji>8
    fengji=8;
end
if fengji<1
    fengji=1;
end
fi=fengji;
wmin=wavewmin(fi);
wmax=wavewmax(fi);
wp=wavewp(fi);
ui=u(fi);
M=pinpushu;
N=jiaodushu;
wavewn=(wmax-wmin)/M;
thetawn=pi/N;
dx=1;
dy=1;
x=[0:dx:500];
y=[0:dy:300];
[x,y]=meshgrid(x,y);
z=zeros(size(x));
for wi=1:M
    for ki=1:N
        theta=-pi/2+(ki-1)*thetawn;
         epsin=rand*2*pi;
         w=wmin+(wi-1)*wavewn+wavewn/2;
         swi=0.81*exp(-7400/(w*ui+eps).^4)*2*(cos(theta)).^2/(pi*(w.^5+eps));
        an=sqrt(2*swi*wavewn*thetawn)*(1+1*randn);
       z1=w*w*x*cos(theta)/9.8+w*w*y*sin(theta)/9.8+epsin;
       z=an*cos(z1)+z;
    end
end
terrian0=z;
max_height=max(max(z));
[lx0,ly0]=size(terrian0);
height_vector=reshape(terrian0,[1,lx0*ly0]);
E_height=sum(height_vector)/length(height_vector);
height_vector=height_vector-E_height;
Var_height=sum(height_vector.^2)/length(height_vector);
delta_height=sqrt(Var_height);

surfl(x,y,z); 

colormap cool

shading interp;
lightangle(-45,30);
set(findobj(gca,'type','surface'),'FaceLighting','phong','AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',200)
axis([0 300 0 300 -10 10]);

