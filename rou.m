function z1_z2=rou(flat)
[lx,ly]=size(flat);
terrain=flat;
% for i=1:ly-2
%     for j=1:lx-3
%         z1((i-1)*lx+j)=mountain(i,j);
%         z2((i-1)*lx+j)=mountain(i+2,i+3);
%     end
% end
% plot(z1,z2);
step=5;
for delta_x=1:lx/2
    for delta_y=1:ly/2
        z1=0;
        z2=0;
        i1=0;
        for i=1:step:lx-delta_x
            i1=i1+1;
            j1=0;
            for j=1:step:ly-delta_y
                j1=j1+1;
                z1((i1-1)*round((ly-delta_y)/step)+j1)=terrain(i,j);
                z2((i1-1)*round((ly-delta_y)/step)+j1)=terrain(i+delta_x,j+delta_y);
            end
        end
        %plot(z1,z2);
        E_z1=sum(z1)/length(z1);
        E_z2=sum(z2)/length(z2);
        z1=z1-E_z1;
        z2=z2-E_z2;
        Var_z1=sum(z1.*z1)/length(z1);
        Var_z2=sum(z2.*z2)/length(z2);
        z1=z1/sqrt(Var_z1);
        z2=z2/sqrt(Var_z2);

        z1_z2(delta_x,delta_y)=min(min(corrcoef(z1, z2)));
    end
end

