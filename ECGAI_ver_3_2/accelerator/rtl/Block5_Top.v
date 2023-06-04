`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/07 20:43:20
// Design Name: 
// Module Name: Block5_Top
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


module Block5_Top(
    input                           clk,
    input                           rst_n,
    input           wire            Bin_0, Bin_1, Bin_2, Bin_3, Bin_4, Bin_5, Bin_6, Bin_7, 
                                    Bin_8, Bin_9, Bin_10, Bin_11, Bin_12, Bin_13, Bin_14, Bin_15, 
                                    Bin_16, Bin_17, Bin_18, Bin_19, Bin_20, Bin_21, Bin_22, Bin_23, 
                                    Bin_24, Bin_25, Bin_26, Bin_27, Bin_28, Bin_29, Bin_30, Bin_31,
    input           wire            Bin_0_Val,
    
    output          wire            B5_o_0_val, B5_Bout_0_Val,
    output          wire            B5_Bout_0, B5_Bout_1, B5_Bout_2, B5_Bout_3, B5_Bout_4, B5_Bout_5, B5_Bout_6, B5_Bout_7, B5_Bout_8, B5_Bout_9, B5_Bout_10, B5_Bout_11, B5_Bout_12, B5_Bout_13, B5_Bout_14, B5_Bout_15, 
                                    B5_Bout_16, B5_Bout_17, B5_Bout_18, B5_Bout_19, B5_Bout_20, B5_Bout_21, B5_Bout_22, B5_Bout_23, B5_Bout_24, B5_Bout_25, B5_Bout_26, B5_Bout_27, B5_Bout_28, B5_Bout_29, B5_Bout_30, B5_Bout_31, 
                                    B5_Bout_32, B5_Bout_33, B5_Bout_34, B5_Bout_35, B5_Bout_36, B5_Bout_37, B5_Bout_38, B5_Bout_39, B5_Bout_40, B5_Bout_41, B5_Bout_42, B5_Bout_43, B5_Bout_44, B5_Bout_45, B5_Bout_46, B5_Bout_47, 
                                    B5_Bout_48, B5_Bout_49, B5_Bout_50, B5_Bout_51, B5_Bout_52, B5_Bout_53, B5_Bout_54, B5_Bout_55, B5_Bout_56, B5_Bout_57, B5_Bout_58, B5_Bout_59, B5_Bout_60, B5_Bout_61, B5_Bout_62, B5_Bout_63
);
wire            [31:0]          RAM_DIN_0, RAM_DIN_1, RAM_DIN_2,  RAM_DIN_3,  RAM_DIN_4,  RAM_DIN_5,  RAM_DIN_6,  RAM_DIN_7, 
                                RAM_DIN_8, RAM_DIN_9, RAM_DIN_10, RAM_DIN_11, RAM_DIN_12, RAM_DIN_13, RAM_DIN_14, RAM_DIN_15,
                                RAM_DIN_16, RAM_DIN_17, RAM_DIN_18, RAM_DIN_19, RAM_DIN_20, RAM_DIN_21, RAM_DIN_22, RAM_DIN_23, 
                                RAM_DIN_24, RAM_DIN_25, RAM_DIN_26, RAM_DIN_27, RAM_DIN_28, RAM_DIN_29, RAM_DIN_30, RAM_DIN_31;
wire            [2:0]           IB_Con_RAM_ADDR_0,  IB_Con_RAM_ADDR_1,  IB_Con_RAM_ADDR_2,   IB_Con_RAM_ADDR_3, 
                                IB_Con_RAM_ADDR_4,  IB_Con_RAM_ADDR_5,  IB_Con_RAM_ADDR_6,   IB_Con_RAM_ADDR_7, 
                                IB_Con_RAM_ADDR_8,  IB_Con_RAM_ADDR_9,  IB_Con_RAM_ADDR_10,  IB_Con_RAM_ADDR_11, 
                                IB_Con_RAM_ADDR_12, IB_Con_RAM_ADDR_13, IB_Con_RAM_ADDR_14,  IB_Con_RAM_ADDR_15,
                                IB_Con_RAM_ADDR_16, IB_Con_RAM_ADDR_17, IB_Con_RAM_ADDR_18, IB_Con_RAM_ADDR_19, 
                                IB_Con_RAM_ADDR_20, IB_Con_RAM_ADDR_21, IB_Con_RAM_ADDR_22, IB_Con_RAM_ADDR_23, 
                                IB_Con_RAM_ADDR_24, IB_Con_RAM_ADDR_25, IB_Con_RAM_ADDR_26, IB_Con_RAM_ADDR_27, 
                                IB_Con_RAM_ADDR_28, IB_Con_RAM_ADDR_29, IB_Con_RAM_ADDR_30, IB_Con_RAM_ADDR_31;
                                   
wire                            IB_Con_RAM_WEA_0, IB_Con_RAM_WEA_1, IB_Con_RAM_WEA_2, IB_Con_RAM_WEA_3, IB_Con_RAM_WEA_4, IB_Con_RAM_WEA_5, IB_Con_RAM_WEA_6, IB_Con_RAM_WEA_7, 
                                IB_Con_RAM_WEA_8, IB_Con_RAM_WEA_9, IB_Con_RAM_WEA_10, IB_Con_RAM_WEA_11, IB_Con_RAM_WEA_12, IB_Con_RAM_WEA_13, IB_Con_RAM_WEA_14, IB_Con_RAM_WEA_15,
                                IB_Con_RAM_WEA_16, IB_Con_RAM_WEA_17, IB_Con_RAM_WEA_18, IB_Con_RAM_WEA_19, IB_Con_RAM_WEA_20, IB_Con_RAM_WEA_21, IB_Con_RAM_WEA_22, IB_Con_RAM_WEA_23, 
                                IB_Con_RAM_WEA_24, IB_Con_RAM_WEA_25, IB_Con_RAM_WEA_26, IB_Con_RAM_WEA_27, IB_Con_RAM_WEA_28, IB_Con_RAM_WEA_29, IB_Con_RAM_WEA_30, IB_Con_RAM_WEA_31;
                                
wire                            IB_Addr_Contr_B5_work, IB_Addr_Contr_B5_work_Done; 

IB_Addr_Contr_B5 IB_Con_5(  .clk(clk),
                            .rst_n(rst_n),
                            .Bin_0_Val(Bin_0_Val),
                            .Bin_0(Bin_0), .Bin_1(Bin_1), .Bin_2(Bin_2), .Bin_3(Bin_3), .Bin_4(Bin_4), .Bin_5(Bin_5), .Bin_6(Bin_6), .Bin_7(Bin_7), 
                            .Bin_8(Bin_8), .Bin_9(Bin_9), .Bin_10(Bin_10), .Bin_11(Bin_11), .Bin_12(Bin_12), .Bin_13(Bin_13), .Bin_14(Bin_14), .Bin_15(Bin_15), 
                            .Bin_16(Bin_16), .Bin_17(Bin_17), .Bin_18(Bin_18), .Bin_19(Bin_19), .Bin_20(Bin_20), .Bin_21(Bin_21), .Bin_22(Bin_22), .Bin_23(Bin_23), 
                            .Bin_24(Bin_24), .Bin_25(Bin_25), .Bin_26(Bin_26), .Bin_27(Bin_27), .Bin_28(Bin_28), .Bin_29(Bin_29), .Bin_30(Bin_30), .Bin_31(Bin_31),   
                            .Dout_0(RAM_DIN_0),  .Dout_1(RAM_DIN_1), .Dout_2(RAM_DIN_2),   .Dout_3(RAM_DIN_3),   .Dout_4(RAM_DIN_4),   .Dout_5(RAM_DIN_5),   .Dout_6(RAM_DIN_6),   .Dout_7(RAM_DIN_7),
                            .Dout_8(RAM_DIN_8),  .Dout_9(RAM_DIN_9), .Dout_10(RAM_DIN_10), .Dout_11(RAM_DIN_11), .Dout_12(RAM_DIN_12), .Dout_13(RAM_DIN_13), .Dout_14(RAM_DIN_14), .Dout_15(RAM_DIN_15),
                            .Dout_16(RAM_DIN_16), .Dout_17(RAM_DIN_17), .Dout_18(RAM_DIN_18), .Dout_19(RAM_DIN_19), .Dout_20(RAM_DIN_20), .Dout_21(RAM_DIN_21), .Dout_22(RAM_DIN_22), .Dout_23(RAM_DIN_23), 
                            .Dout_24(RAM_DIN_24), .Dout_25(RAM_DIN_25), .Dout_26(RAM_DIN_26), .Dout_27(RAM_DIN_27), .Dout_28(RAM_DIN_28), .Dout_29(RAM_DIN_29), .Dout_30(RAM_DIN_30), .Dout_31(RAM_DIN_31),
                            .ADDR_0(IB_Con_RAM_ADDR_0), .ADDR_1(IB_Con_RAM_ADDR_1), .ADDR_2(IB_Con_RAM_ADDR_2), .ADDR_3(IB_Con_RAM_ADDR_3), .ADDR_4(IB_Con_RAM_ADDR_4), .ADDR_5(IB_Con_RAM_ADDR_5), .ADDR_6(IB_Con_RAM_ADDR_6), .ADDR_7(IB_Con_RAM_ADDR_7), 
                            .ADDR_8(IB_Con_RAM_ADDR_8), .ADDR_9(IB_Con_RAM_ADDR_9), .ADDR_10(IB_Con_RAM_ADDR_10), .ADDR_11(IB_Con_RAM_ADDR_11), .ADDR_12(IB_Con_RAM_ADDR_12), .ADDR_13(IB_Con_RAM_ADDR_13), .ADDR_14(IB_Con_RAM_ADDR_14), .ADDR_15(IB_Con_RAM_ADDR_15),
                            .ADDR_16(IB_Con_RAM_ADDR_16), .ADDR_17(IB_Con_RAM_ADDR_17), .ADDR_18(IB_Con_RAM_ADDR_18), .ADDR_19(IB_Con_RAM_ADDR_19), .ADDR_20(IB_Con_RAM_ADDR_20), .ADDR_21(IB_Con_RAM_ADDR_21), .ADDR_22(IB_Con_RAM_ADDR_22), .ADDR_23(IB_Con_RAM_ADDR_23), 
                            .ADDR_24(IB_Con_RAM_ADDR_24), .ADDR_25(IB_Con_RAM_ADDR_25), .ADDR_26(IB_Con_RAM_ADDR_26), .ADDR_27(IB_Con_RAM_ADDR_27), .ADDR_28(IB_Con_RAM_ADDR_28), .ADDR_29(IB_Con_RAM_ADDR_29), .ADDR_30(IB_Con_RAM_ADDR_30), .ADDR_31(IB_Con_RAM_ADDR_31), 
                            .WEA_0(IB_Con_RAM_WEA_0),   .WEA_1(IB_Con_RAM_WEA_1),   .WEA_2(IB_Con_RAM_WEA_2),   .WEA_3(IB_Con_RAM_WEA_3), 
                            .WEA_4(IB_Con_RAM_WEA_4),   .WEA_5(IB_Con_RAM_WEA_5),   .WEA_6(IB_Con_RAM_WEA_6),   .WEA_7(IB_Con_RAM_WEA_7), 
                            .WEA_8(IB_Con_RAM_WEA_8),   .WEA_9(IB_Con_RAM_WEA_9),   .WEA_10(IB_Con_RAM_WEA_10), .WEA_11(IB_Con_RAM_WEA_11), 
                            .WEA_12(IB_Con_RAM_WEA_12), .WEA_13(IB_Con_RAM_WEA_13), .WEA_14(IB_Con_RAM_WEA_14), .WEA_15(IB_Con_RAM_WEA_15),
                            .WEA_16(IB_Con_RAM_WEA_16), .WEA_17(IB_Con_RAM_WEA_17), .WEA_18(IB_Con_RAM_WEA_18), .WEA_19(IB_Con_RAM_WEA_19), 
                            .WEA_20(IB_Con_RAM_WEA_20), .WEA_21(IB_Con_RAM_WEA_21), .WEA_22(IB_Con_RAM_WEA_22), .WEA_23(IB_Con_RAM_WEA_23), 
                            .WEA_24(IB_Con_RAM_WEA_24), .WEA_25(IB_Con_RAM_WEA_25), .WEA_26(IB_Con_RAM_WEA_26), .WEA_27(IB_Con_RAM_WEA_27), 
                            .WEA_28(IB_Con_RAM_WEA_28), .WEA_29(IB_Con_RAM_WEA_29), .WEA_30(IB_Con_RAM_WEA_30), .WEA_31(IB_Con_RAM_WEA_31), 
                            .IB_Addr_Contr_B5_work(IB_Addr_Contr_B5_work), .IB_Addr_Contr_B5_work_Done(IB_Addr_Contr_B5_work_Done)
);

wire            [2:0]           ADDR_0, ADDR_1, ADDR_2,  ADDR_3,  ADDR_4,  ADDR_5,  ADDR_6,  ADDR_7, 
                                ADDR_8, ADDR_9, ADDR_10, ADDR_11, ADDR_12, ADDR_13, ADDR_14, ADDR_15,
                                ADDR_16, ADDR_17, ADDR_18, ADDR_19, ADDR_20, ADDR_21, ADDR_22, ADDR_23, 
                                ADDR_24, ADDR_25, ADDR_26, ADDR_27, ADDR_28, ADDR_29, ADDR_30, ADDR_31;
wire                            WEA_0, WEA_1,  WEA_2,  WEA_3,  WEA_4,  WEA_5,  WEA_6,  WEA_7,
                                WEA_8, WEA_9,  WEA_10, WEA_11, WEA_12, WEA_13, WEA_14, WEA_15,
                                WEA_16, WEA_17, WEA_18, WEA_19, WEA_20, WEA_21, WEA_22, WEA_23, 
                                WEA_24, WEA_25, WEA_26, WEA_27, WEA_28, WEA_29, WEA_30, WEA_31;
wire                            ENA_0, ENA_1,  ENA_2,  ENA_3,  ENA_4,  ENA_5,  ENA_6, ENA_7,
                                ENA_8, ENA_9,  ENA_10, ENA_11, ENA_12, ENA_13, ENA_14, ENA_15,
                                ENA_16, ENA_17, ENA_18, ENA_19, ENA_20, ENA_21, ENA_22, ENA_23, 
                                ENA_24, ENA_25, ENA_26, ENA_27, ENA_28, ENA_29, ENA_30, ENA_31;
wire            [31:0]          DOUTA_0, DOUTA_1, DOUTA_2,  DOUTA_3,  DOUTA_4,  DOUTA_5,  DOUTA_6,  DOUTA_7, 
                                DOUTA_8, DOUTA_9, DOUTA_10, DOUTA_11, DOUTA_12, DOUTA_13, DOUTA_14, DOUTA_15,
                                DOUTA_16, DOUTA_17, DOUTA_18, DOUTA_19, DOUTA_20, DOUTA_21, DOUTA_22, DOUTA_23, 
                                DOUTA_24, DOUTA_25, DOUTA_26, DOUTA_27, DOUTA_28, DOUTA_29, DOUTA_30, DOUTA_31;
//SWU
wire                            SWU_work, SWU_WEA, SWU_work_Done;
wire            [2:0]           SWU_ADDR;

assign  ADDR_0  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_0  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_1  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_1  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_2  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_2  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_3  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_3  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_4  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_4  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_5  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_5  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_6  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_6  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_7  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_7  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_8  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_8  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_9  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_9  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_10  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_10  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_11  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_11  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_12  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_12  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_13  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_13  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_14  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_14  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_15  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_15  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_16  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_16  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_17  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_17  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_18  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_18  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_19  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_19  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_20  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_20  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_21  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_21  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_22  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_22  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_23  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_23  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_24  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_24  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_25  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_25  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_26  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_26  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_27  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_27  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_28  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_28  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_29  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_29  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_30  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_30  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_31  = IB_Addr_Contr_B5_work? IB_Con_RAM_ADDR_31  : (SWU_work? SWU_ADDR : 0);


assign  WEA_0   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_0   : (SWU_work? SWU_WEA : 0);
assign  WEA_1   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_1   : (SWU_work? SWU_WEA : 0);
assign  WEA_2   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_2   : (SWU_work? SWU_WEA : 0);
assign  WEA_3   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_3   : (SWU_work? SWU_WEA : 0);
assign  WEA_4   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_4   : (SWU_work? SWU_WEA : 0);
assign  WEA_5   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_5   : (SWU_work? SWU_WEA : 0);
assign  WEA_6   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_6   : (SWU_work? SWU_WEA : 0);
assign  WEA_7   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_7   : (SWU_work? SWU_WEA : 0);
assign  WEA_8   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_8   : (SWU_work? SWU_WEA : 0);
assign  WEA_9   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_9   : (SWU_work? SWU_WEA : 0);
assign  WEA_10   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_10   : (SWU_work? SWU_WEA : 0);
assign  WEA_11   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_11   : (SWU_work? SWU_WEA : 0);
assign  WEA_12   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_12   : (SWU_work? SWU_WEA : 0);
assign  WEA_13   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_13   : (SWU_work? SWU_WEA : 0);
assign  WEA_14   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_14   : (SWU_work? SWU_WEA : 0);
assign  WEA_15   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_15   : (SWU_work? SWU_WEA : 0);
assign  WEA_16   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_16   : (SWU_work? SWU_WEA : 0);
assign  WEA_17   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_17   : (SWU_work? SWU_WEA : 0);
assign  WEA_18   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_18   : (SWU_work? SWU_WEA : 0);
assign  WEA_19   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_19   : (SWU_work? SWU_WEA : 0);
assign  WEA_20   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_20   : (SWU_work? SWU_WEA : 0);
assign  WEA_21   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_21   : (SWU_work? SWU_WEA : 0);
assign  WEA_22   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_22   : (SWU_work? SWU_WEA : 0);
assign  WEA_23   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_23   : (SWU_work? SWU_WEA : 0);
assign  WEA_24   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_24   : (SWU_work? SWU_WEA : 0);
assign  WEA_25   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_25   : (SWU_work? SWU_WEA : 0);
assign  WEA_26   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_26   : (SWU_work? SWU_WEA : 0);
assign  WEA_27   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_27   : (SWU_work? SWU_WEA : 0);
assign  WEA_28   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_28   : (SWU_work? SWU_WEA : 0);
assign  WEA_29   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_29   : (SWU_work? SWU_WEA : 0);
assign  WEA_30   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_30   : (SWU_work? SWU_WEA : 0);
assign  WEA_31   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_31   : (SWU_work? SWU_WEA : 0);

assign  ENA_0   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_0   : (SWU_work? !SWU_WEA : 0);
assign  ENA_1   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_1   : (SWU_work? !SWU_WEA : 0);
assign  ENA_2   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_2   : (SWU_work? !SWU_WEA : 0);
assign  ENA_3   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_3   : (SWU_work? !SWU_WEA : 0);
assign  ENA_4   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_4   : (SWU_work? !SWU_WEA : 0);
assign  ENA_5   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_5   : (SWU_work? !SWU_WEA : 0);
assign  ENA_6   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_6   : (SWU_work? !SWU_WEA : 0);
assign  ENA_7   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_7   : (SWU_work? !SWU_WEA : 0);
assign  ENA_8   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_8   : (SWU_work? !SWU_WEA : 0);
assign  ENA_9   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_9   : (SWU_work? !SWU_WEA : 0);
assign  ENA_10   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_10   : (SWU_work? !SWU_WEA : 0);
assign  ENA_11   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_11   : (SWU_work? !SWU_WEA : 0);
assign  ENA_12   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_12   : (SWU_work? !SWU_WEA : 0);
assign  ENA_13   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_13   : (SWU_work? !SWU_WEA : 0);
assign  ENA_14   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_14   : (SWU_work? !SWU_WEA : 0);
assign  ENA_15   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_15   : (SWU_work? !SWU_WEA : 0);
assign  ENA_16   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_16   : (SWU_work? !SWU_WEA : 0);
assign  ENA_17   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_17   : (SWU_work? !SWU_WEA : 0);
assign  ENA_18   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_18   : (SWU_work? !SWU_WEA : 0);
assign  ENA_19   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_19   : (SWU_work? !SWU_WEA : 0);
assign  ENA_20   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_20   : (SWU_work? !SWU_WEA : 0);
assign  ENA_21   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_21   : (SWU_work? !SWU_WEA : 0);
assign  ENA_22   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_22   : (SWU_work? !SWU_WEA : 0);
assign  ENA_23   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_23   : (SWU_work? !SWU_WEA : 0);
assign  ENA_24   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_24   : (SWU_work? !SWU_WEA : 0);
assign  ENA_25   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_25   : (SWU_work? !SWU_WEA : 0);
assign  ENA_26   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_26   : (SWU_work? !SWU_WEA : 0);
assign  ENA_27   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_27   : (SWU_work? !SWU_WEA : 0);
assign  ENA_28   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_28   : (SWU_work? !SWU_WEA : 0);
assign  ENA_29   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_29   : (SWU_work? !SWU_WEA : 0);
assign  ENA_30   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_30   : (SWU_work? !SWU_WEA : 0);
assign  ENA_31   = IB_Addr_Contr_B5_work? IB_Con_RAM_WEA_31   : (SWU_work? !SWU_WEA : 0);

Input_Buffer_B5 IB_5(       .clk(clk),
                            .rst_n(rst_n),
                            .DIN_0(RAM_DIN_0),   .DIN_1(RAM_DIN_1), .DIN_2(RAM_DIN_2),   .DIN_3(RAM_DIN_3),   .DIN_4(RAM_DIN_4),   .DIN_5(RAM_DIN_5),   .DIN_6(RAM_DIN_6),   .DIN_7(RAM_DIN_7),
                            .DIN_8(RAM_DIN_8),   .DIN_9(RAM_DIN_9), .DIN_10(RAM_DIN_10), .DIN_11(RAM_DIN_11), .DIN_12(RAM_DIN_12), .DIN_13(RAM_DIN_13), .DIN_14(RAM_DIN_14), .DIN_15(RAM_DIN_15),
                            .DIN_16(RAM_DIN_16), .DIN_17(RAM_DIN_17), .DIN_18(RAM_DIN_18), .DIN_19(RAM_DIN_19), .DIN_20(RAM_DIN_20), .DIN_21(RAM_DIN_21), .DIN_22(RAM_DIN_22), .DIN_23(RAM_DIN_23), 
                            .DIN_24(RAM_DIN_24), .DIN_25(RAM_DIN_25), .DIN_26(RAM_DIN_26), .DIN_27(RAM_DIN_27), .DIN_28(RAM_DIN_28), .DIN_29(RAM_DIN_29), .DIN_30(RAM_DIN_30), .DIN_31(RAM_DIN_31),  
                            .ADDR_0(ADDR_0), .ADDR_1(ADDR_1), .ADDR_2(ADDR_2),   .ADDR_3(ADDR_3),   .ADDR_4(ADDR_4),   .ADDR_5(ADDR_5),   .ADDR_6(ADDR_6),   .ADDR_7(ADDR_7),
                            .ADDR_8(ADDR_8), .ADDR_9(ADDR_9), .ADDR_10(ADDR_10), .ADDR_11(ADDR_11), .ADDR_12(ADDR_12), .ADDR_13(ADDR_13), .ADDR_14(ADDR_14), .ADDR_15(ADDR_15),
                            .ADDR_16(ADDR_16), .ADDR_17(ADDR_17), .ADDR_18(ADDR_18), .ADDR_19(ADDR_19), .ADDR_20(ADDR_20), .ADDR_21(ADDR_21), .ADDR_22(ADDR_22), .ADDR_23(ADDR_23), 
                            .ADDR_24(ADDR_24), .ADDR_25(ADDR_25), .ADDR_26(ADDR_26), .ADDR_27(ADDR_27), .ADDR_28(ADDR_28), .ADDR_29(ADDR_29), .ADDR_30(ADDR_30), .ADDR_31(ADDR_31), 
                            .WEA_0(WEA_0),   .WEA_1(WEA_1),   .WEA_2(WEA_2),     .WEA_3(WEA_3),     .WEA_4(WEA_4),     .WEA_5(WEA_5),     .WEA_6(WEA_6),     .WEA_7(WEA_7),
                            .WEA_8(WEA_8),   .WEA_9(WEA_9),   .WEA_10(WEA_10),   .WEA_11(WEA_11),   .WEA_12(WEA_12),   .WEA_13(WEA_13),   .WEA_14(WEA_14),   .WEA_15(WEA_15),
                            .WEA_16(WEA_16), .WEA_17(WEA_17), .WEA_18(WEA_18), .WEA_19(WEA_19), .WEA_20(WEA_20), .WEA_21(WEA_21), .WEA_22(WEA_22), .WEA_23(WEA_23), 
                            .WEA_24(WEA_24), .WEA_25(WEA_25), .WEA_26(WEA_26), .WEA_27(WEA_27), .WEA_28(WEA_28), .WEA_29(WEA_29), .WEA_30(WEA_30), .WEA_31(WEA_31), 
                            .ENA_0(ENA_0),   .ENA_1(ENA_1),   .ENA_2(ENA_2),     .ENA_3(ENA_3),     .ENA_4(ENA_4),     .ENA_5(ENA_5),     .ENA_6(ENA_6),     .ENA_7(ENA_7),
                            .ENA_8(ENA_8),   .ENA_9(ENA_9),   .ENA_10(ENA_10),   .ENA_11(ENA_11),   .ENA_12(ENA_12),   .ENA_13(ENA_13),   .ENA_14(ENA_14),   .ENA_15(ENA_15),
                            .ENA_16(ENA_16), .ENA_17(ENA_17), .ENA_18(ENA_18), .ENA_19(ENA_19), .ENA_20(ENA_20), .ENA_21(ENA_21), .ENA_22(ENA_22), .ENA_23(ENA_23), 
                            .ENA_24(ENA_24), .ENA_25(ENA_25), .ENA_26(ENA_26), .ENA_27(ENA_27), .ENA_28(ENA_28), .ENA_29(ENA_29), .ENA_30(ENA_30), .ENA_31(ENA_31), 
                            .DOUTA_0(DOUTA_0), .DOUTA_1(DOUTA_1), .DOUTA_2(DOUTA_2),   .DOUTA_3(DOUTA_3),   .DOUTA_4(DOUTA_4),   .DOUTA_5(DOUTA_5),   .DOUTA_6(DOUTA_6),   .DOUTA_7(DOUTA_7),
                            .DOUTA_8(DOUTA_8), .DOUTA_9(DOUTA_9), .DOUTA_10(DOUTA_10), .DOUTA_11(DOUTA_11), .DOUTA_12(DOUTA_12), .DOUTA_13(DOUTA_13), .DOUTA_14(DOUTA_14), .DOUTA_15(DOUTA_15),
                            .DOUTA_16(DOUTA_16), .DOUTA_17(DOUTA_17), .DOUTA_18(DOUTA_18), .DOUTA_19(DOUTA_19), .DOUTA_20(DOUTA_20), .DOUTA_21(DOUTA_21), .DOUTA_22(DOUTA_22), .DOUTA_23(DOUTA_23), 
                            .DOUTA_24(DOUTA_24), .DOUTA_25(DOUTA_25), .DOUTA_26(DOUTA_26), .DOUTA_27(DOUTA_27), .DOUTA_28(DOUTA_28), .DOUTA_29(DOUTA_29), .DOUTA_30(DOUTA_30), .DOUTA_31(DOUTA_31) 
);


wire    [6:0]       w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7, w_8, w_9, w_10, w_11, w_12, w_13, w_14, w_15, 
                    w_16, w_17, w_18, w_19, w_20, w_21, w_22, w_23, w_24, w_25, w_26, w_27, w_28, w_29, w_30, w_31;
wire    [63:0]      new_weight_val;
wire                Weight_Trans_Done;
Weight_Control_B5 WC_B5(    .clk(clk),  .rst_n(IB_Addr_Contr_B5_work_Done),
                            .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                            .w_8(w_8), .w_9(w_9), .w_10(w_10), .w_11(w_11), .w_12(w_12), .w_13(w_13), .w_14(w_14), .w_15(w_15),
                            .w_16(w_16), .w_17(w_17), .w_18(w_18), .w_19(w_19), .w_20(w_20), .w_21(w_21), .w_22(w_22), .w_23(w_23), 
                            .w_24(w_24), .w_25(w_25), .w_26(w_26), .w_27(w_27), .w_28(w_28), .w_29(w_29), .w_30(w_30), .w_31(w_31), 
                            .new_weight_val(new_weight_val),
                            .Weight_Trans_Done(Weight_Trans_Done)
);

wire      [ 6:0]     Slide_data_0, Slide_data_1, Slide_data_2,  Slide_data_3,  Slide_data_4,  Slide_data_5,  Slide_data_6,  Slide_data_7,
                     Slide_data_8, Slide_data_9, Slide_data_10, Slide_data_11, Slide_data_12, Slide_data_13, Slide_data_14, Slide_data_15,
                     Slide_data_16, Slide_data_17, Slide_data_18, Slide_data_19, Slide_data_20, Slide_data_21, Slide_data_22, Slide_data_23, 
                     Slide_data_24, Slide_data_25, Slide_data_26, Slide_data_27, Slide_data_28, Slide_data_29, Slide_data_30, Slide_data_31;

wire                PE_EN;
IB_SWU_Addr_Contr_B5 SWU_B5(    .clk(clk),       .rst_n(Weight_Trans_Done), 
                                .DIN_0(DOUTA_0), .DIN_1(DOUTA_1), .DIN_2(DOUTA_2), .DIN_3(DOUTA_3), 
                                .DIN_4(DOUTA_4), .DIN_5(DOUTA_5), .DIN_6(DOUTA_6), .DIN_7(DOUTA_7),
                                .DIN_8(DOUTA_8), .DIN_9(DOUTA_9), .DIN_10(DOUTA_10), .DIN_11(DOUTA_11), 
                                .DIN_12(DOUTA_12), .DIN_13(DOUTA_13), .DIN_14(DOUTA_14), .DIN_15(DOUTA_15),
                                .DIN_16(DOUTA_16),.DIN_17(DOUTA_17),.DIN_18(DOUTA_18),.DIN_19(DOUTA_19), 
                                .DIN_20(DOUTA_20),.DIN_21(DOUTA_21),.DIN_22(DOUTA_22),.DIN_23(DOUTA_23),
                                .DIN_24(DOUTA_24),.DIN_25(DOUTA_25),.DIN_26(DOUTA_26),.DIN_27(DOUTA_27),
                                .DIN_28(DOUTA_28),.DIN_29(DOUTA_29),.DIN_30(DOUTA_30),.DIN_31(DOUTA_31),
                                .ADDR(SWU_ADDR), .WEA(SWU_WEA),   .IB_Addr_SWU_work(SWU_work),   .IB_Addr_SWU_work_Done(SWU_work_Done),
                                .Slide_data_0(Slide_data_0), .Slide_data_1(Slide_data_1), .Slide_data_2(Slide_data_2),   .Slide_data_3(Slide_data_3),
                                .Slide_data_4(Slide_data_4), .Slide_data_5(Slide_data_5), .Slide_data_6(Slide_data_6),   .Slide_data_7(Slide_data_7),
                                .Slide_data_8(Slide_data_8), .Slide_data_9(Slide_data_9), .Slide_data_10(Slide_data_10), .Slide_data_11(Slide_data_11),
                                .Slide_data_12(Slide_data_12), .Slide_data_13(Slide_data_13), .Slide_data_14(Slide_data_14), .Slide_data_15(Slide_data_15),
                                .Slide_data_16(Slide_data_16), .Slide_data_17(Slide_data_17), .Slide_data_18(Slide_data_18), .Slide_data_19(Slide_data_19), 
                                .Slide_data_20(Slide_data_20), .Slide_data_21(Slide_data_21), .Slide_data_22(Slide_data_22), .Slide_data_23(Slide_data_23), 
                                .Slide_data_24(Slide_data_24), .Slide_data_25(Slide_data_25), .Slide_data_26(Slide_data_26), .Slide_data_27(Slide_data_27), 
                                .Slide_data_28(Slide_data_28), .Slide_data_29(Slide_data_29), .Slide_data_30(Slide_data_30), .Slide_data_31(Slide_data_31), 
                                .PE_EN(PE_EN)
);


wire signed [8:0]   o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7, o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15,
                    o_16, o_17, o_18, o_19, o_20, o_21, o_22, o_23, o_24, o_25, o_26, o_27, o_28, o_29, o_30, o_31,
                    o_32, o_33, o_34, o_35, o_36, o_37, o_38, o_39, o_40, o_41, o_42, o_43, o_44, o_45, o_46, o_47, 
                    o_48, o_49, o_50, o_51, o_52, o_53, o_54, o_55, o_56, o_57, o_58, o_59, o_60, o_61, o_62, o_63;

PE_Array_B5  PE_Array_Block5(   .clk(clk), .rst_n(PE_EN), .new_weight_val(new_weight_val), 
                                .Slide_data_0(Slide_data_0), .Slide_data_1(Slide_data_1), .Slide_data_2(Slide_data_2), .Slide_data_3(Slide_data_3),
                                .Slide_data_4(Slide_data_4), .Slide_data_5(Slide_data_5), .Slide_data_6(Slide_data_6), .Slide_data_7(Slide_data_7),
                                .Slide_data_8(Slide_data_8), .Slide_data_9(Slide_data_9), .Slide_data_10(Slide_data_10), .Slide_data_11(Slide_data_11),
                                .Slide_data_12(Slide_data_12), .Slide_data_13(Slide_data_13), .Slide_data_14(Slide_data_14), .Slide_data_15(Slide_data_15),
                                .Slide_data_16(Slide_data_16), .Slide_data_17(Slide_data_17), .Slide_data_18(Slide_data_18), .Slide_data_19(Slide_data_19), 
                                .Slide_data_20(Slide_data_20), .Slide_data_21(Slide_data_21), .Slide_data_22(Slide_data_22), .Slide_data_23(Slide_data_23), 
                                .Slide_data_24(Slide_data_24), .Slide_data_25(Slide_data_25), .Slide_data_26(Slide_data_26), .Slide_data_27(Slide_data_27), 
                                .Slide_data_28(Slide_data_28), .Slide_data_29(Slide_data_29), .Slide_data_30(Slide_data_30), .Slide_data_31(Slide_data_31),
                                .o_0(o_0), .o_1(o_1), .o_2(o_2),   .o_3(o_3),   .o_4(o_4),   .o_5(o_5),   .o_6(o_6),   .o_7(o_7),
                                .o_8(o_8), .o_9(o_9), .o_10(o_10), .o_11(o_11), .o_12(o_12), .o_13(o_13), .o_14(o_14), .o_15(o_15),
                                .o_16(o_16), .o_17(o_17), .o_18(o_18), .o_19(o_19), .o_20(o_20), .o_21(o_21), .o_22(o_22), .o_23(o_23),
                                .o_24(o_24), .o_25(o_25), .o_26(o_26), .o_27(o_27), .o_28(o_28), .o_29(o_29), .o_30(o_30), .o_31(o_31),
                                .o_32(o_32), .o_33(o_33), .o_34(o_34), .o_35(o_35), .o_36(o_36), .o_37(o_37), .o_38(o_38), .o_39(o_39), 
                                .o_40(o_40), .o_41(o_41), .o_42(o_42), .o_43(o_43), .o_44(o_44), .o_45(o_45), .o_46(o_46), .o_47(o_47), 
                                .o_48(o_48), .o_49(o_49), .o_50(o_50), .o_51(o_51), .o_52(o_52), .o_53(o_53), .o_54(o_54), .o_55(o_55), 
                                .o_56(o_56), .o_57(o_57), .o_58(o_58), .o_59(o_59), .o_60(o_60), .o_61(o_61), .o_62(o_62), .o_63(o_63), 
                                .o_0_val(B5_o_0_val),
                                .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                                .w_8(w_8), .w_9(w_9), .w_10(w_10), .w_11(w_11), .w_12(w_12), .w_13(w_13), .w_14(w_14), .w_15(w_15),
                                .w_16(w_16), .w_17(w_17), .w_18(w_18), .w_19(w_19), .w_20(w_20), .w_21(w_21), .w_22(w_22), .w_23(w_23), 
                                .w_24(w_24), .w_25(w_25), .w_26(w_26), .w_27(w_27), .w_28(w_28), .w_29(w_29), .w_30(w_30), .w_31(w_31) 
);


Maxpool_Thre_B5 MP_Thre(.clk(clk), .rst_n(rst_n), 
                        .o_0(o_0), .o_1(o_1), .o_2(o_2),   .o_3(o_3),   .o_4(o_4),   .o_5(o_5),   .o_6(o_6),   .o_7(o_7),
                        .o_8(o_8), .o_9(o_9), .o_10(o_10), .o_11(o_11), .o_12(o_12), .o_13(o_13), .o_14(o_14), .o_15(o_15),
                        .o_16(o_16), .o_17(o_17), .o_18(o_18), .o_19(o_19), .o_20(o_20), .o_21(o_21), .o_22(o_22), .o_23(o_23),
                        .o_24(o_24), .o_25(o_25), .o_26(o_26), .o_27(o_27), .o_28(o_28), .o_29(o_29), .o_30(o_30), .o_31(o_31),
                        .o_32(o_32), .o_33(o_33), .o_34(o_34), .o_35(o_35), .o_36(o_36), .o_37(o_37), .o_38(o_38), .o_39(o_39), 
                        .o_40(o_40), .o_41(o_41), .o_42(o_42), .o_43(o_43), .o_44(o_44), .o_45(o_45), .o_46(o_46), .o_47(o_47), 
                        .o_48(o_48), .o_49(o_49), .o_50(o_50), .o_51(o_51), .o_52(o_52), .o_53(o_53), .o_54(o_54), .o_55(o_55), 
                        .o_56(o_56), .o_57(o_57), .o_58(o_58), .o_59(o_59), .o_60(o_60), .o_61(o_61), .o_62(o_62), .o_63(o_63),
                        .o_0_val(B5_o_0_val),
                        .Bout_0(B5_Bout_0), .Bout_1(B5_Bout_1), .Bout_2(B5_Bout_2), .Bout_3(B5_Bout_3), .Bout_4(B5_Bout_4), .Bout_5(B5_Bout_5), .Bout_6(B5_Bout_6), .Bout_7(B5_Bout_7), 
                        .Bout_8(B5_Bout_8), .Bout_9(B5_Bout_9), .Bout_10(B5_Bout_10), .Bout_11(B5_Bout_11), .Bout_12(B5_Bout_12), .Bout_13(B5_Bout_13), .Bout_14(B5_Bout_14), .Bout_15(B5_Bout_15), 
                        .Bout_16(B5_Bout_16), .Bout_17(B5_Bout_17), .Bout_18(B5_Bout_18), .Bout_19(B5_Bout_19), .Bout_20(B5_Bout_20), .Bout_21(B5_Bout_21), .Bout_22(B5_Bout_22), .Bout_23(B5_Bout_23), 
                        .Bout_24(B5_Bout_24), .Bout_25(B5_Bout_25), .Bout_26(B5_Bout_26), .Bout_27(B5_Bout_27), .Bout_28(B5_Bout_28), .Bout_29(B5_Bout_29), .Bout_30(B5_Bout_30), .Bout_31(B5_Bout_31),
                        .Bout_32(B5_Bout_32), .Bout_33(B5_Bout_33), .Bout_34(B5_Bout_34), .Bout_35(B5_Bout_35), .Bout_36(B5_Bout_36), .Bout_37(B5_Bout_37), .Bout_38(B5_Bout_38), 
                        .Bout_39(B5_Bout_39), .Bout_40(B5_Bout_40), .Bout_41(B5_Bout_41), .Bout_42(B5_Bout_42), .Bout_43(B5_Bout_43), .Bout_44(B5_Bout_44), .Bout_45(B5_Bout_45), 
                        .Bout_46(B5_Bout_46), .Bout_47(B5_Bout_47), .Bout_48(B5_Bout_48), .Bout_49(B5_Bout_49), .Bout_50(B5_Bout_50), .Bout_51(B5_Bout_51), .Bout_52(B5_Bout_52), 
                        .Bout_53(B5_Bout_53), .Bout_54(B5_Bout_54), .Bout_55(B5_Bout_55), .Bout_56(B5_Bout_56), .Bout_57(B5_Bout_57), .Bout_58(B5_Bout_58), .Bout_59(B5_Bout_59), 
                        .Bout_60(B5_Bout_60), .Bout_61(B5_Bout_61), .Bout_62(B5_Bout_62), .Bout_63(B5_Bout_63),
                        .Bout_0_Val(B5_Bout_0_Val)
                        );
endmodule
