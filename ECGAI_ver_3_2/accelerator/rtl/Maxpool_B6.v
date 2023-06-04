`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 21:28:09
// Design Name: 
// Module Name: Maxpool_B6
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


module Maxpool_B6(
    input                       clk,
    input                       rst_n,
    input   wire signed [9:0]   o_0, o_1, o_2, o_3, o_4,
    input                       o_0_val,
    output  wire signed [9:0]   max_0, max_1, max_2, max_3, max_4,
    output  wire                Max_out_Val
    );
reg     [69:0]      Conpare_In_seven_0, Conpare_In_seven_1, Conpare_In_seven_2, Conpare_In_seven_3, Conpare_In_seven_4;
reg     [2:0]       cnt_7_0;
reg     [1:0]       cnt_2_0; //首先cnt到7后，即集齐7个9bit数据于上面的63bit寄存器。接着就开始一二、一二的计数，来让Maxpool的步长为2
wire                maxpool_0_enable;
reg                 maxpool_0_enable_d1;
always@(posedge clk or negedge o_0_val)begin
    if(!o_0_val)begin
        Conpare_In_seven_0 <= 0;
        Conpare_In_seven_1 <= 0;
        Conpare_In_seven_2 <= 0;
        Conpare_In_seven_3 <= 0;
        Conpare_In_seven_4 <= 0;
    end else begin
        Conpare_In_seven_0 <= {Conpare_In_seven_0[59:0], o_0[9:0]};
        Conpare_In_seven_1 <= {Conpare_In_seven_1[59:0], o_1[9:0]};
        Conpare_In_seven_2 <= {Conpare_In_seven_2[59:0], o_2[9:0]};
        Conpare_In_seven_3 <= {Conpare_In_seven_3[59:0], o_3[9:0]};
        Conpare_In_seven_4 <= {Conpare_In_seven_4[59:0], o_4[9:0]};
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
//由于寄存器的缘故，延迟1个clk的波形才是正对着步长为2的max_value的
//但是阈值比较为0、1也有一个延迟，故除去第一个时钟脉冲，之后的时钟脉冲又对应着正确的0与1被输出的clk
always@(posedge clk)begin
    maxpool_0_enable_d1 <= maxpool_0_enable;
end   

assign Max_out_Val = maxpool_0_enable_d1;

Compare_Block6  Channel_0_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_0), .max_value(max_0));
Compare_Block6  Channel_1_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_1), .max_value(max_1));
Compare_Block6  Channel_2_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_2), .max_value(max_2));
Compare_Block6  Channel_3_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_3), .max_value(max_3));
Compare_Block6  Channel_4_comp(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_4), .max_value(max_4));
endmodule
