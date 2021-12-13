clc,clear;
%%% AlexNet parameter %%%
H = [224,27,13,13,13]; %Imap Size
M = [3,96,256,384,384]; %Imap Number
R = [55,27,13,13,13]; %Omap Size
N = [96,256,384,384,384]; %Omap Number
K = [11,5,3,3,3]; %Kernel Size
S = [4,1,1,1,1]; %Stride
P = [4,4,1,1,1]; %Pooling
%%% Alex16 parameter %%%
% H = [224,224,112,112,56,56,56,28,28,28,14,14,14]; %Imap Size
% M = [3,64,64,128,128,256,256,256,512,512,512,512,512]; %Imap Number
% R = [224,112,112,56,56,56,28,28,28,14,14,14,7]; %Omap Size
% N = [64,64,128,128,256,256,256,512,512,512,512,512,512]; %Omap Number
% K = [3,3,3,3,3,3,3,3,3,3,3,3,3]; %Kernel Size
% S = [1,1,1,1,1,1,1,1,1,1,1,1,1]; %Stride
% P = [1,4,1,4,1,1,4,1,1,4,1,1,4]; %Pooling
Frequency = 10^8;
rateCom = 1;%ѹ���ʸ�Ϊ1
AlexALL = [];
%% The experiment results under different conditions
for i=1:length(H)
    result = systolic_array(K(i),H(i),H(i),M(i),R(i),R(i),N(i),S(i),Frequency,P(i),rateCom);
    
    for j = 1:size(result,1)
        AlexALL(end+1,:) = [result(j,:),i];%%Add layer index to every result
    end
end
% Sort the results according to the first five colums.
AlexALL = sortrows(AlexALL,[1:5]);
%% �ҵ���ͬ�����£��������в�Ľ��������
a = AlexALL(:,11);
index = [];
for i=1:size(AlexALL,1)-4
    if a(i) == 1
        if a(i+1) == 2
            if a(i+2) == 3
                if a(i+3) == 4
                    if a(i+4) ==5
                        index(end+1)=i;
                    else
                        continue;
                    end
                else
                    continue;
                end
            else
                continue;
            end
        else
            continue;
        end
    else
        continue;
    end
end

%% �ҳ���������5����ϲ����Ľ��
Alex5C = [];
Alex5A = [];%��ֵƽ��
for i=index
    for j =0:4
        Alex5C(end+1,:)=AlexALL(i+j,:);
        temp(j+1,:)= AlexALL(i+j,:);
    end
    Alex5A(end+1,:) = mean(temp);
end
%% ÿһ��ļ�����
su = 0;
numCal = [];
for i =1:length(M)
    Cal = K(i)*K(i)*M(i)*R(i)*R(i)*N(i);
    numCal(end+1) = Cal;
    su = su + Cal;
end
rateCal = numCal./su;%ÿһ�������ռ��

%% 
temp = 0;
AlexA2 = [];%����ÿһ��ļ�������Ȩƽ��
for i = 1:5:size(Alex5C,1)
    temp = 0;
    temp3 = 0;
    for j = 0:4
        temp = temp + Alex5C(i+j,6:8).*rateCal(j+1);
        temp3 = temp3 + Alex5C(i+j,10);
    end
    temp2 = Alex5C(i,1:5);
    %temp4 = max(Alex5C(i:i+4,5));
    AlexA2(end+1,:)=[temp2,temp,temp3];
end
AlexA3 = [];%�ڼ�Ȩƽ���Ļ����Ͻ�����ƽ����ÿһ����Դ
for i = 1:size(AlexA2,1)
    pervsbuffer = AlexA2(i,7)/(AlexA2(i,5));
    Efvsbuffer = AlexA2(i,8)/(AlexA2(i,5));
    pervspe = AlexA2(i,7)/(AlexA2(i,1)*AlexA2(i,2));
    Efvspe = AlexA2(i,8)/(AlexA2(i,1)*AlexA2(i,2));
    CycVSbuffer = AlexA2(i,9)/(AlexA2(i,5));
    CycVSpe = AlexA2(i,9)/(AlexA2(i,1)*AlexA2(i,2));
    AlexA3(end+1,:)=[AlexA2(i,:),pervsbuffer,Efvsbuffer,CycVSbuffer,pervspe,Efvspe,CycVSpe];
end

save('alex.mat','Alex5A','Alex5C','AlexA2','AlexA3','AlexALL');