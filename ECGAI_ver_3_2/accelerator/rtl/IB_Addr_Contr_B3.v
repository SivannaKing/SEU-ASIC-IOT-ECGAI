`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/02 09:29:47
// Design Name: 
// Module Name: IB_Addr_Contr_B3
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


module IB_Addr_Contr_B3(
    input                        clk,
    input                        rst_n,
    input                        B2_Bout_0_Val,
    input                        Bin_0, Bin_1, Bin_2,  Bin_3,  Bin_4,  Bin_5,  Bin_6,  Bin_7,
                                 Bin_8, Bin_9, Bin_10, Bin_11, Bin_12, Bin_13, Bin_14, Bin_15,
    output   reg     [31:0]      Dout_0, Dout_1, Dout_2,  Dout_3,  Dout_4,  Dout_5,  Dout_6,  Dout_7,
                                 Dout_8, Dout_9, Dout_10, Dout_11, Dout_12, Dout_13, Dout_14, Dout_15,
    output   reg     [ 3:0]      ADDR_0, ADDR_1, ADDR_2,  ADDR_3,  ADDR_4,  ADDR_5,  ADDR_6,  ADDR_7, 
                                 ADDR_8, ADDR_9, ADDR_10, ADDR_11, ADDR_12, ADDR_13, ADDR_14, ADDR_15, 
    output   reg                 WEA_0, WEA_1, WEA_2,  WEA_3,  WEA_4,  WEA_5,  WEA_6,  WEA_7,  
                                 WEA_8, WEA_9, WEA_10, WEA_11, WEA_12, WEA_13, WEA_14, WEA_15, 
    output   reg                 IB_Addr_Contr_B3_work, IB_Addr_Contr_B3_work_Done 
);
//*******************************************RAM0***************************************
reg         [4:0]       addr_cnt_0;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        addr_cnt_0 <= 0;
    end
    else begin
        if(ADDR_0 < 14)begin
            if(B2_Bout_0_Val) begin
                addr_cnt_0 <= addr_cnt_0 + 1;
            end
        end else if(ADDR_0 == 14)begin
            addr_cnt_0 <= 0;
        end
    end    
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_0 <= 0;
    end
    else begin
        if(B2_Bout_0_Val) begin
            Dout_0 <= {Dout_0[30:0], Bin_0};
        end
    end
end
reg             WEA_0_e1;
reg   [3:0]     ADDR_0_e2, ADDR_0_e1;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        ADDR_0_e2 <= 0;
        WEA_0_e1 <= 0;
    end else begin
        if(ADDR_0 < 14) begin
            if(addr_cnt_0 == 31 && !B2_Bout_0_Val)begin
                ADDR_0_e2 <= ADDR_0_e2 + 1;
                WEA_0_e1 <= 1;
            end
            else begin
                WEA_0_e1 <= 0;
            end
        end else if(ADDR_0 == 14)begin
            WEA_0_e1  <= 0;
        end
    end
end
always@(posedge clk)begin
    ADDR_0_e1 <= ADDR_0_e2;
    ADDR_0 <= ADDR_0_e1;
    WEA_0 <= WEA_0_e1;
end
//*******************************************RAM1***************************************
reg         B2_Bout_1_Val;
always@(posedge clk)begin
    ADDR_1 <= ADDR_0;
    WEA_1 <= WEA_0;
    B2_Bout_1_Val <= B2_Bout_0_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_1 <= 0;
    end
    else begin
        if(B2_Bout_1_Val) begin
            Dout_1 <= {Dout_1[30:0], Bin_1};
        end
    end
end
//*******************************************RAM2***************************************
reg         B2_Bout_2_Val;
always@(posedge clk)begin
    ADDR_2 <= ADDR_1;
    WEA_2 <= WEA_1;
    B2_Bout_2_Val <= B2_Bout_1_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_2 <= 0;
    end
    else begin
        if(B2_Bout_2_Val) begin
            Dout_2 <= {Dout_2[30:0], Bin_2};
        end
    end
end
//*******************************************RAM3***************************************
reg         B2_Bout_3_Val;
always@(posedge clk)begin
    ADDR_3 <= ADDR_2;
    WEA_3 <= WEA_2;
    B2_Bout_3_Val <= B2_Bout_2_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_3 <= 0;
    end
    else begin
        if(B2_Bout_3_Val) begin
            Dout_3 <= {Dout_3[30:0], Bin_3};
        end
    end
end
//*******************************************RAM4***************************************
reg         B2_Bout_4_Val;
always@(posedge clk)begin
    ADDR_4 <= ADDR_3;
    WEA_4 <= WEA_3;
    B2_Bout_4_Val <= B2_Bout_3_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_4 <= 0;
    end
    else begin
        if(B2_Bout_4_Val) begin
            Dout_4 <= {Dout_4[30:0], Bin_4};
        end
    end
end
//*******************************************RAM5***************************************
reg         B2_Bout_5_Val;
always@(posedge clk)begin
    ADDR_5 <= ADDR_4;
    WEA_5 <= WEA_4;
    B2_Bout_5_Val <= B2_Bout_4_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_5 <= 0;
    end
    else begin
        if(B2_Bout_5_Val) begin
            Dout_5 <= {Dout_5[30:0], Bin_5};
        end
    end
end
//*******************************************RAM6***************************************
reg         B2_Bout_6_Val;
always@(posedge clk)begin
    ADDR_6 <= ADDR_5;
    WEA_6 <= WEA_5;
    B2_Bout_6_Val <= B2_Bout_5_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_6 <= 0;
    end
    else begin
        if(B2_Bout_6_Val) begin
            Dout_6 <= {Dout_6[30:0], Bin_6};
        end
    end
end
//*******************************************RAM7***************************************
reg         B2_Bout_7_Val;
always@(posedge clk)begin
    ADDR_7 <= ADDR_6;
    WEA_7 <= WEA_6;
    B2_Bout_7_Val <= B2_Bout_6_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_7 <= 0;
    end
    else begin
        if(B2_Bout_7_Val) begin
            Dout_7 <= {Dout_7[30:0], Bin_7};
        end
    end
end
//*******************************************RAM8***************************************
reg         B2_Bout_8_Val;
always@(posedge clk)begin
    ADDR_8 <= ADDR_7;
    WEA_8 <= WEA_7;
    B2_Bout_8_Val <= B2_Bout_7_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_8 <= 0;
    end
    else begin
        if(B2_Bout_8_Val) begin
            Dout_8 <= {Dout_8[30:0], Bin_8};
        end
    end
end
//*******************************************RAM9***************************************
reg         B2_Bout_9_Val;
always@(posedge clk)begin
    ADDR_9 <= ADDR_8;
    WEA_9 <= WEA_8;
    B2_Bout_9_Val <= B2_Bout_8_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_9 <= 0;
    end
    else begin
        if(B2_Bout_9_Val) begin
            Dout_9 <= {Dout_9[30:0], Bin_9};
        end
    end
end
//*******************************************RAM10***************************************
reg         B2_Bout_10_Val;
always@(posedge clk)begin
    ADDR_10 <= ADDR_9;
    WEA_10 <= WEA_9;
    B2_Bout_10_Val <= B2_Bout_9_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_10 <= 0;
    end
    else begin
        if(B2_Bout_10_Val) begin
            Dout_10 <= {Dout_10[30:0], Bin_10};
        end
    end
end
//*******************************************RAM11***************************************
reg         B2_Bout_11_Val;
always@(posedge clk)begin
    ADDR_11 <= ADDR_10;
    WEA_11 <= WEA_10;
    B2_Bout_11_Val <= B2_Bout_10_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_11 <= 0;
    end
    else begin
        if(B2_Bout_11_Val) begin
            Dout_11 <= {Dout_11[30:0], Bin_11};
        end
    end
end
//*******************************************RAM12***************************************
reg         B2_Bout_12_Val;
always@(posedge clk)begin
    ADDR_12 <= ADDR_11;
    WEA_12 <= WEA_11;
    B2_Bout_12_Val <= B2_Bout_11_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_12 <= 0;
    end
    else begin
        if(B2_Bout_12_Val) begin
            Dout_12 <= {Dout_12[30:0], Bin_12};
        end
    end
end
//*******************************************RAM13***************************************
reg         B2_Bout_13_Val;
always@(posedge clk)begin
    ADDR_13 <= ADDR_12;
    WEA_13 <= WEA_12;
    B2_Bout_13_Val <= B2_Bout_12_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_13 <= 0;
    end
    else begin
        if(B2_Bout_13_Val) begin
            Dout_13 <= {Dout_13[30:0], Bin_13};
        end
    end
end
//*******************************************RAM14***************************************
reg         B2_Bout_14_Val;
always@(posedge clk)begin
    ADDR_14 <= ADDR_13;
    WEA_14 <= WEA_13;
    B2_Bout_14_Val <= B2_Bout_13_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_14 <= 0;
    end
    else begin
        if(B2_Bout_14_Val) begin
            Dout_14 <= {Dout_14[30:0], Bin_14};
        end
    end
end
//*******************************************RAM15***************************************
reg         B2_Bout_15_Val;
always@(posedge clk)begin
    ADDR_15 <= ADDR_14;
    WEA_15 <= WEA_14;
    B2_Bout_15_Val <= B2_Bout_14_Val;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Dout_15 <= 0;
    end
    else begin
        if(B2_Bout_15_Val) begin
            Dout_15 <= {Dout_15[30:0], Bin_15};
        end
    end
end
//*********************************************************
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        IB_Addr_Contr_B3_work <= 0;
        IB_Addr_Contr_B3_work_Done <= 0;
    end
    else begin
        if(ADDR_15 != 14)begin
            if(B2_Bout_0_Val)
                IB_Addr_Contr_B3_work <= 1;
        end
        else if(ADDR_15 == 14)begin
            IB_Addr_Contr_B3_work <= 0;
            IB_Addr_Contr_B3_work_Done <= 1;
        end
    end
end
endmodule
