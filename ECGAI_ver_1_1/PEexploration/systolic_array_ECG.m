%% Defination of input arguments
clc,clear;
%%% ECG parameter %%%
K = [16,12,8,8,4,3]; %Kernel Size
%K = [16,11,9,7,5,3];

IX = [3600,894,220,105,48,22]; %Imap Size
%IX = [3614,459,119,60,30,15];

IY = [1,1,1,1,1,1,1];

M = [8,16,32,64,64,72]; %Imap Number
%M = [8,12,32,64,64,72];

OX = [1793,442,213,98,45,20]; %Omap Size
%OX = [1800,225,111,54,26,13];
%OX = [900, 112.5, 55.5, 27, 13, 6.5, 3];%Omap Size

OY = [1,1,1,1,1,1,1];

N = [8,16,32,64,64,72]; %Omap Number
%N = [8,12,32,64,64,72];

S = [2,2,1,1,1,1]; %Stride
%Pooling = [2,2,1,1,1,1]; %Pooling
Frequency = 10^8;

%% version1.0 network params
% K = [16,11,9,7,5,3];
% IX = [3614,459,119,60,30,15];
% M = [8,12,32,64,64,72];
% OX = [1800,225,111,54,26,13];
% N = [8,12,32,64,64,72];

%% Define the domain of independent variable
% The size of systolic PE array is R and C
R_domain = 2:2:20;
C_domain = 2:2:40;
PE_maxnum = 1024;
%Bi = 2^12;
%Bo = 2^14;
%Bw = 2^15;
alpha1 = 1/9; %coefficient of pe array utilization 
alpha2 = 1/9; %coefficient of pe array perfromance 吞吐率
alpha3 = 7/9; %coefficient of pe array power efficiency
%% Find the best option for current CNN layer
ECGALL = [];

for R = R_domain
    for C = C_domain
                %% Phrase 1.0: OXt OYt Nt Mt
                    %OXt = OX;
                    %OYt = min(OY, R);
                    %OYt = min(OX(i),R);
                    %Nt = min(N, C);
                    %Mt = M;
                    
                %% Phrase 2.0:PE利用率
                    all_numPE = [];
                    layer_numTimes = [];
                    Utilization_PE = 0;
                    numTimes_sum = 0;
                    for i =1:length(M)
                        Nt = min(N(i), C);
                        Ntemp = N(i);
                        layer_numTimes(end+1) = ceil(N(i)/Nt);
                        layer_numPE = 0;
                        OYt = min(OX(i),R);
                        %OYt = R;
                        for j = 1:layer_numTimes(i) %批数循环
                            if(Nt<Ntemp)
                                Ntemp = Ntemp - C;
                            else
                                OYt=mod(OX(i),R); %last batch
                            end
                            %layer_numPE = layer_numPE + (OX(i) * Nt);
                            layer_numPE = layer_numPE + (OYt * Nt);
                            Nt = min(Ntemp, C);
                        end
                        all_numPE(end+1) = layer_numPE;
                        numTimes_sum = numTimes_sum + layer_numTimes(i);
                    end
                    
                    for i =1:length(M)
                        Utilization_PE_layer = (all_numPE(i)/numTimes_sum)/(R*C);
                        Utilization_PE = Utilization_PE + Utilization_PE_layer;
                    end
                    
                %% Phrase 2.1:吞吐率
                    numOps = 0;
                    numCycle_all = 0;
                    numCycle_temp = [];
                    for i =1:length(M)
                        Nt = min(N(i), C);
                        Ntemp = N(i);
                        layer_numTimes = ceil(N(i)/Nt);
                        numCycle_perlyr = 0;
                        OYt = min(OX(i),R);%new
                        for j = 1:layer_numTimes %批数循环
                            if(Nt<Ntemp)
                                Ntemp = Ntemp - C;
                            else
                                OYt=mod(OX(i),R); %last batch
                            end
                            %numCycle_perlyr = numCycle_perlyr + max(K(i) * 1 * M(i), 2 * (Nt - 1)) * OX(i)/R + 2 * (Nt - 1);
                            numCycle_perlyr = numCycle_perlyr + max(K(i) * 1 * M(i), 2 * (Nt - 1)) * OX(i)/OYt + 2 * (Nt - 1);
                            Nt = min(Ntemp, C);
                        end
                        numOps = numOps +  K(i) *1 * M(i) * OX(i) * OY(i) * N(i);
                        numCycle_temp(i) = numCycle_perlyr;
                        numCycle_all = numCycle_all + numCycle_perlyr;
                    end
                    Performance = numOps * Frequency / numCycle_all;

                    
                %% Phrase 2.2:能效
                    numMemAccBuf = 0;
                    %numMemAccDram = 0;
                    numCount_sum = 0;
                    for i =1:length(M)
                        numIN = IX(i) * IY(i) * M(i);
                        numOUT = OX(i) * OY(i) * N(i);
                        numWEI = K(i) * 1 * M(i) * N(i);
                        ain = 1 +  ceil(N(i) / Nt);
                        aout = 1;
                        awei = 2;
                        numMemAccBuf = numMemAccBuf + (numIN * ain + numOUT * aout + numWEI * awei);
                        %numMemAccDram = numMemAccDram + (numIN * 2  + numOUT * 0 + numWEI * 1);
                        if(OX(i) >= R)
                            numCount_sum = numCount_sum + K(i) *1 * M(i) * OX(i) *  C * ceil(N(i)/Nt);
                        else
                            numCount_sum = numCount_sum + K(i) *1 * M(i) * OX(i) *  C * ceil(N(i)/Nt) + numCycle_temp(i)* (R-OX(i)) *C;
                        end
                        %numCount_sum = numCount_sum + K(i) *1 * M(i) * OX(i) *  C * ceil(N(i)/Nt);
                    end
                    %RatePowerEfficiency = numOps / (numMemAccDram * 70 + numMemAccBuf * 0.42 + numCount_sum * 0.06) / 8 * 10^12;
                    RatePowerEfficiency = numOps / (numMemAccBuf * 0.42 + numCount_sum * 0.06) / 8 * 10^12;
               %% Phrase 3:sort the result in ECGALL
                    ECGALL(end+1,:) = [R,C,Utilization_PE,Performance,RatePowerEfficiency];   %Add layer index to every result
    end
end

ECGALL = sortrows(ECGALL,1:2);
save('ECG.mat','ECGALL');



ecg1 = sortrows(ECGALL, -5);%按能效比倒序排列
ecg1 = ecg1(1:floor(0.7 * size(ecg1,1)), :);%取前10%
ecg2 = sortrows(ecg1, -4);%按照性能倒序排列
ecg2 = ecg2(1:floor(0.7 * size(ecg2,1)), :);%取前70%
ecg3 = sortrows(ecg2, -3);%按照利用率倒序排列
ecg3 = ecg3(1:floor(0.7 * size(ecg3,1)), :);%取前70%

%% 找出所有PE阵列总数量小于PE_maxnum的
selectedECG = [];
for i = 1:size(ecg3,1)
    temp = ecg3(i,:);
    if(temp(1) * temp(2) <= PE_maxnum)
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
    temp = [temp, alpha1*score1+alpha2*score2+alpha3*score3];
    last_result(end+1,:) = temp;
end
% last_result = sortrows(last_result, -6);%按照评分倒序排列
last_result(:, [1,2,3,4,5,6]) = last_result(:, [1,2,5,4,3,6]);
last_result = sortrows(last_result, -3);%按照评分倒序排列