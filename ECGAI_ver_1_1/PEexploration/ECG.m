clc,clear;
%%% AlexNet parameter %%%
% H = [224,27,13,13,13]; %Imap Size
% M = [3,96,256,384,384,384]; %Imap Number
% R = [55,27,13,13,13]; %Omap Size
% N = [96,256,384,384,384]; %Omap Number
% K = [11,5,3,3,3]; %Kernel Size
% S = [4,1,1,1,1]; %Stride
% P = [4,4,1,1,1]; %Pooling
%%% ECG parameter %%%
H = [3600,449,111,54,26,13,6]; %Imap Size
M = [1,8,12,32,64,64,64]; %Imap Number
%M = [1,1,1,1,1,1,1]; %new
%R = [1800,225,111,54,26,13,6]; %Omap Size
RX = [600,75,37,18,8.667,4.3334,2];
RY = [3,3,3,3,3,3,3];
N = [8,12,32,64,64,64,72]; %Omap Number
%N = [1,1,1,1,1,1,1]; %new
K = [16,12,9,7,5,3,3]; %Kernel Size
S = [2,2,1,1,1,1,1]; %Stride
P = [8,4,4,4,2,2,2]; %Pooling
Frequency = 10^8;
rateCom = 1;
%VGGALL = [];
ECGALL = [];
%% The experiment results under different conditions
for i=1:length(H)
    result = systolic_array_ECG(K(i),H(i),1,M(i),RX(i),RY(i),N(i),S(i),Frequency,P(i),rateCom); %new
    
    for j = 1:size(result,1)
        ECGALL(end+1,:) = [result(j,:),i];   %Add layer index to every result
    end
end
% Sort the results according to the first five colums.
ECGALL = sortrows(ECGALL,1:5);
%% 找到相同条件下，满足所有层的结果的索引
a = ECGALL(:,13);              % the 11th column of VGGALL represent the numeber of layers of VGG
index = [];
for i=1:size(ECGALL,1)-6
    if a(i) == 1
        if a(i+1) == 2
            if a(i+2) == 3
                if a(i+3) == 4
                    if a(i+4) ==5
                        if a(i+5) ==6
                            if a(i+6) ==7
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
        else
            continue;
        end
    else
        continue;
    end
end
%% 找出所有满足7层组合参数的结果
ECG7C = [];
ECG7A = [];%数值平均
for i=index
    for j =0:6
        ECG7C(end+1,:)=ECGALL(i+j,:);
        temp(j+1,:)= ECGALL(i+j,:);
    end
    ECG7A(end+1,:) = mean(temp);
end
%% 每一层的计算量
su = 0;
numCal = [];
for i =1:length(M)
    Cal = K(i)* 1 *M(i)*RX(i)* RY(i) *N(i);   %new
    numCal(end+1) = Cal;
    su = su + Cal;
end
rateCal = numCal./su;%加权平均的权重
%%
temp = 0;
ECGA2 = [];
for i = 1:7:size(ECG7C,1)
    temp = 0;
    temp3 = 0;
    for j = 0:6
        temp = temp + ECG7C(i+j,6:8).*rateCal(j+1);
        temp3 = temp3 + ECG7C(i+j,10);
    end
    temp2 = ECG7C(i,1:5);
    %temp4 = max(VGG13C(i:i+12,5));
    ECGA2(end+1,:)=[temp2, temp, temp3];     %%  将所有层的性能进行加权平均，得到整体的参数
end
ECGA3 = [];%在加权平均的基础上将性能平均到每一种资源
for i = 1:size(ECGA2,1)
    pervsbuffer = ECGA2(i,7)/(ECGA2(i,5));
    Efvsbuffer = ECGA2(i,8)/(ECGA2(i,5));
    pervspe = ECGA2(i,7)/(ECGA2(i,1)*ECGA2(i,2));
    Efvspe = ECGA2(i,8)/(ECGA2(i,1)*ECGA2(i,2));
    CycVSbuffer = ECGA2(i,9)/(ECGA2(i,5));
    CycVSpe = ECGA2(i,9)/(ECGA2(i,1)*ECGA2(i,2));
    ECGA3(end+1,:)=[ECGA2(i,:),pervsbuffer,Efvsbuffer,CycVSbuffer,pervspe,Efvspe,CycVSpe];
end

save('ECG.mat','ECG7A','ECG7C','ECGA2','ECGA3','ECGALL');