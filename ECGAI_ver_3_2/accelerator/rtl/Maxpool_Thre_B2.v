`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 19:56:34
// Design Name: 
// Module Name: Maxpool_Thre_B2
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


module Maxpool_Thre_B2(
    input                       clk,
    input                       rst_n,
    input                       B2_rst_n, //即为binary_in_val信号，它代表Block2的模块开始计算了
    input   wire signed [6:0]   o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7, o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15,
    input                       o_0_val,
    output  wire                Bout_0, Bout_1, Bout_2,  Bout_3,  Bout_4,  Bout_5,  Bout_6,  Bout_7,
                                Bout_8, Bout_9, Bout_10, Bout_11, Bout_12, Bout_13, Bout_14, Bout_15,
    output  reg                 Bout_0_Val           
);
//***************************读取阈�?�函数并存储在自己的寄存器中,向比较模型传递这些阈值让其存�?************************
reg     [3:0]     Thre_ROM_ADDR;
wire              enable;
wire    [23:0]    data_o;
reg     [4:0]     thre_cnt;
reg     [15:0]     loadthrehold, loadthrehold_e1;
//ThreholdBuffer_ROM_B2  #(.ADDR_WIDTH(4), .DATA_WIDTH(24),.DATA_DEPTH(16)) ThreholdBuffer_B2(.clk(clk),  .enable(enable),  .addr(Thre_ROM_ADDR),  .data_o(data_o));
ThreholdBuffer_ROM_B2_IP ThreholdBuffer_B2 (
  .clka(clk),    // input wire clka
  .ena(enable),      // input wire ena
  .addra(Thre_ROM_ADDR),  // input wire [3 : 0] addra
  .douta(data_o)  // output wire [21 : 0] douta
);
always@(posedge clk or negedge B2_rst_n)begin
    if(!B2_rst_n)begin
        Thre_ROM_ADDR <= 0;
    end else begin
        if(thre_cnt < 16 )begin
            Thre_ROM_ADDR <= Thre_ROM_ADDR + 1 ;
        end else if(thre_cnt == 16)begin
            Thre_ROM_ADDR <= 0;
        end
    end
end

always@(posedge clk or negedge B2_rst_n)begin
    if(!B2_rst_n)begin
        thre_cnt <= 0;
        loadthrehold_e1 <= 0;
    end else begin
        if(thre_cnt < 16)begin
            thre_cnt <= thre_cnt + 1;
            loadthrehold_e1 <= {loadthrehold_e1[14:0], 1'b1};
        end
        else if(thre_cnt == 16)begin
            thre_cnt <= 16;
        end
    end
end

always@(posedge clk)begin
    loadthrehold <= loadthrehold_e1;
end
assign enable = (B2_rst_n & thre_cnt!= 16);

//***************************读取阈�?�函数并存储在自己的寄存器中************************
reg     [48:0]      Conpare_In_seven_0, Conpare_In_seven_1, Conpare_In_seven_2, Conpare_In_seven_3, Conpare_In_seven_4, Conpare_In_seven_5, Conpare_In_seven_6, Conpare_In_seven_7,
                    Conpare_In_seven_8, Conpare_In_seven_9, Conpare_In_seven_10, Conpare_In_seven_11, Conpare_In_seven_12, Conpare_In_seven_13, Conpare_In_seven_14, Conpare_In_seven_15; 
reg     [2:0]       cnt_7_0;
reg     [1:0]       cnt_2_0; //首先cnt�?7后，即集�?7�?7bit数据于上面的49bit寄存器�?�接�?就开始一二�?�一二的计数，来让Maxpool的步长为2
wire                maxpool_0_enable;
reg                 maxpool_0_enable_d1;
always@(posedge clk or negedge o_0_val)begin
    if(!o_0_val)begin
        Conpare_In_seven_0 <= 0;
        Conpare_In_seven_1 <= 0;
        Conpare_In_seven_2 <= 0;
        Conpare_In_seven_3 <= 0;
        Conpare_In_seven_4 <= 0;
        Conpare_In_seven_5 <= 0;
        Conpare_In_seven_6 <= 0;
        Conpare_In_seven_7 <= 0;
        Conpare_In_seven_8 <= 0;
        Conpare_In_seven_9 <= 0;
        Conpare_In_seven_10 <= 0;
        Conpare_In_seven_11 <= 0;
        Conpare_In_seven_12 <= 0;
        Conpare_In_seven_13 <= 0;
        Conpare_In_seven_14 <= 0;
        Conpare_In_seven_15 <= 0;       
    end else begin
        Conpare_In_seven_0 <= {Conpare_In_seven_0[41:0], o_0[6:0]};
        Conpare_In_seven_1 <= {Conpare_In_seven_1[41:0], o_1[6:0]};
        Conpare_In_seven_2 <= {Conpare_In_seven_2[41:0], o_2[6:0]};
        Conpare_In_seven_3 <= {Conpare_In_seven_3[41:0], o_3[6:0]};
        Conpare_In_seven_4 <= {Conpare_In_seven_4[41:0], o_4[6:0]};
        Conpare_In_seven_5 <= {Conpare_In_seven_5[41:0], o_5[6:0]};
        Conpare_In_seven_6 <= {Conpare_In_seven_6[41:0], o_6[6:0]};
        Conpare_In_seven_7 <= {Conpare_In_seven_7[41:0], o_7[6:0]};
        Conpare_In_seven_8 <= {Conpare_In_seven_8[41:0], o_8[6:0]};
        Conpare_In_seven_9 <= {Conpare_In_seven_9[41:0], o_9[6:0]};
        Conpare_In_seven_10 <= {Conpare_In_seven_10[41:0], o_10[6:0]};
        Conpare_In_seven_11 <= {Conpare_In_seven_11[41:0], o_11[6:0]};
        Conpare_In_seven_12 <= {Conpare_In_seven_12[41:0], o_12[6:0]};
        Conpare_In_seven_13 <= {Conpare_In_seven_13[41:0], o_13[6:0]};
        Conpare_In_seven_14 <= {Conpare_In_seven_14[41:0], o_14[6:0]};
        Conpare_In_seven_15 <= {Conpare_In_seven_15[41:0], o_15[6:0]};
    end
end

always@(posedge clk or negedge o_0_val)begin
    if(!o_0_val)begin
        cnt_7_0 <= 0;
        cnt_2_0 <= 0;
    end else begin
        if(cnt_7_0!=7)begin
            cnt_7_0 <= cnt_7_0 + 1;
        end
        else if(cnt_7_0 == 7)begin
            if(cnt_2_0 != 2)begin
                cnt_2_0 <= cnt_2_0 + 1;
            end else if(cnt_2_0 == 2)begin
                cnt_2_0 <= 1;
            end
        end
    end
end
assign  maxpool_0_enable = cnt_7_0 == 7 && (cnt_2_0 == 0 || cnt_2_0 == 2);
//由于寄存器的缘故，延�?1个clk的波形才是正对着步长�?2的max_value�?
//但是阈�?�比较为0�?1也有�?个延迟，故除去第�?个时钟脉冲，之后的时钟脉冲又对应�?正确�?0�?1被输出的clk
always@(posedge clk)begin
    maxpool_0_enable_d1 <= maxpool_0_enable;
    Bout_0_Val <= maxpool_0_enable_d1;
end

//assign  Bout_0_Val = maxpool_0_enable & (cnt_2_0 != 0);
Compare_Block2 Channel_0_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_0), .loadthrehold(loadthrehold[0]), .threhold(data_o), .binary(Bout_0));
Compare_Block2 Channel_1_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_1), .loadthrehold(loadthrehold[1]), .threhold(data_o), .binary(Bout_1));
Compare_Block2 Channel_2_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_2), .loadthrehold(loadthrehold[2]), .threhold(data_o), .binary(Bout_2));
Compare_Block2 Channel_3_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_3), .loadthrehold(loadthrehold[3]), .threhold(data_o), .binary(Bout_3));
Compare_Block2 Channel_4_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_4), .loadthrehold(loadthrehold[4]), .threhold(data_o), .binary(Bout_4));
Compare_Block2 Channel_5_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_5), .loadthrehold(loadthrehold[5]), .threhold(data_o), .binary(Bout_5));
Compare_Block2 Channel_6_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_6), .loadthrehold(loadthrehold[6]), .threhold(data_o), .binary(Bout_6));
Compare_Block2 Channel_7_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_7), .loadthrehold(loadthrehold[7]), .threhold(data_o), .binary(Bout_7));
Compare_Block2 Channel_8_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_8), .loadthrehold(loadthrehold[8]), .threhold(data_o), .binary(Bout_8));
Compare_Block2 Channel_9_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_9), .loadthrehold(loadthrehold[9]), .threhold(data_o), .binary(Bout_9));
Compare_Block2 Channel_10_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_10), .loadthrehold(loadthrehold[10]), .threhold(data_o), .binary(Bout_10));
Compare_Block2 Channel_11_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_11), .loadthrehold(loadthrehold[11]), .threhold(data_o), .binary(Bout_11));
Compare_Block2 Channel_12_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_12), .loadthrehold(loadthrehold[12]), .threhold(data_o), .binary(Bout_12));
Compare_Block2 Channel_13_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_13), .loadthrehold(loadthrehold[13]), .threhold(data_o), .binary(Bout_13));
Compare_Block2 Channel_14_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_14), .loadthrehold(loadthrehold[14]), .threhold(data_o), .binary(Bout_14));
Compare_Block2 Channel_15_comp(.clk(clk), .rst_n(B2_rst_n), .in_Data(Conpare_In_seven_15), .loadthrehold(loadthrehold[15]), .threhold(data_o), .binary(Bout_15));




endmodule
