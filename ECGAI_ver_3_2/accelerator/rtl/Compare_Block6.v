`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 09:36:12
// Design Name: 
// Module Name: Compare_Block6
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


module Compare_Block6(
    input                           clk,
    input                           rst_n,
    input  wire          [69:0]     in_Data,
    output reg  signed   [ 9:0]     max_value  //目前不需要将其输出
);
wire    signed  [9:0]   in_0, in_1, in_2, in_3, in_4, in_5, in_6;
assign  in_0 = in_Data[69:60];
assign  in_1 = in_Data[59:50];
assign  in_2 = in_Data[49:40];
assign  in_3 = in_Data[39:30];
assign  in_4 = in_Data[29:20];
assign  in_5 = in_Data[19:10];
assign  in_6 = in_Data[ 9: 0];

reg signed [9:0] max_value_stage1;
reg signed [9:0] max_value_stage2;

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

endmodule
