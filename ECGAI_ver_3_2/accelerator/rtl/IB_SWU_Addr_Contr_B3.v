`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/02 16:24:11
// Design Name: 
// Module Name: IB_SWU_Addr_Contr_B3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IB_SWU_Addr_Contr_B3(
    input                        clk,
    input                        rst_n,
    input    wire     [31:0]     DIN_0, DIN_1, DIN_2,  DIN_3,  DIN_4,  DIN_5,  DIN_6,  DIN_7,
                                 DIN_8, DIN_9, DIN_10, DIN_11, DIN_12, DIN_13, DIN_14, DIN_15,
    output   reg      [ 3:0]     ADDR,
    output   reg                 WEA,
    output   reg                 IB_Addr_SWU_work, IB_Addr_SWU_work_Done,
    output   reg      [ 6:0]     Slide_data_0, Slide_data_1, Slide_data_2,  Slide_data_3,  Slide_data_4,  Slide_data_5,  Slide_data_6,  Slide_data_7,
                                 Slide_data_8, Slide_data_9, Slide_data_10, Slide_data_11, Slide_data_12, Slide_data_13, Slide_data_14, Slide_data_15,
    output   reg                 PE_EN  //产生第一个7bit的PE阵列输入数据时，代表了PE有效 
);
//*****************************************************照搬Block2的SWU代码
reg   [5:0]     cnt;  //这个cnt用来协助ADDR加一
reg   [4:0]     ADDR_d1, ADDR_d2;
//*********由于要padding5，经过测算，ADDR_cnt第一次计数要从0计数到35，以后只需从0计数到25，故用状态机实现*********
reg    [1:0]    current_state, next_state;
parameter       start         = 2'b00,
                cnt_state_1   = 2'b01,
                cnt_state_2   = 2'b10,
                cnt_done      = 2'b11; 

parameter       CNT_1=6'd32, CNT_2=6'd31;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        current_state <= start;
    else
        current_state <= next_state;
end
always@(*)begin
    case(current_state)
        start:begin
                next_state = cnt_state_1;
        end
        cnt_state_1:begin
            if(cnt == CNT_1)begin
                next_state = cnt_state_2;
            end
            else begin 
                next_state = cnt_state_1;
            end
        end
        cnt_state_2:begin
            if(!(ADDR_d2==14 && cnt ==5))begin
                if(cnt == CNT_2)begin
                    next_state = cnt_state_2;
                end
                else begin 
                    next_state = cnt_state_2;
                end
            end else begin
                next_state = cnt_done;
            end
        end
        default: next_state = cnt_done;     
    endcase
end

always@(posedge clk)begin
    case(current_state)
        start:begin
            cnt <= 0;
        end
        cnt_state_1:begin
            if(cnt == CNT_1)begin
                cnt <= 0;
            end
            else begin 
                cnt <= cnt + 1;
            end
        end
        cnt_state_2:begin
            if(cnt == CNT_2)begin
                cnt <= 0;
            end
            else begin 
                cnt <= cnt + 1;
            end
        end
        cnt_done:begin
            cnt <= 0;
        end
        default: cnt <= 0;     
    endcase
end

reg     IB_Addr_SWU_workd1, IB_Addr_SWU_workd2, IB_Addr_SWU_workd3;


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        IB_Addr_SWU_work <= 0;
        IB_Addr_SWU_work_Done <= 0;
        PE_EN <= 0;
    end
    else begin
        if(ADDR == 0 && cnt == 0)begin
            IB_Addr_SWU_work <= 1;
//            PE_EN <= 1;
        end
        if(ADDR == 0 && cnt == 2)begin
//            IB_Addr_SWU_work <= 1;
            PE_EN <= 1;
        end
        if(ADDR == 14 && cnt ==5)begin
            IB_Addr_SWU_work <= 0;
            IB_Addr_SWU_work_Done <= 1;
        end
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        ADDR <= 0;
    end
    else begin
        if(ADDR ==0 && cnt == (CNT_1-2))begin
            ADDR <= ADDR + 1;
        end
        else begin
            if(ADDR != 0)begin
                if(cnt == 29)begin
                    ADDR <= ADDR + 1;
                end
             end
        end
    end
end


always@(posedge clk)begin
    ADDR_d1 <= ADDR;
    ADDR_d2 <= ADDR_d1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        WEA <= 1;
    end
    else begin
        if(!(ADDR_d2==14 && cnt ==5))begin
            if(cnt == 0 && ADDR == 0)begin
                WEA <= 0;
            end
            else if(ADDR==0 && (cnt == CNT_1-2))begin
                WEA <= 0;
            end
            else if(cnt == 29 && ADDR!=0)begin
                WEA <= 0;
            end
            else begin
                WEA <= 1;
            end
        end else begin
            WEA = 1;
        end
    end
end


reg   [ 4:0]     padding_data;
reg   [36:0]     Pad_and_ADDR1_Temp_0,  Pad_and_ADDR1_Temp_1,  Pad_and_ADDR1_Temp_2,  Pad_and_ADDR1_Temp_3, 
                 Pad_and_ADDR1_Temp_4,  Pad_and_ADDR1_Temp_5,  Pad_and_ADDR1_Temp_6,  Pad_and_ADDR1_Temp_7,
                 Pad_and_ADDR1_Temp_8,  Pad_and_ADDR1_Temp_9,  Pad_and_ADDR1_Temp_10, Pad_and_ADDR1_Temp_11, 
                 Pad_and_ADDR1_Temp_12, Pad_and_ADDR1_Temp_13, Pad_and_ADDR1_Temp_14, Pad_and_ADDR1_Temp_15;
reg   [ 5:0]     Temp6_0, Temp6_1, Temp6_2,  Temp6_3,  Temp6_4,  Temp6_5,  Temp6_6,  Temp6_7,
                 Temp6_8, Temp6_9, Temp6_10, Temp6_11, Temp6_12, Temp6_13, Temp6_14, Temp6_15;
reg   [37:0]     Temp6_and_Next_ADDR_Data_0,  Temp6_and_Next_ADDR_Data_1,  Temp6_and_Next_ADDR_Data_2,  Temp6_and_Next_ADDR_Data_3, 
                 Temp6_and_Next_ADDR_Data_4,  Temp6_and_Next_ADDR_Data_5,  Temp6_and_Next_ADDR_Data_6,  Temp6_and_Next_ADDR_Data_7,
                 Temp6_and_Next_ADDR_Data_8,  Temp6_and_Next_ADDR_Data_9,  Temp6_and_Next_ADDR_Data_10, Temp6_and_Next_ADDR_Data_11, 
                 Temp6_and_Next_ADDR_Data_12, Temp6_and_Next_ADDR_Data_13, Temp6_and_Next_ADDR_Data_14, Temp6_and_Next_ADDR_Data_15;
//Block3比较特殊，RAM刚好全部装下所有的数据，因此读完RAM后还要另外修改Block1的代码令其完成padding5个1
reg   [10:0]     Temp6_and_pad_5_0,  Temp6_and_pad_5_1,  Temp6_and_pad_5_2,  Temp6_and_pad_5_3, 
                 Temp6_and_pad_5_4,  Temp6_and_pad_5_5,  Temp6_and_pad_5_6,  Temp6_and_pad_5_7,
                 Temp6_and_pad_5_8,  Temp6_and_pad_5_9,  Temp6_and_pad_5_10, Temp6_and_pad_5_11,
                 Temp6_and_pad_5_12, Temp6_and_pad_5_13, Temp6_and_pad_5_14, Temp6_and_pad_5_15;
                 
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        padding_data <= 5'b11111;
        
        Slide_data_0 <= 0;
        Temp6_0      <= 0;
        Pad_and_ADDR1_Temp_0 <= 0;
        Temp6_and_Next_ADDR_Data_0 <= 0;
        Temp6_and_pad_5_0 <= 0;
    
        Slide_data_1 <= 0;
        Temp6_1      <= 0;
        Pad_and_ADDR1_Temp_1 <= 0;
        Temp6_and_Next_ADDR_Data_1 <= 0;
        Temp6_and_pad_5_1 <= 0;
        
        Slide_data_2 <= 0;
        Temp6_2      <= 0;
        Pad_and_ADDR1_Temp_2 <= 0;
        Temp6_and_Next_ADDR_Data_2 <= 0;
        Temp6_and_pad_5_2 <= 0;
        
        Slide_data_3 <= 0;
        Temp6_3      <= 0;
        Pad_and_ADDR1_Temp_3 <= 0;
        Temp6_and_Next_ADDR_Data_3 <= 0;
        Temp6_and_pad_5_3 <= 0;
        
        Slide_data_4 <= 0;
        Temp6_4      <= 0;
        Pad_and_ADDR1_Temp_4 <= 0;
        Temp6_and_Next_ADDR_Data_4 <= 0;
        Temp6_and_pad_5_4 <= 0;
        
        Slide_data_5 <= 0;
        Temp6_5      <= 0;
        Pad_and_ADDR1_Temp_5 <= 0;
        Temp6_and_Next_ADDR_Data_5 <= 0;
        Temp6_and_pad_5_5 <= 0;
        
        Slide_data_6 <= 0;
        Temp6_6      <= 0;
        Pad_and_ADDR1_Temp_6 <= 0;
        Temp6_and_Next_ADDR_Data_6 <= 0;
        Temp6_and_pad_5_6 <= 0;
        
        Slide_data_7 <= 0;
        Temp6_7      <= 0;
        Pad_and_ADDR1_Temp_7 <= 0;
        Temp6_and_Next_ADDR_Data_7 <= 0;
        Temp6_and_pad_5_7 <= 0;
        
        Slide_data_8 <= 0;
        Temp6_8      <= 0;
        Pad_and_ADDR1_Temp_8 <= 0;
        Temp6_and_Next_ADDR_Data_8 <= 0;
        Temp6_and_pad_5_8 <= 0;
        
        Slide_data_9 <= 0;
        Temp6_9      <= 0;
        Pad_and_ADDR1_Temp_9 <= 0;
        Temp6_and_Next_ADDR_Data_9 <= 0;
        Temp6_and_pad_5_9 <= 0;
        
        Slide_data_10 <= 0;
        Temp6_10      <= 0;
        Pad_and_ADDR1_Temp_10 <= 0;
        Temp6_and_Next_ADDR_Data_10 <= 0;
        Temp6_and_pad_5_10 <= 0;
        
        Slide_data_11 <= 0;
        Temp6_11      <= 0;
        Pad_and_ADDR1_Temp_11 <= 0;
        Temp6_and_Next_ADDR_Data_11 <= 0;
        Temp6_and_pad_5_11 <= 0;
        
        Slide_data_12 <= 0;
        Temp6_12 <= 0;
        Pad_and_ADDR1_Temp_12 <= 0;
        Temp6_and_Next_ADDR_Data_12 <= 0;
        Temp6_and_pad_5_12 <= 0;
        
        Slide_data_13 <= 0;
        Temp6_13 <= 0;
        Pad_and_ADDR1_Temp_13 <= 0;
        Temp6_and_Next_ADDR_Data_13 <= 0;
        Temp6_and_pad_5_13 <= 0;
        
        Slide_data_14 <= 0;
        Temp6_14 <= 0;
        Pad_and_ADDR1_Temp_14 <= 0;
        Temp6_and_Next_ADDR_Data_14 <= 0;
        Temp6_and_pad_5_14 <= 0;
        
        Slide_data_15 <= 0;
        Temp6_15 <= 0;
        Pad_and_ADDR1_Temp_15 <= 0;
        Temp6_and_Next_ADDR_Data_15 <= 0;
        Temp6_and_pad_5_15 <= 0;
        
    end
    else begin
        if(ADDR_d2 == 0)begin
            if(cnt == 1)begin
              Pad_and_ADDR1_Temp_0 <= {padding_data[4:0], DIN_0[31:0]};
              Temp6_0 <= DIN_0[5:0];
              
              Pad_and_ADDR1_Temp_1 <= {padding_data[4:0], DIN_1[31:0]};
              Temp6_1 <= DIN_1[5:0];
              
              Pad_and_ADDR1_Temp_2 <= {padding_data[4:0], DIN_2[31:0]};
              Temp6_2 <= DIN_2[5:0];
              
              Pad_and_ADDR1_Temp_3 <= {padding_data[4:0], DIN_3[31:0]};
              Temp6_3 <= DIN_3[5:0];
              
              Pad_and_ADDR1_Temp_4 <= {padding_data[4:0], DIN_4[31:0]};
              Temp6_4 <= DIN_4[5:0];
              
              Pad_and_ADDR1_Temp_5 <= {padding_data[4:0], DIN_5[31:0]};
              Temp6_5 <= DIN_5[5:0];
              
              Pad_and_ADDR1_Temp_6 <= {padding_data[4:0], DIN_6[31:0]};
              Temp6_6 <= DIN_6[5:0];
              
              Pad_and_ADDR1_Temp_7 <= {padding_data[4:0], DIN_7[31:0]};
              Temp6_7 <= DIN_7[5:0];
              
              Pad_and_ADDR1_Temp_8 <= {padding_data[4:0], DIN_8[31:0]};
              Temp6_8 <= DIN_8[5:0];
                
              Pad_and_ADDR1_Temp_9 <= {padding_data[4:0], DIN_9[31:0]};
              Temp6_9 <= DIN_9[5:0];
                
              Pad_and_ADDR1_Temp_10 <= {padding_data[4:0], DIN_10[31:0]};
              Temp6_10 <= DIN_10[5:0];
                
              Pad_and_ADDR1_Temp_11 <= {padding_data[4:0], DIN_11[31:0]};
              Temp6_11 <= DIN_11[5:0];
                
              Pad_and_ADDR1_Temp_12 <= {padding_data[4:0], DIN_12[31:0]};
              Temp6_12 <= DIN_12[5:0];
               
              Pad_and_ADDR1_Temp_13 <= {padding_data[4:0], DIN_13[31:0]};
              Temp6_13 <= DIN_13[5:0];
                
              Pad_and_ADDR1_Temp_14 <= {padding_data[4:0], DIN_14[31:0]};
              Temp6_14 <= DIN_14[5:0];
                
              Pad_and_ADDR1_Temp_15 <= {padding_data[4:0], DIN_15[31:0]};
              Temp6_15 <= DIN_15[5:0];
            end
            else if (cnt <= 32)begin 
                Slide_data_0 <= Pad_and_ADDR1_Temp_0[36:30];
                Pad_and_ADDR1_Temp_0 <= {Pad_and_ADDR1_Temp_0[35:0], 1'b0};
                
                Slide_data_1 <= Pad_and_ADDR1_Temp_1[36:30];
                Pad_and_ADDR1_Temp_1 <= {Pad_and_ADDR1_Temp_1[35:0], 1'b0};
                
                Slide_data_2 <= Pad_and_ADDR1_Temp_2[36:30];
                Pad_and_ADDR1_Temp_2 <= {Pad_and_ADDR1_Temp_2[35:0], 1'b0};
                
                Slide_data_3 <= Pad_and_ADDR1_Temp_3[36:30];
                Pad_and_ADDR1_Temp_3 <= {Pad_and_ADDR1_Temp_3[35:0], 1'b0};
                
                Slide_data_4 <= Pad_and_ADDR1_Temp_4[36:30];
                Pad_and_ADDR1_Temp_4 <= {Pad_and_ADDR1_Temp_4[35:0], 1'b0};
                
                Slide_data_5 <= Pad_and_ADDR1_Temp_5[36:30];
                Pad_and_ADDR1_Temp_5 <= {Pad_and_ADDR1_Temp_5[35:0], 1'b0};
                
                Slide_data_6 <= Pad_and_ADDR1_Temp_6[36:30];
                Pad_and_ADDR1_Temp_6 <= {Pad_and_ADDR1_Temp_6[35:0], 1'b0};
                
                Slide_data_7 <= Pad_and_ADDR1_Temp_7[36:30];
                Pad_and_ADDR1_Temp_7 <= {Pad_and_ADDR1_Temp_7[35:0], 1'b0};  
                
                Slide_data_8 <= Pad_and_ADDR1_Temp_8[36:30];
                Pad_and_ADDR1_Temp_8 <= {Pad_and_ADDR1_Temp_8[35:0], 1'b0};
                
                Slide_data_9 <= Pad_and_ADDR1_Temp_9[36:30];
                Pad_and_ADDR1_Temp_9 <= {Pad_and_ADDR1_Temp_9[35:0], 1'b0};
                
                Slide_data_10 <= Pad_and_ADDR1_Temp_10[36:30];
                Pad_and_ADDR1_Temp_10 <= {Pad_and_ADDR1_Temp_10[35:0], 1'b0};
                
                Slide_data_11 <= Pad_and_ADDR1_Temp_11[36:30];
                Pad_and_ADDR1_Temp_11 <= {Pad_and_ADDR1_Temp_11[35:0], 1'b0};
                
                Slide_data_12 <= Pad_and_ADDR1_Temp_12[36:30];
                Pad_and_ADDR1_Temp_12 <= {Pad_and_ADDR1_Temp_12[35:0], 1'b0};
                
                Slide_data_13 <= Pad_and_ADDR1_Temp_13[36:30];
                Pad_and_ADDR1_Temp_13 <= {Pad_and_ADDR1_Temp_13[35:0], 1'b0};
                
                Slide_data_14 <= Pad_and_ADDR1_Temp_14[36:30];
                Pad_and_ADDR1_Temp_14 <= {Pad_and_ADDR1_Temp_14[35:0], 1'b0};
                
                Slide_data_15 <= Pad_and_ADDR1_Temp_15[36:30];
                Pad_and_ADDR1_Temp_15 <= {Pad_and_ADDR1_Temp_15[35:0], 1'b0};                              
                if(cnt == 32)begin
                    Temp6_and_Next_ADDR_Data_0 <= {Temp6_0[5:0], DIN_0[31:0]};
                    Temp6_and_Next_ADDR_Data_1 <= {Temp6_1[5:0], DIN_1[31:0]};
                    Temp6_and_Next_ADDR_Data_2 <= {Temp6_2[5:0], DIN_2[31:0]};
                    Temp6_and_Next_ADDR_Data_3 <= {Temp6_3[5:0], DIN_3[31:0]};
                    Temp6_and_Next_ADDR_Data_4 <= {Temp6_4[5:0], DIN_4[31:0]};
                    Temp6_and_Next_ADDR_Data_5 <= {Temp6_5[5:0], DIN_5[31:0]};
                    Temp6_and_Next_ADDR_Data_6 <= {Temp6_6[5:0], DIN_6[31:0]};
                    Temp6_and_Next_ADDR_Data_7 <= {Temp6_7[5:0], DIN_7[31:0]};
                    Temp6_and_Next_ADDR_Data_8 <= {Temp6_8[5:0], DIN_8[31:0]};
                    Temp6_and_Next_ADDR_Data_9 <= {Temp6_9[5:0], DIN_9[31:0]};
                    Temp6_and_Next_ADDR_Data_10 <= {Temp6_10[5:0], DIN_10[31:0]};
                    Temp6_and_Next_ADDR_Data_11 <= {Temp6_11[5:0], DIN_11[31:0]};
                    Temp6_and_Next_ADDR_Data_12 <= {Temp6_12[5:0], DIN_12[31:0]};
                    Temp6_and_Next_ADDR_Data_13 <= {Temp6_13[5:0], DIN_13[31:0]};
                    Temp6_and_Next_ADDR_Data_14 <= {Temp6_14[5:0], DIN_14[31:0]};
                    Temp6_and_Next_ADDR_Data_15 <= {Temp6_15[5:0], DIN_15[31:0]};
                end
            end
        end
        else if(ADDR_d2 <= 13)begin
            if(cnt == 0)begin
                Slide_data_0 <= Temp6_and_Next_ADDR_Data_0[37:31];
                Temp6_and_Next_ADDR_Data_0 <= {Temp6_and_Next_ADDR_Data_0[36:0], 1'b0};
                Temp6_0 <= DIN_0[5:0];
            
                Slide_data_1 <= Temp6_and_Next_ADDR_Data_1[37:31];
                Temp6_and_Next_ADDR_Data_1 <= {Temp6_and_Next_ADDR_Data_1[36:0], 1'b0};
                Temp6_1 <= DIN_1[5:0];
                
                Slide_data_2 <= Temp6_and_Next_ADDR_Data_2[37:31];
                Temp6_and_Next_ADDR_Data_2 <= {Temp6_and_Next_ADDR_Data_2[36:0], 1'b0};
                Temp6_2 <= DIN_2[5:0];
                
                Slide_data_3 <= Temp6_and_Next_ADDR_Data_3[37:31];
                Temp6_and_Next_ADDR_Data_3 <= {Temp6_and_Next_ADDR_Data_3[36:0], 1'b0};
                Temp6_3 <= DIN_3[5:0];
                
                Slide_data_4 <= Temp6_and_Next_ADDR_Data_4[37:31];
                Temp6_and_Next_ADDR_Data_4 <= {Temp6_and_Next_ADDR_Data_4[36:0], 1'b0};
                Temp6_4 <= DIN_4[5:0];
                
                Slide_data_5 <= Temp6_and_Next_ADDR_Data_5[37:31];
                Temp6_and_Next_ADDR_Data_5 <= {Temp6_and_Next_ADDR_Data_5[36:0], 1'b0};
                Temp6_5 <= DIN_5[5:0];
                
                Slide_data_6 <= Temp6_and_Next_ADDR_Data_6[37:31];
                Temp6_and_Next_ADDR_Data_6 <= {Temp6_and_Next_ADDR_Data_6[36:0], 1'b0};
                Temp6_6 <= DIN_6[5:0];
                
                Slide_data_7 <= Temp6_and_Next_ADDR_Data_7[37:31];
                Temp6_and_Next_ADDR_Data_7 <= {Temp6_and_Next_ADDR_Data_7[36:0], 1'b0};
                Temp6_7 <= DIN_7[5:0];
                
                Slide_data_8 <= Temp6_and_Next_ADDR_Data_8[37:31];
                Temp6_and_Next_ADDR_Data_8 <= {Temp6_and_Next_ADDR_Data_8[36:0], 1'b0};
                Temp6_8 <= DIN_8[5:0];
                
                Slide_data_9 <= Temp6_and_Next_ADDR_Data_9[37:31];
                Temp6_and_Next_ADDR_Data_9 <= {Temp6_and_Next_ADDR_Data_9[36:0], 1'b0};
                Temp6_9 <= DIN_9[5:0];
                
                Slide_data_10 <= Temp6_and_Next_ADDR_Data_10[37:31];
                Temp6_and_Next_ADDR_Data_10 <= {Temp6_and_Next_ADDR_Data_10[36:0], 1'b0};
                Temp6_10 <= DIN_10[5:0];
                
                Slide_data_11 <= Temp6_and_Next_ADDR_Data_11[37:31];
                Temp6_and_Next_ADDR_Data_11 <= {Temp6_and_Next_ADDR_Data_11[36:0], 1'b0};
                Temp6_11 <= DIN_11[5:0];
                
                Slide_data_12 <= Temp6_and_Next_ADDR_Data_12[37:31];
                Temp6_and_Next_ADDR_Data_12 <= {Temp6_and_Next_ADDR_Data_12[36:0], 1'b0};
                Temp6_12 <= DIN_12[5:0];
                
                Slide_data_13 <= Temp6_and_Next_ADDR_Data_13[37:31];
                Temp6_and_Next_ADDR_Data_13 <= {Temp6_and_Next_ADDR_Data_13[36:0], 1'b0};
                Temp6_13 <= DIN_13[5:0];
                
                Slide_data_14 <= Temp6_and_Next_ADDR_Data_14[37:31];
                Temp6_and_Next_ADDR_Data_14 <= {Temp6_and_Next_ADDR_Data_14[36:0], 1'b0};
                Temp6_14 <= DIN_14[5:0];
                
                Slide_data_15 <= Temp6_and_Next_ADDR_Data_15[37:31];
                Temp6_and_Next_ADDR_Data_15 <= {Temp6_and_Next_ADDR_Data_15[36:0], 1'b0};
                Temp6_15 <= DIN_15[5:0];         
            end
            else if(cnt <= 31)begin
                Slide_data_0 <= Temp6_and_Next_ADDR_Data_0[37:31];
                Temp6_and_Next_ADDR_Data_0 <= {Temp6_and_Next_ADDR_Data_0[36:0], 1'b0};
            
                Slide_data_1 <= Temp6_and_Next_ADDR_Data_1[37:31];
                Temp6_and_Next_ADDR_Data_1 <= {Temp6_and_Next_ADDR_Data_1[36:0], 1'b0};
                
                Slide_data_2 <= Temp6_and_Next_ADDR_Data_2[37:31];
                Temp6_and_Next_ADDR_Data_2 <= {Temp6_and_Next_ADDR_Data_2[36:0], 1'b0};
                
                Slide_data_3 <= Temp6_and_Next_ADDR_Data_3[37:31];
                Temp6_and_Next_ADDR_Data_3 <= {Temp6_and_Next_ADDR_Data_3[36:0], 1'b0};
                
                Slide_data_4 <= Temp6_and_Next_ADDR_Data_4[37:31];
                Temp6_and_Next_ADDR_Data_4 <= {Temp6_and_Next_ADDR_Data_4[36:0], 1'b0};
                
                Slide_data_5 <= Temp6_and_Next_ADDR_Data_5[37:31];
                Temp6_and_Next_ADDR_Data_5 <= {Temp6_and_Next_ADDR_Data_5[36:0], 1'b0};
                
                Slide_data_6 <= Temp6_and_Next_ADDR_Data_6[37:31];
                Temp6_and_Next_ADDR_Data_6 <= {Temp6_and_Next_ADDR_Data_6[36:0], 1'b0};
                
                Slide_data_7 <= Temp6_and_Next_ADDR_Data_7[37:31];
                Temp6_and_Next_ADDR_Data_7 <= {Temp6_and_Next_ADDR_Data_7[36:0], 1'b0};
                
                Slide_data_8 <= Temp6_and_Next_ADDR_Data_8[37:31];
                Temp6_and_Next_ADDR_Data_8 <= {Temp6_and_Next_ADDR_Data_8[36:0], 1'b0};
                
                Slide_data_9 <= Temp6_and_Next_ADDR_Data_9[37:31];
                Temp6_and_Next_ADDR_Data_9 <= {Temp6_and_Next_ADDR_Data_9[36:0], 1'b0};
                
                Slide_data_10 <= Temp6_and_Next_ADDR_Data_10[37:31];
                Temp6_and_Next_ADDR_Data_10 <= {Temp6_and_Next_ADDR_Data_10[36:0], 1'b0};
                
                Slide_data_11 <= Temp6_and_Next_ADDR_Data_11[37:31];
                Temp6_and_Next_ADDR_Data_11 <= {Temp6_and_Next_ADDR_Data_11[36:0], 1'b0};
                
                Slide_data_12 <= Temp6_and_Next_ADDR_Data_12[37:31];
                Temp6_and_Next_ADDR_Data_12 <= {Temp6_and_Next_ADDR_Data_12[36:0], 1'b0};
                
                Slide_data_13 <= Temp6_and_Next_ADDR_Data_13[37:31];
                Temp6_and_Next_ADDR_Data_13 <= {Temp6_and_Next_ADDR_Data_13[36:0], 1'b0};
                
                Slide_data_14 <= Temp6_and_Next_ADDR_Data_14[37:31];
                Temp6_and_Next_ADDR_Data_14 <= {Temp6_and_Next_ADDR_Data_14[36:0], 1'b0};
                
                Slide_data_15 <= Temp6_and_Next_ADDR_Data_15[37:31];
                Temp6_and_Next_ADDR_Data_15 <= {Temp6_and_Next_ADDR_Data_15[36:0], 1'b0};
                if(ADDR_d2!= 13 && cnt == 31)begin
                    Temp6_and_Next_ADDR_Data_0 <= {Temp6_0[5:0], DIN_0[31:0]};
                    Temp6_and_Next_ADDR_Data_1 <= {Temp6_1[5:0], DIN_1[31:0]};
                    Temp6_and_Next_ADDR_Data_2 <= {Temp6_2[5:0], DIN_2[31:0]};
                    Temp6_and_Next_ADDR_Data_3 <= {Temp6_3[5:0], DIN_3[31:0]};
                    Temp6_and_Next_ADDR_Data_4 <= {Temp6_4[5:0], DIN_4[31:0]};
                    Temp6_and_Next_ADDR_Data_5 <= {Temp6_5[5:0], DIN_5[31:0]};
                    Temp6_and_Next_ADDR_Data_6 <= {Temp6_6[5:0], DIN_6[31:0]};
                    Temp6_and_Next_ADDR_Data_7 <= {Temp6_7[5:0], DIN_7[31:0]};
                    Temp6_and_Next_ADDR_Data_8 <= {Temp6_8[5:0], DIN_8[31:0]};
                    Temp6_and_Next_ADDR_Data_9 <= {Temp6_9[5:0], DIN_9[31:0]};
                    Temp6_and_Next_ADDR_Data_10 <= {Temp6_10[5:0], DIN_10[31:0]};
                    Temp6_and_Next_ADDR_Data_11 <= {Temp6_11[5:0], DIN_11[31:0]};
                    Temp6_and_Next_ADDR_Data_12 <= {Temp6_12[5:0], DIN_12[31:0]};
                    Temp6_and_Next_ADDR_Data_13 <= {Temp6_13[5:0], DIN_13[31:0]};
                    Temp6_and_Next_ADDR_Data_14 <= {Temp6_14[5:0], DIN_14[31:0]};
                    Temp6_and_Next_ADDR_Data_15 <= {Temp6_15[5:0], DIN_15[31:0]};
                end else if(ADDR_d2 == 13 && cnt ==31)begin
                    Temp6_and_pad_5_0 <= {Temp6_0[5:0], 5'b11111};
                    Temp6_and_pad_5_1 <= {Temp6_1[5:0], 5'b11111};
                    Temp6_and_pad_5_2 <= {Temp6_2[5:0], 5'b11111};
                    Temp6_and_pad_5_3 <= {Temp6_3[5:0], 5'b11111};
                    Temp6_and_pad_5_4 <= {Temp6_4[5:0], 5'b11111};
                    Temp6_and_pad_5_5 <= {Temp6_5[5:0], 5'b11111};
                    Temp6_and_pad_5_6 <= {Temp6_6[5:0], 5'b11111};
                    Temp6_and_pad_5_7 <= {Temp6_7[5:0], 5'b11111};
                    Temp6_and_pad_5_8 <= {Temp6_8[5:0], 5'b11111};
                    Temp6_and_pad_5_9 <= {Temp6_9[5:0], 5'b11111};
                    Temp6_and_pad_5_10 <= {Temp6_10[5:0], 5'b11111};
                    Temp6_and_pad_5_11 <= {Temp6_11[5:0], 5'b11111};
                    Temp6_and_pad_5_12 <= {Temp6_12[5:0], 5'b11111};
                    Temp6_and_pad_5_13 <= {Temp6_13[5:0], 5'b11111};
                    Temp6_and_pad_5_14 <= {Temp6_14[5:0], 5'b11111};
                    Temp6_and_pad_5_15 <= {Temp6_15[5:0], 5'b11111};
                end
            end
            end else if(ADDR_d2 == 14)begin
                if(cnt <= 4)begin
                    Slide_data_0 <= Temp6_and_pad_5_0[10:4];
                    Temp6_and_pad_5_0 <= {Temp6_and_pad_5_0[9:0], 1'b0};
                    
                    Slide_data_1 <= Temp6_and_pad_5_1[10:4];
                    Temp6_and_pad_5_1 <= {Temp6_and_pad_5_1[9:0], 1'b0};
                    
                    Slide_data_2 <= Temp6_and_pad_5_2[10:4];
                    Temp6_and_pad_5_2 <= {Temp6_and_pad_5_2[9:0], 1'b0};
                    
                    Slide_data_3 <= Temp6_and_pad_5_3[10:4];
                    Temp6_and_pad_5_3 <= {Temp6_and_pad_5_3[9:0], 1'b0};
                    
                    Slide_data_4 <= Temp6_and_pad_5_4[10:4];
                    Temp6_and_pad_5_4 <= {Temp6_and_pad_5_4[9:0], 1'b0};
                    
                    Slide_data_5 <= Temp6_and_pad_5_5[10:4];
                    Temp6_and_pad_5_5 <= {Temp6_and_pad_5_5[9:0], 1'b0};
                    
                    Slide_data_6 <= Temp6_and_pad_5_6[10:4];
                    Temp6_and_pad_5_6 <= {Temp6_and_pad_5_6[9:0], 1'b0};
                    
                    Slide_data_7 <= Temp6_and_pad_5_7[10:4];
                    Temp6_and_pad_5_7 <= {Temp6_and_pad_5_7[9:0], 1'b0};
                    
                    Slide_data_8 <= Temp6_and_pad_5_8[10:4];
                    Temp6_and_pad_5_8 <= {Temp6_and_pad_5_8[9:0], 1'b0};
                    
                    Slide_data_9 <= Temp6_and_pad_5_9[10:4];
                    Temp6_and_pad_5_9 <= {Temp6_and_pad_5_9[9:0], 1'b0};
                    
                    Slide_data_10 <= Temp6_and_pad_5_10[10:4];
                    Temp6_and_pad_5_10 <= {Temp6_and_pad_5_10[9:0], 1'b0};
                    
                    Slide_data_11 <= Temp6_and_pad_5_11[10:4];
                    Temp6_and_pad_5_11 <= {Temp6_and_pad_5_11[9:0], 1'b0};
                    
                    Slide_data_12 <= Temp6_and_pad_5_12[10:4];
                    Temp6_and_pad_5_12 <= {Temp6_and_pad_5_12[9:0], 1'b0};
                    
                    Slide_data_13 <= Temp6_and_pad_5_13[10:4];
                    Temp6_and_pad_5_13 <= {Temp6_and_pad_5_13[9:0], 1'b0};
                    
                    Slide_data_14 <= Temp6_and_pad_5_14[10:4];
                    Temp6_and_pad_5_14 <= {Temp6_and_pad_5_14[9:0], 1'b0};
                    
                    Slide_data_15 <= Temp6_and_pad_5_15[10:4];
                    Temp6_and_pad_5_15 <= {Temp6_and_pad_5_15[9:0], 1'b0};
                end
                else if(cnt == 5)begin
                    padding_data <= 0;
                                
                    Slide_data_0 <= 0;
                    Temp6_and_Next_ADDR_Data_0 <= 0;
                    Temp6_and_pad_5_0 <= 0;
                    
                    Slide_data_1 <= 0;
                    Temp6_and_Next_ADDR_Data_1 <= 0;
                    Temp6_and_pad_5_1 <= 0;
                    
                    Slide_data_2 <= 0;
                    Temp6_and_Next_ADDR_Data_2 <= 0;
                    Temp6_and_pad_5_2 <= 0;
                    
                    Slide_data_3 <= 0;
                    Temp6_and_Next_ADDR_Data_3 <= 0;
                    Temp6_and_pad_5_3 <= 0;
                    
                    Slide_data_4 <= 0;
                    Temp6_and_Next_ADDR_Data_4 <= 0;
                    Temp6_and_pad_5_4 <= 0;
                    
                    Slide_data_5 <= 0;
                    Temp6_and_Next_ADDR_Data_5 <= 0;
                    Temp6_and_pad_5_5 <= 0;
                    
                    Slide_data_6 <= 0;
                    Temp6_and_Next_ADDR_Data_6 <= 0;
                    Temp6_and_pad_5_6 <= 0;
                    
                    Slide_data_7 <= 0;
                    Temp6_and_Next_ADDR_Data_7 <= 0;
                    Temp6_and_pad_5_7 <= 0;
                    
                    Slide_data_8 <= 0;
                    Temp6_and_Next_ADDR_Data_8 <= 0;
                    Temp6_and_pad_5_8 <= 0;
                    
                    Slide_data_9 <= 0;
                    Temp6_and_Next_ADDR_Data_9 <= 0;
                    Temp6_and_pad_5_9 <= 0;
                    
                    Slide_data_10 <= 0;
                    Temp6_and_Next_ADDR_Data_10 <= 0;
                    Temp6_and_pad_5_10 <= 0;
                    
                    Slide_data_11 <= 0;
                    Temp6_and_Next_ADDR_Data_11 <= 0;
                    Temp6_and_pad_5_11 <= 0;
                    
                    Slide_data_12 <= 0;
                    Temp6_and_Next_ADDR_Data_12 <= 0;
                    Temp6_and_pad_5_12 <= 0;
                    
                    Slide_data_13 <= 0;
                    Temp6_and_Next_ADDR_Data_13 <= 0;
                    Temp6_and_pad_5_13 <= 0;
                    
                    Slide_data_14 <= 0;
                    Temp6_and_Next_ADDR_Data_14 <= 0;
                    Temp6_and_pad_5_14 <= 0;
                    
                    Slide_data_15 <= 0;
                    Temp6_and_Next_ADDR_Data_15 <= 0;
                    Temp6_and_pad_5_15 <= 0;
                end
            end
        end
    end










endmodule
