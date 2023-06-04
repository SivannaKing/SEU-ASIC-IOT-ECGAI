`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/22 10:30:12
// Design Name: 
// Module Name: Compare_Block1
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


module Compare_Block1(
    input                           clk,
    input                           rst_n,
    input  wire          [27:0]     in_Data,
    input  wire                     loadthrehold,
    input  wire          [23:0]     threhold, 
    output reg  signed   [ 3:0]     max_value,
    output reg                      binary
);

reg signed [10:0]    thre_plus, thre_minus;
reg                 plus_sign, minus_sign;
always@(posedge loadthrehold)begin
    plus_sign <= threhold[23];
    minus_sign <= threhold[11];
    thre_plus <= threhold[22:12];
    thre_minus <= threhold[ 10:0];
end


wire    signed  [3:0]   in_0, in_1, in_2, in_3, in_4, in_5, in_6;
assign  in_0 = in_Data[27:24];
assign  in_1 = in_Data[23:20];
assign  in_2 = in_Data[19:16];
assign  in_3 = in_Data[15:12];
assign  in_4 = in_Data[11: 8];
assign  in_5 = in_Data[ 7: 4];
assign  in_6 = in_Data[ 3: 0];

reg signed [3:0] max_value_stage1;
reg signed [3:0] max_value_stage2;

always@(*)begin
    max_value_stage1 = in_0 > in_1? (in_0 > in_2 ? in_0 : in_2):(in_1 > in_2 ? in_1 : in_2);
    max_value_stage2 = in_3 > in_4? (in_3 > in_5 ? in_3 : in_5):(in_4 > in_5 ? in_4 : in_5);
end


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        max_value <= 0;
    end
    else begin
        max_value <= max_value_stage1 > max_value_stage2? (max_value_stage1 > in_6 ? max_value_stage1 : in_6) : (max_value_stage2 > in_6 ? max_value_stage2 : in_6);
    end
end


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        binary <= 0;
    end
    else begin
        if(max_value[3] == 0)begin  //即max_value >= 0
            case(plus_sign)
                0: binary <= (max_value<<1 > thre_plus)? 0:1;
                1: binary <= (max_value<<1 > thre_plus)? 1:0;
            endcase
        end
        else begin//即max_value < 0
            case(minus_sign)
                0: binary <= (max_value<<1 > thre_minus)? 0:1;
                1: binary <= (max_value<<1 > thre_minus)? 1:0;
            endcase
        end
    end
end
 



endmodule
