`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/07 21:22:40
// Design Name: 
// Module Name: Input_Buffer_B5
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


module Input_Buffer_B5(
    input                       clk,
    input                       rst_n,
    input    [31:0]             DIN_0, DIN_1, DIN_2,  DIN_3,  DIN_4,  DIN_5,  DIN_6,  DIN_7,
                                DIN_8, DIN_9, DIN_10, DIN_11, DIN_12, DIN_13, DIN_14, DIN_15,
                                DIN_16, DIN_17, DIN_18, DIN_19, DIN_20, DIN_21, DIN_22, DIN_23, 
                                DIN_24, DIN_25, DIN_26, DIN_27, DIN_28, DIN_29, DIN_30, DIN_31, 
    input    [2:0]              ADDR_0, ADDR_1, ADDR_2,  ADDR_3,  ADDR_4,  ADDR_5,  ADDR_6,  ADDR_7,
                                ADDR_8, ADDR_9, ADDR_10, ADDR_11, ADDR_12, ADDR_13, ADDR_14, ADDR_15,
                                ADDR_16, ADDR_17, ADDR_18, ADDR_19, ADDR_20, ADDR_21, ADDR_22, ADDR_23, 
                                ADDR_24, ADDR_25, ADDR_26, ADDR_27, ADDR_28, ADDR_29, ADDR_30, ADDR_31, 
    input                       WEA_0, WEA_1,  WEA_2,  WEA_3,  WEA_4,  WEA_5,  WEA_6,  WEA_7,
                                WEA_8, WEA_9,  WEA_10, WEA_11, WEA_12, WEA_13, WEA_14, WEA_15,
                                WEA_16, WEA_17, WEA_18, WEA_19, WEA_20, WEA_21, WEA_22, WEA_23, 
                                WEA_24, WEA_25, WEA_26, WEA_27, WEA_28, WEA_29, WEA_30, WEA_31,
    input                       ENA_0, ENA_1,  ENA_2,  ENA_3,  ENA_4,  ENA_5,  ENA_6,  ENA_7,
                                ENA_8, ENA_9,  ENA_10, ENA_11, ENA_12, ENA_13, ENA_14, ENA_15,
                                ENA_16, ENA_17, ENA_18, ENA_19, ENA_20, ENA_21, ENA_22, ENA_23, 
                                ENA_24, ENA_25, ENA_26, ENA_27, ENA_28, ENA_29, ENA_30, ENA_31, 
    output   wire  [31:0]       DOUTA_0, DOUTA_1, DOUTA_2,  DOUTA_3,  DOUTA_4,  DOUTA_5,  DOUTA_6,  DOUTA_7,
                                DOUTA_8, DOUTA_9, DOUTA_10, DOUTA_11, DOUTA_12, DOUTA_13, DOUTA_14, DOUTA_15,
                                DOUTA_16, DOUTA_17, DOUTA_18, DOUTA_19, DOUTA_20, DOUTA_21, DOUTA_22, DOUTA_23, 
                                DOUTA_24, DOUTA_25, DOUTA_26, DOUTA_27, DOUTA_28, DOUTA_29, DOUTA_30, DOUTA_31                                              
);
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_0( .clk(clk),  .rst_n(rst_n), .DINA(DIN_0), .ADDRA(ADDR_0), .WEA(WEA_0), .DOUTA(DOUTA_0),  .ENA(ENA_0) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_1( .clk(clk),  .rst_n(rst_n), .DINA(DIN_1), .ADDRA(ADDR_1), .WEA(WEA_1), .DOUTA(DOUTA_1),  .ENA(ENA_1) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_2( .clk(clk),  .rst_n(rst_n), .DINA(DIN_2), .ADDRA(ADDR_2), .WEA(WEA_2), .DOUTA(DOUTA_2),  .ENA(ENA_2) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_3( .clk(clk),  .rst_n(rst_n), .DINA(DIN_3), .ADDRA(ADDR_3), .WEA(WEA_3), .DOUTA(DOUTA_3),  .ENA(ENA_3) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_4( .clk(clk),  .rst_n(rst_n), .DINA(DIN_4), .ADDRA(ADDR_4), .WEA(WEA_4), .DOUTA(DOUTA_4),  .ENA(ENA_4) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_5( .clk(clk),  .rst_n(rst_n), .DINA(DIN_5), .ADDRA(ADDR_5), .WEA(WEA_5), .DOUTA(DOUTA_5),  .ENA(ENA_5) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_6( .clk(clk),  .rst_n(rst_n), .DINA(DIN_6), .ADDRA(ADDR_6), .WEA(WEA_6), .DOUTA(DOUTA_6),  .ENA(ENA_6) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_7( .clk(clk),  .rst_n(rst_n), .DINA(DIN_7), .ADDRA(ADDR_7), .WEA(WEA_7), .DOUTA(DOUTA_7),  .ENA(ENA_7) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_8( .clk(clk),  .rst_n(rst_n), .DINA(DIN_8), .ADDRA(ADDR_8), .WEA(WEA_8), .DOUTA(DOUTA_8),  .ENA(ENA_8) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_9( .clk(clk),  .rst_n(rst_n), .DINA(DIN_9), .ADDRA(ADDR_9), .WEA(WEA_9), .DOUTA(DOUTA_9),  .ENA(ENA_9) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_10( .clk(clk),  .rst_n(rst_n), .DINA(DIN_10), .ADDRA(ADDR_10), .WEA(WEA_10), .DOUTA(DOUTA_10),  .ENA(ENA_10) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_11( .clk(clk),  .rst_n(rst_n), .DINA(DIN_11), .ADDRA(ADDR_11), .WEA(WEA_11), .DOUTA(DOUTA_11),  .ENA(ENA_11) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_12( .clk(clk),  .rst_n(rst_n), .DINA(DIN_12), .ADDRA(ADDR_12), .WEA(WEA_12), .DOUTA(DOUTA_12),  .ENA(ENA_12) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_13( .clk(clk),  .rst_n(rst_n), .DINA(DIN_13), .ADDRA(ADDR_13), .WEA(WEA_13), .DOUTA(DOUTA_13),  .ENA(ENA_13) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_14( .clk(clk),  .rst_n(rst_n), .DINA(DIN_14), .ADDRA(ADDR_14), .WEA(WEA_14), .DOUTA(DOUTA_14),  .ENA(ENA_14) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_15( .clk(clk),  .rst_n(rst_n), .DINA(DIN_15), .ADDRA(ADDR_15), .WEA(WEA_15), .DOUTA(DOUTA_15),  .ENA(ENA_15) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_16( .clk(clk),  .rst_n(rst_n), .DINA(DIN_16), .ADDRA(ADDR_16), .WEA(WEA_16), .DOUTA(DOUTA_16),  .ENA(ENA_16) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_17( .clk(clk),  .rst_n(rst_n), .DINA(DIN_17), .ADDRA(ADDR_17), .WEA(WEA_17), .DOUTA(DOUTA_17),  .ENA(ENA_17) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_18( .clk(clk),  .rst_n(rst_n), .DINA(DIN_18), .ADDRA(ADDR_18), .WEA(WEA_18), .DOUTA(DOUTA_18),  .ENA(ENA_18) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_19( .clk(clk),  .rst_n(rst_n), .DINA(DIN_19), .ADDRA(ADDR_19), .WEA(WEA_19), .DOUTA(DOUTA_19), .ENA(ENA_19) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_20( .clk(clk),  .rst_n(rst_n), .DINA(DIN_20), .ADDRA(ADDR_20), .WEA(WEA_20), .DOUTA(DOUTA_20),  .ENA(ENA_20) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_21( .clk(clk),  .rst_n(rst_n), .DINA(DIN_21), .ADDRA(ADDR_21), .WEA(WEA_21), .DOUTA(DOUTA_21), .ENA(ENA_21) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_22( .clk(clk),  .rst_n(rst_n), .DINA(DIN_22), .ADDRA(ADDR_22), .WEA(WEA_22), .DOUTA(DOUTA_22),  .ENA(ENA_22) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_23( .clk(clk),  .rst_n(rst_n), .DINA(DIN_23), .ADDRA(ADDR_23), .WEA(WEA_23), .DOUTA(DOUTA_23),  .ENA(ENA_23) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_24( .clk(clk),  .rst_n(rst_n), .DINA(DIN_24), .ADDRA(ADDR_24), .WEA(WEA_24), .DOUTA(DOUTA_24),  .ENA(ENA_24) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_25( .clk(clk),  .rst_n(rst_n), .DINA(DIN_25), .ADDRA(ADDR_25), .WEA(WEA_25), .DOUTA(DOUTA_25),  .ENA(ENA_25) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_26( .clk(clk),  .rst_n(rst_n), .DINA(DIN_26), .ADDRA(ADDR_26), .WEA(WEA_26), .DOUTA(DOUTA_26),  .ENA(ENA_26) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_27( .clk(clk),  .rst_n(rst_n), .DINA(DIN_27), .ADDRA(ADDR_27), .WEA(WEA_27), .DOUTA(DOUTA_27), .ENA(ENA_27) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_28( .clk(clk),  .rst_n(rst_n), .DINA(DIN_28), .ADDRA(ADDR_28), .WEA(WEA_28), .DOUTA(DOUTA_28),  .ENA(ENA_28) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_29( .clk(clk),  .rst_n(rst_n), .DINA(DIN_29), .ADDRA(ADDR_29), .WEA(WEA_29), .DOUTA(DOUTA_29),  .ENA(ENA_29) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_30( .clk(clk),  .rst_n(rst_n), .DINA(DIN_30), .ADDRA(ADDR_30), .WEA(WEA_30), .DOUTA(DOUTA_30), .ENA(ENA_30) );
SPRAM   #(.ADDR_WIDTH(3), .DATA_WIDTH(32),.DATA_DEPTH(4)) Input_Buffer5_31( .clk(clk),  .rst_n(rst_n), .DINA(DIN_31), .ADDRA(ADDR_31), .WEA(WEA_31), .DOUTA(DOUTA_31),  .ENA(ENA_31) );




endmodule
