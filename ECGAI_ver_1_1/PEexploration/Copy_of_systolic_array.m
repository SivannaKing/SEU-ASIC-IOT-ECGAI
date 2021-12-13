function results = systolic_array(K, IX, IY, M, OX, OY, N, S, Frequency, Pooling, rateCompress)
%% Defination of input arguments
%  K the size of kernel
%  IX the size of input map in horizontal direction
%  IY the size of input map in vertical direction
%  M the number of input maps
%  OX the horizontal size of output maps
%  OY the vertical size of output maps
%  N the number of output maps
%  S the stirde of the kernel
%  Frequency working frequency
%  Pooling the size of pooling, 4 or 9
%  rateCompress the rate of compress
%
%  results = [results; R, C, Bi, Bo, Bw, Utilization_PE, Performance, RatePowerEfficiencyIR, RatePowerEfficiencyOR, RatePowerEfficiencyWR];

results = [];
%% the numbers of input data, output data and weights
numIN = IX * IY * M;
numOUT = OX * OY * N;
numWEI = K * K * M * N;
%% Define the domain of independent variable
% The size of systolic PE array is R and C
R_domain = 4:2:32;
C_domain = 4:2:32;

% The size of input buffer is presented by Bi, and Bo for output buffer
Bi_domain = [2^14 2^15 2^16 2^17];
Bo_domain = [2^12 2^13 2^14 2^15 2^16 2^17];

%% Find the best option for current CNN layer
for R = R_domain
    for C = C_domain
        for Bi = Bi_domain
            for Bo = Bo_domain
            %% Phrase 1.0:Nt OYt 
            	Nt = min(N, C);
                OYt = min(OY, R);
            
            %% Phrase 1.1:IYt
                IYt = (OYt - 1) * S + K;
                
            %% Phrase 1.2:OXt IXt                
                OXt = min(floor(Bo / (Nt * OYt)), OX);
                IXt = (OXt - 1) * S + K;
                
            %% Phrase 1.3:Mt
                Mt = min(floor(Bi / (IXt * IYt)), M);
                
            %% Phrasse 1.4:Bw
                Bw = K * K * Mt * Nt;
                
            %% Phrase 2.0:numPE numCycle_per numTimes
                numPE = OYt * Nt;
                %numCycle_per = min(K * K * Mt + 2 * (Nt - 1), 4 * (Nt - 1)) * OXt;
                numCycle_per = max(K * K * Mt, 2 * (Nt - 1)) * OXt + 2 * (Nt - 1);
                numTimes = ceil(N / Nt) * ceil(OX / OXt) * ceil(OY / OYt) * ceil(M / Mt);
                
            %% Phrase 2.1:numCycle_act numOps
                numCycle_act = numCycle_per * numTimes;
                numOps = 2 * K *K * M * OX * OY * N;
                
            %% Phrase 2.2:Utilization_PE Performance
                Utilization_PE = numPE / (R * C);
                Performance = numOps * Frequency / numCycle_act;
                
            %% Phrase 2.3.1:ainIR aoutIR aweiIR binIR boutIR bweiIR numMemAccBufIR numMemAccDramIR
                ainIR = 2;
                if(N * OXt * OYt <= Bo)
                    aoutIR = 2 * ceil(M / Mt);
                else 
                    aoutIR = 4 * ceil(M / Mt) - 2;
                end
                aweiIR = ceil(OX / OXt) * ceil(OY / OYt);
%                 if(numWEI <= Bw)
%                     %aweiIR = ceil(OX / OXt) * ceil(OY / OYt) + 1;
%                     aweiIR = ceil(OX / OXt) * ceil(OY / OYt);
%                 else
%                     %aweiIR = 2 * ceil(OX / OXt) * ceil(OY / OYt);
%                     aweiIR = ceil(OX / OXt) * ceil(OY / OYt);
%                 end
                
                binIR = 1;
                if(N * OXt * OYt <= Bo)
                    boutIR = 1;
                else
                    boutIR = 2 * (ceil(M / Mt) - 1);
                end
                if(numWEI <= Bw)
                    bweiIR = 1;
                else
                    bweiIR = ceil(OX / OXt) * ceil(OY / OYt);
                end
                
                numMemAccBufIR = numIN * ainIR + numOUT * aoutIR + numWEI * aweiIR;
                numMemAccDramIR = (numIN * binIR + numOUT / Pooling) * rateCompress + numOUT * boutIR + numWEI * bweiIR;
                
            %% Phrase 2.3.2:ainOR aoutOR aweiOR binOR boutOR bweiOR numMemAccBufOR numMemAccDramOR
                if(M * IXt * IYt <= Bi)
                    ainOR = 2;
                else
                    ainOR = 2 * ceil(N / Nt);
                end
                aoutOR = 2;
                aweiOR = ceil(OX / OXt) * ceil(OY / OYt);
%                 if(numWEI <= Bw)
%                     aweiOR = ceil(OX / OXt) * ceil(OY / OYt) + 1;
%                 else
%                     aweiOR = 2* ceil(OX / OXt) * ceil(OY / OYt);
%                 end
                
                if(M * IXt * IYt <= Bi)
                    binOR = 1;
                else
                    binOR = ceil(N / Nt);
                end
                boutOR = 0;
                if(numWEI <= Bw)
                    bweiOR = 1;
                else
                    bweiOR = ceil(OX / OXt) * ceil(OY / OYt);
                end
                
                numMemAccBufOR = numIN * ainOR + numOUT * aoutOR + numWEI * aweiOR;
                numMemAccDramOR = (numIN * binOR + numOUT / Pooling) * rateCompress + numOUT * boutOR + numWEI * bweiOR;
            
            %% Phrase 2.3.3:ainWR aoutWR aweiWR binWR boutWR bweiWR numMemAccBufWR numMemAccDramWR
                ainWR = 2 * ceil(N / Nt);
                if(Nt * OX * OY <= Bo)
                    aoutWR = 2 * ceil(M / Mt);
                else 
                    aoutWR = 4 * ceil(M / Mt) - 2;
                end
                aweiWR = ceil(OX / OXt) * ceil(OY / OYt);
%                 if(numWEI <= Bw)
%                     aweiWR = ceil(OX / OXt) * ceil(OY / OYt) + 1;
%                 else
%                     aweiWR = 2* ceil(OX / OXt) * ceil(OY / OYt);
%                 end
                
                binWR = ceil(N / Nt);
                if(Nt * OX * OY <= Bo)
                    boutWR = 0;
                else
                    boutWR = 2 * (ceil(M / Mt) - 1);
                end
                bweiWR = 1;
                
                numMemAccBufWR = numIN * ainWR + numOUT * aoutWR + numWEI * aweiWR;
                numMemAccDramWR = (numIN * binWR + numOUT / Pooling) * rateCompress + numOUT * boutWR + numWEI * bweiWR;
                
            %% Phrase 2.4 RatePowerEfficiencyIR RatePowerEfficiencyOR RatePowerEfficiencyWR
                RatePowerEfficiencyIR = numOps / (numMemAccDramIR * 70 + numMemAccBufIR * 0.42 + numOps * 0.06) / 8 * 10^12;
                RatePowerEfficiencyOR = numOps / (numMemAccDramOR * 70 + numMemAccBufOR * 0.42 + numOps * 0.06) / 8 * 10^12;
                RatePowerEfficiencyWR = numOps / (numMemAccDramWR * 70 + numMemAccBufWR * 0.42 + numOps * 0.06) / 8 * 10^12;
                RatePowerEfficiency = max(RatePowerEfficiencyIR,max(RatePowerEfficiencyOR,RatePowerEfficiencyWR));
                if RatePowerEfficiency == RatePowerEfficiencyIR
                    class = 1;
                else if RatePowerEfficiency == RatePowerEfficiencyOR
                        class = 2;
                    else
                        class =3;
                    end
                end
            %% Phrase 3.0 Save the results
                if Mt ~= 0
                    results(end + 1,:) = [R, C, Bi, Bo, Bw, Utilization_PE, Performance, RatePowerEfficiency, class, numCycle_act];
                end
            end
        end
    end
end