`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 19:49:14
// Design Name: 
// Module Name: Compare_Block3
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


module Compare_Block3(
    input                           clk,
    input                           rst_n,
    input  wire          [55:0]     in_Data,
    input  wire                     loadthrehold,
    input  wire          [23:0]     threhold, 
    output reg                      binary
);

reg signed [10:0]    thre_plus, thre_minus;
reg                 plus_sign, minus_sign;
reg signed [7:0]    max_value;
always@(posedge loadthrehold)begin
    plus_sign <= threhold[23];
    minus_sign <= threhold[11];
    thre_plus <= threhold[22:12];
    thre_minus <= threhold[ 10:0];
end


wire    signed  [7:0]   in_0, in_1, in_2, in_3, in_4, in_5, in_6;
assign  in_0 = in_Data[55:48];
assign  in_1 = in_Data[47:40];
assign  in_2 = in_Data[39:32];
assign  in_3 = in_Data[31:24];
assign  in_4 = in_Data[23:16];
assign  in_5 = in_Data[15: 8];
assign  in_6 = in_Data[ 7: 0];

reg signed [7:0] max_value_stage1;
reg signed [7:0] max_value_stage2;

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
        if(max_value[7] == 0)begin  //即max_value >= 0
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
