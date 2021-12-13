clear;clc;
%para
R_start=2;
C_start=2;
step=2;
R_end=20;
C_end=40;

load('ECG.mat');
a = ECGALL(:,1:2);
[b,c]=unique(a,'rows');
c(end+1) = size(ECGALL,1)+1;

peutilization = [];
efficiency = [];
performance = [];
for i=1:size(c,1)-1
    peu_temp = sortrows(ECGALL(c(i):c(i+1)-1,:),-3);
    eff_temp = sortrows(ECGALL(c(i):c(i+1)-1,:),-5);
    per_temp = sortrows(ECGALL(c(i):c(i+1)-1,:),-4);
    peutilization(end+1,:) = peu_temp(1,:);
    efficiency(end+1,:) = eff_temp(1,:);
    performance(end+1,:) = per_temp(1,:);
end
x = R_start:step:R_end;
y = C_start:step:C_end;
z1 = zeros(size(x,1),size(y,1));
z2 = zeros(size(x,1),size(y,1));
z3 = zeros(size(x,1),size(y,1));
for i=1:(C_end-C_start)/step+1
    for j=1:(R_end-R_start)/step+1
        index=(j-1)*((C_end-C_start)/step+1)+i;
        z1(i,j) = peutilization(index,3);
        z2(i,j) = efficiency(index,5);
        z3(i,j) = performance(index,4);
    end
end

surf(x,y,z3);shading interp  
figure(gcf);
xlabel('R');
ylabel('C');
zlabel('Power Efficiency');

axis vis3d
for i=1:72
camorbit(10,0,'camera')
M=getframe(gcf);
nn=frame2im(M);
[nn,cm]=rgb2ind(nn,256);
if i==1
imwrite(nn,cm,'out.gif','gif','LoopCount',inf,'DelayTime',0.1);%说明loopcount只是在i==1的时候才有用
else
imwrite(nn,cm,'out.gif','gif','WriteMode','append','DelayTime',0.1)%当i>=2的时候loopcount不起作用
end
end

