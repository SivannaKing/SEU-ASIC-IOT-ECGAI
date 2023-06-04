`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/07 21:48:48
// Design Name: 
// Module Name: IB_SWU_Addr_Contr_B5
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


module IB_SWU_Addr_Contr_B5(
    input                        clk,
    input                        rst_n,
    input    wire     [31:0]     DIN_0, DIN_1, DIN_2,  DIN_3,  DIN_4,  DIN_5,  DIN_6,  DIN_7,
                                 DIN_8, DIN_9, DIN_10, DIN_11, DIN_12, DIN_13, DIN_14, DIN_15,
                                 DIN_16, DIN_17, DIN_18, DIN_19, DIN_20, DIN_21, DIN_22, DIN_23, 
                                 DIN_24, DIN_25, DIN_26, DIN_27, DIN_28, DIN_29, DIN_30, DIN_31, 
    output   reg      [ 2:0]     ADDR,
    output   reg                 WEA,
    output   reg                 IB_Addr_SWU_work, IB_Addr_SWU_work_Done,
    output   reg      [ 6:0]     Slide_data_0, Slide_data_1, Slide_data_2,  Slide_data_3,  Slide_data_4,  Slide_data_5,  Slide_data_6,  Slide_data_7,
                                 Slide_data_8, Slide_data_9, Slide_data_10, Slide_data_11, Slide_data_12, Slide_data_13, Slide_data_14, Slide_data_15,
                                 Slide_data_16, Slide_data_17, Slide_data_18, Slide_data_19, Slide_data_20, Slide_data_21, Slide_data_22, Slide_data_23, 
                                 Slide_data_24, Slide_data_25, Slide_data_26, Slide_data_27, Slide_data_28, Slide_data_29, Slide_data_30, Slide_data_31, 
    output   reg                 PE_EN  //产生第一个7bit的PE阵列输入数据时，代表了PE有效 
);
//*****************************************************基本照搬Block4的SWU代码*****************************************************
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
            if(!(ADDR_d2==3 && cnt ==20))begin//20是因为Block5的地址4仅有15个有效数据，另外考虑5个padding
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
        if(ADDR == 3 && cnt == 20)begin
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
        if(!(ADDR_d2==3 && cnt == 20))begin
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
reg   [36:0]     Pad_and_ADDR1_Temp_0, Pad_and_ADDR1_Temp_1, Pad_and_ADDR1_Temp_2, Pad_and_ADDR1_Temp_3, Pad_and_ADDR1_Temp_4, Pad_and_ADDR1_Temp_5, Pad_and_ADDR1_Temp_6, Pad_and_ADDR1_Temp_7, 
                 Pad_and_ADDR1_Temp_8, Pad_and_ADDR1_Temp_9, Pad_and_ADDR1_Temp_10, Pad_and_ADDR1_Temp_11, Pad_and_ADDR1_Temp_12, Pad_and_ADDR1_Temp_13, Pad_and_ADDR1_Temp_14, Pad_and_ADDR1_Temp_15, 
                 Pad_and_ADDR1_Temp_16, Pad_and_ADDR1_Temp_17, Pad_and_ADDR1_Temp_18, Pad_and_ADDR1_Temp_19, Pad_and_ADDR1_Temp_20, Pad_and_ADDR1_Temp_21, Pad_and_ADDR1_Temp_22, Pad_and_ADDR1_Temp_23, 
                 Pad_and_ADDR1_Temp_24, Pad_and_ADDR1_Temp_25, Pad_and_ADDR1_Temp_26, Pad_and_ADDR1_Temp_27, Pad_and_ADDR1_Temp_28, Pad_and_ADDR1_Temp_29, Pad_and_ADDR1_Temp_30, Pad_and_ADDR1_Temp_31;
reg   [ 5:0]     Temp6_0, Temp6_1, Temp6_2, Temp6_3, Temp6_4, Temp6_5, Temp6_6, Temp6_7, Temp6_8, Temp6_9, Temp6_10, Temp6_11, Temp6_12, Temp6_13, Temp6_14, Temp6_15, 
                 Temp6_16, Temp6_17, Temp6_18, Temp6_19, Temp6_20, Temp6_21, Temp6_22, Temp6_23, Temp6_24, Temp6_25, Temp6_26, Temp6_27, Temp6_28, Temp6_29, Temp6_30, Temp6_31;
reg   [37:0]     Temp6_and_Next_ADDR_Data_0, Temp6_and_Next_ADDR_Data_1, Temp6_and_Next_ADDR_Data_2, Temp6_and_Next_ADDR_Data_3, Temp6_and_Next_ADDR_Data_4, Temp6_and_Next_ADDR_Data_5, Temp6_and_Next_ADDR_Data_6, Temp6_and_Next_ADDR_Data_7, 
                 Temp6_and_Next_ADDR_Data_8, Temp6_and_Next_ADDR_Data_9, Temp6_and_Next_ADDR_Data_10, Temp6_and_Next_ADDR_Data_11, Temp6_and_Next_ADDR_Data_12, Temp6_and_Next_ADDR_Data_13, Temp6_and_Next_ADDR_Data_14, Temp6_and_Next_ADDR_Data_15, 
                 Temp6_and_Next_ADDR_Data_16, Temp6_and_Next_ADDR_Data_17, Temp6_and_Next_ADDR_Data_18, Temp6_and_Next_ADDR_Data_19, Temp6_and_Next_ADDR_Data_20, Temp6_and_Next_ADDR_Data_21, Temp6_and_Next_ADDR_Data_22, Temp6_and_Next_ADDR_Data_23, 
                 Temp6_and_Next_ADDR_Data_24, Temp6_and_Next_ADDR_Data_25, Temp6_and_Next_ADDR_Data_26, Temp6_and_Next_ADDR_Data_27, Temp6_and_Next_ADDR_Data_28, Temp6_and_Next_ADDR_Data_29, Temp6_and_Next_ADDR_Data_30, Temp6_and_Next_ADDR_Data_31;
reg   [10:0]     Temp6_and_five_one_0, Temp6_and_five_one_1, Temp6_and_five_one_2, Temp6_and_five_one_3, Temp6_and_five_one_4, Temp6_and_five_one_5, Temp6_and_five_one_6, Temp6_and_five_one_7, 
                 Temp6_and_five_one_8, Temp6_and_five_one_9, Temp6_and_five_one_10, Temp6_and_five_one_11, Temp6_and_five_one_12, Temp6_and_five_one_13, Temp6_and_five_one_14, Temp6_and_five_one_15, Temp6_and_five_one_16, 
                 Temp6_and_five_one_17, Temp6_and_five_one_18, Temp6_and_five_one_19, Temp6_and_five_one_20, Temp6_and_five_one_21, Temp6_and_five_one_22, Temp6_and_five_one_23, Temp6_and_five_one_24, Temp6_and_five_one_25, 
                 Temp6_and_five_one_26, Temp6_and_five_one_27, Temp6_and_five_one_28, Temp6_and_five_one_29, Temp6_and_five_one_30, Temp6_and_five_one_31;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        padding_data <= 5'b11111;
        
        Slide_data_0 <= 0;
        Temp6_0      <= 0;
        Pad_and_ADDR1_Temp_0 <= 0;
        Temp6_and_Next_ADDR_Data_0 <= 0;
        Temp6_and_five_one_0 <= 0;
        
        Slide_data_1 <= 0;
        Temp6_1      <= 0;
        Pad_and_ADDR1_Temp_1 <= 0;
        Temp6_and_Next_ADDR_Data_1 <= 0;
        Temp6_and_five_one_1 <= 0;
        
        
        Slide_data_2 <= 0;
        Temp6_2      <= 0;
        Pad_and_ADDR1_Temp_2 <= 0;
        Temp6_and_Next_ADDR_Data_2 <= 0;
        Temp6_and_five_one_2 <= 0;
        
        
        Slide_data_3 <= 0;
        Temp6_3      <= 0;
        Pad_and_ADDR1_Temp_3 <= 0;
        Temp6_and_Next_ADDR_Data_3 <= 0;
        Temp6_and_five_one_3 <= 0;
        
        
        Slide_data_4 <= 0;
        Temp6_4      <= 0;
        Pad_and_ADDR1_Temp_4 <= 0;
        Temp6_and_Next_ADDR_Data_4 <= 0;
        Temp6_and_five_one_4 <= 0;
        
        
        Slide_data_5 <= 0;
        Temp6_5      <= 0;
        Pad_and_ADDR1_Temp_5 <= 0;
        Temp6_and_Next_ADDR_Data_5 <= 0;
        Temp6_and_five_one_5 <= 0;
        
        
        Slide_data_6 <= 0;
        Temp6_6      <= 0;
        Pad_and_ADDR1_Temp_6 <= 0;
        Temp6_and_Next_ADDR_Data_6 <= 0;
        Temp6_and_five_one_6 <= 0;
        
        
        Slide_data_7 <= 0;
        Temp6_7      <= 0;
        Pad_and_ADDR1_Temp_7 <= 0;
        Temp6_and_Next_ADDR_Data_7 <= 0;
        Temp6_and_five_one_7 <= 0;
        
        
        Slide_data_8 <= 0;
        Temp6_8      <= 0;
        Pad_and_ADDR1_Temp_8 <= 0;
        Temp6_and_Next_ADDR_Data_8 <= 0;
        Temp6_and_five_one_8 <= 0;
        
        
        Slide_data_9 <= 0;
        Temp6_9      <= 0;
        Pad_and_ADDR1_Temp_9 <= 0;
        Temp6_and_Next_ADDR_Data_9 <= 0;
        Temp6_and_five_one_9 <= 0;
        
        
        Slide_data_10 <= 0;
        Temp6_10      <= 0;
        Pad_and_ADDR1_Temp_10 <= 0;
        Temp6_and_Next_ADDR_Data_10 <= 0;
        Temp6_and_five_one_10 <= 0;
        
        
        Slide_data_11 <= 0;
        Temp6_11      <= 0;
        Pad_and_ADDR1_Temp_11 <= 0;
        Temp6_and_Next_ADDR_Data_11 <= 0;
        Temp6_and_five_one_11 <= 0;
        
        
        Slide_data_12 <= 0;
        Temp6_12      <= 0;
        Pad_and_ADDR1_Temp_12 <= 0;
        Temp6_and_Next_ADDR_Data_12 <= 0;
        Temp6_and_five_one_12 <= 0;
        
        
        Slide_data_13 <= 0;
        Temp6_13      <= 0;
        Pad_and_ADDR1_Temp_13 <= 0;
        Temp6_and_Next_ADDR_Data_13 <= 0;
        Temp6_and_five_one_13 <= 0;
        
        
        Slide_data_14 <= 0;
        Temp6_14      <= 0;
        Pad_and_ADDR1_Temp_14 <= 0;
        Temp6_and_Next_ADDR_Data_14 <= 0;
        Temp6_and_five_one_14 <= 0;
        
        
        Slide_data_15 <= 0;
        Temp6_15      <= 0;
        Pad_and_ADDR1_Temp_15 <= 0;
        Temp6_and_Next_ADDR_Data_15 <= 0;
        Temp6_and_five_one_15 <= 0;
        
        
        Slide_data_16 <= 0;
        Temp6_16      <= 0;
        Pad_and_ADDR1_Temp_16 <= 0;
        Temp6_and_Next_ADDR_Data_16 <= 0;
        Temp6_and_five_one_16 <= 0;
        
        
        Slide_data_17 <= 0;
        Temp6_17      <= 0;
        Pad_and_ADDR1_Temp_17 <= 0;
        Temp6_and_Next_ADDR_Data_17 <= 0;
        Temp6_and_five_one_17 <= 0;
        
        
        Slide_data_18 <= 0;
        Temp6_18      <= 0;
        Pad_and_ADDR1_Temp_18 <= 0;
        Temp6_and_Next_ADDR_Data_18 <= 0;
        Temp6_and_five_one_18 <= 0;
        
        
        Slide_data_19 <= 0;
        Temp6_19      <= 0;
        Pad_and_ADDR1_Temp_19 <= 0;
        Temp6_and_Next_ADDR_Data_19 <= 0;
        Temp6_and_five_one_19 <= 0;
        
        
        Slide_data_20 <= 0;
        Temp6_20      <= 0;
        Pad_and_ADDR1_Temp_20 <= 0;
        Temp6_and_Next_ADDR_Data_20 <= 0;
        Temp6_and_five_one_20 <= 0;
        
        
        Slide_data_21 <= 0;
        Temp6_21      <= 0;
        Pad_and_ADDR1_Temp_21 <= 0;
        Temp6_and_Next_ADDR_Data_21 <= 0;
        Temp6_and_five_one_21 <= 0;
        
        
        Slide_data_22 <= 0;
        Temp6_22      <= 0;
        Pad_and_ADDR1_Temp_22 <= 0;
        Temp6_and_Next_ADDR_Data_22 <= 0;
        Temp6_and_five_one_22 <= 0;
        
        
        Slide_data_23 <= 0;
        Temp6_23      <= 0;
        Pad_and_ADDR1_Temp_23 <= 0;
        Temp6_and_Next_ADDR_Data_23 <= 0;
        Temp6_and_five_one_23 <= 0;
        
        
        Slide_data_24 <= 0;
        Temp6_24      <= 0;
        Pad_and_ADDR1_Temp_24 <= 0;
        Temp6_and_Next_ADDR_Data_24 <= 0;
        Temp6_and_five_one_24 <= 0;
        
        
        Slide_data_25 <= 0;
        Temp6_25      <= 0;
        Pad_and_ADDR1_Temp_25 <= 0;
        Temp6_and_Next_ADDR_Data_25 <= 0;
        Temp6_and_five_one_25 <= 0;
        
        
        Slide_data_26 <= 0;
        Temp6_26      <= 0;
        Pad_and_ADDR1_Temp_26 <= 0;
        Temp6_and_Next_ADDR_Data_26 <= 0;
        Temp6_and_five_one_26 <= 0;
        
        
        Slide_data_27 <= 0;
        Temp6_27      <= 0;
        Pad_and_ADDR1_Temp_27 <= 0;
        Temp6_and_Next_ADDR_Data_27 <= 0;
        Temp6_and_five_one_27 <= 0;
        
        
        Slide_data_28 <= 0;
        Temp6_28      <= 0;
        Pad_and_ADDR1_Temp_28 <= 0;
        Temp6_and_Next_ADDR_Data_28 <= 0;
        Temp6_and_five_one_28 <= 0;
        
        
        Slide_data_29 <= 0;
        Temp6_29      <= 0;
        Pad_and_ADDR1_Temp_29 <= 0;
        Temp6_and_Next_ADDR_Data_29 <= 0;
        Temp6_and_five_one_29 <= 0;
        
        
        Slide_data_30 <= 0;
        Temp6_30      <= 0;
        Pad_and_ADDR1_Temp_30 <= 0;
        Temp6_and_Next_ADDR_Data_30 <= 0;
        Temp6_and_five_one_30 <= 0;
        
        
        Slide_data_31 <= 0;
        Temp6_31      <= 0;
        Pad_and_ADDR1_Temp_31 <= 0;
        Temp6_and_Next_ADDR_Data_31 <= 0;
        Temp6_and_five_one_31 <= 0;
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
                
                
                Pad_and_ADDR1_Temp_16 <= {padding_data[4:0], DIN_16[31:0]};
                Temp6_16 <= DIN_16[5:0];
                
                
                Pad_and_ADDR1_Temp_17 <= {padding_data[4:0], DIN_17[31:0]};
                Temp6_17 <= DIN_17[5:0];
                
                
                Pad_and_ADDR1_Temp_18 <= {padding_data[4:0], DIN_18[31:0]};
                Temp6_18 <= DIN_18[5:0];
                
                
                Pad_and_ADDR1_Temp_19 <= {padding_data[4:0], DIN_19[31:0]};
                Temp6_19 <= DIN_19[5:0];
                
                
                Pad_and_ADDR1_Temp_20 <= {padding_data[4:0], DIN_20[31:0]};
                Temp6_20 <= DIN_20[5:0];
                
                
                Pad_and_ADDR1_Temp_21 <= {padding_data[4:0], DIN_21[31:0]};
                Temp6_21 <= DIN_21[5:0];
                
                
                Pad_and_ADDR1_Temp_22 <= {padding_data[4:0], DIN_22[31:0]};
                Temp6_22 <= DIN_22[5:0];
                
                
                Pad_and_ADDR1_Temp_23 <= {padding_data[4:0], DIN_23[31:0]};
                Temp6_23 <= DIN_23[5:0];
                
                
                Pad_and_ADDR1_Temp_24 <= {padding_data[4:0], DIN_24[31:0]};
                Temp6_24 <= DIN_24[5:0];
                
                
                Pad_and_ADDR1_Temp_25 <= {padding_data[4:0], DIN_25[31:0]};
                Temp6_25 <= DIN_25[5:0];
                
                
                Pad_and_ADDR1_Temp_26 <= {padding_data[4:0], DIN_26[31:0]};
                Temp6_26 <= DIN_26[5:0];
                
                
                Pad_and_ADDR1_Temp_27 <= {padding_data[4:0], DIN_27[31:0]};
                Temp6_27 <= DIN_27[5:0];
                
                
                Pad_and_ADDR1_Temp_28 <= {padding_data[4:0], DIN_28[31:0]};
                Temp6_28 <= DIN_28[5:0];
                
                
                Pad_and_ADDR1_Temp_29 <= {padding_data[4:0], DIN_29[31:0]};
                Temp6_29 <= DIN_29[5:0];
                
                
                Pad_and_ADDR1_Temp_30 <= {padding_data[4:0], DIN_30[31:0]};
                Temp6_30 <= DIN_30[5:0];
                
                
                Pad_and_ADDR1_Temp_31 <= {padding_data[4:0], DIN_31[31:0]};
                Temp6_31 <= DIN_31[5:0];
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
                
                
                Slide_data_16 <= Pad_and_ADDR1_Temp_16[36:30];
                Pad_and_ADDR1_Temp_16 <= {Pad_and_ADDR1_Temp_16[35:0], 1'b0};
                
                
                Slide_data_17 <= Pad_and_ADDR1_Temp_17[36:30];
                Pad_and_ADDR1_Temp_17 <= {Pad_and_ADDR1_Temp_17[35:0], 1'b0};
                
                
                Slide_data_18 <= Pad_and_ADDR1_Temp_18[36:30];
                Pad_and_ADDR1_Temp_18 <= {Pad_and_ADDR1_Temp_18[35:0], 1'b0};
                
                
                Slide_data_19 <= Pad_and_ADDR1_Temp_19[36:30];
                Pad_and_ADDR1_Temp_19 <= {Pad_and_ADDR1_Temp_19[35:0], 1'b0};
                
                
                Slide_data_20 <= Pad_and_ADDR1_Temp_20[36:30];
                Pad_and_ADDR1_Temp_20 <= {Pad_and_ADDR1_Temp_20[35:0], 1'b0};
                
                
                Slide_data_21 <= Pad_and_ADDR1_Temp_21[36:30];
                Pad_and_ADDR1_Temp_21 <= {Pad_and_ADDR1_Temp_21[35:0], 1'b0};
                
                
                Slide_data_22 <= Pad_and_ADDR1_Temp_22[36:30];
                Pad_and_ADDR1_Temp_22 <= {Pad_and_ADDR1_Temp_22[35:0], 1'b0};
                
                
                Slide_data_23 <= Pad_and_ADDR1_Temp_23[36:30];
                Pad_and_ADDR1_Temp_23 <= {Pad_and_ADDR1_Temp_23[35:0], 1'b0};
                
                
                Slide_data_24 <= Pad_and_ADDR1_Temp_24[36:30];
                Pad_and_ADDR1_Temp_24 <= {Pad_and_ADDR1_Temp_24[35:0], 1'b0};
                
                
                Slide_data_25 <= Pad_and_ADDR1_Temp_25[36:30];
                Pad_and_ADDR1_Temp_25 <= {Pad_and_ADDR1_Temp_25[35:0], 1'b0};
                
                
                Slide_data_26 <= Pad_and_ADDR1_Temp_26[36:30];
                Pad_and_ADDR1_Temp_26 <= {Pad_and_ADDR1_Temp_26[35:0], 1'b0};
                
                
                Slide_data_27 <= Pad_and_ADDR1_Temp_27[36:30];
                Pad_and_ADDR1_Temp_27 <= {Pad_and_ADDR1_Temp_27[35:0], 1'b0};
                
                
                Slide_data_28 <= Pad_and_ADDR1_Temp_28[36:30];
                Pad_and_ADDR1_Temp_28 <= {Pad_and_ADDR1_Temp_28[35:0], 1'b0};
                
                
                Slide_data_29 <= Pad_and_ADDR1_Temp_29[36:30];
                Pad_and_ADDR1_Temp_29 <= {Pad_and_ADDR1_Temp_29[35:0], 1'b0};
                
                
                Slide_data_30 <= Pad_and_ADDR1_Temp_30[36:30];
                Pad_and_ADDR1_Temp_30 <= {Pad_and_ADDR1_Temp_30[35:0], 1'b0};
                
                
                Slide_data_31 <= Pad_and_ADDR1_Temp_31[36:30];
                Pad_and_ADDR1_Temp_31 <= {Pad_and_ADDR1_Temp_31[35:0], 1'b0};
                
            end
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
                    
                    Temp6_and_Next_ADDR_Data_16 <= {Temp6_16[5:0], DIN_16[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_17 <= {Temp6_17[5:0], DIN_17[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_18 <= {Temp6_18[5:0], DIN_18[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_19 <= {Temp6_19[5:0], DIN_19[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_20 <= {Temp6_20[5:0], DIN_20[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_21 <= {Temp6_21[5:0], DIN_21[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_22 <= {Temp6_22[5:0], DIN_22[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_23 <= {Temp6_23[5:0], DIN_23[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_24 <= {Temp6_24[5:0], DIN_24[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_25 <= {Temp6_25[5:0], DIN_25[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_26 <= {Temp6_26[5:0], DIN_26[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_27 <= {Temp6_27[5:0], DIN_27[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_28 <= {Temp6_28[5:0], DIN_28[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_29 <= {Temp6_29[5:0], DIN_29[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_30 <= {Temp6_30[5:0], DIN_30[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_31 <= {Temp6_31[5:0], DIN_31[31:0]};
            end
        end
        else if(ADDR_d2 <= 2)begin
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
                
                Slide_data_16 <= Temp6_and_Next_ADDR_Data_16[37:31];
                Temp6_and_Next_ADDR_Data_16 <= {Temp6_and_Next_ADDR_Data_16[36:0], 1'b0};
                Temp6_16 <= DIN_16[5:0];
                
                Slide_data_17 <= Temp6_and_Next_ADDR_Data_17[37:31];
                Temp6_and_Next_ADDR_Data_17 <= {Temp6_and_Next_ADDR_Data_17[36:0], 1'b0};
                Temp6_17 <= DIN_17[5:0];
                
                Slide_data_18 <= Temp6_and_Next_ADDR_Data_18[37:31];
                Temp6_and_Next_ADDR_Data_18 <= {Temp6_and_Next_ADDR_Data_18[36:0], 1'b0};
                Temp6_18 <= DIN_18[5:0];
                
                Slide_data_19 <= Temp6_and_Next_ADDR_Data_19[37:31];
                Temp6_and_Next_ADDR_Data_19 <= {Temp6_and_Next_ADDR_Data_19[36:0], 1'b0};
                Temp6_19 <= DIN_19[5:0];
                
                Slide_data_20 <= Temp6_and_Next_ADDR_Data_20[37:31];
                Temp6_and_Next_ADDR_Data_20 <= {Temp6_and_Next_ADDR_Data_20[36:0], 1'b0};
                Temp6_20 <= DIN_20[5:0];
                
                Slide_data_21 <= Temp6_and_Next_ADDR_Data_21[37:31];
                Temp6_and_Next_ADDR_Data_21 <= {Temp6_and_Next_ADDR_Data_21[36:0], 1'b0};
                Temp6_21 <= DIN_21[5:0];
                
                Slide_data_22 <= Temp6_and_Next_ADDR_Data_22[37:31];
                Temp6_and_Next_ADDR_Data_22 <= {Temp6_and_Next_ADDR_Data_22[36:0], 1'b0};
                Temp6_22 <= DIN_22[5:0];
                
                Slide_data_23 <= Temp6_and_Next_ADDR_Data_23[37:31];
                Temp6_and_Next_ADDR_Data_23 <= {Temp6_and_Next_ADDR_Data_23[36:0], 1'b0};
                Temp6_23 <= DIN_23[5:0];
                
                Slide_data_24 <= Temp6_and_Next_ADDR_Data_24[37:31];
                Temp6_and_Next_ADDR_Data_24 <= {Temp6_and_Next_ADDR_Data_24[36:0], 1'b0};
                Temp6_24 <= DIN_24[5:0];
                
                Slide_data_25 <= Temp6_and_Next_ADDR_Data_25[37:31];
                Temp6_and_Next_ADDR_Data_25 <= {Temp6_and_Next_ADDR_Data_25[36:0], 1'b0};
                Temp6_25 <= DIN_25[5:0];
                
                Slide_data_26 <= Temp6_and_Next_ADDR_Data_26[37:31];
                Temp6_and_Next_ADDR_Data_26 <= {Temp6_and_Next_ADDR_Data_26[36:0], 1'b0};
                Temp6_26 <= DIN_26[5:0];
                
                Slide_data_27 <= Temp6_and_Next_ADDR_Data_27[37:31];
                Temp6_and_Next_ADDR_Data_27 <= {Temp6_and_Next_ADDR_Data_27[36:0], 1'b0};
                Temp6_27 <= DIN_27[5:0];
                
                Slide_data_28 <= Temp6_and_Next_ADDR_Data_28[37:31];
                Temp6_and_Next_ADDR_Data_28 <= {Temp6_and_Next_ADDR_Data_28[36:0], 1'b0};
                Temp6_28 <= DIN_28[5:0];
                
                Slide_data_29 <= Temp6_and_Next_ADDR_Data_29[37:31];
                Temp6_and_Next_ADDR_Data_29 <= {Temp6_and_Next_ADDR_Data_29[36:0], 1'b0};
                Temp6_29 <= DIN_29[5:0];
                
                Slide_data_30 <= Temp6_and_Next_ADDR_Data_30[37:31];
                Temp6_and_Next_ADDR_Data_30 <= {Temp6_and_Next_ADDR_Data_30[36:0], 1'b0};
                Temp6_30 <= DIN_30[5:0];
                
                Slide_data_31 <= Temp6_and_Next_ADDR_Data_31[37:31];
                Temp6_and_Next_ADDR_Data_31 <= {Temp6_and_Next_ADDR_Data_31[36:0], 1'b0};
                Temp6_31 <= DIN_31[5:0];
        
            end
            else begin
                if(cnt <= 31)begin
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
                    
                    Slide_data_16 <= Temp6_and_Next_ADDR_Data_16[37:31];
                    Temp6_and_Next_ADDR_Data_16 <= {Temp6_and_Next_ADDR_Data_16[36:0], 1'b0};
                    
                    Slide_data_17 <= Temp6_and_Next_ADDR_Data_17[37:31];
                    Temp6_and_Next_ADDR_Data_17 <= {Temp6_and_Next_ADDR_Data_17[36:0], 1'b0};
                    
                    Slide_data_18 <= Temp6_and_Next_ADDR_Data_18[37:31];
                    Temp6_and_Next_ADDR_Data_18 <= {Temp6_and_Next_ADDR_Data_18[36:0], 1'b0};
                    
                    Slide_data_19 <= Temp6_and_Next_ADDR_Data_19[37:31];
                    Temp6_and_Next_ADDR_Data_19 <= {Temp6_and_Next_ADDR_Data_19[36:0], 1'b0};
                    
                    Slide_data_20 <= Temp6_and_Next_ADDR_Data_20[37:31];
                    Temp6_and_Next_ADDR_Data_20 <= {Temp6_and_Next_ADDR_Data_20[36:0], 1'b0};
                    
                    Slide_data_21 <= Temp6_and_Next_ADDR_Data_21[37:31];
                    Temp6_and_Next_ADDR_Data_21 <= {Temp6_and_Next_ADDR_Data_21[36:0], 1'b0};
                    
                    Slide_data_22 <= Temp6_and_Next_ADDR_Data_22[37:31];
                    Temp6_and_Next_ADDR_Data_22 <= {Temp6_and_Next_ADDR_Data_22[36:0], 1'b0};
                    
                    Slide_data_23 <= Temp6_and_Next_ADDR_Data_23[37:31];
                    Temp6_and_Next_ADDR_Data_23 <= {Temp6_and_Next_ADDR_Data_23[36:0], 1'b0};
                    
                    Slide_data_24 <= Temp6_and_Next_ADDR_Data_24[37:31];
                    Temp6_and_Next_ADDR_Data_24 <= {Temp6_and_Next_ADDR_Data_24[36:0], 1'b0};
                    
                    Slide_data_25 <= Temp6_and_Next_ADDR_Data_25[37:31];
                    Temp6_and_Next_ADDR_Data_25 <= {Temp6_and_Next_ADDR_Data_25[36:0], 1'b0};
                    
                    Slide_data_26 <= Temp6_and_Next_ADDR_Data_26[37:31];
                    Temp6_and_Next_ADDR_Data_26 <= {Temp6_and_Next_ADDR_Data_26[36:0], 1'b0};
                    
                    Slide_data_27 <= Temp6_and_Next_ADDR_Data_27[37:31];
                    Temp6_and_Next_ADDR_Data_27 <= {Temp6_and_Next_ADDR_Data_27[36:0], 1'b0};
                    
                    Slide_data_28 <= Temp6_and_Next_ADDR_Data_28[37:31];
                    Temp6_and_Next_ADDR_Data_28 <= {Temp6_and_Next_ADDR_Data_28[36:0], 1'b0};
                    
                    Slide_data_29 <= Temp6_and_Next_ADDR_Data_29[37:31];
                    Temp6_and_Next_ADDR_Data_29 <= {Temp6_and_Next_ADDR_Data_29[36:0], 1'b0};
                    
                    Slide_data_30 <= Temp6_and_Next_ADDR_Data_30[37:31];
                    Temp6_and_Next_ADDR_Data_30 <= {Temp6_and_Next_ADDR_Data_30[36:0], 1'b0};
                    
                    Slide_data_31 <= Temp6_and_Next_ADDR_Data_31[37:31];
                    Temp6_and_Next_ADDR_Data_31 <= {Temp6_and_Next_ADDR_Data_31[36:0], 1'b0};
                end
                if(cnt == 31)begin
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
                    
                    Temp6_and_Next_ADDR_Data_16 <= {Temp6_16[5:0], DIN_16[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_17 <= {Temp6_17[5:0], DIN_17[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_18 <= {Temp6_18[5:0], DIN_18[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_19 <= {Temp6_19[5:0], DIN_19[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_20 <= {Temp6_20[5:0], DIN_20[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_21 <= {Temp6_21[5:0], DIN_21[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_22 <= {Temp6_22[5:0], DIN_22[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_23 <= {Temp6_23[5:0], DIN_23[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_24 <= {Temp6_24[5:0], DIN_24[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_25 <= {Temp6_25[5:0], DIN_25[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_26 <= {Temp6_26[5:0], DIN_26[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_27 <= {Temp6_27[5:0], DIN_27[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_28 <= {Temp6_28[5:0], DIN_28[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_29 <= {Temp6_29[5:0], DIN_29[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_30 <= {Temp6_30[5:0], DIN_30[31:0]};
                    
                    Temp6_and_Next_ADDR_Data_31 <= {Temp6_31[5:0], DIN_31[31:0]};
        
                end
            end
        end else if(ADDR_d2 == 3)begin      //Block5的地址3仅前15个数据有效，这一步是专门对地址3进行处理
        
            if(cnt <= 14)begin
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
                
                Slide_data_16 <= Temp6_and_Next_ADDR_Data_16[37:31];
                Temp6_and_Next_ADDR_Data_16 <= {Temp6_and_Next_ADDR_Data_16[36:0], 1'b0};
                
                Slide_data_17 <= Temp6_and_Next_ADDR_Data_17[37:31];
                Temp6_and_Next_ADDR_Data_17 <= {Temp6_and_Next_ADDR_Data_17[36:0], 1'b0};
                
                Slide_data_18 <= Temp6_and_Next_ADDR_Data_18[37:31];
                Temp6_and_Next_ADDR_Data_18 <= {Temp6_and_Next_ADDR_Data_18[36:0], 1'b0};
                
                Slide_data_19 <= Temp6_and_Next_ADDR_Data_19[37:31];
                Temp6_and_Next_ADDR_Data_19 <= {Temp6_and_Next_ADDR_Data_19[36:0], 1'b0};
                
                Slide_data_20 <= Temp6_and_Next_ADDR_Data_20[37:31];
                Temp6_and_Next_ADDR_Data_20 <= {Temp6_and_Next_ADDR_Data_20[36:0], 1'b0};
                
                Slide_data_21 <= Temp6_and_Next_ADDR_Data_21[37:31];
                Temp6_and_Next_ADDR_Data_21 <= {Temp6_and_Next_ADDR_Data_21[36:0], 1'b0};
                
                Slide_data_22 <= Temp6_and_Next_ADDR_Data_22[37:31];
                Temp6_and_Next_ADDR_Data_22 <= {Temp6_and_Next_ADDR_Data_22[36:0], 1'b0};
                
                Slide_data_23 <= Temp6_and_Next_ADDR_Data_23[37:31];
                Temp6_and_Next_ADDR_Data_23 <= {Temp6_and_Next_ADDR_Data_23[36:0], 1'b0};
                
                Slide_data_24 <= Temp6_and_Next_ADDR_Data_24[37:31];
                Temp6_and_Next_ADDR_Data_24 <= {Temp6_and_Next_ADDR_Data_24[36:0], 1'b0};
                
                Slide_data_25 <= Temp6_and_Next_ADDR_Data_25[37:31];
                Temp6_and_Next_ADDR_Data_25 <= {Temp6_and_Next_ADDR_Data_25[36:0], 1'b0};
                
                Slide_data_26 <= Temp6_and_Next_ADDR_Data_26[37:31];
                Temp6_and_Next_ADDR_Data_26 <= {Temp6_and_Next_ADDR_Data_26[36:0], 1'b0};
                
                Slide_data_27 <= Temp6_and_Next_ADDR_Data_27[37:31];
                Temp6_and_Next_ADDR_Data_27 <= {Temp6_and_Next_ADDR_Data_27[36:0], 1'b0};
                
                Slide_data_28 <= Temp6_and_Next_ADDR_Data_28[37:31];
                Temp6_and_Next_ADDR_Data_28 <= {Temp6_and_Next_ADDR_Data_28[36:0], 1'b0};
                
                Slide_data_29 <= Temp6_and_Next_ADDR_Data_29[37:31];
                Temp6_and_Next_ADDR_Data_29 <= {Temp6_and_Next_ADDR_Data_29[36:0], 1'b0};
                
                Slide_data_30 <= Temp6_and_Next_ADDR_Data_30[37:31];
                Temp6_and_Next_ADDR_Data_30 <= {Temp6_and_Next_ADDR_Data_30[36:0], 1'b0};
                
                Slide_data_31 <= Temp6_and_Next_ADDR_Data_31[37:31];
                Temp6_and_Next_ADDR_Data_31 <= {Temp6_and_Next_ADDR_Data_31[36:0], 1'b0};
        
                
                if(cnt == 14)begin
                    Temp6_and_five_one_0 <= {Temp6_and_Next_ADDR_Data_0[36:31], padding_data[4:0]}; //即地址4的9~15与padding(5个1),由于寄存器的缘故，是36:31而非37:21
                    Temp6_and_five_one_1 <= {Temp6_and_Next_ADDR_Data_1[36:31], padding_data[4:0]};
                    Temp6_and_five_one_2 <= {Temp6_and_Next_ADDR_Data_2[36:31], padding_data[4:0]};
                    Temp6_and_five_one_3 <= {Temp6_and_Next_ADDR_Data_3[36:31], padding_data[4:0]};
                    Temp6_and_five_one_4 <= {Temp6_and_Next_ADDR_Data_4[36:31], padding_data[4:0]};
                    Temp6_and_five_one_5 <= {Temp6_and_Next_ADDR_Data_5[36:31], padding_data[4:0]};
                    Temp6_and_five_one_6 <= {Temp6_and_Next_ADDR_Data_6[36:31], padding_data[4:0]};
                    Temp6_and_five_one_7 <= {Temp6_and_Next_ADDR_Data_7[36:31], padding_data[4:0]};
                    Temp6_and_five_one_8 <= {Temp6_and_Next_ADDR_Data_8[36:31], padding_data[4:0]};
                    Temp6_and_five_one_9 <= {Temp6_and_Next_ADDR_Data_9[36:31], padding_data[4:0]};
                    Temp6_and_five_one_10 <= {Temp6_and_Next_ADDR_Data_10[36:31], padding_data[4:0]};
                    Temp6_and_five_one_11 <= {Temp6_and_Next_ADDR_Data_11[36:31], padding_data[4:0]};
                    Temp6_and_five_one_12 <= {Temp6_and_Next_ADDR_Data_12[36:31], padding_data[4:0]};
                    Temp6_and_five_one_13 <= {Temp6_and_Next_ADDR_Data_13[36:31], padding_data[4:0]};
                    Temp6_and_five_one_14 <= {Temp6_and_Next_ADDR_Data_14[36:31], padding_data[4:0]};
                    Temp6_and_five_one_15 <= {Temp6_and_Next_ADDR_Data_15[36:31], padding_data[4:0]};
                    Temp6_and_five_one_16 <= {Temp6_and_Next_ADDR_Data_16[36:31], padding_data[4:0]};
                    Temp6_and_five_one_17 <= {Temp6_and_Next_ADDR_Data_17[36:31], padding_data[4:0]};
                    Temp6_and_five_one_18 <= {Temp6_and_Next_ADDR_Data_18[36:31], padding_data[4:0]};
                    Temp6_and_five_one_19 <= {Temp6_and_Next_ADDR_Data_19[36:31], padding_data[4:0]};
                    Temp6_and_five_one_20 <= {Temp6_and_Next_ADDR_Data_20[36:31], padding_data[4:0]};
                    Temp6_and_five_one_21 <= {Temp6_and_Next_ADDR_Data_21[36:31], padding_data[4:0]};
                    Temp6_and_five_one_22 <= {Temp6_and_Next_ADDR_Data_22[36:31], padding_data[4:0]};
                    Temp6_and_five_one_23 <= {Temp6_and_Next_ADDR_Data_23[36:31], padding_data[4:0]};
                    Temp6_and_five_one_24 <= {Temp6_and_Next_ADDR_Data_24[36:31], padding_data[4:0]};
                    Temp6_and_five_one_25 <= {Temp6_and_Next_ADDR_Data_25[36:31], padding_data[4:0]};
                    Temp6_and_five_one_26 <= {Temp6_and_Next_ADDR_Data_26[36:31], padding_data[4:0]};
                    Temp6_and_five_one_27 <= {Temp6_and_Next_ADDR_Data_27[36:31], padding_data[4:0]};
                    Temp6_and_five_one_28 <= {Temp6_and_Next_ADDR_Data_28[36:31], padding_data[4:0]};
                    Temp6_and_five_one_29 <= {Temp6_and_Next_ADDR_Data_29[36:31], padding_data[4:0]};
                    Temp6_and_five_one_30 <= {Temp6_and_Next_ADDR_Data_30[36:31], padding_data[4:0]};
                    Temp6_and_five_one_31 <= {Temp6_and_Next_ADDR_Data_31[36:31], padding_data[4:0]};
                    
                end
            end
            else if(cnt <= 19)begin
                Slide_data_0 <= Temp6_and_five_one_0[10:4];
                Temp6_and_five_one_0 <= {Temp6_and_five_one_0[9:0], 1'b0};
                
                Slide_data_1 <= Temp6_and_five_one_1[10:4];
                Temp6_and_five_one_1 <= {Temp6_and_five_one_1[9:0], 1'b0};
                
                Slide_data_2 <= Temp6_and_five_one_2[10:4];
                Temp6_and_five_one_2 <= {Temp6_and_five_one_2[9:0], 1'b0};
                
                Slide_data_3 <= Temp6_and_five_one_3[10:4];
                Temp6_and_five_one_3 <= {Temp6_and_five_one_3[9:0], 1'b0};
                
                Slide_data_4 <= Temp6_and_five_one_4[10:4];
                Temp6_and_five_one_4 <= {Temp6_and_five_one_4[9:0], 1'b0};
                
                Slide_data_5 <= Temp6_and_five_one_5[10:4];
                Temp6_and_five_one_5 <= {Temp6_and_five_one_5[9:0], 1'b0};
                
                Slide_data_6 <= Temp6_and_five_one_6[10:4];
                Temp6_and_five_one_6 <= {Temp6_and_five_one_6[9:0], 1'b0};
                
                Slide_data_7 <= Temp6_and_five_one_7[10:4];
                Temp6_and_five_one_7 <= {Temp6_and_five_one_7[9:0], 1'b0};
                
                Slide_data_8 <= Temp6_and_five_one_8[10:4];
                Temp6_and_five_one_8 <= {Temp6_and_five_one_8[9:0], 1'b0};
                
                Slide_data_9 <= Temp6_and_five_one_9[10:4];
                Temp6_and_five_one_9 <= {Temp6_and_five_one_9[9:0], 1'b0};
                
                Slide_data_10 <= Temp6_and_five_one_10[10:4];
                Temp6_and_five_one_10 <= {Temp6_and_five_one_10[9:0], 1'b0};
                
                Slide_data_11 <= Temp6_and_five_one_11[10:4];
                Temp6_and_five_one_11 <= {Temp6_and_five_one_11[9:0], 1'b0};
                
                Slide_data_12 <= Temp6_and_five_one_12[10:4];
                Temp6_and_five_one_12 <= {Temp6_and_five_one_12[9:0], 1'b0};
                
                Slide_data_13 <= Temp6_and_five_one_13[10:4];
                Temp6_and_five_one_13 <= {Temp6_and_five_one_13[9:0], 1'b0};
                
                Slide_data_14 <= Temp6_and_five_one_14[10:4];
                Temp6_and_five_one_14 <= {Temp6_and_five_one_14[9:0], 1'b0};
                
                Slide_data_15 <= Temp6_and_five_one_15[10:4];
                Temp6_and_five_one_15 <= {Temp6_and_five_one_15[9:0], 1'b0};
                
                Slide_data_16 <= Temp6_and_five_one_16[10:4];
                Temp6_and_five_one_16 <= {Temp6_and_five_one_16[9:0], 1'b0};
                
                Slide_data_17 <= Temp6_and_five_one_17[10:4];
                Temp6_and_five_one_17 <= {Temp6_and_five_one_17[9:0], 1'b0};
                
                Slide_data_18 <= Temp6_and_five_one_18[10:4];
                Temp6_and_five_one_18 <= {Temp6_and_five_one_18[9:0], 1'b0};
                
                Slide_data_19 <= Temp6_and_five_one_19[10:4];
                Temp6_and_five_one_19 <= {Temp6_and_five_one_19[9:0], 1'b0};
                
                Slide_data_20 <= Temp6_and_five_one_20[10:4];
                Temp6_and_five_one_20 <= {Temp6_and_five_one_20[9:0], 1'b0};
                
                Slide_data_21 <= Temp6_and_five_one_21[10:4];
                Temp6_and_five_one_21 <= {Temp6_and_five_one_21[9:0], 1'b0};
                
                Slide_data_22 <= Temp6_and_five_one_22[10:4];
                Temp6_and_five_one_22 <= {Temp6_and_five_one_22[9:0], 1'b0};
                
                Slide_data_23 <= Temp6_and_five_one_23[10:4];
                Temp6_and_five_one_23 <= {Temp6_and_five_one_23[9:0], 1'b0};
                
                Slide_data_24 <= Temp6_and_five_one_24[10:4];
                Temp6_and_five_one_24 <= {Temp6_and_five_one_24[9:0], 1'b0};
                
                Slide_data_25 <= Temp6_and_five_one_25[10:4];
                Temp6_and_five_one_25 <= {Temp6_and_five_one_25[9:0], 1'b0};
                
                Slide_data_26 <= Temp6_and_five_one_26[10:4];
                Temp6_and_five_one_26 <= {Temp6_and_five_one_26[9:0], 1'b0};
                
                Slide_data_27 <= Temp6_and_five_one_27[10:4];
                Temp6_and_five_one_27 <= {Temp6_and_five_one_27[9:0], 1'b0};
                
                Slide_data_28 <= Temp6_and_five_one_28[10:4];
                Temp6_and_five_one_28 <= {Temp6_and_five_one_28[9:0], 1'b0};
                
                Slide_data_29 <= Temp6_and_five_one_29[10:4];
                Temp6_and_five_one_29 <= {Temp6_and_five_one_29[9:0], 1'b0};
                
                Slide_data_30 <= Temp6_and_five_one_30[10:4];
                Temp6_and_five_one_30 <= {Temp6_and_five_one_30[9:0], 1'b0};
                
                Slide_data_31 <= Temp6_and_five_one_31[10:4];
                Temp6_and_five_one_31 <= {Temp6_and_five_one_31[9:0], 1'b0};
            end
            else begin
                Slide_data_0 <= 0;
                Temp6_0      <= 0;
                Pad_and_ADDR1_Temp_0 <= 0;
                Temp6_and_Next_ADDR_Data_0 <= 0;
                Temp6_and_five_one_0 <= 0;
                
                Slide_data_1 <= 0;
                Temp6_1      <= 0;
                Pad_and_ADDR1_Temp_1 <= 0;
                Temp6_and_Next_ADDR_Data_1 <= 0;
                Temp6_and_five_one_1 <= 0;
                
                Slide_data_2 <= 0;
                Temp6_2      <= 0;
                Pad_and_ADDR1_Temp_2 <= 0;
                Temp6_and_Next_ADDR_Data_2 <= 0;
                Temp6_and_five_one_2 <= 0;
                
                Slide_data_3 <= 0;
                Temp6_3      <= 0;
                Pad_and_ADDR1_Temp_3 <= 0;
                Temp6_and_Next_ADDR_Data_3 <= 0;
                Temp6_and_five_one_3 <= 0;
                
                Slide_data_4 <= 0;
                Temp6_4      <= 0;
                Pad_and_ADDR1_Temp_4 <= 0;
                Temp6_and_Next_ADDR_Data_4 <= 0;
                Temp6_and_five_one_4 <= 0;
                
                Slide_data_5 <= 0;
                Temp6_5      <= 0;
                Pad_and_ADDR1_Temp_5 <= 0;
                Temp6_and_Next_ADDR_Data_5 <= 0;
                Temp6_and_five_one_5 <= 0;
                
                Slide_data_6 <= 0;
                Temp6_6      <= 0;
                Pad_and_ADDR1_Temp_6 <= 0;
                Temp6_and_Next_ADDR_Data_6 <= 0;
                Temp6_and_five_one_6 <= 0;
                
                Slide_data_7 <= 0;
                Temp6_7      <= 0;
                Pad_and_ADDR1_Temp_7 <= 0;
                Temp6_and_Next_ADDR_Data_7 <= 0;
                Temp6_and_five_one_7 <= 0;
                
                Slide_data_8 <= 0;
                Temp6_8      <= 0;
                Pad_and_ADDR1_Temp_8 <= 0;
                Temp6_and_Next_ADDR_Data_8 <= 0;
                Temp6_and_five_one_8 <= 0;
                
                Slide_data_9 <= 0;
                Temp6_9      <= 0;
                Pad_and_ADDR1_Temp_9 <= 0;
                Temp6_and_Next_ADDR_Data_9 <= 0;
                Temp6_and_five_one_9 <= 0;
                
                Slide_data_10 <= 0;
                Temp6_10      <= 0;
                Pad_and_ADDR1_Temp_10 <= 0;
                Temp6_and_Next_ADDR_Data_10 <= 0;
                Temp6_and_five_one_10 <= 0;
                
                Slide_data_11 <= 0;
                Temp6_11      <= 0;
                Pad_and_ADDR1_Temp_11 <= 0;
                Temp6_and_Next_ADDR_Data_11 <= 0;
                Temp6_and_five_one_11 <= 0;
                
                Slide_data_12 <= 0;
                Temp6_12      <= 0;
                Pad_and_ADDR1_Temp_12 <= 0;
                Temp6_and_Next_ADDR_Data_12 <= 0;
                Temp6_and_five_one_12 <= 0;
                
                Slide_data_13 <= 0;
                Temp6_13      <= 0;
                Pad_and_ADDR1_Temp_13 <= 0;
                Temp6_and_Next_ADDR_Data_13 <= 0;
                Temp6_and_five_one_13 <= 0;
                
                Slide_data_14 <= 0;
                Temp6_14      <= 0;
                Pad_and_ADDR1_Temp_14 <= 0;
                Temp6_and_Next_ADDR_Data_14 <= 0;
                Temp6_and_five_one_14 <= 0;
                
                Slide_data_15 <= 0;
                Temp6_15      <= 0;
                Pad_and_ADDR1_Temp_15 <= 0;
                Temp6_and_Next_ADDR_Data_15 <= 0;
                Temp6_and_five_one_15 <= 0;
                
                Slide_data_16 <= 0;
                Temp6_16      <= 0;
                Pad_and_ADDR1_Temp_16 <= 0;
                Temp6_and_Next_ADDR_Data_16 <= 0;
                Temp6_and_five_one_16 <= 0;
                
                Slide_data_17 <= 0;
                Temp6_17      <= 0;
                Pad_and_ADDR1_Temp_17 <= 0;
                Temp6_and_Next_ADDR_Data_17 <= 0;
                Temp6_and_five_one_17 <= 0;
                
                Slide_data_18 <= 0;
                Temp6_18      <= 0;
                Pad_and_ADDR1_Temp_18 <= 0;
                Temp6_and_Next_ADDR_Data_18 <= 0;
                Temp6_and_five_one_18 <= 0;
                
                Slide_data_19 <= 0;
                Temp6_19      <= 0;
                Pad_and_ADDR1_Temp_19 <= 0;
                Temp6_and_Next_ADDR_Data_19 <= 0;
                Temp6_and_five_one_19 <= 0;
                
                Slide_data_20 <= 0;
                Temp6_20      <= 0;
                Pad_and_ADDR1_Temp_20 <= 0;
                Temp6_and_Next_ADDR_Data_20 <= 0;
                Temp6_and_five_one_20 <= 0;
                
                Slide_data_21 <= 0;
                Temp6_21      <= 0;
                Pad_and_ADDR1_Temp_21 <= 0;
                Temp6_and_Next_ADDR_Data_21 <= 0;
                Temp6_and_five_one_21 <= 0;
                
                Slide_data_22 <= 0;
                Temp6_22      <= 0;
                Pad_and_ADDR1_Temp_22 <= 0;
                Temp6_and_Next_ADDR_Data_22 <= 0;
                Temp6_and_five_one_22 <= 0;
                
                Slide_data_23 <= 0;
                Temp6_23      <= 0;
                Pad_and_ADDR1_Temp_23 <= 0;
                Temp6_and_Next_ADDR_Data_23 <= 0;
                Temp6_and_five_one_23 <= 0;
                
                Slide_data_24 <= 0;
                Temp6_24      <= 0;
                Pad_and_ADDR1_Temp_24 <= 0;
                Temp6_and_Next_ADDR_Data_24 <= 0;
                Temp6_and_five_one_24 <= 0;
                
                Slide_data_25 <= 0;
                Temp6_25      <= 0;
                Pad_and_ADDR1_Temp_25 <= 0;
                Temp6_and_Next_ADDR_Data_25 <= 0;
                Temp6_and_five_one_25 <= 0;
                
                Slide_data_26 <= 0;
                Temp6_26      <= 0;
                Pad_and_ADDR1_Temp_26 <= 0;
                Temp6_and_Next_ADDR_Data_26 <= 0;
                Temp6_and_five_one_26 <= 0;
                
                Slide_data_27 <= 0;
                Temp6_27      <= 0;
                Pad_and_ADDR1_Temp_27 <= 0;
                Temp6_and_Next_ADDR_Data_27 <= 0;
                Temp6_and_five_one_27 <= 0;
                
                Slide_data_28 <= 0;
                Temp6_28      <= 0;
                Pad_and_ADDR1_Temp_28 <= 0;
                Temp6_and_Next_ADDR_Data_28 <= 0;
                Temp6_and_five_one_28 <= 0;
                
                Slide_data_29 <= 0;
                Temp6_29      <= 0;
                Pad_and_ADDR1_Temp_29 <= 0;
                Temp6_and_Next_ADDR_Data_29 <= 0;
                Temp6_and_five_one_29 <= 0;
                
                Slide_data_30 <= 0;
                Temp6_30      <= 0;
                Pad_and_ADDR1_Temp_30 <= 0;
                Temp6_and_Next_ADDR_Data_30 <= 0;
                Temp6_and_five_one_30 <= 0;
                
                Slide_data_31 <= 0;
                Temp6_31      <= 0;
                Pad_and_ADDR1_Temp_31 <= 0;
                Temp6_and_Next_ADDR_Data_31 <= 0;
                Temp6_and_five_one_31 <= 0;
        
                
            end
                 
        end
     end
end
endmodule
