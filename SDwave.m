function [data1]=SDwave(N,initWave) 
%输入N为：方阵的维数2^N+1,在方阵的四个角的顶点上放置的初值，maxWave为波动的程度 
%这里定为四个初值一样，这是可拼接的必要条件 
% Example: 
%       tic; 
%       d=SquareDiamond2(5,0,10); 
%       d=d-mod(d,1); 
%       colormap(pink); 
% 
%       surf(d); 
%       shading faceted 
%       axis equal 
%       toc 

%n=2^N; 
% data=zeros(n+1); 
% data(1,1)=initvalue; 
% data(1,n+1)=initvalue; 
% data(n+1,1)=initvalue; 
% data(n+1,n+1)=initvalue; 
data=initWave;
r0=0.03;
for i1=1:N
   w=(N-i1)/(N-1);
   r=r0*w*w;
   data=mytry(data,r); 
   
   nd=size(data,1);
for idn=2:nd-1
    for idm=2:nd-1
        data1(idn,idm)=(1/6)*(data(idn,idm-1)+data(idn,idm+1)+data(idn+1,idm)+data(idn-1,idm)+data(idn,idm)+data(idn,idm));
    end
end

end
colormap(winter);
surf(data1);



    

function [x]=rnd(absvalue) 
%扩展的随机函数生成器，产生绝对值小于absvalue的随机实数 
x=(rand(1)-0.5)*2*absvalue; 

function [data]=mytry(initdata,r) 
%square========================================= 
%x---x 
%----- 
%--0--  由四个x定中间的0 
%----- 
%x---x 
m=2;
n0=size(initdata,1);
for i1=1:n0
    for i2=1:n0
    data(i1*2-1,i2*2-1)=initdata(i1,i2);
    end
end
  n=n0*2-2;
for i=1:m:n 
  for j=1:m:n 
     data((i+i+m)/2,(j+j+m)/2)=(data(i,j)+data(i,j+m)+data(i+m,j)+data(i+m,j+m))/4+rnd(r); 
  end 
end 
%diamond======================================== 
%---x-- 
%----- 
%x-0-x  由四个x定中间的0 
%----- 
%---x-- 

%钻石步骤的横向部分 
%line No.1 and last 
for j=1+m/2:m:n 
  data(1,j)=(data(1,j+m/2)+data(1+m/2,j)+data(1,j-m/2)+data(n+1-m/2,j))/4+rnd(r); 
  data(n+1,j)=data(1,j); 
end 
%middle 
for i=1+m:m:n 
  for j=1+m/2:m:n 
     data(i,j)=(data(i,j+m/2)+data(i+m/2,j)+data(i,j-m/2)+data(i-m/2,j))/4+rnd(r); 
  end 
end 

%钻石步骤的纵向部分 
%line No.1 and last 
for i=1+m/2:m:n 
  data(i,1)=(data(i,1+m/2)+data(i+m/2,1)+data(i,n+1-m/2)+data(i-m/2,1))/4+rnd(r); 
  data(i,n+1)=data(i,1); 
end 
%middle 
for i=1+m/2:m:n 
  for j=1+m:m:n 
     data(i,j)=(data(i,j+m/2)+data(i+m/2,j)+data(i,j-m/2)+data(i-m/2,j))/4+rnd(r); 
  end 
end 

% if (m>2) 
%   data=mytry(data,m/2,r/3,n); 
% end 
%