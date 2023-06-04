`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/02 09:54:16
// Design Name: 
// Module Name: Input_Buffer_B3
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


module Input_Buffer_B3(
    input                       clk,
    input                       rst_n,
    input    [31:0]             DIN_0, DIN_1, DIN_2,  DIN_3,  DIN_4,  DIN_5,  DIN_6,  DIN_7,
                                DIN_8, DIN_9, DIN_10, DIN_11, DIN_12, DIN_13, DIN_14, DIN_15,
    input    [3:0]              ADDR_0, ADDR_1, ADDR_2,  ADDR_3,  ADDR_4,  ADDR_5,  ADDR_6,  ADDR_7,
                                ADDR_8, ADDR_9, ADDR_10, ADDR_11, ADDR_12, ADDR_13, ADDR_14, ADDR_15,
    input                       WEA_0, WEA_1,  WEA_2,  WEA_3,  WEA_4,  WEA_5,  WEA_6,  WEA_7,
                                WEA_8, WEA_9,  WEA_10, WEA_11, WEA_12, WEA_13, WEA_14, WEA_15,
    input                       ENA_0, ENA_1,  ENA_2,  ENA_3,  ENA_4,  ENA_5,  ENA_6,  ENA_7,
                                ENA_8, ENA_9,  ENA_10, ENA_11, ENA_12, ENA_13, ENA_14, ENA_15, 
    output   wire  [31:0]       DOUTA_0, DOUTA_1, DOUTA_2,  DOUTA_3,  DOUTA_4,  DOUTA_5,  DOUTA_6,  DOUTA_7,
                                DOUTA_8, DOUTA_9, DOUTA_10, DOUTA_11, DOUTA_12, DOUTA_13, DOUTA_14, DOUTA_15                                              
);
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer30( .clk(clk),  .rst_n(rst_n), .DINA(DIN_0), .ADDRA(ADDR_0), .WEA(WEA_0), .DOUTA(DOUTA_0),  .ENA(ENA_0) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer31( .clk(clk),  .rst_n(rst_n), .DINA(DIN_1), .ADDRA(ADDR_1), .WEA(WEA_1), .DOUTA(DOUTA_1),  .ENA(ENA_1) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer32( .clk(clk),  .rst_n(rst_n), .DINA(DIN_2), .ADDRA(ADDR_2), .WEA(WEA_2), .DOUTA(DOUTA_2),  .ENA(ENA_2) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer33( .clk(clk),  .rst_n(rst_n), .DINA(DIN_3), .ADDRA(ADDR_3), .WEA(WEA_3), .DOUTA(DOUTA_3),  .ENA(ENA_3) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer34( .clk(clk),  .rst_n(rst_n), .DINA(DIN_4), .ADDRA(ADDR_4), .WEA(WEA_4), .DOUTA(DOUTA_4),  .ENA(ENA_4) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer35( .clk(clk),  .rst_n(rst_n), .DINA(DIN_5), .ADDRA(ADDR_5), .WEA(WEA_5), .DOUTA(DOUTA_5),  .ENA(ENA_5) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer36( .clk(clk),  .rst_n(rst_n), .DINA(DIN_6), .ADDRA(ADDR_6), .WEA(WEA_6), .DOUTA(DOUTA_6),  .ENA(ENA_6) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer37( .clk(clk),  .rst_n(rst_n), .DINA(DIN_7), .ADDRA(ADDR_7), .WEA(WEA_7), .DOUTA(DOUTA_7),  .ENA(ENA_7) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer38( .clk(clk),  .rst_n(rst_n), .DINA(DIN_8), .ADDRA(ADDR_8), .WEA(WEA_8), .DOUTA(DOUTA_8),  .ENA(ENA_8) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer39( .clk(clk),  .rst_n(rst_n), .DINA(DIN_9), .ADDRA(ADDR_9), .WEA(WEA_9), .DOUTA(DOUTA_9),  .ENA(ENA_9) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer3_10( .clk(clk),  .rst_n(rst_n), .DINA(DIN_10), .ADDRA(ADDR_10), .WEA(WEA_10), .DOUTA(DOUTA_10),  .ENA(ENA_10) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer3_11( .clk(clk),  .rst_n(rst_n), .DINA(DIN_11), .ADDRA(ADDR_11), .WEA(WEA_11), .DOUTA(DOUTA_11),  .ENA(ENA_11) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer3_12( .clk(clk),  .rst_n(rst_n), .DINA(DIN_12), .ADDRA(ADDR_12), .WEA(WEA_12), .DOUTA(DOUTA_12),  .ENA(ENA_12) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer3_13( .clk(clk),  .rst_n(rst_n), .DINA(DIN_13), .ADDRA(ADDR_13), .WEA(WEA_13), .DOUTA(DOUTA_13),  .ENA(ENA_13) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer3_14( .clk(clk),  .rst_n(rst_n), .DINA(DIN_14), .ADDRA(ADDR_14), .WEA(WEA_14), .DOUTA(DOUTA_14),  .ENA(ENA_14) );
//SPRAM   #(.ADDR_WIDTH(4), .DATA_WIDTH(32),.DATA_DEPTH(14)) Input_Buffer3_15( .clk(clk),  .rst_n(rst_n), .DINA(DIN_15), .ADDRA(ADDR_15), .WEA(WEA_15), .DOUTA(DOUTA_15),  .ENA(ENA_15) );
Input_Buffer3_IP Input_Buffer30 (.clka(clk), .ena(ENA_0), .wea(WEA_0), .addra(ADDR_0), .dina(DIN_0), .douta(DOUTA_0));
Input_Buffer3_IP Input_Buffer31 (.clka(clk), .ena(ENA_1), .wea(WEA_1), .addra(ADDR_1), .dina(DIN_1), .douta(DOUTA_1));
Input_Buffer3_IP Input_Buffer32 (.clka(clk), .ena(ENA_2), .wea(WEA_2), .addra(ADDR_2), .dina(DIN_2), .douta(DOUTA_2));
Input_Buffer3_IP Input_Buffer33 (.clka(clk), .ena(ENA_3), .wea(WEA_3), .addra(ADDR_3), .dina(DIN_3), .douta(DOUTA_3));
Input_Buffer3_IP Input_Buffer34 (.clka(clk), .ena(ENA_4), .wea(WEA_4), .addra(ADDR_4), .dina(DIN_4), .douta(DOUTA_4));
Input_Buffer3_IP Input_Buffer35 (.clka(clk), .ena(ENA_5), .wea(WEA_5), .addra(ADDR_5), .dina(DIN_5), .douta(DOUTA_5));
Input_Buffer3_IP Input_Buffer36 (.clka(clk), .ena(ENA_6), .wea(WEA_6), .addra(ADDR_6), .dina(DIN_6), .douta(DOUTA_6));
Input_Buffer3_IP Input_Buffer37 (.clka(clk), .ena(ENA_7), .wea(WEA_7), .addra(ADDR_7), .dina(DIN_7), .douta(DOUTA_7));
Input_Buffer3_IP Input_Buffer38 (.clka(clk), .ena(ENA_8), .wea(WEA_8), .addra(ADDR_8), .dina(DIN_8), .douta(DOUTA_8));
Input_Buffer3_IP Input_Buffer39 (.clka(clk), .ena(ENA_9), .wea(WEA_9), .addra(ADDR_9), .dina(DIN_9), .douta(DOUTA_9));
Input_Buffer3_IP Input_Buffer310 (.clka(clk), .ena(ENA_10), .wea(WEA_10), .addra(ADDR_10), .dina(DIN_10), .douta(DOUTA_10));
Input_Buffer3_IP Input_Buffer311 (.clka(clk), .ena(ENA_11), .wea(WEA_11), .addra(ADDR_11), .dina(DIN_11), .douta(DOUTA_11));
Input_Buffer3_IP Input_Buffer312 (.clka(clk), .ena(ENA_12), .wea(WEA_12), .addra(ADDR_12), .dina(DIN_12), .douta(DOUTA_12));
Input_Buffer3_IP Input_Buffer313 (.clka(clk), .ena(ENA_13), .wea(WEA_13), .addra(ADDR_13), .dina(DIN_13), .douta(DOUTA_13));
Input_Buffer3_IP Input_Buffer314 (.clka(clk), .ena(ENA_14), .wea(WEA_14), .addra(ADDR_14), .dina(DIN_14), .douta(DOUTA_14));
Input_Buffer3_IP Input_Buffer315 (.clka(clk), .ena(ENA_15), .wea(WEA_15), .addra(ADDR_15), .dina(DIN_15), .douta(DOUTA_15));
endmodule
