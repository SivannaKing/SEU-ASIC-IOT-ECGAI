

max_peutilization = max(bbb1(:,6));
max_performance = max(bbb1(:,7));
max_efficiency = max(bbb1(:,8));
min_cylcle = min(bbb1(:,9));
bbb11 = [];
for i = 1 : size(bbb1,1)
    temp = bbb1(i,:);
    score1 = temp(6) ./ max_peutilization .* 50;
    score2 = temp(7) ./ max_performance .* 100;
    score3 = temp(8) ./ max_efficiency .* 100;
    score4 = (100-(temp(9) ./ min_cylcle*100 -100))*0.8;
    temp = [temp, score1+score2+score3+score4];
    bbb11(end+1,:) = temp;
end
max_peutilization = max(bbb2(:,6));
max_performance = max(bbb2(:,7));
max_efficiency = max(bbb2(:,8));
min_cylcle = min(bbb2(:,9));
bbb22 = [];
for i = 1 : size(bbb2,1)
    temp = bbb2(i,:);
    score1 = temp(6) ./ max_peutilization .* 50;
    score2 = temp(7) ./ max_performance .* 100;
    score3 = temp(8) ./ max_efficiency .* 100;
    score4 = (100-(temp(9) ./ min_cylcle*100 -100))*0.8;
    temp = [temp, score1+score2+score3+score4];
    bbb22(end+1,:) = temp;
end