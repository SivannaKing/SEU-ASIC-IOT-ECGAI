clc,clear;
%%% AlexNet parameter %%%
% H = [224,27,13,13,13]; %Imap Size
% M = [3,96,256,384,384,384]; %Imap Number
% R = [55,27,13,13,13]; %Omap Size
% N = [96,256,384,384,384]; %Omap Number
% K = [11,5,3,3,3]; %Kernel Size
% S = [4,1,1,1,1]; %Stride
% P = [4,4,1,1,1]; %Pooling
%%% VGG16 parameter %%%
H = [224,224,112,112,56,56,56,28,28,28,14,14,14]; %Imap Size
M = [3,64,64,128,128,256,256,256,512,512,512,512,512]; %Imap Number
R = [224,112,112,56,56,56,28,28,28,14,14,14,7]; %Omap Size
N = [64,64,128,128,256,256,256,512,512,512,512,512,512]; %Omap Number
K = [3,3,3,3,3,3,3,3,3,3,3,3,3]; %Kernel Size
S = [1,1,1,1,1,1,1,1,1,1,1,1,1]; %Stride
P = [1,4,1,4,1,1,4,1,1,4,1,1,4]; %Pooling
Frequency = 10^8;
rateCom = 1;
VGGALL = [];

for i=1:length(H)
    result = systolic_array(K(i),H(i),H(i),M(i),R(i),R(i),N(i),S(i),Frequency,P(i),rateCom);
    
    for j = 1:size(result,1)
        VGGALL(end+1,:) = [result(j,:),i];   %
    end
end
VGGALL = sortrows(VGGALL,1:5);
a = VGGALL(:,11);              % the 11th column of VGGALL represent the numeber of layers of VGG
index = [];
for i=1:size(VGGALL,1)-12
    if a(i) == 1
        if a(i+1) == 2
            if a(i+2) == 3
                if a(i+3) == 4
                    if a(i+4) ==5
                        if a(i+5) ==6
                            if a(i+6) ==7
                                if a(i+7) ==8
                                    if a(i+8) == 9
                                        if a(i+9) ==10
                                            if a(i+10) == 11
                                                if a(i+11) == 12
                                                    if a(i+12) == 13
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
VGG13C = [];
VGG13A = [];
for i=index
    for j =0:12
        VGG13C(end+1,:)=VGGALL(i+j,:);
        temp(j+1,:)= VGGALL(i+j,:);
    end
    VGG13A(end+1,:) = mean(temp);
end
su = 0;
numCal = [];
for i =1:length(M)
    Cal = K(i)*K(i)*M(i)*R(i)*R(i)*N(i);
    numCal(end+1) = Cal;
    su = su + Cal;
end
rateCal = numCal./su;
temp = 0;
VGGA2 = [];
for i = 1:13:size(VGG13C,1)
    temp = 0;
    temp3 = 0;
    for j = 0:12
        temp = temp + VGG13C(i+j,6:8).*rateCal(j+1);
        temp3 = temp3 + VGG13C(i+j,10);
    end
    temp2 = VGG13C(i,1:5);
    %temp4 = max(VGG13C(i:i+12,5));
    VGGA2(end+1,:)=[temp2, temp, temp3];     %%  将VGG所有层的性能进行加权平均，得到整体的参数
end
VGGA3 = [];
for i = 1:size(VGGA2,1)
    pervsbuffer = VGGA2(i,7)/(VGGA2(i,5));
    Efvsbuffer = VGGA2(i,8)/(VGGA2(i,5));
    pervspe = VGGA2(i,7)/(VGGA2(i,1)*VGGA2(i,2));
    Efvspe = VGGA2(i,8)/(VGGA2(i,1)*VGGA2(i,2));
    CycVSbuffer = VGGA2(i,9)/(VGGA2(i,5));
    CycVSpe = VGGA2(i,9)/(VGGA2(i,1)*VGGA2(i,2));
    VGGA3(end+1,:)=[VGGA2(i,:),pervsbuffer,Efvsbuffer,CycVSbuffer,pervspe,Efvspe,CycVSpe];
end

save('vgg.mat','VGG13A','VGG13C','VGGA2','VGGA3','VGGALL');