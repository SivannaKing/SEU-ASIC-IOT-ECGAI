%% 更换数据只需将raw_data重新赋值  可以改变数据取得比例默认20%

raw_data = VGGA2;
[row col] = size(raw_data);


%% 数据初步筛选
%%
%数据排名比例20%；
rate = (1-0.2);
%对efficiency进行排序
[sorted Index] = sort(raw_data(:,8), 1); %升序
sorted_1 = raw_data(Index(row*rate+1:end), :); %按照efficiency的顺序取出最高的20%
%对performence进行排序
[sorted Index2] = sort(sorted_1(:,7),1);
r = length(Index2);
sorted_2 = sorted_1(Index2(ceil(r*rate)+1:end), :);%取出最高的20%(计算前20%时采用的是向上取整)
%%对Utilition_PE进行排序
[sorted Index3] = sort(sorted_2(:, 6), 1);
r = length(Index3);
sorted_3 = sorted_2(Index3(ceil(r*rate)+1:end), :);
%%对numCycle进行排序
[sorted Index4] = sort(sorted_3(:,9), 1);
r = length(Index4);
sorted_4 = sorted_3(Index4(1:ceil(r*(1-rate))), :);%注意这里是数值小的20%


%% 统计Bi、Bo、Bw哪种组合出现的次数最多
%%
%为降低复杂度将Bi、Bo、Bw的数值拼接成一个字符串，并统计各种字符串出现的次数
num_str = [num2str(sorted_4(:, 3)) num2str(sorted_4(:, 4)) num2str(sorted_4(:, 5))];
max_show = tabulate(num_str);
[h w] = size(max_show);
show_fre = zeros(h,1);
for i = 1:h
    show_fre(i) = max_show{i,2}; %读出元胞数组中的频率数据
end

[num in] = max(show_fre); %找出出现频率最高的字符串的次数和下标
max_str = max_show{in, 1};%通过下标索引到该字符串

for i = 1:length(num_str)
    if strfind(num_str(i,:), max_str)
        find_it = i;     %取最先出现的下标
        break;
    end
end
%%获得出现最多的Bi、Bo、Bw组合
Bi = sorted_4(find_it, 3);
Bo = sorted_4(find_it, 4);
Bw = sorted_4(find_it, 5);


%% 从原始数据中提取所有上述Bi，Bo，Bw组合的数据项
%%
bi_index = find(raw_data(:,3)==Bi); %原始数据中所有为Bi的数据项下标（以下同理）
bo_index = find(raw_data(:,4)==Bo);
bw_index = find(raw_data(:,5)==Bw);
%三个下标数组的交集即为所有满足此组合的数据项下标
final_index = intersect(intersect(bi_index, bo_index), bw_index);
%通过索引下标得到数据
final_data = raw_data(final_index,:);


%% 用所得数据做出热力图
%%
%准备数据
R = final_data(:,1); C = final_data(:,2);
Pe = final_data(:,6);
Performance = final_data(:,7);
Efficiency = final_data(:,8);
Cycle = final_data(:,9);
%作图
maxx=max(R);
minx=min(R);
maxy=max(C);
miny=min(C);
[X,Y]=meshgrid(linspace(minx,maxx),linspace(miny,maxy));
%pe图
Z1=griddata(R,C,Pe,X,Y,'v4');
subplot(2,2,1)
surf(X,Y,Z1)
title('PE利用率')
xlabel('C');
ylabel('R');
set(gca,'xtick',0:5:45)
set(gca,'ytick',0:5:45)
shading interp
hold on
view(2);
colorbar
%performance图
Z2=griddata(R,C,Performance,X,Y,'v4');
subplot(2,2,2)
surf(X,Y,Z2)
xlabel('C');
ylabel('R');
title('performance')
set(gca,'xtick',0:5:45)
set(gca,'ytick',0:5:45)
shading interp
hold on
view(2);
colorbar
%Efficiency图
Z3=griddata(R,C,Efficiency,X,Y,'v4');
subplot(2,2,3)
surf(X,Y,Z3)
xlabel('C');
ylabel('R');
title('Efficiency')
set(gca,'xtick',0:5:45)
set(gca,'ytick',0:5:45)
shading interp
hold on
view(2);
colorbar
%Cycle图
Z4=griddata(R,C,Cycle,X,Y,'v4');
subplot(2,2,4)
surf(X,Y,Z4)
xlabel('C');
ylabel('R');
title('Cycle')
set(gca,'xtick',0:5:45)
set(gca,'ytick',0:5:45)
shading interp
hold on
view(2);
colorbar