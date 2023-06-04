`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/30 19:13:29
// Design Name: 
// Module Name: ThreholdBuffer_ROM_B1
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


module ThreholdBuffer_ROM_B1#(parameter ADDR_WIDTH = 8,
                              parameter DATA_WIDTH = 32,
                              parameter DATA_DEPTH = 2
)(
    input                                   clk,
    input                                   enable,
    input       [ADDR_WIDTH - 1 : 0]        addr,
    output  reg [DATA_WIDTH - 1 : 0]        data_o
);
    reg [DATA_WIDTH - 1 : 0] ram [DATA_DEPTH - 1 : 0];
    //7*8=56个数据，�?32bit宽，深度2的ram存储�?
    initial begin
        $readmemb("G:\\ECG_BNN_9160\\Data\\Threhold\\block1_thre.txt", ram);
    end
    always@(posedge clk)begin
        if(enable)begin
            data_o <=  ram[addr];
        end
    end
endmodule
