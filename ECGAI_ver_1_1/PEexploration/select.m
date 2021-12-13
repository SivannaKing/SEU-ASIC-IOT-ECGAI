% selectedAlex = [];
% for i = 1:size(AlexA3,1)
%     temp = AlexA3(i,:);
%     if(temp(1) * temp(2) <= 512)
%         selectedAlex(end+1,:) = temp;
%     end
% end
% selectedVGG = [];
% for i = 1:size(VGGA3,1)
%     temp = VGGA3(i,:);
%     if(temp(1) * temp(2) <= 512)
%         selectedVGG(end+1,:) = temp;
%     end
% end

alex1 = sortrows(AlexA3, -7);%�����ܵ�������
alex1 = alex1(1:floor(0.4 * size(alex1,1)), :);%ȡǰ40%
alex2 = sortrows(alex1, -8);%������Ч�ȵ�������
alex2 = alex2(1:floor(0.4 * size(alex2,1)), :);%ȡǰ40%
alex3 = sortrows(alex2, 9);%�����ܼ���ʱ����������
alex3 = alex3(1:floor(0.4 * size(alex3,1)), :);%ȡǰ40%

vgg1 = sortrows(VGGA3, -7);
vgg1 = vgg1(1:floor(0.4 * size(vgg1,1)),:);
vgg2 = sortrows(vgg1, -8);
vgg2 = vgg2(1:floor(0.4 * size(vgg2,1)),:);
vgg3 = sortrows(vgg2, 9);
vgg3 = vgg3(1:floor(0.4 * size(vgg3,1)),:);
%% �ҳ�����PE����������С��512��
selectedAlex = [];
for i = 1:size(alex3,1)
    temp = alex3(i,:);
    if(temp(1) * temp(2) <= 1024)
        selectedAlex(end+1,:) = [temp,1];
    end
end
selectedVGG = [];
for i = 1:size(vgg3,1)
    temp = vgg3(i,:);
    if(temp(1) * temp(2) <= 1024)
        selectedVGG(end+1,:) = [temp,2];
    end
end
aaa = [selectedAlex;selectedVGG];
aaa = sortrows(aaa, 1:5);
%% �ҳ��ʺ���������Ĳ���
a = aaa(:,16);
bbb = [];
for i=1:size(aaa,1)-1
    if(a(i) == 1 && a(i+1) == 2 && isequal(aaa(i, 1:5), aaa(i+1, 1:5)))
        bbb(end+1:end+2,:)=[aaa(i,:);aaa(i+1,:)];
    end
end
%% ��������뿪
bbbb = sortrows(bbb, 16);
size_b = size(bbbb,1);
bbb1 = bbbb(1:(size_b*0.5),:);
bbb2 = bbbb((size_b*0.5 + 1):size_b,:);
