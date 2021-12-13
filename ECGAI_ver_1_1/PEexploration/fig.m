clear;clc;
load('alex.mat');
a = AlexA2(:,1:2);
[b,c]=unique(a,'rows');
c(end+1) = size(AlexA2,1)+1;

cycle = [];
efficiency = [];
performance = [];
for i=1:size(c,1)-1
    cyc_temp = sortrows(AlexA2(c(i):c(i+1)-1,:),9);
    eff_temp = sortrows(AlexA2(c(i):c(i+1)-1,:),-8);
    per_temp = sortrows(AlexA2(c(i):c(i+1)-1,:),-7);
    cycle(end+1,:) = cyc_temp(1,:);
    efficiency(end+1,:) = eff_temp(1,:);
    performance(end+1,:) = per_temp(1,:);
end
x = 10:2:42;
y = 10:2:42;
z1 = zeros(size(x,1),size(y,1));
z2 = zeros(size(x,1),size(y,1));
z3 = zeros(size(x,1),size(y,1));
for i=1:17
    for j=1:17
        z1(i,j) = cycle(i*j,9);
        z2(i,j) = efficiency(i*j,8);
        z3(i,j) = performance(i*j,7);
    end
end

surf(x,y,z3);shading interp  
figure(gcf);
xlabel('R');
ylabel('C');
zlabel('cycle');

axis vis3d
for i=1:36
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

