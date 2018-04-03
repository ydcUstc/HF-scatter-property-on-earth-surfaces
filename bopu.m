function [s,w]=bopu(fengji,duanshu)
u=[3,5,7,9,11,13,15,17];
wavewmax = [16.444115 9.866469 7.047480 5.481373 4.484760 3.794799 3.288826 2.90190];
if fengji>8
    fengji=8;
end
if fengji<1
    fengji=1;
end
fi=fengji;
u=u(fi);
wmin=0;
wmax=wavewmax(fi);
m=duanshu;
wavemn=(wmax-wmin)/m;
w=[wmin:wavemn:wmax];
s=0.81*exp(-7400./(w*u+eps).^4)./(w.^5+eps);
%plot(w,s);