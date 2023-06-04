`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/07 20:58:36
// Design Name: 
// Module Name: Block6_Top
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


module Block6_Top(
    input                           clk,
    input                           rst_n,
    input           wire            Bin_0, Bin_1, Bin_2, Bin_3, Bin_4, Bin_5, Bin_6, Bin_7, 
                                    Bin_8, Bin_9, Bin_10, Bin_11, Bin_12, Bin_13, Bin_14, Bin_15, 
                                    Bin_16, Bin_17, Bin_18, Bin_19, Bin_20, Bin_21, Bin_22, Bin_23, 
                                    Bin_24, Bin_25, Bin_26, Bin_27, Bin_28, Bin_29, Bin_30, Bin_31,
                                    Bin_32, Bin_33, Bin_34, Bin_35, Bin_36, Bin_37, Bin_38, Bin_39, 
                                    Bin_40, Bin_41, Bin_42, Bin_43, Bin_44, Bin_45, Bin_46, Bin_47, 
                                    Bin_48, Bin_49, Bin_50, Bin_51, Bin_52, Bin_53, Bin_54, Bin_55, 
                                    Bin_56, Bin_57, Bin_58, Bin_59, Bin_60, Bin_61, Bin_62, Bin_63, 
    input           wire            Bin_0_Val,
    output          wire   [2:0]    class
    
);
wire            [31:0]          RAM_DIN_0, RAM_DIN_1, RAM_DIN_2,  RAM_DIN_3,  RAM_DIN_4,  RAM_DIN_5,  RAM_DIN_6,  RAM_DIN_7, 
                                RAM_DIN_8, RAM_DIN_9, RAM_DIN_10, RAM_DIN_11, RAM_DIN_12, RAM_DIN_13, RAM_DIN_14, RAM_DIN_15,
                                RAM_DIN_16, RAM_DIN_17, RAM_DIN_18, RAM_DIN_19, RAM_DIN_20, RAM_DIN_21, RAM_DIN_22, RAM_DIN_23, 
                                RAM_DIN_24, RAM_DIN_25, RAM_DIN_26, RAM_DIN_27, RAM_DIN_28, RAM_DIN_29, RAM_DIN_30, RAM_DIN_31,
                                RAM_DIN_32, RAM_DIN_33, RAM_DIN_34, RAM_DIN_35, RAM_DIN_36, RAM_DIN_37, RAM_DIN_38, RAM_DIN_39, 
                                RAM_DIN_40, RAM_DIN_41, RAM_DIN_42, RAM_DIN_43, RAM_DIN_44, RAM_DIN_45, RAM_DIN_46, RAM_DIN_47, 
                                RAM_DIN_48, RAM_DIN_49, RAM_DIN_50, RAM_DIN_51, RAM_DIN_52, RAM_DIN_53, RAM_DIN_54, RAM_DIN_55, 
                                RAM_DIN_56, RAM_DIN_57, RAM_DIN_58, RAM_DIN_59, RAM_DIN_60, RAM_DIN_61, RAM_DIN_62, RAM_DIN_63; 
wire            [1:0]           IB_Con_RAM_ADDR_0,  IB_Con_RAM_ADDR_1,  IB_Con_RAM_ADDR_2,   IB_Con_RAM_ADDR_3, //05.11修改地址为2bit
                                IB_Con_RAM_ADDR_4,  IB_Con_RAM_ADDR_5,  IB_Con_RAM_ADDR_6,   IB_Con_RAM_ADDR_7, 
                                IB_Con_RAM_ADDR_8,  IB_Con_RAM_ADDR_9,  IB_Con_RAM_ADDR_10,  IB_Con_RAM_ADDR_11, 
                                IB_Con_RAM_ADDR_12, IB_Con_RAM_ADDR_13, IB_Con_RAM_ADDR_14,  IB_Con_RAM_ADDR_15,
                                IB_Con_RAM_ADDR_16, IB_Con_RAM_ADDR_17, IB_Con_RAM_ADDR_18, IB_Con_RAM_ADDR_19, 
                                IB_Con_RAM_ADDR_20, IB_Con_RAM_ADDR_21, IB_Con_RAM_ADDR_22, IB_Con_RAM_ADDR_23, 
                                IB_Con_RAM_ADDR_24, IB_Con_RAM_ADDR_25, IB_Con_RAM_ADDR_26, IB_Con_RAM_ADDR_27, 
                                IB_Con_RAM_ADDR_28, IB_Con_RAM_ADDR_29, IB_Con_RAM_ADDR_30, IB_Con_RAM_ADDR_31,
                                IB_Con_RAM_ADDR_32, IB_Con_RAM_ADDR_33, IB_Con_RAM_ADDR_34, IB_Con_RAM_ADDR_35, 
                                IB_Con_RAM_ADDR_36, IB_Con_RAM_ADDR_37, IB_Con_RAM_ADDR_38, IB_Con_RAM_ADDR_39, 
                                IB_Con_RAM_ADDR_40, IB_Con_RAM_ADDR_41, IB_Con_RAM_ADDR_42, IB_Con_RAM_ADDR_43, 
                                IB_Con_RAM_ADDR_44, IB_Con_RAM_ADDR_45, IB_Con_RAM_ADDR_46, IB_Con_RAM_ADDR_47, 
                                IB_Con_RAM_ADDR_48, IB_Con_RAM_ADDR_49, IB_Con_RAM_ADDR_50, IB_Con_RAM_ADDR_51, 
                                IB_Con_RAM_ADDR_52, IB_Con_RAM_ADDR_53, IB_Con_RAM_ADDR_54, IB_Con_RAM_ADDR_55, 
                                IB_Con_RAM_ADDR_56, IB_Con_RAM_ADDR_57, IB_Con_RAM_ADDR_58, IB_Con_RAM_ADDR_59, 
                                IB_Con_RAM_ADDR_60, IB_Con_RAM_ADDR_61, IB_Con_RAM_ADDR_62, IB_Con_RAM_ADDR_63;
                                   
wire                            IB_Con_RAM_WEA_0, IB_Con_RAM_WEA_1, IB_Con_RAM_WEA_2, IB_Con_RAM_WEA_3, IB_Con_RAM_WEA_4, IB_Con_RAM_WEA_5, IB_Con_RAM_WEA_6, IB_Con_RAM_WEA_7, 
                                IB_Con_RAM_WEA_8, IB_Con_RAM_WEA_9, IB_Con_RAM_WEA_10, IB_Con_RAM_WEA_11, IB_Con_RAM_WEA_12, IB_Con_RAM_WEA_13, IB_Con_RAM_WEA_14, IB_Con_RAM_WEA_15,
                                IB_Con_RAM_WEA_16, IB_Con_RAM_WEA_17, IB_Con_RAM_WEA_18, IB_Con_RAM_WEA_19, IB_Con_RAM_WEA_20, IB_Con_RAM_WEA_21, IB_Con_RAM_WEA_22, IB_Con_RAM_WEA_23, 
                                IB_Con_RAM_WEA_24, IB_Con_RAM_WEA_25, IB_Con_RAM_WEA_26, IB_Con_RAM_WEA_27, IB_Con_RAM_WEA_28, IB_Con_RAM_WEA_29, IB_Con_RAM_WEA_30, IB_Con_RAM_WEA_31,
                                IB_Con_RAM_WEA_32, IB_Con_RAM_WEA_33, IB_Con_RAM_WEA_34, IB_Con_RAM_WEA_35, IB_Con_RAM_WEA_36, IB_Con_RAM_WEA_37, IB_Con_RAM_WEA_38, IB_Con_RAM_WEA_39, 
                                IB_Con_RAM_WEA_40, IB_Con_RAM_WEA_41, IB_Con_RAM_WEA_42, IB_Con_RAM_WEA_43, IB_Con_RAM_WEA_44, IB_Con_RAM_WEA_45, IB_Con_RAM_WEA_46, IB_Con_RAM_WEA_47, 
                                IB_Con_RAM_WEA_48, IB_Con_RAM_WEA_49, IB_Con_RAM_WEA_50, IB_Con_RAM_WEA_51, IB_Con_RAM_WEA_52, IB_Con_RAM_WEA_53, IB_Con_RAM_WEA_54, IB_Con_RAM_WEA_55, 
                                IB_Con_RAM_WEA_56, IB_Con_RAM_WEA_57, IB_Con_RAM_WEA_58, IB_Con_RAM_WEA_59, IB_Con_RAM_WEA_60, IB_Con_RAM_WEA_61, IB_Con_RAM_WEA_62, IB_Con_RAM_WEA_63;
                                
wire                            IB_Addr_Contr_B6_work, IB_Addr_Contr_B6_work_Done; 

IB_Addr_Contr_B6 IB_Con_6(  .clk(clk),
                            .rst_n(rst_n),
                            .Bin_0_Val(Bin_0_Val),
                            .Bin_0(Bin_0), .Bin_1(Bin_1), .Bin_2(Bin_2), .Bin_3(Bin_3), .Bin_4(Bin_4), .Bin_5(Bin_5), .Bin_6(Bin_6), .Bin_7(Bin_7), 
                            .Bin_8(Bin_8), .Bin_9(Bin_9), .Bin_10(Bin_10), .Bin_11(Bin_11), .Bin_12(Bin_12), .Bin_13(Bin_13), .Bin_14(Bin_14), .Bin_15(Bin_15), 
                            .Bin_16(Bin_16), .Bin_17(Bin_17), .Bin_18(Bin_18), .Bin_19(Bin_19), .Bin_20(Bin_20), .Bin_21(Bin_21), .Bin_22(Bin_22), .Bin_23(Bin_23), 
                            .Bin_24(Bin_24), .Bin_25(Bin_25), .Bin_26(Bin_26), .Bin_27(Bin_27), .Bin_28(Bin_28), .Bin_29(Bin_29), .Bin_30(Bin_30), .Bin_31(Bin_31),
                            .Bin_32(Bin_32), .Bin_33(Bin_33), .Bin_34(Bin_34), .Bin_35(Bin_35), .Bin_36(Bin_36), .Bin_37(Bin_37), .Bin_38(Bin_38), .Bin_39(Bin_39), 
                            .Bin_40(Bin_40), .Bin_41(Bin_41), .Bin_42(Bin_42), .Bin_43(Bin_43), .Bin_44(Bin_44), .Bin_45(Bin_45), .Bin_46(Bin_46), .Bin_47(Bin_47), 
                            .Bin_48(Bin_48), .Bin_49(Bin_49), .Bin_50(Bin_50), .Bin_51(Bin_51), .Bin_52(Bin_52), .Bin_53(Bin_53), .Bin_54(Bin_54), .Bin_55(Bin_55), 
                            .Bin_56(Bin_56), .Bin_57(Bin_57), .Bin_58(Bin_58), .Bin_59(Bin_59), .Bin_60(Bin_60), .Bin_61(Bin_61), .Bin_62(Bin_62), .Bin_63(Bin_63),   
                            .Dout_0(RAM_DIN_0),  .Dout_1(RAM_DIN_1), .Dout_2(RAM_DIN_2),   .Dout_3(RAM_DIN_3),   .Dout_4(RAM_DIN_4),   .Dout_5(RAM_DIN_5),   .Dout_6(RAM_DIN_6),   .Dout_7(RAM_DIN_7),
                            .Dout_8(RAM_DIN_8),  .Dout_9(RAM_DIN_9), .Dout_10(RAM_DIN_10), .Dout_11(RAM_DIN_11), .Dout_12(RAM_DIN_12), .Dout_13(RAM_DIN_13), .Dout_14(RAM_DIN_14), .Dout_15(RAM_DIN_15),
                            .Dout_16(RAM_DIN_16), .Dout_17(RAM_DIN_17), .Dout_18(RAM_DIN_18), .Dout_19(RAM_DIN_19), .Dout_20(RAM_DIN_20), .Dout_21(RAM_DIN_21), .Dout_22(RAM_DIN_22), .Dout_23(RAM_DIN_23), 
                            .Dout_24(RAM_DIN_24), .Dout_25(RAM_DIN_25), .Dout_26(RAM_DIN_26), .Dout_27(RAM_DIN_27), .Dout_28(RAM_DIN_28), .Dout_29(RAM_DIN_29), .Dout_30(RAM_DIN_30), .Dout_31(RAM_DIN_31),
                            .Dout_32(RAM_DIN_32), .Dout_33(RAM_DIN_33), .Dout_34(RAM_DIN_34), .Dout_35(RAM_DIN_35), .Dout_36(RAM_DIN_36), .Dout_37(RAM_DIN_37), .Dout_38(RAM_DIN_38), .Dout_39(RAM_DIN_39), 
                            .Dout_40(RAM_DIN_40), .Dout_41(RAM_DIN_41), .Dout_42(RAM_DIN_42), .Dout_43(RAM_DIN_43), .Dout_44(RAM_DIN_44), .Dout_45(RAM_DIN_45), .Dout_46(RAM_DIN_46), .Dout_47(RAM_DIN_47), 
                            .Dout_48(RAM_DIN_48), .Dout_49(RAM_DIN_49), .Dout_50(RAM_DIN_50), .Dout_51(RAM_DIN_51), .Dout_52(RAM_DIN_52), .Dout_53(RAM_DIN_53), .Dout_54(RAM_DIN_54), .Dout_55(RAM_DIN_55), 
                            .Dout_56(RAM_DIN_56), .Dout_57(RAM_DIN_57), .Dout_58(RAM_DIN_58), .Dout_59(RAM_DIN_59), .Dout_60(RAM_DIN_60), .Dout_61(RAM_DIN_61), .Dout_62(RAM_DIN_62), .Dout_63(RAM_DIN_63), 
                            .ADDR_0(IB_Con_RAM_ADDR_0), .ADDR_1(IB_Con_RAM_ADDR_1), .ADDR_2(IB_Con_RAM_ADDR_2), .ADDR_3(IB_Con_RAM_ADDR_3), .ADDR_4(IB_Con_RAM_ADDR_4), .ADDR_5(IB_Con_RAM_ADDR_5), .ADDR_6(IB_Con_RAM_ADDR_6), .ADDR_7(IB_Con_RAM_ADDR_7), 
                            .ADDR_8(IB_Con_RAM_ADDR_8), .ADDR_9(IB_Con_RAM_ADDR_9), .ADDR_10(IB_Con_RAM_ADDR_10), .ADDR_11(IB_Con_RAM_ADDR_11), .ADDR_12(IB_Con_RAM_ADDR_12), .ADDR_13(IB_Con_RAM_ADDR_13), .ADDR_14(IB_Con_RAM_ADDR_14), .ADDR_15(IB_Con_RAM_ADDR_15),
                            .ADDR_16(IB_Con_RAM_ADDR_16), .ADDR_17(IB_Con_RAM_ADDR_17), .ADDR_18(IB_Con_RAM_ADDR_18), .ADDR_19(IB_Con_RAM_ADDR_19), .ADDR_20(IB_Con_RAM_ADDR_20), .ADDR_21(IB_Con_RAM_ADDR_21), .ADDR_22(IB_Con_RAM_ADDR_22), .ADDR_23(IB_Con_RAM_ADDR_23), 
                            .ADDR_24(IB_Con_RAM_ADDR_24), .ADDR_25(IB_Con_RAM_ADDR_25), .ADDR_26(IB_Con_RAM_ADDR_26), .ADDR_27(IB_Con_RAM_ADDR_27), .ADDR_28(IB_Con_RAM_ADDR_28), .ADDR_29(IB_Con_RAM_ADDR_29), .ADDR_30(IB_Con_RAM_ADDR_30), .ADDR_31(IB_Con_RAM_ADDR_31),
                            .ADDR_32(IB_Con_RAM_ADDR_32), .ADDR_33(IB_Con_RAM_ADDR_33), .ADDR_34(IB_Con_RAM_ADDR_34), .ADDR_35(IB_Con_RAM_ADDR_35), .ADDR_36(IB_Con_RAM_ADDR_36), .ADDR_37(IB_Con_RAM_ADDR_37), .ADDR_38(IB_Con_RAM_ADDR_38), .ADDR_39(IB_Con_RAM_ADDR_39), 
                            .ADDR_40(IB_Con_RAM_ADDR_40), .ADDR_41(IB_Con_RAM_ADDR_41), .ADDR_42(IB_Con_RAM_ADDR_42), .ADDR_43(IB_Con_RAM_ADDR_43), .ADDR_44(IB_Con_RAM_ADDR_44), .ADDR_45(IB_Con_RAM_ADDR_45), .ADDR_46(IB_Con_RAM_ADDR_46), .ADDR_47(IB_Con_RAM_ADDR_47), 
                            .ADDR_48(IB_Con_RAM_ADDR_48), .ADDR_49(IB_Con_RAM_ADDR_49), .ADDR_50(IB_Con_RAM_ADDR_50), .ADDR_51(IB_Con_RAM_ADDR_51), .ADDR_52(IB_Con_RAM_ADDR_52), .ADDR_53(IB_Con_RAM_ADDR_53), .ADDR_54(IB_Con_RAM_ADDR_54), .ADDR_55(IB_Con_RAM_ADDR_55), 
                            .ADDR_56(IB_Con_RAM_ADDR_56), .ADDR_57(IB_Con_RAM_ADDR_57), .ADDR_58(IB_Con_RAM_ADDR_58), .ADDR_59(IB_Con_RAM_ADDR_59), .ADDR_60(IB_Con_RAM_ADDR_60), .ADDR_61(IB_Con_RAM_ADDR_61), .ADDR_62(IB_Con_RAM_ADDR_62), .ADDR_63(IB_Con_RAM_ADDR_63),   
                            .WEA_0(IB_Con_RAM_WEA_0),   .WEA_1(IB_Con_RAM_WEA_1),   .WEA_2(IB_Con_RAM_WEA_2),   .WEA_3(IB_Con_RAM_WEA_3), 
                            .WEA_4(IB_Con_RAM_WEA_4),   .WEA_5(IB_Con_RAM_WEA_5),   .WEA_6(IB_Con_RAM_WEA_6),   .WEA_7(IB_Con_RAM_WEA_7), 
                            .WEA_8(IB_Con_RAM_WEA_8),   .WEA_9(IB_Con_RAM_WEA_9),   .WEA_10(IB_Con_RAM_WEA_10), .WEA_11(IB_Con_RAM_WEA_11), 
                            .WEA_12(IB_Con_RAM_WEA_12), .WEA_13(IB_Con_RAM_WEA_13), .WEA_14(IB_Con_RAM_WEA_14), .WEA_15(IB_Con_RAM_WEA_15),
                            .WEA_16(IB_Con_RAM_WEA_16), .WEA_17(IB_Con_RAM_WEA_17), .WEA_18(IB_Con_RAM_WEA_18), .WEA_19(IB_Con_RAM_WEA_19), 
                            .WEA_20(IB_Con_RAM_WEA_20), .WEA_21(IB_Con_RAM_WEA_21), .WEA_22(IB_Con_RAM_WEA_22), .WEA_23(IB_Con_RAM_WEA_23), 
                            .WEA_24(IB_Con_RAM_WEA_24), .WEA_25(IB_Con_RAM_WEA_25), .WEA_26(IB_Con_RAM_WEA_26), .WEA_27(IB_Con_RAM_WEA_27), 
                            .WEA_28(IB_Con_RAM_WEA_28), .WEA_29(IB_Con_RAM_WEA_29), .WEA_30(IB_Con_RAM_WEA_30), .WEA_31(IB_Con_RAM_WEA_31),
                            .WEA_32(IB_Con_RAM_WEA_32), .WEA_33(IB_Con_RAM_WEA_33), .WEA_34(IB_Con_RAM_WEA_34), .WEA_35(IB_Con_RAM_WEA_35), 
                            .WEA_36(IB_Con_RAM_WEA_36), .WEA_37(IB_Con_RAM_WEA_37), .WEA_38(IB_Con_RAM_WEA_38), .WEA_39(IB_Con_RAM_WEA_39), 
                            .WEA_40(IB_Con_RAM_WEA_40), .WEA_41(IB_Con_RAM_WEA_41), .WEA_42(IB_Con_RAM_WEA_42), .WEA_43(IB_Con_RAM_WEA_43), 
                            .WEA_44(IB_Con_RAM_WEA_44), .WEA_45(IB_Con_RAM_WEA_45), .WEA_46(IB_Con_RAM_WEA_46), .WEA_47(IB_Con_RAM_WEA_47), 
                            .WEA_48(IB_Con_RAM_WEA_48), .WEA_49(IB_Con_RAM_WEA_49), .WEA_50(IB_Con_RAM_WEA_50), .WEA_51(IB_Con_RAM_WEA_51), 
                            .WEA_52(IB_Con_RAM_WEA_52), .WEA_53(IB_Con_RAM_WEA_53), .WEA_54(IB_Con_RAM_WEA_54), .WEA_55(IB_Con_RAM_WEA_55), 
                            .WEA_56(IB_Con_RAM_WEA_56), .WEA_57(IB_Con_RAM_WEA_57), .WEA_58(IB_Con_RAM_WEA_58), .WEA_59(IB_Con_RAM_WEA_59), 
                            .WEA_60(IB_Con_RAM_WEA_60), .WEA_61(IB_Con_RAM_WEA_61), .WEA_62(IB_Con_RAM_WEA_62), .WEA_63(IB_Con_RAM_WEA_63),   
                            .IB_Addr_Contr_B6_work(IB_Addr_Contr_B6_work), .IB_Addr_Contr_B6_work_Done(IB_Addr_Contr_B6_work_Done)
);
wire            [1:0]           ADDR_0, ADDR_1, ADDR_2,  ADDR_3,  ADDR_4,  ADDR_5,  ADDR_6,  ADDR_7, 
                                ADDR_8, ADDR_9, ADDR_10, ADDR_11, ADDR_12, ADDR_13, ADDR_14, ADDR_15,
                                ADDR_16, ADDR_17, ADDR_18, ADDR_19, ADDR_20, ADDR_21, ADDR_22, ADDR_23, 
                                ADDR_24, ADDR_25, ADDR_26, ADDR_27, ADDR_28, ADDR_29, ADDR_30, ADDR_31, 
                                ADDR_32, ADDR_33, ADDR_34, ADDR_35, ADDR_36, ADDR_37, ADDR_38, ADDR_39, 
                                ADDR_40, ADDR_41, ADDR_42, ADDR_43, ADDR_44, ADDR_45, ADDR_46, ADDR_47, 
                                ADDR_48, ADDR_49, ADDR_50, ADDR_51, ADDR_52, ADDR_53, ADDR_54, ADDR_55, 
                                ADDR_56, ADDR_57, ADDR_58, ADDR_59, ADDR_60, ADDR_61, ADDR_62, ADDR_63;
wire                            WEA_0, WEA_1,  WEA_2,  WEA_3,  WEA_4,  WEA_5,  WEA_6,  WEA_7,
                                WEA_8, WEA_9,  WEA_10, WEA_11, WEA_12, WEA_13, WEA_14, WEA_15,
                                WEA_16, WEA_17, WEA_18, WEA_19, WEA_20, WEA_21, WEA_22, WEA_23, 
                                WEA_24, WEA_25, WEA_26, WEA_27, WEA_28, WEA_29, WEA_30, WEA_31,
                                WEA_32, WEA_33, WEA_34, WEA_35, WEA_36, WEA_37, WEA_38, WEA_39, 
                                WEA_40, WEA_41, WEA_42, WEA_43, WEA_44, WEA_45, WEA_46, WEA_47, 
                                WEA_48, WEA_49, WEA_50, WEA_51, WEA_52, WEA_53, WEA_54, WEA_55, 
                                WEA_56, WEA_57, WEA_58, WEA_59, WEA_60, WEA_61, WEA_62, WEA_63;
wire                            ENA_0, ENA_1,  ENA_2,  ENA_3,  ENA_4,  ENA_5,  ENA_6, ENA_7,
                                ENA_8, ENA_9,  ENA_10, ENA_11, ENA_12, ENA_13, ENA_14, ENA_15,
                                ENA_16, ENA_17, ENA_18, ENA_19, ENA_20, ENA_21, ENA_22, ENA_23, 
                                ENA_24, ENA_25, ENA_26, ENA_27, ENA_28, ENA_29, ENA_30, ENA_31,
                                ENA_32, ENA_33, ENA_34, ENA_35, ENA_36, ENA_37, ENA_38, ENA_39, 
                                ENA_40, ENA_41, ENA_42, ENA_43, ENA_44, ENA_45, ENA_46, ENA_47, 
                                ENA_48, ENA_49, ENA_50, ENA_51, ENA_52, ENA_53, ENA_54, ENA_55, 
                                ENA_56, ENA_57, ENA_58, ENA_59, ENA_60, ENA_61, ENA_62, ENA_63;
wire            [31:0]          DOUTA_0, DOUTA_1, DOUTA_2,  DOUTA_3,  DOUTA_4,  DOUTA_5,  DOUTA_6,  DOUTA_7, 
                                DOUTA_8, DOUTA_9, DOUTA_10, DOUTA_11, DOUTA_12, DOUTA_13, DOUTA_14, DOUTA_15,
                                DOUTA_16, DOUTA_17, DOUTA_18, DOUTA_19, DOUTA_20, DOUTA_21, DOUTA_22, DOUTA_23, 
                                DOUTA_24, DOUTA_25, DOUTA_26, DOUTA_27, DOUTA_28, DOUTA_29, DOUTA_30, DOUTA_31,
                                DOUTA_32, DOUTA_33, DOUTA_34, DOUTA_35, DOUTA_36, DOUTA_37, DOUTA_38, DOUTA_39,
                                DOUTA_40, DOUTA_41, DOUTA_42, DOUTA_43, DOUTA_44, DOUTA_45, DOUTA_46, DOUTA_47, 
                                DOUTA_48, DOUTA_49, DOUTA_50, DOUTA_51, DOUTA_52, DOUTA_53, DOUTA_54, DOUTA_55, 
                                DOUTA_56, DOUTA_57, DOUTA_58, DOUTA_59, DOUTA_60, DOUTA_61, DOUTA_62, DOUTA_63;
//SWU
wire                            SWU_work, SWU_WEA, SWU_work_Done;
wire            [1:0]           SWU_ADDR;
assign  ADDR_0  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_0  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_1  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_1  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_2  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_2  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_3  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_3  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_4  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_4  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_5  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_5  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_6  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_6  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_7  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_7  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_8  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_8  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_9  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_9  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_10  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_10  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_11  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_11  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_12  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_12  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_13  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_13  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_14  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_14  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_15  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_15  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_16  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_16  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_17  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_17  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_18  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_18  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_19  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_19  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_20  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_20  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_21  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_21  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_22  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_22  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_23  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_23  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_24  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_24  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_25  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_25  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_26  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_26  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_27  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_27  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_28  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_28  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_29  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_29  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_30  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_30  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_31  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_31  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_32  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_32  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_33  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_33  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_34  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_34  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_35  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_35  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_36  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_36  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_37  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_37  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_38  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_38  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_39  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_39  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_40  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_40  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_41  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_41  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_42  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_42  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_43  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_43  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_44  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_44  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_45  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_45  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_46  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_46  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_47  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_47  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_48  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_48  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_49  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_49  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_50  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_50  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_51  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_51  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_52  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_52  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_53  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_53  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_54  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_54  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_55  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_55  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_56  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_56  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_57  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_57  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_58  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_58  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_59  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_59  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_60  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_60  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_61  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_61  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_62  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_62  : (SWU_work? SWU_ADDR : 0);
assign  ADDR_63  = IB_Addr_Contr_B6_work? IB_Con_RAM_ADDR_63  : (SWU_work? SWU_ADDR : 0);

assign  WEA_0   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_0   : (SWU_work? SWU_WEA : 0);
assign  WEA_1   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_1   : (SWU_work? SWU_WEA : 0);
assign  WEA_2   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_2   : (SWU_work? SWU_WEA : 0);
assign  WEA_3   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_3   : (SWU_work? SWU_WEA : 0);
assign  WEA_4   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_4   : (SWU_work? SWU_WEA : 0);
assign  WEA_5   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_5   : (SWU_work? SWU_WEA : 0);
assign  WEA_6   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_6   : (SWU_work? SWU_WEA : 0);
assign  WEA_7   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_7   : (SWU_work? SWU_WEA : 0);
assign  WEA_8   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_8   : (SWU_work? SWU_WEA : 0);
assign  WEA_9   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_9   : (SWU_work? SWU_WEA : 0);
assign  WEA_10   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_10   : (SWU_work? SWU_WEA : 0);
assign  WEA_11   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_11   : (SWU_work? SWU_WEA : 0);
assign  WEA_12   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_12   : (SWU_work? SWU_WEA : 0);
assign  WEA_13   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_13   : (SWU_work? SWU_WEA : 0);
assign  WEA_14   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_14   : (SWU_work? SWU_WEA : 0);
assign  WEA_15   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_15   : (SWU_work? SWU_WEA : 0);
assign  WEA_16   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_16   : (SWU_work? SWU_WEA : 0);
assign  WEA_17   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_17   : (SWU_work? SWU_WEA : 0);
assign  WEA_18   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_18   : (SWU_work? SWU_WEA : 0);
assign  WEA_19   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_19   : (SWU_work? SWU_WEA : 0);
assign  WEA_20   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_20   : (SWU_work? SWU_WEA : 0);
assign  WEA_21   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_21   : (SWU_work? SWU_WEA : 0);
assign  WEA_22   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_22   : (SWU_work? SWU_WEA : 0);
assign  WEA_23   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_23   : (SWU_work? SWU_WEA : 0);
assign  WEA_24   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_24   : (SWU_work? SWU_WEA : 0);
assign  WEA_25   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_25   : (SWU_work? SWU_WEA : 0);
assign  WEA_26   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_26   : (SWU_work? SWU_WEA : 0);
assign  WEA_27   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_27   : (SWU_work? SWU_WEA : 0);
assign  WEA_28   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_28   : (SWU_work? SWU_WEA : 0);
assign  WEA_29   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_29   : (SWU_work? SWU_WEA : 0);
assign  WEA_30   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_30   : (SWU_work? SWU_WEA : 0);
assign  WEA_31   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_31   : (SWU_work? SWU_WEA : 0);
assign  WEA_32   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_32   : (SWU_work? SWU_WEA : 0);
assign  WEA_33   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_33   : (SWU_work? SWU_WEA : 0);
assign  WEA_34   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_34   : (SWU_work? SWU_WEA : 0);
assign  WEA_35   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_35   : (SWU_work? SWU_WEA : 0);
assign  WEA_36   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_36   : (SWU_work? SWU_WEA : 0);
assign  WEA_37   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_37   : (SWU_work? SWU_WEA : 0);
assign  WEA_38   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_38   : (SWU_work? SWU_WEA : 0);
assign  WEA_39   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_39   : (SWU_work? SWU_WEA : 0);
assign  WEA_40   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_40   : (SWU_work? SWU_WEA : 0);
assign  WEA_41   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_41   : (SWU_work? SWU_WEA : 0);
assign  WEA_42   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_42   : (SWU_work? SWU_WEA : 0);
assign  WEA_43   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_43   : (SWU_work? SWU_WEA : 0);
assign  WEA_44   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_44   : (SWU_work? SWU_WEA : 0);
assign  WEA_45   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_45   : (SWU_work? SWU_WEA : 0);
assign  WEA_46   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_46   : (SWU_work? SWU_WEA : 0);
assign  WEA_47   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_47   : (SWU_work? SWU_WEA : 0);
assign  WEA_48   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_48   : (SWU_work? SWU_WEA : 0);
assign  WEA_49   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_49   : (SWU_work? SWU_WEA : 0);
assign  WEA_50   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_50   : (SWU_work? SWU_WEA : 0);
assign  WEA_51   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_51   : (SWU_work? SWU_WEA : 0);
assign  WEA_52   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_52   : (SWU_work? SWU_WEA : 0);
assign  WEA_53   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_53   : (SWU_work? SWU_WEA : 0);
assign  WEA_54   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_54   : (SWU_work? SWU_WEA : 0);
assign  WEA_55   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_55   : (SWU_work? SWU_WEA : 0);
assign  WEA_56   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_56   : (SWU_work? SWU_WEA : 0);
assign  WEA_57   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_57   : (SWU_work? SWU_WEA : 0);
assign  WEA_58   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_58   : (SWU_work? SWU_WEA : 0);
assign  WEA_59   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_59   : (SWU_work? SWU_WEA : 0);
assign  WEA_60   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_60   : (SWU_work? SWU_WEA : 0);
assign  WEA_61   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_61   : (SWU_work? SWU_WEA : 0);
assign  WEA_62   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_62   : (SWU_work? SWU_WEA : 0);
assign  WEA_63   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_63   : (SWU_work? SWU_WEA : 0);

assign  ENA_0   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_0   : (SWU_work? !SWU_WEA : 0);
assign  ENA_1   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_1   : (SWU_work? !SWU_WEA : 0);
assign  ENA_2   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_2   : (SWU_work? !SWU_WEA : 0);
assign  ENA_3   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_3   : (SWU_work? !SWU_WEA : 0);
assign  ENA_4   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_4   : (SWU_work? !SWU_WEA : 0);
assign  ENA_5   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_5   : (SWU_work? !SWU_WEA : 0);
assign  ENA_6   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_6   : (SWU_work? !SWU_WEA : 0);
assign  ENA_7   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_7   : (SWU_work? !SWU_WEA : 0);
assign  ENA_8   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_8   : (SWU_work? !SWU_WEA : 0);
assign  ENA_9   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_9   : (SWU_work? !SWU_WEA : 0);
assign  ENA_10   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_10   : (SWU_work? !SWU_WEA : 0);
assign  ENA_11   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_11   : (SWU_work? !SWU_WEA : 0);
assign  ENA_12   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_12   : (SWU_work? !SWU_WEA : 0);
assign  ENA_13   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_13   : (SWU_work? !SWU_WEA : 0);
assign  ENA_14   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_14   : (SWU_work? !SWU_WEA : 0);
assign  ENA_15   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_15   : (SWU_work? !SWU_WEA : 0);
assign  ENA_16   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_16   : (SWU_work? !SWU_WEA : 0);
assign  ENA_17   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_17   : (SWU_work? !SWU_WEA : 0);
assign  ENA_18   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_18   : (SWU_work? !SWU_WEA : 0);
assign  ENA_19   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_19   : (SWU_work? !SWU_WEA : 0);
assign  ENA_20   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_20   : (SWU_work? !SWU_WEA : 0);
assign  ENA_21   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_21   : (SWU_work? !SWU_WEA : 0);
assign  ENA_22   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_22   : (SWU_work? !SWU_WEA : 0);
assign  ENA_23   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_23   : (SWU_work? !SWU_WEA : 0);
assign  ENA_24   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_24   : (SWU_work? !SWU_WEA : 0);
assign  ENA_25   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_25   : (SWU_work? !SWU_WEA : 0);
assign  ENA_26   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_26   : (SWU_work? !SWU_WEA : 0);
assign  ENA_27   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_27   : (SWU_work? !SWU_WEA : 0);
assign  ENA_28   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_28   : (SWU_work? !SWU_WEA : 0);
assign  ENA_29   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_29   : (SWU_work? !SWU_WEA : 0);
assign  ENA_30   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_30   : (SWU_work? !SWU_WEA : 0);
assign  ENA_31   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_31   : (SWU_work? !SWU_WEA : 0);
assign  ENA_32   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_32   : (SWU_work? !SWU_WEA : 0);
assign  ENA_33   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_33   : (SWU_work? !SWU_WEA : 0);
assign  ENA_34   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_34   : (SWU_work? !SWU_WEA : 0);
assign  ENA_35   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_35   : (SWU_work? !SWU_WEA : 0);
assign  ENA_36   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_36   : (SWU_work? !SWU_WEA : 0);
assign  ENA_37   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_37   : (SWU_work? !SWU_WEA : 0);
assign  ENA_38   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_38   : (SWU_work? !SWU_WEA : 0);
assign  ENA_39   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_39   : (SWU_work? !SWU_WEA : 0);
assign  ENA_40   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_40   : (SWU_work? !SWU_WEA : 0);
assign  ENA_41   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_41   : (SWU_work? !SWU_WEA : 0);
assign  ENA_42   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_42   : (SWU_work? !SWU_WEA : 0);
assign  ENA_43   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_43   : (SWU_work? !SWU_WEA : 0);
assign  ENA_44   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_44   : (SWU_work? !SWU_WEA : 0);
assign  ENA_45   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_45   : (SWU_work? !SWU_WEA : 0);
assign  ENA_46   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_46   : (SWU_work? !SWU_WEA : 0);
assign  ENA_47   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_47   : (SWU_work? !SWU_WEA : 0);
assign  ENA_48   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_48   : (SWU_work? !SWU_WEA : 0);
assign  ENA_49   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_49   : (SWU_work? !SWU_WEA : 0);
assign  ENA_50   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_50   : (SWU_work? !SWU_WEA : 0);
assign  ENA_51   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_51   : (SWU_work? !SWU_WEA : 0);
assign  ENA_52   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_52   : (SWU_work? !SWU_WEA : 0);
assign  ENA_53   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_53   : (SWU_work? !SWU_WEA : 0);
assign  ENA_54   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_54   : (SWU_work? !SWU_WEA : 0);
assign  ENA_55   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_55   : (SWU_work? !SWU_WEA : 0);
assign  ENA_56   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_56   : (SWU_work? !SWU_WEA : 0);
assign  ENA_57   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_57   : (SWU_work? !SWU_WEA : 0);
assign  ENA_58   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_58   : (SWU_work? !SWU_WEA : 0);
assign  ENA_59   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_59   : (SWU_work? !SWU_WEA : 0);
assign  ENA_60   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_60   : (SWU_work? !SWU_WEA : 0);
assign  ENA_61   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_61   : (SWU_work? !SWU_WEA : 0);
assign  ENA_62   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_62   : (SWU_work? !SWU_WEA : 0);
assign  ENA_63   = IB_Addr_Contr_B6_work? IB_Con_RAM_WEA_63   : (SWU_work? !SWU_WEA : 0);

Input_Buffer_B6 IB_6(       .clk(clk),
                            .rst_n(rst_n),
                            .DIN_0(RAM_DIN_0),   .DIN_1(RAM_DIN_1), .DIN_2(RAM_DIN_2),   .DIN_3(RAM_DIN_3),   .DIN_4(RAM_DIN_4),   .DIN_5(RAM_DIN_5),   .DIN_6(RAM_DIN_6),   .DIN_7(RAM_DIN_7),
                            .DIN_8(RAM_DIN_8),   .DIN_9(RAM_DIN_9), .DIN_10(RAM_DIN_10), .DIN_11(RAM_DIN_11), .DIN_12(RAM_DIN_12), .DIN_13(RAM_DIN_13), .DIN_14(RAM_DIN_14), .DIN_15(RAM_DIN_15),
                            .DIN_16(RAM_DIN_16), .DIN_17(RAM_DIN_17), .DIN_18(RAM_DIN_18), .DIN_19(RAM_DIN_19), .DIN_20(RAM_DIN_20), .DIN_21(RAM_DIN_21), .DIN_22(RAM_DIN_22), .DIN_23(RAM_DIN_23), 
                            .DIN_24(RAM_DIN_24), .DIN_25(RAM_DIN_25), .DIN_26(RAM_DIN_26), .DIN_27(RAM_DIN_27), .DIN_28(RAM_DIN_28), .DIN_29(RAM_DIN_29), .DIN_30(RAM_DIN_30), .DIN_31(RAM_DIN_31), 
                            .DIN_32(RAM_DIN_32), .DIN_33(RAM_DIN_33), .DIN_34(RAM_DIN_34), .DIN_35(RAM_DIN_35), .DIN_36(RAM_DIN_36), .DIN_37(RAM_DIN_37), .DIN_38(RAM_DIN_38), .DIN_39(RAM_DIN_39), 
                            .DIN_40(RAM_DIN_40), .DIN_41(RAM_DIN_41), .DIN_42(RAM_DIN_42), .DIN_43(RAM_DIN_43), .DIN_44(RAM_DIN_44), .DIN_45(RAM_DIN_45), .DIN_46(RAM_DIN_46), .DIN_47(RAM_DIN_47), 
                            .DIN_48(RAM_DIN_48), .DIN_49(RAM_DIN_49), .DIN_50(RAM_DIN_50), .DIN_51(RAM_DIN_51), .DIN_52(RAM_DIN_52), .DIN_53(RAM_DIN_53), .DIN_54(RAM_DIN_54), .DIN_55(RAM_DIN_55), 
                            .DIN_56(RAM_DIN_56), .DIN_57(RAM_DIN_57), .DIN_58(RAM_DIN_58), .DIN_59(RAM_DIN_59), .DIN_60(RAM_DIN_60), .DIN_61(RAM_DIN_61), .DIN_62(RAM_DIN_62), .DIN_63(RAM_DIN_63), 
                            .ADDR_0(ADDR_0), .ADDR_1(ADDR_1), .ADDR_2(ADDR_2),   .ADDR_3(ADDR_3),   .ADDR_4(ADDR_4),   .ADDR_5(ADDR_5),   .ADDR_6(ADDR_6),   .ADDR_7(ADDR_7),
                            .ADDR_8(ADDR_8), .ADDR_9(ADDR_9), .ADDR_10(ADDR_10), .ADDR_11(ADDR_11), .ADDR_12(ADDR_12), .ADDR_13(ADDR_13), .ADDR_14(ADDR_14), .ADDR_15(ADDR_15),
                            .ADDR_16(ADDR_16), .ADDR_17(ADDR_17), .ADDR_18(ADDR_18), .ADDR_19(ADDR_19), .ADDR_20(ADDR_20), .ADDR_21(ADDR_21), .ADDR_22(ADDR_22), .ADDR_23(ADDR_23), 
                            .ADDR_24(ADDR_24), .ADDR_25(ADDR_25), .ADDR_26(ADDR_26), .ADDR_27(ADDR_27), .ADDR_28(ADDR_28), .ADDR_29(ADDR_29), .ADDR_30(ADDR_30), .ADDR_31(ADDR_31), 
                            .ADDR_32(ADDR_32), .ADDR_33(ADDR_33), .ADDR_34(ADDR_34), .ADDR_35(ADDR_35), .ADDR_36(ADDR_36), .ADDR_37(ADDR_37), .ADDR_38(ADDR_38), .ADDR_39(ADDR_39), 
                            .ADDR_40(ADDR_40), .ADDR_41(ADDR_41), .ADDR_42(ADDR_42), .ADDR_43(ADDR_43), .ADDR_44(ADDR_44), .ADDR_45(ADDR_45), .ADDR_46(ADDR_46), .ADDR_47(ADDR_47), 
                            .ADDR_48(ADDR_48), .ADDR_49(ADDR_49), .ADDR_50(ADDR_50), .ADDR_51(ADDR_51), .ADDR_52(ADDR_52), .ADDR_53(ADDR_53), .ADDR_54(ADDR_54), .ADDR_55(ADDR_55), 
                            .ADDR_56(ADDR_56), .ADDR_57(ADDR_57), .ADDR_58(ADDR_58), .ADDR_59(ADDR_59), .ADDR_60(ADDR_60), .ADDR_61(ADDR_61), .ADDR_62(ADDR_62), .ADDR_63(ADDR_63),
                            .WEA_0(WEA_0),   .WEA_1(WEA_1),   .WEA_2(WEA_2),     .WEA_3(WEA_3),     .WEA_4(WEA_4),     .WEA_5(WEA_5),     .WEA_6(WEA_6),     .WEA_7(WEA_7),
                            .WEA_8(WEA_8),   .WEA_9(WEA_9),   .WEA_10(WEA_10),   .WEA_11(WEA_11),   .WEA_12(WEA_12),   .WEA_13(WEA_13),   .WEA_14(WEA_14),   .WEA_15(WEA_15),
                            .WEA_16(WEA_16), .WEA_17(WEA_17), .WEA_18(WEA_18), .WEA_19(WEA_19), .WEA_20(WEA_20), .WEA_21(WEA_21), .WEA_22(WEA_22), .WEA_23(WEA_23), 
                            .WEA_24(WEA_24), .WEA_25(WEA_25), .WEA_26(WEA_26), .WEA_27(WEA_27), .WEA_28(WEA_28), .WEA_29(WEA_29), .WEA_30(WEA_30), .WEA_31(WEA_31), 
                            .WEA_32(WEA_32), .WEA_33(WEA_33), .WEA_34(WEA_34), .WEA_35(WEA_35), .WEA_36(WEA_36), .WEA_37(WEA_37), .WEA_38(WEA_38), .WEA_39(WEA_39), 
                            .WEA_40(WEA_40), .WEA_41(WEA_41), .WEA_42(WEA_42), .WEA_43(WEA_43), .WEA_44(WEA_44), .WEA_45(WEA_45), .WEA_46(WEA_46), .WEA_47(WEA_47), 
                            .WEA_48(WEA_48), .WEA_49(WEA_49), .WEA_50(WEA_50), .WEA_51(WEA_51), .WEA_52(WEA_52), .WEA_53(WEA_53), .WEA_54(WEA_54), .WEA_55(WEA_55), 
                            .WEA_56(WEA_56), .WEA_57(WEA_57), .WEA_58(WEA_58), .WEA_59(WEA_59), .WEA_60(WEA_60), .WEA_61(WEA_61), .WEA_62(WEA_62), .WEA_63(WEA_63),
                            .ENA_0(ENA_0),   .ENA_1(ENA_1),   .ENA_2(ENA_2),     .ENA_3(ENA_3),     .ENA_4(ENA_4),     .ENA_5(ENA_5),     .ENA_6(ENA_6),     .ENA_7(ENA_7),
                            .ENA_8(ENA_8),   .ENA_9(ENA_9),   .ENA_10(ENA_10),   .ENA_11(ENA_11),   .ENA_12(ENA_12),   .ENA_13(ENA_13),   .ENA_14(ENA_14),   .ENA_15(ENA_15),
                            .ENA_16(ENA_16), .ENA_17(ENA_17), .ENA_18(ENA_18), .ENA_19(ENA_19), .ENA_20(ENA_20), .ENA_21(ENA_21), .ENA_22(ENA_22), .ENA_23(ENA_23), 
                            .ENA_24(ENA_24), .ENA_25(ENA_25), .ENA_26(ENA_26), .ENA_27(ENA_27), .ENA_28(ENA_28), .ENA_29(ENA_29), .ENA_30(ENA_30), .ENA_31(ENA_31),
                            .ENA_32(ENA_32), .ENA_33(ENA_33), .ENA_34(ENA_34), .ENA_35(ENA_35), .ENA_36(ENA_36), .ENA_37(ENA_37), .ENA_38(ENA_38), .ENA_39(ENA_39), 
                            .ENA_40(ENA_40), .ENA_41(ENA_41), .ENA_42(ENA_42), .ENA_43(ENA_43), .ENA_44(ENA_44), .ENA_45(ENA_45), .ENA_46(ENA_46), .ENA_47(ENA_47), 
                            .ENA_48(ENA_48), .ENA_49(ENA_49), .ENA_50(ENA_50), .ENA_51(ENA_51), .ENA_52(ENA_52), .ENA_53(ENA_53), .ENA_54(ENA_54), .ENA_55(ENA_55), 
                            .ENA_56(ENA_56), .ENA_57(ENA_57), .ENA_58(ENA_58), .ENA_59(ENA_59), .ENA_60(ENA_60), .ENA_61(ENA_61), .ENA_62(ENA_62), .ENA_63(ENA_63), 
                            .DOUTA_0(DOUTA_0), .DOUTA_1(DOUTA_1), .DOUTA_2(DOUTA_2),   .DOUTA_3(DOUTA_3),   .DOUTA_4(DOUTA_4),   .DOUTA_5(DOUTA_5),   .DOUTA_6(DOUTA_6),   .DOUTA_7(DOUTA_7),
                            .DOUTA_8(DOUTA_8), .DOUTA_9(DOUTA_9), .DOUTA_10(DOUTA_10), .DOUTA_11(DOUTA_11), .DOUTA_12(DOUTA_12), .DOUTA_13(DOUTA_13), .DOUTA_14(DOUTA_14), .DOUTA_15(DOUTA_15),
                            .DOUTA_16(DOUTA_16), .DOUTA_17(DOUTA_17), .DOUTA_18(DOUTA_18), .DOUTA_19(DOUTA_19), .DOUTA_20(DOUTA_20), .DOUTA_21(DOUTA_21), .DOUTA_22(DOUTA_22), .DOUTA_23(DOUTA_23), 
                            .DOUTA_24(DOUTA_24), .DOUTA_25(DOUTA_25), .DOUTA_26(DOUTA_26), .DOUTA_27(DOUTA_27), .DOUTA_28(DOUTA_28), .DOUTA_29(DOUTA_29), .DOUTA_30(DOUTA_30), .DOUTA_31(DOUTA_31),
                            .DOUTA_32(DOUTA_32), .DOUTA_33(DOUTA_33), .DOUTA_34(DOUTA_34), .DOUTA_35(DOUTA_35), .DOUTA_36(DOUTA_36), .DOUTA_37(DOUTA_37), .DOUTA_38(DOUTA_38), .DOUTA_39(DOUTA_39), 
                            .DOUTA_40(DOUTA_40), .DOUTA_41(DOUTA_41), .DOUTA_42(DOUTA_42), .DOUTA_43(DOUTA_43), .DOUTA_44(DOUTA_44), .DOUTA_45(DOUTA_45), .DOUTA_46(DOUTA_46), .DOUTA_47(DOUTA_47), 
                            .DOUTA_48(DOUTA_48), .DOUTA_49(DOUTA_49), .DOUTA_50(DOUTA_50), .DOUTA_51(DOUTA_51), .DOUTA_52(DOUTA_52), .DOUTA_53(DOUTA_53), .DOUTA_54(DOUTA_54), .DOUTA_55(DOUTA_55), 
                            .DOUTA_56(DOUTA_56), .DOUTA_57(DOUTA_57), .DOUTA_58(DOUTA_58), .DOUTA_59(DOUTA_59), .DOUTA_60(DOUTA_60), .DOUTA_61(DOUTA_61), .DOUTA_62(DOUTA_62), .DOUTA_63(DOUTA_63) 
);

wire    [6:0]       w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7, w_8, w_9, w_10, w_11, w_12, w_13, w_14, w_15, 
                    w_16, w_17, w_18, w_19, w_20, w_21, w_22, w_23, w_24, w_25, w_26, w_27, w_28, w_29, w_30, 
                    w_31, w_32, w_33, w_34, w_35, w_36, w_37, w_38, w_39, w_40, w_41, w_42, w_43, w_44, w_45, 
                    w_46, w_47, w_48, w_49, w_50, w_51, w_52, w_53, w_54, w_55, w_56, w_57, w_58, w_59, w_60, 
                    w_61, w_62, w_63;
wire    [4:0]      new_weight_val;
wire               Weight_Trans_Done;
Weight_Control_B6 WC_B6(    .clk(clk),  .rst_n(IB_Addr_Contr_B6_work_Done),
                            .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                            .w_8(w_8), .w_9(w_9), .w_10(w_10), .w_11(w_11), .w_12(w_12), .w_13(w_13), .w_14(w_14), .w_15(w_15),
                            .w_16(w_16), .w_17(w_17), .w_18(w_18), .w_19(w_19), .w_20(w_20), .w_21(w_21), .w_22(w_22), .w_23(w_23), 
                            .w_24(w_24), .w_25(w_25), .w_26(w_26), .w_27(w_27), .w_28(w_28), .w_29(w_29), .w_30(w_30), .w_31(w_31),
                            .w_32(w_32), .w_33(w_33), .w_34(w_34), .w_35(w_35), .w_36(w_36), .w_37(w_37), .w_38(w_38), .w_39(w_39), 
                            .w_40(w_40), .w_41(w_41), .w_42(w_42), .w_43(w_43), .w_44(w_44), .w_45(w_45), .w_46(w_46), .w_47(w_47), 
                            .w_48(w_48), .w_49(w_49), .w_50(w_50), .w_51(w_51), .w_52(w_52), .w_53(w_53), .w_54(w_54), .w_55(w_55), 
                            .w_56(w_56), .w_57(w_57), .w_58(w_58), .w_59(w_59), .w_60(w_60), .w_61(w_61), .w_62(w_62), .w_63(w_63),  
                            .new_weight_val(new_weight_val),
                            .Weight_Trans_Done(Weight_Trans_Done)
 );
 
 wire      [ 6:0]    Slide_data_0, Slide_data_1, Slide_data_2,  Slide_data_3,  Slide_data_4,  Slide_data_5,  Slide_data_6,  Slide_data_7,
                     Slide_data_8, Slide_data_9, Slide_data_10, Slide_data_11, Slide_data_12, Slide_data_13, Slide_data_14, Slide_data_15,
                     Slide_data_16, Slide_data_17, Slide_data_18, Slide_data_19, Slide_data_20, Slide_data_21, Slide_data_22, Slide_data_23, 
                     Slide_data_24, Slide_data_25, Slide_data_26, Slide_data_27, Slide_data_28, Slide_data_29, Slide_data_30, Slide_data_31,
                     Slide_data_32, Slide_data_33, Slide_data_34, Slide_data_35, Slide_data_36, Slide_data_37, Slide_data_38, Slide_data_39, 
                     Slide_data_40, Slide_data_41, Slide_data_42, Slide_data_43, Slide_data_44, Slide_data_45, Slide_data_46, Slide_data_47, 
                     Slide_data_48, Slide_data_49, Slide_data_50, Slide_data_51, Slide_data_52, Slide_data_53, Slide_data_54, Slide_data_55, 
                     Slide_data_56, Slide_data_57, Slide_data_58, Slide_data_59, Slide_data_60, Slide_data_61, Slide_data_62, Slide_data_63;

wire                PE_EN;
IB_SWU_Addr_Contr_B6 SWU_B6(    .clk(clk),       .rst_n(Weight_Trans_Done), 
                                .DIN_0(DOUTA_0), .DIN_1(DOUTA_1), .DIN_2(DOUTA_2), .DIN_3(DOUTA_3), 
                                .DIN_4(DOUTA_4), .DIN_5(DOUTA_5), .DIN_6(DOUTA_6), .DIN_7(DOUTA_7),
                                .DIN_8(DOUTA_8), .DIN_9(DOUTA_9), .DIN_10(DOUTA_10), .DIN_11(DOUTA_11), 
                                .DIN_12(DOUTA_12), .DIN_13(DOUTA_13), .DIN_14(DOUTA_14), .DIN_15(DOUTA_15),
                                .DIN_16(DOUTA_16),.DIN_17(DOUTA_17),.DIN_18(DOUTA_18),.DIN_19(DOUTA_19), 
                                .DIN_20(DOUTA_20),.DIN_21(DOUTA_21),.DIN_22(DOUTA_22),.DIN_23(DOUTA_23),
                                .DIN_24(DOUTA_24),.DIN_25(DOUTA_25),.DIN_26(DOUTA_26),.DIN_27(DOUTA_27),
                                .DIN_28(DOUTA_28),.DIN_29(DOUTA_29),.DIN_30(DOUTA_30),.DIN_31(DOUTA_31),
                                .DIN_32(DOUTA_32), .DIN_33(DOUTA_33), .DIN_34(DOUTA_34), .DIN_35(DOUTA_35), 
                                .DIN_36(DOUTA_36), .DIN_37(DOUTA_37), .DIN_38(DOUTA_38), .DIN_39(DOUTA_39), 
                                .DIN_40(DOUTA_40), .DIN_41(DOUTA_41), .DIN_42(DOUTA_42), .DIN_43(DOUTA_43), 
                                .DIN_44(DOUTA_44), .DIN_45(DOUTA_45), .DIN_46(DOUTA_46), .DIN_47(DOUTA_47), 
                                .DIN_48(DOUTA_48), .DIN_49(DOUTA_49), .DIN_50(DOUTA_50), .DIN_51(DOUTA_51), 
                                .DIN_52(DOUTA_52), .DIN_53(DOUTA_53), .DIN_54(DOUTA_54), .DIN_55(DOUTA_55), 
                                .DIN_56(DOUTA_56), .DIN_57(DOUTA_57), .DIN_58(DOUTA_58), .DIN_59(DOUTA_59), 
                                .DIN_60(DOUTA_60), .DIN_61(DOUTA_61), .DIN_62(DOUTA_62), .DIN_63(DOUTA_63),
                                .ADDR(SWU_ADDR), .WEA(SWU_WEA),   .IB_Addr_SWU_work(SWU_work),   .IB_Addr_SWU_work_Done(SWU_work_Done),
                                .Slide_data_0(Slide_data_0), .Slide_data_1(Slide_data_1), .Slide_data_2(Slide_data_2),   .Slide_data_3(Slide_data_3),
                                .Slide_data_4(Slide_data_4), .Slide_data_5(Slide_data_5), .Slide_data_6(Slide_data_6),   .Slide_data_7(Slide_data_7),
                                .Slide_data_8(Slide_data_8), .Slide_data_9(Slide_data_9), .Slide_data_10(Slide_data_10), .Slide_data_11(Slide_data_11),
                                .Slide_data_12(Slide_data_12), .Slide_data_13(Slide_data_13), .Slide_data_14(Slide_data_14), .Slide_data_15(Slide_data_15),
                                .Slide_data_16(Slide_data_16), .Slide_data_17(Slide_data_17), .Slide_data_18(Slide_data_18), .Slide_data_19(Slide_data_19), 
                                .Slide_data_20(Slide_data_20), .Slide_data_21(Slide_data_21), .Slide_data_22(Slide_data_22), .Slide_data_23(Slide_data_23), 
                                .Slide_data_24(Slide_data_24), .Slide_data_25(Slide_data_25), .Slide_data_26(Slide_data_26), .Slide_data_27(Slide_data_27), 
                                .Slide_data_28(Slide_data_28), .Slide_data_29(Slide_data_29), .Slide_data_30(Slide_data_30), .Slide_data_31(Slide_data_31),
                                .Slide_data_32(Slide_data_32), .Slide_data_33(Slide_data_33), .Slide_data_34(Slide_data_34), .Slide_data_35(Slide_data_35), 
                                .Slide_data_36(Slide_data_36), .Slide_data_37(Slide_data_37), .Slide_data_38(Slide_data_38), .Slide_data_39(Slide_data_39), 
                                .Slide_data_40(Slide_data_40), .Slide_data_41(Slide_data_41), .Slide_data_42(Slide_data_42), .Slide_data_43(Slide_data_43), 
                                .Slide_data_44(Slide_data_44), .Slide_data_45(Slide_data_45), .Slide_data_46(Slide_data_46), .Slide_data_47(Slide_data_47), 
                                .Slide_data_48(Slide_data_48), .Slide_data_49(Slide_data_49), .Slide_data_50(Slide_data_50), .Slide_data_51(Slide_data_51), 
                                .Slide_data_52(Slide_data_52), .Slide_data_53(Slide_data_53), .Slide_data_54(Slide_data_54), .Slide_data_55(Slide_data_55), 
                                .Slide_data_56(Slide_data_56), .Slide_data_57(Slide_data_57), .Slide_data_58(Slide_data_58), .Slide_data_59(Slide_data_59), 
                                .Slide_data_60(Slide_data_60), .Slide_data_61(Slide_data_61), .Slide_data_62(Slide_data_62), .Slide_data_63(Slide_data_63), 
                                .PE_EN(PE_EN)
);

wire signed [9:0]   o_0, o_1, o_2, o_3, o_4;
wire    B6_o_0_val;
PE_Array_B6  PE_Array_Block6(   .clk(clk), .rst_n(PE_EN), .new_weight_val(new_weight_val), 
                                .Slide_data_0(Slide_data_0), .Slide_data_1(Slide_data_1), .Slide_data_2(Slide_data_2), .Slide_data_3(Slide_data_3),
                                .Slide_data_4(Slide_data_4), .Slide_data_5(Slide_data_5), .Slide_data_6(Slide_data_6), .Slide_data_7(Slide_data_7),
                                .Slide_data_8(Slide_data_8), .Slide_data_9(Slide_data_9), .Slide_data_10(Slide_data_10), .Slide_data_11(Slide_data_11),
                                .Slide_data_12(Slide_data_12), .Slide_data_13(Slide_data_13), .Slide_data_14(Slide_data_14), .Slide_data_15(Slide_data_15),
                                .Slide_data_16(Slide_data_16), .Slide_data_17(Slide_data_17), .Slide_data_18(Slide_data_18), .Slide_data_19(Slide_data_19), 
                                .Slide_data_20(Slide_data_20), .Slide_data_21(Slide_data_21), .Slide_data_22(Slide_data_22), .Slide_data_23(Slide_data_23), 
                                .Slide_data_24(Slide_data_24), .Slide_data_25(Slide_data_25), .Slide_data_26(Slide_data_26), .Slide_data_27(Slide_data_27), 
                                .Slide_data_28(Slide_data_28), .Slide_data_29(Slide_data_29), .Slide_data_30(Slide_data_30), .Slide_data_31(Slide_data_31),
                                .Slide_data_32(Slide_data_32), .Slide_data_33(Slide_data_33), .Slide_data_34(Slide_data_34), .Slide_data_35(Slide_data_35), 
                                .Slide_data_36(Slide_data_36), .Slide_data_37(Slide_data_37), .Slide_data_38(Slide_data_38), .Slide_data_39(Slide_data_39), 
                                .Slide_data_40(Slide_data_40), .Slide_data_41(Slide_data_41), .Slide_data_42(Slide_data_42), .Slide_data_43(Slide_data_43), 
                                .Slide_data_44(Slide_data_44), .Slide_data_45(Slide_data_45), .Slide_data_46(Slide_data_46), .Slide_data_47(Slide_data_47), 
                                .Slide_data_48(Slide_data_48), .Slide_data_49(Slide_data_49), .Slide_data_50(Slide_data_50), .Slide_data_51(Slide_data_51), 
                                .Slide_data_52(Slide_data_52), .Slide_data_53(Slide_data_53), .Slide_data_54(Slide_data_54), .Slide_data_55(Slide_data_55), 
                                .Slide_data_56(Slide_data_56), .Slide_data_57(Slide_data_57), .Slide_data_58(Slide_data_58), .Slide_data_59(Slide_data_59), 
                                .Slide_data_60(Slide_data_60), .Slide_data_61(Slide_data_61), .Slide_data_62(Slide_data_62), .Slide_data_63(Slide_data_63), 
                                .o_0(o_0), .o_1(o_1), .o_2(o_2),   .o_3(o_3),   .o_4(o_4),  
                                .o_0_val(B6_o_0_val),
                                .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                                .w_8(w_8), .w_9(w_9), .w_10(w_10), .w_11(w_11), .w_12(w_12), .w_13(w_13), .w_14(w_14), .w_15(w_15),
                                .w_16(w_16), .w_17(w_17), .w_18(w_18), .w_19(w_19), .w_20(w_20), .w_21(w_21), .w_22(w_22), .w_23(w_23), 
                                .w_24(w_24), .w_25(w_25), .w_26(w_26), .w_27(w_27), .w_28(w_28), .w_29(w_29), .w_30(w_30), .w_31(w_31),
                                .w_32(w_32), .w_33(w_33), .w_34(w_34), .w_35(w_35), .w_36(w_36), .w_37(w_37), .w_38(w_38), .w_39(w_39), 
                                .w_40(w_40), .w_41(w_41), .w_42(w_42), .w_43(w_43), .w_44(w_44), .w_45(w_45), .w_46(w_46), .w_47(w_47), 
                                .w_48(w_48), .w_49(w_49), .w_50(w_50), .w_51(w_51), .w_52(w_52), .w_53(w_53), .w_54(w_54), .w_55(w_55), 
                                .w_56(w_56), .w_57(w_57), .w_58(w_58), .w_59(w_59), .w_60(w_60), .w_61(w_61), .w_62(w_62), .w_63(w_63) 
);
wire    [9:0]       max_0, max_1, max_2, max_3, max_4;
wire                Max_out_Val;
Maxpool_B6 Max_Pool(    .clk(clk), .rst_n(rst_n), 
                        .o_0(o_0), .o_1(o_1), .o_2(o_2),   .o_3(o_3),   .o_4(o_4), 
                        .o_0_val(B6_o_0_val),
                        .max_0(max_0), .max_1(max_1), .max_2(max_2), .max_3(max_3), .max_4(max_4), 
                        .Max_out_Val(Max_out_Val)
                        );
AKX_PLUS_B akx_plus_b(  .clk(clk), .rst_n(rst_n),
                        .o_0_val(B6_o_0_val),
                        .Max_out_Val(Max_out_Val),
                        .max_0(max_0), .max_1(max_1), .max_2(max_2), .max_3(max_3), .max_4(max_4),
                        .class(class)
);

endmodule
