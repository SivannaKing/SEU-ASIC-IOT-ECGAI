%% ��������ֻ�轫raw_data���¸�ֵ  ���Ըı�����ȡ�ñ���Ĭ��20%

raw_data = VGGA2;
[row col] = size(raw_data);


%% ���ݳ���ɸѡ
%%
%������������20%��
rate = (1-0.2);
%��efficiency��������
[sorted Index] = sort(raw_data(:,8), 1); %����
sorted_1 = raw_data(Index(row*rate+1:end), :); %����efficiency��˳��ȡ����ߵ�20%
%��performence��������
[sorted Index2] = sort(sorted_1(:,7),1);
r = length(Index2);
sorted_2 = sorted_1(Index2(ceil(r*rate)+1:end), :);%ȡ����ߵ�20%(����ǰ20%ʱ���õ�������ȡ��)
%%��Utilition_PE��������
[sorted Index3] = sort(sorted_2(:, 6), 1);
r = length(Index3);
sorted_3 = sorted_2(Index3(ceil(r*rate)+1:end), :);
%%��numCycle��������
[sorted Index4] = sort(sorted_3(:,9), 1);
r = length(Index4);
sorted_4 = sorted_3(Index4(1:ceil(r*(1-rate))), :);%ע����������ֵС��20%


%% ͳ��Bi��Bo��Bw������ϳ��ֵĴ������
%%
%Ϊ���͸��ӶȽ�Bi��Bo��Bw����ֵƴ�ӳ�һ���ַ�������ͳ�Ƹ����ַ������ֵĴ���
num_str = [num2str(sorted_4(:, 3)) num2str(sorted_4(:, 4)) num2str(sorted_4(:, 5))];
max_show = tabulate(num_str);
[h w] = size(max_show);
show_fre = zeros(h,1);
for i = 1:h
    show_fre(i) = max_show{i,2}; %����Ԫ�������е�Ƶ������
end

[num in] = max(show_fre); %�ҳ�����Ƶ����ߵ��ַ����Ĵ������±�
max_str = max_show{in, 1};%ͨ���±����������ַ���

for i = 1:length(num_str)
    if strfind(num_str(i,:), max_str)
        find_it = i;     %ȡ���ȳ��ֵ��±�
        break;
    end
end
%%��ó�������Bi��Bo��Bw���
Bi = sorted_4(find_it, 3);
Bo = sorted_4(find_it, 4);
Bw = sorted_4(find_it, 5);


%% ��ԭʼ��������ȡ��������Bi��Bo��Bw��ϵ�������
%%
bi_index = find(raw_data(:,3)==Bi); %ԭʼ����������ΪBi���������±꣨����ͬ��
bo_index = find(raw_data(:,4)==Bo);
bw_index = find(raw_data(:,5)==Bw);
%�����±�����Ľ�����Ϊ�����������ϵ��������±�
final_index = intersect(intersect(bi_index, bo_index), bw_index);
%ͨ�������±�õ�����
final_data = raw_data(final_index,:);


%% ������������������ͼ
%%
%׼������
R = final_data(:,1); C = final_data(:,2);
Pe = final_data(:,6);
Performance = final_data(:,7);
Efficiency = final_data(:,8);
Cycle = final_data(:,9);
%��ͼ
maxx=max(R);
minx=min(R);
maxy=max(C);
miny=min(C);
[X,Y]=meshgrid(linspace(minx,maxx),linspace(miny,maxy));
%peͼ
Z1=griddata(R,C,Pe,X,Y,'v4');
subplot(2,2,1)
surf(X,Y,Z1)
title('PE������')
xlabel('C');
ylabel('R');
set(gca,'xtick',0:5:45)
set(gca,'ytick',0:5:45)
shading interp
hold on
view(2);
colorbar
%performanceͼ
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
%Efficiencyͼ
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
%Cycleͼ
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