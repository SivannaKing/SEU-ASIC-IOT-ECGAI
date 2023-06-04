`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 21:43:05
// Design Name: 
// Module Name: Block3_Top
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


module Block3_Top(
    input                           clk,
    input                           rst_n,
    input             wire          Bout_0, Bout_1, Bout_2,  Bout_3,  Bout_4,  Bout_5,  Bout_6,  Bout_7,
                                    Bout_8, Bout_9, Bout_10, Bout_11, Bout_12, Bout_13, Bout_14, Bout_15,
    input             wire          Bout_0_Val,
    output            wire          B3_Bout_0, B3_Bout_1, B3_Bout_2, B3_Bout_3, B3_Bout_4, B3_Bout_5, B3_Bout_6, B3_Bout_7, 
                                    B3_Bout_8, B3_Bout_9, B3_Bout_10, B3_Bout_11, B3_Bout_12, B3_Bout_13, B3_Bout_14, B3_Bout_15, 
                                    B3_Bout_16, B3_Bout_17, B3_Bout_18, B3_Bout_19, B3_Bout_20, B3_Bout_21, B3_Bout_22, B3_Bout_23, 
                                    B3_Bout_24, B3_Bout_25, B3_Bout_26, B3_Bout_27, B3_Bout_28, B3_Bout_29, B3_Bout_30, B3_Bout_31,
    output            wire          B3_Bout_0_Val, B3_o_0_val
);

wire            [31:0]          RAM_DIN_0, RAM_DIN_1, RAM_DIN_2,  RAM_DIN_3,  RAM_DIN_4,  RAM_DIN_5,  RAM_DIN_6,  RAM_DIN_7, 
                                RAM_DIN_8, RAM_DIN_9, RAM_DIN_10, RAM_DIN_11, RAM_DIN_12, RAM_DIN_13, RAM_DIN_14, RAM_DIN_15;
wire            [3:0]           IB_Con_RAM_ADDR_0,  IB_Con_RAM_ADDR_1,  IB_Con_RAM_ADDR_2,   IB_Con_RAM_ADDR_3, 
                                IB_Con_RAM_ADDR_4,  IB_Con_RAM_ADDR_5,  IB_Con_RAM_ADDR_6,   IB_Con_RAM_ADDR_7, 
                                IB_Con_RAM_ADDR_8,  IB_Con_RAM_ADDR_9,  IB_Con_RAM_ADDR_10,  IB_Con_RAM_ADDR_11, 
                                IB_Con_RAM_ADDR_12, IB_Con_RAM_ADDR_13, IB_Con_RAM_ADDR_14,  IB_Con_RAM_ADDR_15;  
wire                            IB_Con_RAM_WEA_0, IB_Con_RAM_WEA_1, IB_Con_RAM_WEA_2, IB_Con_RAM_WEA_3, IB_Con_RAM_WEA_4, IB_Con_RAM_WEA_5, IB_Con_RAM_WEA_6, IB_Con_RAM_WEA_7, 
                                IB_Con_RAM_WEA_8, IB_Con_RAM_WEA_9, IB_Con_RAM_WEA_10, IB_Con_RAM_WEA_11, IB_Con_RAM_WEA_12, IB_Con_RAM_WEA_13, IB_Con_RAM_WEA_14, IB_Con_RAM_WEA_15; 
                                
wire                            IB_Addr_Contr_B3_work, IB_Addr_Contr_B3_work_Done;
wire            [3:0]           SWU_ADDR;
wire                            SWU_WEA;




IB_Addr_Contr_B3 IB_Con_3(  .clk(clk),
                            .rst_n(rst_n),
                            .B2_Bout_0_Val(Bout_0_Val),
                            .Bin_0(Bout_0),   .Bin_1(Bout_1),   .Bin_2(Bout_2),   .Bin_3(Bout_3), 
                            .Bin_4(Bout_4),   .Bin_5(Bout_5),   .Bin_6(Bout_6),   .Bin_7(Bout_7),
                            .Bin_8(Bout_8),   .Bin_9(Bout_9),   .Bin_10(Bout_10), .Bin_11(Bout_11), 
                            .Bin_12(Bout_12), .Bin_13(Bout_13), .Bin_14(Bout_14), .Bin_15(Bout_15),
                            .Dout_0(RAM_DIN_0),  .Dout_1(RAM_DIN_1), .Dout_2(RAM_DIN_2),   .Dout_3(RAM_DIN_3),   .Dout_4(RAM_DIN_4),   .Dout_5(RAM_DIN_5),   .Dout_6(RAM_DIN_6),   .Dout_7(RAM_DIN_7),
                            .Dout_8(RAM_DIN_8),  .Dout_9(RAM_DIN_9), .Dout_10(RAM_DIN_10), .Dout_11(RAM_DIN_11), .Dout_12(RAM_DIN_12), .Dout_13(RAM_DIN_13), .Dout_14(RAM_DIN_14), .Dout_15(RAM_DIN_15),
                            .ADDR_0(IB_Con_RAM_ADDR_0), .ADDR_1(IB_Con_RAM_ADDR_1), .ADDR_2(IB_Con_RAM_ADDR_2), .ADDR_3(IB_Con_RAM_ADDR_3), .ADDR_4(IB_Con_RAM_ADDR_4), 
                            .ADDR_5(IB_Con_RAM_ADDR_5), .ADDR_6(IB_Con_RAM_ADDR_6), .ADDR_7(IB_Con_RAM_ADDR_7), .ADDR_8(IB_Con_RAM_ADDR_8), .ADDR_9(IB_Con_RAM_ADDR_9), 
                            .ADDR_10(IB_Con_RAM_ADDR_10), .ADDR_11(IB_Con_RAM_ADDR_11), .ADDR_12(IB_Con_RAM_ADDR_12), .ADDR_13(IB_Con_RAM_ADDR_13), .ADDR_14(IB_Con_RAM_ADDR_14), 
                            .ADDR_15(IB_Con_RAM_ADDR_15), 
                            .WEA_0(IB_Con_RAM_WEA_0),   .WEA_1(IB_Con_RAM_WEA_1),   .WEA_2(IB_Con_RAM_WEA_2),   .WEA_3(IB_Con_RAM_WEA_3), 
                            .WEA_4(IB_Con_RAM_WEA_4),   .WEA_5(IB_Con_RAM_WEA_5),   .WEA_6(IB_Con_RAM_WEA_6),   .WEA_7(IB_Con_RAM_WEA_7), 
                            .WEA_8(IB_Con_RAM_WEA_8),   .WEA_9(IB_Con_RAM_WEA_9),   .WEA_10(IB_Con_RAM_WEA_10), .WEA_11(IB_Con_RAM_WEA_11), 
                            .WEA_12(IB_Con_RAM_WEA_12), .WEA_13(IB_Con_RAM_WEA_13), .WEA_14(IB_Con_RAM_WEA_14), .WEA_15(IB_Con_RAM_WEA_15),  
                            .IB_Addr_Contr_B3_work(IB_Addr_Contr_B3_work), .IB_Addr_Contr_B3_work_Done(IB_Addr_Contr_B3_work_Done)
);

wire            [3:0]           ADDR_0, ADDR_1, ADDR_2,  ADDR_3,  ADDR_4,  ADDR_5,  ADDR_6,  ADDR_7, 
                                ADDR_8, ADDR_9, ADDR_10, ADDR_11, ADDR_12, ADDR_13, ADDR_14, ADDR_15;
wire                            WEA_0, WEA_1,  WEA_2,  WEA_3,  WEA_4,  WEA_5,  WEA_6,  WEA_7,
                                WEA_8, WEA_9,  WEA_10, WEA_11, WEA_12, WEA_13, WEA_14, WEA_15;
wire                            ENA_0, ENA_1,  ENA_2,  ENA_3,  ENA_4,  ENA_5,  ENA_6, ENA_7,
                                ENA_8, ENA_9,  ENA_10, ENA_11, ENA_12, ENA_13, ENA_14, ENA_15;
wire            [31:0]          DOUTA_0, DOUTA_1, DOUTA_2,  DOUTA_3,  DOUTA_4,  DOUTA_5,  DOUTA_6,  DOUTA_7, 
                                DOUTA_8, DOUTA_9, DOUTA_10, DOUTA_11, DOUTA_12, DOUTA_13, DOUTA_14, DOUTA_15;
                                
assign  ADDR_0  = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_0  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_1  = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_1  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_2  = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_2  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_3  = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_3  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_4  = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_4  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_5  = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_5  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_6  = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_6  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_7  = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_7  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_8  = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_8  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_9  = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_9  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_10 = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_10 : (SWU_work? SWU_ADDR : 0);
assign  ADDR_11 = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_11 : (SWU_work? SWU_ADDR : 0);
assign  ADDR_12 = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_12 : (SWU_work? SWU_ADDR : 0);
assign  ADDR_13 = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_13 : (SWU_work? SWU_ADDR : 0);
assign  ADDR_14 = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_14 : (SWU_work? SWU_ADDR : 0);
assign  ADDR_15 = IB_Addr_Contr_B3_work? IB_Con_RAM_ADDR_15 : (SWU_work? SWU_ADDR : 0);

assign  WEA_0   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_0   : (SWU_work? SWU_WEA : 0);
assign  WEA_1   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_1   : (SWU_work? SWU_WEA : 0);
assign  WEA_2   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_2   : (SWU_work? SWU_WEA : 0);
assign  WEA_3   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_3   : (SWU_work? SWU_WEA : 0);
assign  WEA_4   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_4   : (SWU_work? SWU_WEA : 0);
assign  WEA_5   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_5   : (SWU_work? SWU_WEA : 0);
assign  WEA_6   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_6   : (SWU_work? SWU_WEA : 0);
assign  WEA_7   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_7   : (SWU_work? SWU_WEA : 0);
assign  WEA_8   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_8   : (SWU_work? SWU_WEA : 0);
assign  WEA_9   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_9   : (SWU_work? SWU_WEA : 0);
assign  WEA_10  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_10  : (SWU_work? SWU_WEA : 0);
assign  WEA_11  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_11  : (SWU_work? SWU_WEA : 0);
assign  WEA_12  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_12  : (SWU_work? SWU_WEA : 0);
assign  WEA_13  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_13  : (SWU_work? SWU_WEA : 0);
assign  WEA_14  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_14  : (SWU_work? SWU_WEA : 0);
assign  WEA_15  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_15  : (SWU_work? SWU_WEA : 0);

assign  ENA_0   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_0   : (SWU_work? !SWU_WEA : 0);
assign  ENA_1   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_1   : (SWU_work? !SWU_WEA : 0);
assign  ENA_2   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_2   : (SWU_work? !SWU_WEA : 0);
assign  ENA_3   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_3   : (SWU_work? !SWU_WEA : 0);
assign  ENA_4   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_4   : (SWU_work? !SWU_WEA : 0);
assign  ENA_5   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_5   : (SWU_work? !SWU_WEA : 0);
assign  ENA_6   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_6   : (SWU_work? !SWU_WEA : 0);
assign  ENA_7   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_7   : (SWU_work? !SWU_WEA : 0);
assign  ENA_8   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_8   : (SWU_work? !SWU_WEA : 0);
assign  ENA_9   = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_9   : (SWU_work? !SWU_WEA : 0);
assign  ENA_10  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_10  : (SWU_work? !SWU_WEA : 0);
assign  ENA_11  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_11  : (SWU_work? !SWU_WEA : 0);
assign  ENA_12  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_12  : (SWU_work? !SWU_WEA : 0);
assign  ENA_13  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_13  : (SWU_work? !SWU_WEA : 0);
assign  ENA_14  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_14  : (SWU_work? !SWU_WEA : 0);
assign  ENA_15  = IB_Addr_Contr_B3_work? IB_Con_RAM_WEA_15  : (SWU_work? !SWU_WEA : 0);


Input_Buffer_B3 IB_3(       .clk(clk),
                            .rst_n(rst_n),
                            .DIN_0(RAM_DIN_0),   .DIN_1(RAM_DIN_1), .DIN_2(RAM_DIN_2),   .DIN_3(RAM_DIN_3),   .DIN_4(RAM_DIN_4),   .DIN_5(RAM_DIN_5),   .DIN_6(RAM_DIN_6),   .DIN_7(RAM_DIN_7),
                            .DIN_8(RAM_DIN_8),   .DIN_9(RAM_DIN_9), .DIN_10(RAM_DIN_10), .DIN_11(RAM_DIN_11), .DIN_12(RAM_DIN_12), .DIN_13(RAM_DIN_13), .DIN_14(RAM_DIN_14), .DIN_15(RAM_DIN_15), 
                            .ADDR_0(ADDR_0), .ADDR_1(ADDR_1), .ADDR_2(ADDR_2),   .ADDR_3(ADDR_3),   .ADDR_4(ADDR_4),   .ADDR_5(ADDR_5),   .ADDR_6(ADDR_6),   .ADDR_7(ADDR_7),
                            .ADDR_8(ADDR_8), .ADDR_9(ADDR_9), .ADDR_10(ADDR_10), .ADDR_11(ADDR_11), .ADDR_12(ADDR_12), .ADDR_13(ADDR_13), .ADDR_14(ADDR_14), .ADDR_15(ADDR_15),
                            .WEA_0(WEA_0),   .WEA_1(WEA_1),   .WEA_2(WEA_2),     .WEA_3(WEA_3),     .WEA_4(WEA_4),     .WEA_5(WEA_5),     .WEA_6(WEA_6),     .WEA_7(WEA_7),
                            .WEA_8(WEA_8),   .WEA_9(WEA_9),   .WEA_10(WEA_10),   .WEA_11(WEA_11),   .WEA_12(WEA_12),   .WEA_13(WEA_13),   .WEA_14(WEA_14),   .WEA_15(WEA_15),
                            .ENA_0(ENA_0),   .ENA_1(ENA_1),   .ENA_2(ENA_2),     .ENA_3(ENA_3),     .ENA_4(ENA_4),     .ENA_5(ENA_5),     .ENA_6(ENA_6),     .ENA_7(ENA_7),
                            .ENA_8(ENA_8),   .ENA_9(ENA_9),   .ENA_10(ENA_10),   .ENA_11(ENA_11),   .ENA_12(ENA_12),   .ENA_13(ENA_13),   .ENA_14(ENA_14),   .ENA_15(ENA_15),
                            .DOUTA_0(DOUTA_0), .DOUTA_1(DOUTA_1), .DOUTA_2(DOUTA_2),   .DOUTA_3(DOUTA_3),   .DOUTA_4(DOUTA_4),   .DOUTA_5(DOUTA_5),   .DOUTA_6(DOUTA_6),   .DOUTA_7(DOUTA_7),
                            .DOUTA_8(DOUTA_8), .DOUTA_9(DOUTA_9), .DOUTA_10(DOUTA_10), .DOUTA_11(DOUTA_11), .DOUTA_12(DOUTA_12), .DOUTA_13(DOUTA_13), .DOUTA_14(DOUTA_14), .DOUTA_15(DOUTA_15)
);  
wire    [6:0]       w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7, w_8, w_9, w_10, w_11, w_12, w_13, w_14, w_15;
wire    [31:0]      new_weight_val;
wire                Weight_Trans_Done;
Weight_Control_B3 WC_B3(    .clk(clk),  .rst_n(IB_Addr_Contr_B3_work_Done),
                            .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                            .w_8(w_8), .w_9(w_9), .w_10(w_10), .w_11(w_11), .w_12(w_12), .w_13(w_13), .w_14(w_14), .w_15(w_15),
                            .new_weight_val(new_weight_val),
                            .Weight_Trans_Done(Weight_Trans_Done)
);

wire      [ 6:0]     Slide_data_0, Slide_data_1, Slide_data_2,  Slide_data_3,  Slide_data_4,  Slide_data_5,  Slide_data_6,  Slide_data_7,
                     Slide_data_8, Slide_data_9, Slide_data_10, Slide_data_11, Slide_data_12, Slide_data_13, Slide_data_14, Slide_data_15;

wire                PE_EN;
IB_SWU_Addr_Contr_B3 SWU_B3(    .clk(clk),       .rst_n(Weight_Trans_Done), 
                                .DIN_0(DOUTA_0), .DIN_1(DOUTA_1), .DIN_2(DOUTA_2), .DIN_3(DOUTA_3), 
                                .DIN_4(DOUTA_4), .DIN_5(DOUTA_5), .DIN_6(DOUTA_6), .DIN_7(DOUTA_7),
                                .DIN_8(DOUTA_8), .DIN_9(DOUTA_9), .DIN_10(DOUTA_10), .DIN_11(DOUTA_11), 
                                .DIN_12(DOUTA_12), .DIN_13(DOUTA_13), .DIN_14(DOUTA_14), .DIN_15(DOUTA_15),
                                .ADDR(SWU_ADDR), .WEA(SWU_WEA),   .IB_Addr_SWU_work(SWU_work),   .IB_Addr_SWU_work_Done(SWU_work_Done),
                                .Slide_data_0(Slide_data_0), .Slide_data_1(Slide_data_1), .Slide_data_2(Slide_data_2),   .Slide_data_3(Slide_data_3),
                                .Slide_data_4(Slide_data_4), .Slide_data_5(Slide_data_5), .Slide_data_6(Slide_data_6),   .Slide_data_7(Slide_data_7),
                                .Slide_data_8(Slide_data_8), .Slide_data_9(Slide_data_9), .Slide_data_10(Slide_data_10), .Slide_data_11(Slide_data_11),
                                .Slide_data_12(Slide_data_12), .Slide_data_13(Slide_data_13), .Slide_data_14(Slide_data_14), .Slide_data_15(Slide_data_15),
                                .PE_EN(PE_EN)
);


wire signed [7:0]   o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7, o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15,
                    o_16, o_17, o_18, o_19, o_20, o_21, o_22, o_23, o_24, o_25, o_26, o_27, o_28, o_29, o_30, o_31;

PE_Array_B3  PE_Array_Block3(   .clk(clk), .rst_n(PE_EN), .new_weight_val(new_weight_val), 
                                .Slide_data_0(Slide_data_0), .Slide_data_1(Slide_data_1), .Slide_data_2(Slide_data_2), .Slide_data_3(Slide_data_3),
                                .Slide_data_4(Slide_data_4), .Slide_data_5(Slide_data_5), .Slide_data_6(Slide_data_6), .Slide_data_7(Slide_data_7),
                                .Slide_data_8(Slide_data_8), .Slide_data_9(Slide_data_9), .Slide_data_10(Slide_data_10), .Slide_data_11(Slide_data_11),
                                .Slide_data_12(Slide_data_12), .Slide_data_13(Slide_data_13), .Slide_data_14(Slide_data_14), .Slide_data_15(Slide_data_15),
                                .o_0(o_0), .o_1(o_1), .o_2(o_2),   .o_3(o_3),   .o_4(o_4),   .o_5(o_5),   .o_6(o_6),   .o_7(o_7),
                                .o_8(o_8), .o_9(o_9), .o_10(o_10), .o_11(o_11), .o_12(o_12), .o_13(o_13), .o_14(o_14), .o_15(o_15),
                                .o_16(o_16), .o_17(o_17), .o_18(o_18), .o_19(o_19), .o_20(o_20), .o_21(o_21), .o_22(o_22), .o_23(o_23),
                                .o_24(o_24), .o_25(o_25), .o_26(o_26), .o_27(o_27), .o_28(o_28), .o_29(o_29), .o_30(o_30), .o_31(o_31),
                                .o_0_val(B3_o_0_val),
                                .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                                .w_8(w_8), .w_9(w_9), .w_10(w_10), .w_11(w_11), .w_12(w_12), .w_13(w_13), .w_14(w_14), .w_15(w_15)
);

Maxpool_Thre_B3 MP_Thre(.clk(clk), .rst_n(rst_n), 
                        .o_0(o_0), .o_1(o_1), .o_2(o_2),   .o_3(o_3),   .o_4(o_4),   .o_5(o_5),   .o_6(o_6),   .o_7(o_7),
                        .o_8(o_8), .o_9(o_9), .o_10(o_10), .o_11(o_11), .o_12(o_12), .o_13(o_13), .o_14(o_14), .o_15(o_15),
                        .o_16(o_16), .o_17(o_17), .o_18(o_18), .o_19(o_19), .o_20(o_20), .o_21(o_21), .o_22(o_22), .o_23(o_23),
                        .o_24(o_24), .o_25(o_25), .o_26(o_26), .o_27(o_27), .o_28(o_28), .o_29(o_29), .o_30(o_30), .o_31(o_31),
                        .o_0_val(B3_o_0_val),
                        .Bout_0(B3_Bout_0),   .Bout_1(B3_Bout_1),   .Bout_2(B3_Bout_2),   .Bout_3(B3_Bout_3),   .Bout_4(B3_Bout_4), 
                        .Bout_5(B3_Bout_5),   .Bout_6(B3_Bout_6),   .Bout_7(B3_Bout_7),   .Bout_8(B3_Bout_8),   .Bout_9(B3_Bout_9), 
                        .Bout_10(B3_Bout_10), .Bout_11(B3_Bout_11), .Bout_12(B3_Bout_12), .Bout_13(B3_Bout_13), .Bout_14(B3_Bout_14), 
                        .Bout_15(B3_Bout_15), .Bout_16(B3_Bout_16), .Bout_17(B3_Bout_17), .Bout_18(B3_Bout_18), .Bout_19(B3_Bout_19), 
                        .Bout_20(B3_Bout_20), .Bout_21(B3_Bout_21), .Bout_22(B3_Bout_22), .Bout_23(B3_Bout_23), .Bout_24(B3_Bout_24), 
                        .Bout_25(B3_Bout_25), .Bout_26(B3_Bout_26), .Bout_27(B3_Bout_27), .Bout_28(B3_Bout_28), .Bout_29(B3_Bout_29), 
                        .Bout_30(B3_Bout_30), .Bout_31(B3_Bout_31), 
                        .Bout_0_Val(B3_Bout_0_Val)
                        );

endmodule
