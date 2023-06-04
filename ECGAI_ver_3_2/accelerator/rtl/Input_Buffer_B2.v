`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 17:17:17
// Design Name: 
// Module Name: Input_Buffer_B2
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


module Input_Buffer_B2(
    input                       clk,
    input                       rst_n,
    input    [31:0]             DIN_0, DIN_1, DIN_2, DIN_3, DIN_4, DIN_5, DIN_6, DIN_7,
    input    [4:0]              ADDR_0, ADDR_1, ADDR_2, ADDR_3, ADDR_4, ADDR_5, ADDR_6, ADDR_7,
    input                       WEA_0, WEA_1,  WEA_2, WEA_3, WEA_4, WEA_5, WEA_6, WEA_7,
    input                       ENA_0, ENA_1,  ENA_2, ENA_3, ENA_4, ENA_5, ENA_6, ENA_7, 
    output   wire  [31:0]       DOUTA_0, DOUTA_1, DOUTA_2, DOUTA_3, DOUTA_4, DOUTA_5, DOUTA_6, DOUTA_7              
);

//20即block2的第0个， I对于程序无用，完全是用来区分之前例化的SPRAM，并将数据存到txt文件里与pytorch对比�?
//SPRAM   #(.ADDR_WIDTH(5), .DATA_WIDTH(32),.DATA_DEPTH(29)) Input_Buffer20( .clk(clk),  .rst_n(rst_n), .DINA(DIN_0), .ADDRA(ADDR_0), .WEA(WEA_0), .DOUTA(DOUTA_0),  .ENA(ENA_0) );
//SPRAM   #(.ADDR_WIDTH(5), .DATA_WIDTH(32),.DATA_DEPTH(29)) Input_Buffer21( .clk(clk),  .rst_n(rst_n), .DINA(DIN_1), .ADDRA(ADDR_1), .WEA(WEA_1), .DOUTA(DOUTA_1),  .ENA(ENA_1) );
//SPRAM   #(.ADDR_WIDTH(5), .DATA_WIDTH(32),.DATA_DEPTH(29)) Input_Buffer22( .clk(clk),  .rst_n(rst_n), .DINA(DIN_2), .ADDRA(ADDR_2), .WEA(WEA_2), .DOUTA(DOUTA_2),  .ENA(ENA_2) );
//SPRAM   #(.ADDR_WIDTH(5), .DATA_WIDTH(32),.DATA_DEPTH(29)) Input_Buffer23( .clk(clk),  .rst_n(rst_n), .DINA(DIN_3), .ADDRA(ADDR_3), .WEA(WEA_3), .DOUTA(DOUTA_3),  .ENA(ENA_3) );
//SPRAM   #(.ADDR_WIDTH(5), .DATA_WIDTH(32),.DATA_DEPTH(29)) Input_Buffer24( .clk(clk),  .rst_n(rst_n), .DINA(DIN_4), .ADDRA(ADDR_4), .WEA(WEA_4), .DOUTA(DOUTA_4),  .ENA(ENA_4) );
//SPRAM   #(.ADDR_WIDTH(5), .DATA_WIDTH(32),.DATA_DEPTH(29)) Input_Buffer25( .clk(clk),  .rst_n(rst_n), .DINA(DIN_5), .ADDRA(ADDR_5), .WEA(WEA_5), .DOUTA(DOUTA_5),  .ENA(ENA_5) );
//SPRAM   #(.ADDR_WIDTH(5), .DATA_WIDTH(32),.DATA_DEPTH(29)) Input_Buffer26( .clk(clk),  .rst_n(rst_n), .DINA(DIN_6), .ADDRA(ADDR_6), .WEA(WEA_6), .DOUTA(DOUTA_6),  .ENA(ENA_6) );
//SPRAM   #(.ADDR_WIDTH(5), .DATA_WIDTH(32),.DATA_DEPTH(29)) Input_Buffer27( .clk(clk),  .rst_n(rst_n), .DINA(DIN_7), .ADDRA(ADDR_7), .WEA(WEA_7), .DOUTA(DOUTA_7),  .ENA(ENA_7) );    
SPRAM_B2 Input_Buffer20 (.clka(clk), .ena(ENA_0),  .wea(WEA_0), .addra(ADDR_0),  .dina(DIN_0), .douta(DOUTA_0) );
SPRAM_B2 Input_Buffer21 (.clka(clk), .ena(ENA_1),  .wea(WEA_1), .addra(ADDR_1),  .dina(DIN_1), .douta(DOUTA_1) );
SPRAM_B2 Input_Buffer22 (.clka(clk), .ena(ENA_2),  .wea(WEA_2), .addra(ADDR_2),  .dina(DIN_2), .douta(DOUTA_2) );
SPRAM_B2 Input_Buffer23 (.clka(clk), .ena(ENA_3),  .wea(WEA_3), .addra(ADDR_3),  .dina(DIN_3), .douta(DOUTA_3) );
SPRAM_B2 Input_Buffer24 (.clka(clk), .ena(ENA_4),  .wea(WEA_4), .addra(ADDR_4),  .dina(DIN_4), .douta(DOUTA_4) );
SPRAM_B2 Input_Buffer25 (.clka(clk), .ena(ENA_5),  .wea(WEA_5), .addra(ADDR_5),  .dina(DIN_5), .douta(DOUTA_5) );
SPRAM_B2 Input_Buffer26 (.clka(clk), .ena(ENA_6),  .wea(WEA_6), .addra(ADDR_6),  .dina(DIN_6), .douta(DOUTA_6) );
SPRAM_B2 Input_Buffer27 (.clka(clk), .ena(ENA_7),  .wea(WEA_7), .addra(ADDR_7),  .dina(DIN_7), .douta(DOUTA_7) );    
    

endmodule
