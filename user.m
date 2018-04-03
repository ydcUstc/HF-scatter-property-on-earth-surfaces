% lamda=5:1:100;
% theta_in=0:1:90;
% total=0;
% for i=1:length(lamda)
% %     for j=1:91
%         total(i)=sanshe(lamda(i),theta_in(30),8,150,0);
% %     end
% end
% % mesh(lamda,theta_in,total);
% plot(lamda,total)
% hold on
% %%
% for j=1:5:length(lamda)
%     total=0;
%     for i=1:length(theta_in)
% 
%         total(i)=sanshe(lamda(j),theta_in(i),8,150,0);
% 
%     end
% 
%     plot(theta_in,total);
%     hold on;
% end
%%
theta_in=0:1:90;
for j=5:1:8
    total=0;
    for i=1:length(theta_in)
        total(i)=sanshe(20,theta_in(i),j,550,0);
    end
    plot(theta_in,total);
    hold on;
end
%%
x=0:28.34:28.34*209;
y=0:28.34:28.34*331;
mesh(x,y,a);
%%
terrian0=flat;
terrian=flat_rou;
terrian_r=terrian;
[lx,ly]=size(terrian_r);
[lx0,ly0]=size(terrian0);
x=0:28.34:28.34*(ly-1);
y=0:28.34:28.34*(lx-1);
for i=1:lx
    for j=1:ly
        terrian_r(i,j)=28.34*sqrt((i)^2+(j)^2);
    end
end

A=reshape(terrian_r,[1,lx*ly]);
B=reshape(terrian,[1,lx*ly]);
plot(A,B);
height_vector=reshape(terrian0,[1,lx0*ly0]);
E_height=sum(height_vector)/length(height_vector);
height_vector=height_vector-E_height;
Var_height=sum(height_vector.^2)/length(height_vector);
delta_height=sqrt(Var_height);
%%
integ=0;
i=0;
for lamda=10:5:100
    i=i+1;
    j=0;
    for theta_i=0:5:90
        j=j+1;
        integ(i,j)=ka(lamda,theta_i,3);
    end
end
%%
theta_in=0:1:90;
for j=10:10:10
    total=0;
    for i=1:length(theta_in)
        total(i)=ka(j,theta_in(i),3);
    end
    feinieer=(cos(theta_in*pi/180)-sqrt(16-sin(theta_in*pi/180).^2))./(cos(theta_in*pi/180)+sqrt(16-sin(theta_in*pi/180).^2));
    feinieer=feinieer.^2;
    plot(theta_in,feinieer-total);
    hold on;
end
%%
integ=0;
i=0;
for wind=4
    i=i+1;
    j=0;
    for theta_in=1:1:90
        j=j+1;
        integ(i,j)=sanshe(20,theta_in,wind,150,0);
    end
end
%%
f=3:27/1000:30;
lamda=300*ones(1,length(f))./f;
for j=30:10:30
    total=0;
    for i=1:length(f)
        total(i)=sanshe(lamda(i),30,5,350,0);
    end
%     feinieer=(cos(theta_in*pi/180)-sqrt(16-sin(theta_in*pi/180).^2))./(cos(theta_in*pi/180)+sqrt(16-sin(theta_in*pi/180).^2));
%     feinieer=feinieer.^2;
    plot(f,1-total);
    reflect=10*log10(1-total);
    hold on;
end