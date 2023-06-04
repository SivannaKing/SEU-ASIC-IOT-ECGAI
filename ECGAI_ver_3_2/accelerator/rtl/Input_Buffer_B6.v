`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 15:29:57
// Design Name: 
// Module Name: Input_Buffer_B6
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


module Input_Buffer_B6(
    input                       clk,
    input                       rst_n,
    input    [31:0]             DIN_0, DIN_1, DIN_2,  DIN_3,  DIN_4,  DIN_5,  DIN_6,  DIN_7,
                                DIN_8, DIN_9, DIN_10, DIN_11, DIN_12, DIN_13, DIN_14, DIN_15,
                                DIN_16, DIN_17, DIN_18, DIN_19, DIN_20, DIN_21, DIN_22, DIN_23, 
                                DIN_24, DIN_25, DIN_26, DIN_27, DIN_28, DIN_29, DIN_30, DIN_31,
                                DIN_32, DIN_33, DIN_34, DIN_35, DIN_36, DIN_37, DIN_38, DIN_39, 
                                DIN_40, DIN_41, DIN_42, DIN_43, DIN_44, DIN_45, DIN_46, DIN_47, 
                                DIN_48, DIN_49, DIN_50, DIN_51, DIN_52, DIN_53, DIN_54, DIN_55, 
                                DIN_56, DIN_57, DIN_58, DIN_59, DIN_60, DIN_61, DIN_62, DIN_63, 
    input    [1:0]              ADDR_0, ADDR_1, ADDR_2,  ADDR_3,  ADDR_4,  ADDR_5,  ADDR_6,  ADDR_7,
                                ADDR_8, ADDR_9, ADDR_10, ADDR_11, ADDR_12, ADDR_13, ADDR_14, ADDR_15,
                                ADDR_16, ADDR_17, ADDR_18, ADDR_19, ADDR_20, ADDR_21, ADDR_22, ADDR_23, 
                                ADDR_24, ADDR_25, ADDR_26, ADDR_27, ADDR_28, ADDR_29, ADDR_30, ADDR_31,
                                ADDR_32, ADDR_33, ADDR_34, ADDR_35, ADDR_36, ADDR_37, ADDR_38, ADDR_39, 
                                ADDR_40, ADDR_41, ADDR_42, ADDR_43, ADDR_44, ADDR_45, ADDR_46, ADDR_47, 
                                ADDR_48, ADDR_49, ADDR_50, ADDR_51, ADDR_52, ADDR_53, ADDR_54, ADDR_55, 
                                ADDR_56, ADDR_57, ADDR_58, ADDR_59, ADDR_60, ADDR_61, ADDR_62, ADDR_63,  
    input                       WEA_0, WEA_1,  WEA_2,  WEA_3,  WEA_4,  WEA_5,  WEA_6,  WEA_7,
                                WEA_8, WEA_9,  WEA_10, WEA_11, WEA_12, WEA_13, WEA_14, WEA_15,
                                WEA_16, WEA_17, WEA_18, WEA_19, WEA_20, WEA_21, WEA_22, WEA_23, 
                                WEA_24, WEA_25, WEA_26, WEA_27, WEA_28, WEA_29, WEA_30, WEA_31,
                                WEA_32, WEA_33, WEA_34, WEA_35, WEA_36, WEA_37, WEA_38, WEA_39, 
                                WEA_40, WEA_41, WEA_42, WEA_43, WEA_44, WEA_45, WEA_46, WEA_47, 
                                WEA_48, WEA_49, WEA_50, WEA_51, WEA_52, WEA_53, WEA_54, WEA_55, 
                                WEA_56, WEA_57, WEA_58, WEA_59, WEA_60, WEA_61, WEA_62, WEA_63, 
    input                       ENA_0, ENA_1,  ENA_2,  ENA_3,  ENA_4,  ENA_5,  ENA_6,  ENA_7,
                                ENA_8, ENA_9,  ENA_10, ENA_11, ENA_12, ENA_13, ENA_14, ENA_15,
                                ENA_16, ENA_17, ENA_18, ENA_19, ENA_20, ENA_21, ENA_22, ENA_23, 
                                ENA_24, ENA_25, ENA_26, ENA_27, ENA_28, ENA_29, ENA_30, ENA_31,
                                ENA_32, ENA_33, ENA_34, ENA_35, ENA_36, ENA_37, ENA_38, ENA_39, 
                                ENA_40, ENA_41, ENA_42, ENA_43, ENA_44, ENA_45, ENA_46, ENA_47, 
                                ENA_48, ENA_49, ENA_50, ENA_51, ENA_52, ENA_53, ENA_54, ENA_55, 
                                ENA_56, ENA_57, ENA_58, ENA_59, ENA_60, ENA_61, ENA_62, ENA_63, 
    output   wire  [31:0]       DOUTA_0, DOUTA_1, DOUTA_2,  DOUTA_3,  DOUTA_4,  DOUTA_5,  DOUTA_6,  DOUTA_7,
                                DOUTA_8, DOUTA_9, DOUTA_10, DOUTA_11, DOUTA_12, DOUTA_13, DOUTA_14, DOUTA_15,
                                DOUTA_16, DOUTA_17, DOUTA_18, DOUTA_19, DOUTA_20, DOUTA_21, DOUTA_22, DOUTA_23, 
                                DOUTA_24, DOUTA_25, DOUTA_26, DOUTA_27, DOUTA_28, DOUTA_29, DOUTA_30, DOUTA_31,
                                DOUTA_32, DOUTA_33, DOUTA_34, DOUTA_35, DOUTA_36, DOUTA_37, DOUTA_38, DOUTA_39, 
                                DOUTA_40, DOUTA_41, DOUTA_42, DOUTA_43, DOUTA_44, DOUTA_45, DOUTA_46, DOUTA_47, 
                                DOUTA_48, DOUTA_49, DOUTA_50, DOUTA_51, DOUTA_52, DOUTA_53, DOUTA_54, DOUTA_55, 
                                DOUTA_56, DOUTA_57, DOUTA_58, DOUTA_59, DOUTA_60, DOUTA_61, DOUTA_62, DOUTA_63 
);

SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_0( .clk(clk),  .rst_n(rst_n), .DINA(DIN_0), .ADDRA(ADDR_0), .WEA(WEA_0), .DOUTA(DOUTA_0),  .ENA(ENA_0) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_1( .clk(clk),  .rst_n(rst_n), .DINA(DIN_1), .ADDRA(ADDR_1), .WEA(WEA_1), .DOUTA(DOUTA_1),  .ENA(ENA_1) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_2( .clk(clk),  .rst_n(rst_n), .DINA(DIN_2), .ADDRA(ADDR_2), .WEA(WEA_2), .DOUTA(DOUTA_2),  .ENA(ENA_2) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_3( .clk(clk),  .rst_n(rst_n), .DINA(DIN_3), .ADDRA(ADDR_3), .WEA(WEA_3), .DOUTA(DOUTA_3),  .ENA(ENA_3) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_4( .clk(clk),  .rst_n(rst_n), .DINA(DIN_4), .ADDRA(ADDR_4), .WEA(WEA_4), .DOUTA(DOUTA_4),  .ENA(ENA_4) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_5( .clk(clk),  .rst_n(rst_n), .DINA(DIN_5), .ADDRA(ADDR_5), .WEA(WEA_5), .DOUTA(DOUTA_5),  .ENA(ENA_5) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_6( .clk(clk),  .rst_n(rst_n), .DINA(DIN_6), .ADDRA(ADDR_6), .WEA(WEA_6), .DOUTA(DOUTA_6),  .ENA(ENA_6) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_7( .clk(clk),  .rst_n(rst_n), .DINA(DIN_7), .ADDRA(ADDR_7), .WEA(WEA_7), .DOUTA(DOUTA_7),  .ENA(ENA_7) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_8( .clk(clk),  .rst_n(rst_n), .DINA(DIN_8), .ADDRA(ADDR_8), .WEA(WEA_8), .DOUTA(DOUTA_8),  .ENA(ENA_8) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_9( .clk(clk),  .rst_n(rst_n), .DINA(DIN_9), .ADDRA(ADDR_9), .WEA(WEA_9), .DOUTA(DOUTA_9),  .ENA(ENA_9) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_10( .clk(clk),  .rst_n(rst_n), .DINA(DIN_10), .ADDRA(ADDR_10), .WEA(WEA_10), .DOUTA(DOUTA_10),  .ENA(ENA_10) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_11( .clk(clk),  .rst_n(rst_n), .DINA(DIN_11), .ADDRA(ADDR_11), .WEA(WEA_11), .DOUTA(DOUTA_11),  .ENA(ENA_11) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_12( .clk(clk),  .rst_n(rst_n), .DINA(DIN_12), .ADDRA(ADDR_12), .WEA(WEA_12), .DOUTA(DOUTA_12),  .ENA(ENA_12) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_13( .clk(clk),  .rst_n(rst_n), .DINA(DIN_13), .ADDRA(ADDR_13), .WEA(WEA_13), .DOUTA(DOUTA_13),  .ENA(ENA_13) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_14( .clk(clk),  .rst_n(rst_n), .DINA(DIN_14), .ADDRA(ADDR_14), .WEA(WEA_14), .DOUTA(DOUTA_14),  .ENA(ENA_14) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_15( .clk(clk),  .rst_n(rst_n), .DINA(DIN_15), .ADDRA(ADDR_15), .WEA(WEA_15), .DOUTA(DOUTA_15),  .ENA(ENA_15) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_16( .clk(clk),  .rst_n(rst_n), .DINA(DIN_16), .ADDRA(ADDR_16), .WEA(WEA_16), .DOUTA(DOUTA_16),  .ENA(ENA_16) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_17( .clk(clk),  .rst_n(rst_n), .DINA(DIN_17), .ADDRA(ADDR_17), .WEA(WEA_17), .DOUTA(DOUTA_17),  .ENA(ENA_17) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_18( .clk(clk),  .rst_n(rst_n), .DINA(DIN_18), .ADDRA(ADDR_18), .WEA(WEA_18), .DOUTA(DOUTA_18),  .ENA(ENA_18) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_19( .clk(clk),  .rst_n(rst_n), .DINA(DIN_19), .ADDRA(ADDR_19), .WEA(WEA_19), .DOUTA(DOUTA_19),  .ENA(ENA_19) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_20( .clk(clk),  .rst_n(rst_n), .DINA(DIN_20), .ADDRA(ADDR_20), .WEA(WEA_20), .DOUTA(DOUTA_20),  .ENA(ENA_20) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_21( .clk(clk),  .rst_n(rst_n), .DINA(DIN_21), .ADDRA(ADDR_21), .WEA(WEA_21), .DOUTA(DOUTA_21),  .ENA(ENA_21) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_22( .clk(clk),  .rst_n(rst_n), .DINA(DIN_22), .ADDRA(ADDR_22), .WEA(WEA_22), .DOUTA(DOUTA_22),  .ENA(ENA_22) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_23( .clk(clk),  .rst_n(rst_n), .DINA(DIN_23), .ADDRA(ADDR_23), .WEA(WEA_23), .DOUTA(DOUTA_23),  .ENA(ENA_23) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_24( .clk(clk),  .rst_n(rst_n), .DINA(DIN_24), .ADDRA(ADDR_24), .WEA(WEA_24), .DOUTA(DOUTA_24),  .ENA(ENA_24) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_25( .clk(clk),  .rst_n(rst_n), .DINA(DIN_25), .ADDRA(ADDR_25), .WEA(WEA_25), .DOUTA(DOUTA_25),  .ENA(ENA_25) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_26( .clk(clk),  .rst_n(rst_n), .DINA(DIN_26), .ADDRA(ADDR_26), .WEA(WEA_26), .DOUTA(DOUTA_26),  .ENA(ENA_26) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_27( .clk(clk),  .rst_n(rst_n), .DINA(DIN_27), .ADDRA(ADDR_27), .WEA(WEA_27), .DOUTA(DOUTA_27),  .ENA(ENA_27) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_28( .clk(clk),  .rst_n(rst_n), .DINA(DIN_28), .ADDRA(ADDR_28), .WEA(WEA_28), .DOUTA(DOUTA_28),  .ENA(ENA_28) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_29( .clk(clk),  .rst_n(rst_n), .DINA(DIN_29), .ADDRA(ADDR_29), .WEA(WEA_29), .DOUTA(DOUTA_29),  .ENA(ENA_29) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_30( .clk(clk),  .rst_n(rst_n), .DINA(DIN_30), .ADDRA(ADDR_30), .WEA(WEA_30), .DOUTA(DOUTA_30),  .ENA(ENA_30) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_31( .clk(clk),  .rst_n(rst_n), .DINA(DIN_31), .ADDRA(ADDR_31), .WEA(WEA_31), .DOUTA(DOUTA_31),  .ENA(ENA_31) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_32( .clk(clk),  .rst_n(rst_n), .DINA(DIN_32), .ADDRA(ADDR_32), .WEA(WEA_32), .DOUTA(DOUTA_32),  .ENA(ENA_32) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_33( .clk(clk),  .rst_n(rst_n), .DINA(DIN_33), .ADDRA(ADDR_33), .WEA(WEA_33), .DOUTA(DOUTA_33),  .ENA(ENA_33) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_34( .clk(clk),  .rst_n(rst_n), .DINA(DIN_34), .ADDRA(ADDR_34), .WEA(WEA_34), .DOUTA(DOUTA_34),  .ENA(ENA_34) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_35( .clk(clk),  .rst_n(rst_n), .DINA(DIN_35), .ADDRA(ADDR_35), .WEA(WEA_35), .DOUTA(DOUTA_35),  .ENA(ENA_35) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_36( .clk(clk),  .rst_n(rst_n), .DINA(DIN_36), .ADDRA(ADDR_36), .WEA(WEA_36), .DOUTA(DOUTA_36),  .ENA(ENA_36) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_37( .clk(clk),  .rst_n(rst_n), .DINA(DIN_37), .ADDRA(ADDR_37), .WEA(WEA_37), .DOUTA(DOUTA_37),  .ENA(ENA_37) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_38( .clk(clk),  .rst_n(rst_n), .DINA(DIN_38), .ADDRA(ADDR_38), .WEA(WEA_38), .DOUTA(DOUTA_38),  .ENA(ENA_38) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_39( .clk(clk),  .rst_n(rst_n), .DINA(DIN_39), .ADDRA(ADDR_39), .WEA(WEA_39), .DOUTA(DOUTA_39),  .ENA(ENA_39) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_40( .clk(clk),  .rst_n(rst_n), .DINA(DIN_40), .ADDRA(ADDR_40), .WEA(WEA_40), .DOUTA(DOUTA_40),  .ENA(ENA_40) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_41( .clk(clk),  .rst_n(rst_n), .DINA(DIN_41), .ADDRA(ADDR_41), .WEA(WEA_41), .DOUTA(DOUTA_41),  .ENA(ENA_41) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_42( .clk(clk),  .rst_n(rst_n), .DINA(DIN_42), .ADDRA(ADDR_42), .WEA(WEA_42), .DOUTA(DOUTA_42),  .ENA(ENA_42) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_43( .clk(clk),  .rst_n(rst_n), .DINA(DIN_43), .ADDRA(ADDR_43), .WEA(WEA_43), .DOUTA(DOUTA_43),  .ENA(ENA_43) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_44( .clk(clk),  .rst_n(rst_n), .DINA(DIN_44), .ADDRA(ADDR_44), .WEA(WEA_44), .DOUTA(DOUTA_44),  .ENA(ENA_44) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_45( .clk(clk),  .rst_n(rst_n), .DINA(DIN_45), .ADDRA(ADDR_45), .WEA(WEA_45), .DOUTA(DOUTA_45),  .ENA(ENA_45) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_46( .clk(clk),  .rst_n(rst_n), .DINA(DIN_46), .ADDRA(ADDR_46), .WEA(WEA_46), .DOUTA(DOUTA_46),  .ENA(ENA_46) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_47( .clk(clk),  .rst_n(rst_n), .DINA(DIN_47), .ADDRA(ADDR_47), .WEA(WEA_47), .DOUTA(DOUTA_47),  .ENA(ENA_47) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_48( .clk(clk),  .rst_n(rst_n), .DINA(DIN_48), .ADDRA(ADDR_48), .WEA(WEA_48), .DOUTA(DOUTA_48),  .ENA(ENA_48) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_49( .clk(clk),  .rst_n(rst_n), .DINA(DIN_49), .ADDRA(ADDR_49), .WEA(WEA_49), .DOUTA(DOUTA_49),  .ENA(ENA_49) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_50( .clk(clk),  .rst_n(rst_n), .DINA(DIN_50), .ADDRA(ADDR_50), .WEA(WEA_50), .DOUTA(DOUTA_50),  .ENA(ENA_50) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_51( .clk(clk),  .rst_n(rst_n), .DINA(DIN_51), .ADDRA(ADDR_51), .WEA(WEA_51), .DOUTA(DOUTA_51),  .ENA(ENA_51) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_52( .clk(clk),  .rst_n(rst_n), .DINA(DIN_52), .ADDRA(ADDR_52), .WEA(WEA_52), .DOUTA(DOUTA_52),  .ENA(ENA_52) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_53( .clk(clk),  .rst_n(rst_n), .DINA(DIN_53), .ADDRA(ADDR_53), .WEA(WEA_53), .DOUTA(DOUTA_53),  .ENA(ENA_53) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_54( .clk(clk),  .rst_n(rst_n), .DINA(DIN_54), .ADDRA(ADDR_54), .WEA(WEA_54), .DOUTA(DOUTA_54),  .ENA(ENA_54) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_55( .clk(clk),  .rst_n(rst_n), .DINA(DIN_55), .ADDRA(ADDR_55), .WEA(WEA_55), .DOUTA(DOUTA_55),  .ENA(ENA_55) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_56( .clk(clk),  .rst_n(rst_n), .DINA(DIN_56), .ADDRA(ADDR_56), .WEA(WEA_56), .DOUTA(DOUTA_56),  .ENA(ENA_56) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_57( .clk(clk),  .rst_n(rst_n), .DINA(DIN_57), .ADDRA(ADDR_57), .WEA(WEA_57), .DOUTA(DOUTA_57),  .ENA(ENA_57) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_58( .clk(clk),  .rst_n(rst_n), .DINA(DIN_58), .ADDRA(ADDR_58), .WEA(WEA_58), .DOUTA(DOUTA_58),  .ENA(ENA_58) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_59( .clk(clk),  .rst_n(rst_n), .DINA(DIN_59), .ADDRA(ADDR_59), .WEA(WEA_59), .DOUTA(DOUTA_59),  .ENA(ENA_59) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_60( .clk(clk),  .rst_n(rst_n), .DINA(DIN_60), .ADDRA(ADDR_60), .WEA(WEA_60), .DOUTA(DOUTA_60),  .ENA(ENA_60) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_61( .clk(clk),  .rst_n(rst_n), .DINA(DIN_61), .ADDRA(ADDR_61), .WEA(WEA_61), .DOUTA(DOUTA_61),  .ENA(ENA_61) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_62( .clk(clk),  .rst_n(rst_n), .DINA(DIN_62), .ADDRA(ADDR_62), .WEA(WEA_62), .DOUTA(DOUTA_62),  .ENA(ENA_62) );
SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_63( .clk(clk),  .rst_n(rst_n), .DINA(DIN_63), .ADDRA(ADDR_63), .WEA(WEA_63), .DOUTA(DOUTA_63),  .ENA(ENA_63) );

//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_1( .clk(clk),  .rst_n(rst_n), .DINA(DIN_1), .ADDRA(ADDR_1), .WEA(WEA_1), .DOUTA(DOUTA_1), .M(61), .ENA(ENA_1) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_2( .clk(clk),  .rst_n(rst_n), .DINA(DIN_2), .ADDRA(ADDR_2), .WEA(WEA_2), .DOUTA(DOUTA_2), .M(62), .ENA(ENA_2) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_3( .clk(clk),  .rst_n(rst_n), .DINA(DIN_3), .ADDRA(ADDR_3), .WEA(WEA_3), .DOUTA(DOUTA_3), .M(63), .ENA(ENA_3) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_4( .clk(clk),  .rst_n(rst_n), .DINA(DIN_4), .ADDRA(ADDR_4), .WEA(WEA_4), .DOUTA(DOUTA_4), .M(64), .ENA(ENA_4) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_5( .clk(clk),  .rst_n(rst_n), .DINA(DIN_5), .ADDRA(ADDR_5), .WEA(WEA_5), .DOUTA(DOUTA_5), .M(65), .ENA(ENA_5) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_6( .clk(clk),  .rst_n(rst_n), .DINA(DIN_6), .ADDRA(ADDR_6), .WEA(WEA_6), .DOUTA(DOUTA_6), .M(66), .ENA(ENA_6) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_7( .clk(clk),  .rst_n(rst_n), .DINA(DIN_7), .ADDRA(ADDR_7), .WEA(WEA_7), .DOUTA(DOUTA_7), .M(67), .ENA(ENA_7) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_8( .clk(clk),  .rst_n(rst_n), .DINA(DIN_8), .ADDRA(ADDR_8), .WEA(WEA_8), .DOUTA(DOUTA_8), .M(68), .ENA(ENA_8) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_9( .clk(clk),  .rst_n(rst_n), .DINA(DIN_9), .ADDRA(ADDR_9), .WEA(WEA_9), .DOUTA(DOUTA_9), .M(69), .ENA(ENA_9) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_10( .clk(clk),  .rst_n(rst_n), .DINA(DIN_10), .ADDRA(ADDR_10), .WEA(WEA_10), .DOUTA(DOUTA_10), .M(610), .ENA(ENA_10) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_11( .clk(clk),  .rst_n(rst_n), .DINA(DIN_11), .ADDRA(ADDR_11), .WEA(WEA_11), .DOUTA(DOUTA_11), .M(611), .ENA(ENA_11) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_12( .clk(clk),  .rst_n(rst_n), .DINA(DIN_12), .ADDRA(ADDR_12), .WEA(WEA_12), .DOUTA(DOUTA_12), .M(612), .ENA(ENA_12) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_13( .clk(clk),  .rst_n(rst_n), .DINA(DIN_13), .ADDRA(ADDR_13), .WEA(WEA_13), .DOUTA(DOUTA_13), .M(613), .ENA(ENA_13) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_14( .clk(clk),  .rst_n(rst_n), .DINA(DIN_14), .ADDRA(ADDR_14), .WEA(WEA_14), .DOUTA(DOUTA_14), .M(614), .ENA(ENA_14) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_15( .clk(clk),  .rst_n(rst_n), .DINA(DIN_15), .ADDRA(ADDR_15), .WEA(WEA_15), .DOUTA(DOUTA_15), .M(615), .ENA(ENA_15) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_16( .clk(clk),  .rst_n(rst_n), .DINA(DIN_16), .ADDRA(ADDR_16), .WEA(WEA_16), .DOUTA(DOUTA_16), .M(616), .ENA(ENA_16) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_17( .clk(clk),  .rst_n(rst_n), .DINA(DIN_17), .ADDRA(ADDR_17), .WEA(WEA_17), .DOUTA(DOUTA_17), .M(617), .ENA(ENA_17) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_18( .clk(clk),  .rst_n(rst_n), .DINA(DIN_18), .ADDRA(ADDR_18), .WEA(WEA_18), .DOUTA(DOUTA_18), .M(618), .ENA(ENA_18) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_19( .clk(clk),  .rst_n(rst_n), .DINA(DIN_19), .ADDRA(ADDR_19), .WEA(WEA_19), .DOUTA(DOUTA_19), .M(619), .ENA(ENA_19) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_20( .clk(clk),  .rst_n(rst_n), .DINA(DIN_20), .ADDRA(ADDR_20), .WEA(WEA_20), .DOUTA(DOUTA_20), .M(620), .ENA(ENA_20) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_21( .clk(clk),  .rst_n(rst_n), .DINA(DIN_21), .ADDRA(ADDR_21), .WEA(WEA_21), .DOUTA(DOUTA_21), .M(621), .ENA(ENA_21) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_22( .clk(clk),  .rst_n(rst_n), .DINA(DIN_22), .ADDRA(ADDR_22), .WEA(WEA_22), .DOUTA(DOUTA_22), .M(622), .ENA(ENA_22) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_23( .clk(clk),  .rst_n(rst_n), .DINA(DIN_23), .ADDRA(ADDR_23), .WEA(WEA_23), .DOUTA(DOUTA_23), .M(623), .ENA(ENA_23) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_24( .clk(clk),  .rst_n(rst_n), .DINA(DIN_24), .ADDRA(ADDR_24), .WEA(WEA_24), .DOUTA(DOUTA_24), .M(624), .ENA(ENA_24) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_25( .clk(clk),  .rst_n(rst_n), .DINA(DIN_25), .ADDRA(ADDR_25), .WEA(WEA_25), .DOUTA(DOUTA_25), .M(625), .ENA(ENA_25) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_26( .clk(clk),  .rst_n(rst_n), .DINA(DIN_26), .ADDRA(ADDR_26), .WEA(WEA_26), .DOUTA(DOUTA_26), .M(626), .ENA(ENA_26) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_27( .clk(clk),  .rst_n(rst_n), .DINA(DIN_27), .ADDRA(ADDR_27), .WEA(WEA_27), .DOUTA(DOUTA_27), .M(627), .ENA(ENA_27) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_28( .clk(clk),  .rst_n(rst_n), .DINA(DIN_28), .ADDRA(ADDR_28), .WEA(WEA_28), .DOUTA(DOUTA_28), .M(628), .ENA(ENA_28) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_29( .clk(clk),  .rst_n(rst_n), .DINA(DIN_29), .ADDRA(ADDR_29), .WEA(WEA_29), .DOUTA(DOUTA_29), .M(629), .ENA(ENA_29) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_30( .clk(clk),  .rst_n(rst_n), .DINA(DIN_30), .ADDRA(ADDR_30), .WEA(WEA_30), .DOUTA(DOUTA_30), .M(630), .ENA(ENA_30) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_31( .clk(clk),  .rst_n(rst_n), .DINA(DIN_31), .ADDRA(ADDR_31), .WEA(WEA_31), .DOUTA(DOUTA_31), .M(631), .ENA(ENA_31) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_32( .clk(clk),  .rst_n(rst_n), .DINA(DIN_32), .ADDRA(ADDR_32), .WEA(WEA_32), .DOUTA(DOUTA_32), .M(632), .ENA(ENA_32) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_33( .clk(clk),  .rst_n(rst_n), .DINA(DIN_33), .ADDRA(ADDR_33), .WEA(WEA_33), .DOUTA(DOUTA_33), .M(633), .ENA(ENA_33) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_34( .clk(clk),  .rst_n(rst_n), .DINA(DIN_34), .ADDRA(ADDR_34), .WEA(WEA_34), .DOUTA(DOUTA_34), .M(634), .ENA(ENA_34) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_35( .clk(clk),  .rst_n(rst_n), .DINA(DIN_35), .ADDRA(ADDR_35), .WEA(WEA_35), .DOUTA(DOUTA_35), .M(635), .ENA(ENA_35) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_36( .clk(clk),  .rst_n(rst_n), .DINA(DIN_36), .ADDRA(ADDR_36), .WEA(WEA_36), .DOUTA(DOUTA_36), .M(636), .ENA(ENA_36) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_37( .clk(clk),  .rst_n(rst_n), .DINA(DIN_37), .ADDRA(ADDR_37), .WEA(WEA_37), .DOUTA(DOUTA_37), .M(637), .ENA(ENA_37) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_38( .clk(clk),  .rst_n(rst_n), .DINA(DIN_38), .ADDRA(ADDR_38), .WEA(WEA_38), .DOUTA(DOUTA_38), .M(638), .ENA(ENA_38) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_39( .clk(clk),  .rst_n(rst_n), .DINA(DIN_39), .ADDRA(ADDR_39), .WEA(WEA_39), .DOUTA(DOUTA_39), .M(639), .ENA(ENA_39) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_40( .clk(clk),  .rst_n(rst_n), .DINA(DIN_40), .ADDRA(ADDR_40), .WEA(WEA_40), .DOUTA(DOUTA_40), .M(640), .ENA(ENA_40) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_41( .clk(clk),  .rst_n(rst_n), .DINA(DIN_41), .ADDRA(ADDR_41), .WEA(WEA_41), .DOUTA(DOUTA_41), .M(641), .ENA(ENA_41) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_42( .clk(clk),  .rst_n(rst_n), .DINA(DIN_42), .ADDRA(ADDR_42), .WEA(WEA_42), .DOUTA(DOUTA_42), .M(642), .ENA(ENA_42) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_43( .clk(clk),  .rst_n(rst_n), .DINA(DIN_43), .ADDRA(ADDR_43), .WEA(WEA_43), .DOUTA(DOUTA_43), .M(643), .ENA(ENA_43) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_44( .clk(clk),  .rst_n(rst_n), .DINA(DIN_44), .ADDRA(ADDR_44), .WEA(WEA_44), .DOUTA(DOUTA_44), .M(644), .ENA(ENA_44) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_45( .clk(clk),  .rst_n(rst_n), .DINA(DIN_45), .ADDRA(ADDR_45), .WEA(WEA_45), .DOUTA(DOUTA_45), .M(645), .ENA(ENA_45) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_46( .clk(clk),  .rst_n(rst_n), .DINA(DIN_46), .ADDRA(ADDR_46), .WEA(WEA_46), .DOUTA(DOUTA_46), .M(646), .ENA(ENA_46) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_47( .clk(clk),  .rst_n(rst_n), .DINA(DIN_47), .ADDRA(ADDR_47), .WEA(WEA_47), .DOUTA(DOUTA_47), .M(647), .ENA(ENA_47) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_48( .clk(clk),  .rst_n(rst_n), .DINA(DIN_48), .ADDRA(ADDR_48), .WEA(WEA_48), .DOUTA(DOUTA_48), .M(648), .ENA(ENA_48) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_49( .clk(clk),  .rst_n(rst_n), .DINA(DIN_49), .ADDRA(ADDR_49), .WEA(WEA_49), .DOUTA(DOUTA_49), .M(649), .ENA(ENA_49) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_50( .clk(clk),  .rst_n(rst_n), .DINA(DIN_50), .ADDRA(ADDR_50), .WEA(WEA_50), .DOUTA(DOUTA_50), .M(650), .ENA(ENA_50) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_51( .clk(clk),  .rst_n(rst_n), .DINA(DIN_51), .ADDRA(ADDR_51), .WEA(WEA_51), .DOUTA(DOUTA_51), .M(651), .ENA(ENA_51) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_52( .clk(clk),  .rst_n(rst_n), .DINA(DIN_52), .ADDRA(ADDR_52), .WEA(WEA_52), .DOUTA(DOUTA_52), .M(652), .ENA(ENA_52) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_53( .clk(clk),  .rst_n(rst_n), .DINA(DIN_53), .ADDRA(ADDR_53), .WEA(WEA_53), .DOUTA(DOUTA_53), .M(653), .ENA(ENA_53) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_54( .clk(clk),  .rst_n(rst_n), .DINA(DIN_54), .ADDRA(ADDR_54), .WEA(WEA_54), .DOUTA(DOUTA_54), .M(654), .ENA(ENA_54) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_55( .clk(clk),  .rst_n(rst_n), .DINA(DIN_55), .ADDRA(ADDR_55), .WEA(WEA_55), .DOUTA(DOUTA_55), .M(655), .ENA(ENA_55) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_56( .clk(clk),  .rst_n(rst_n), .DINA(DIN_56), .ADDRA(ADDR_56), .WEA(WEA_56), .DOUTA(DOUTA_56), .M(656), .ENA(ENA_56) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_57( .clk(clk),  .rst_n(rst_n), .DINA(DIN_57), .ADDRA(ADDR_57), .WEA(WEA_57), .DOUTA(DOUTA_57), .M(657), .ENA(ENA_57) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_58( .clk(clk),  .rst_n(rst_n), .DINA(DIN_58), .ADDRA(ADDR_58), .WEA(WEA_58), .DOUTA(DOUTA_58), .M(658), .ENA(ENA_58) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_59( .clk(clk),  .rst_n(rst_n), .DINA(DIN_59), .ADDRA(ADDR_59), .WEA(WEA_59), .DOUTA(DOUTA_59), .M(659), .ENA(ENA_59) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_60( .clk(clk),  .rst_n(rst_n), .DINA(DIN_60), .ADDRA(ADDR_60), .WEA(WEA_60), .DOUTA(DOUTA_60), .M(660), .ENA(ENA_60) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_61( .clk(clk),  .rst_n(rst_n), .DINA(DIN_61), .ADDRA(ADDR_61), .WEA(WEA_61), .DOUTA(DOUTA_61), .M(661), .ENA(ENA_61) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_62( .clk(clk),  .rst_n(rst_n), .DINA(DIN_62), .ADDRA(ADDR_62), .WEA(WEA_62), .DOUTA(DOUTA_62), .M(662), .ENA(ENA_62) );
//SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_63( .clk(clk),  .rst_n(rst_n), .DINA(DIN_63), .ADDRA(ADDR_63), .WEA(WEA_63), .DOUTA(DOUTA_63), .M(663), .ENA(ENA_63) );


endmodule
