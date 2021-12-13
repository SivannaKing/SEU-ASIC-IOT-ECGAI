% ecg1 = sortrows(ECGALL, -5);%按能效比倒序排列
% ecg1 = ecg1(1:floor(0.5 * size(ecg1,1)), :);%取前70%
% ecg2 = sortrows(ecg1, -5);%按照能效比倒序排列
% ecg2 = ecg2(1:floor(0.9 * size(ecg2,1)), :);%取前90%
% ecg3 = sortrows(ecg2, 9);%按照总计算时钟升序排列
% ecg3 = ecg3(1:floor(0.4 * size(ecg3,1)), :);%取前40%

%% 找出所有PE阵列总数量小于512的
selectedECG = [];
for i = 1:size(ECGALL,1)
    temp = ECGALL(i,:);
    if(temp(1) * temp(2) <= 512)
        selectedECG(end+1,:) = temp;
    end
end

%% 评分选择
max_peutilization = max(selectedECG(:,3));
max_performance = max(selectedECG(:,4));
max_efficiency = max(selectedECG(:,5));
%min_cylcle = min(selectedECG(:,9));
last_result = [];
for i = 1 : size(selectedECG,1)
    temp = selectedECG(i,:);
    score1 = temp(3) ./ max_peutilization .* 100;
    score2 = temp(4) ./ max_performance .* 100;
    score3 = temp(5) ./ max_efficiency .* 100;
    temp = [temp, score1+score2+score3];
    last_result(end+1,:) = temp;
end
last_result = sortrows(last_result, -6);%按照评分倒序排列

