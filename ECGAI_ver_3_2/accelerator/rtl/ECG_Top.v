`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 15:51:53
// Design Name: 
// Module Name: ECG_Top
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


module ECG_Top(
    input                           clk,
    input                           rst_n,
    output     wire    [2:0]        class
);

wire    Bin_0, Bin_1, Bin_2, Bin_3, Bin_4, Bin_5, Bin_6, Bin_7;
wire    B1_Bin_Out_Val;
Block1_Top Block1(  .clk(clk), .rst_n(rst_n), .binary_out_val(B1_Bin_Out_Val), 
                    .Bin_0(Bin_0), .Bin_1(Bin_1), .Bin_2(Bin_2), .Bin_3(Bin_3), 
                    .Bin_4(Bin_4), .Bin_5(Bin_5), .Bin_6(Bin_6), .Bin_7(Bin_7) 
);

wire          Bout_0, Bout_1, Bout_2,  Bout_3,  Bout_4,  Bout_5,  Bout_6,  Bout_7,
              Bout_8, Bout_9, Bout_10, Bout_11, Bout_12, Bout_13, Bout_14, Bout_15;
wire          B2_o_0_val, B2_Bout_0_Val;

Block2_Top Block2(  .clk(clk), .rst_n(rst_n), .binary_in_val(B1_Bin_Out_Val), 
                    .Bin_0(Bin_0), .Bin_1(Bin_1), .Bin_2(Bin_2), .Bin_3(Bin_3), 
                    .Bin_4(Bin_4), .Bin_5(Bin_5), .Bin_6(Bin_6), .Bin_7(Bin_7),
                    .Bout_0(Bout_0), .Bout_1(Bout_1), .Bout_2(Bout_2),   .Bout_3(Bout_3),   .Bout_4(Bout_4), .Bout_5(Bout_5), .Bout_6(Bout_6), .Bout_7(Bout_7), 
                    .Bout_8(Bout_8), .Bout_9(Bout_9), .Bout_10(Bout_10), .Bout_11(Bout_11), .Bout_12(Bout_12), .Bout_13(Bout_13), .Bout_14(Bout_14), .Bout_15(Bout_15),
                    .o_0_val(B2_o_0_val),      .Bout_0_Val(B2_Bout_0_Val)                    
);

wire           B3_Bout_0, B3_Bout_1, B3_Bout_2, B3_Bout_3, B3_Bout_4, B3_Bout_5, B3_Bout_6, B3_Bout_7, 
               B3_Bout_8, B3_Bout_9, B3_Bout_10, B3_Bout_11, B3_Bout_12, B3_Bout_13, B3_Bout_14, B3_Bout_15, 
               B3_Bout_16, B3_Bout_17, B3_Bout_18, B3_Bout_19, B3_Bout_20, B3_Bout_21, B3_Bout_22, B3_Bout_23, 
               B3_Bout_24, B3_Bout_25, B3_Bout_26, B3_Bout_27, B3_Bout_28, B3_Bout_29, B3_Bout_30, B3_Bout_31;
wire           B3_Bout_0_Val, B3_o_0_val;               
Block3_Top Block3(  .clk(clk),      .rst_n(B2_o_0_val),
                    .Bout_0(Bout_0), .Bout_1(Bout_1), .Bout_2(Bout_2),   .Bout_3(Bout_3),   .Bout_4(Bout_4),   .Bout_5(Bout_5),   .Bout_6(Bout_6),   .Bout_7(Bout_7), 
                    .Bout_8(Bout_8), .Bout_9(Bout_9), .Bout_10(Bout_10), .Bout_11(Bout_11), .Bout_12(Bout_12), .Bout_13(Bout_13), .Bout_14(Bout_14), .Bout_15(Bout_15),
                    .Bout_0_Val(B2_Bout_0_Val),
                    //上面是B2对B3的Input信号，下面是B3的out信号
                    .B3_Bout_0(B3_Bout_0), .B3_Bout_1(B3_Bout_1), .B3_Bout_2(B3_Bout_2), .B3_Bout_3(B3_Bout_3), .B3_Bout_4(B3_Bout_4), .B3_Bout_5(B3_Bout_5), .B3_Bout_6(B3_Bout_6), .B3_Bout_7(B3_Bout_7), 
                    .B3_Bout_8(B3_Bout_8), .B3_Bout_9(B3_Bout_9), .B3_Bout_10(B3_Bout_10), .B3_Bout_11(B3_Bout_11), .B3_Bout_12(B3_Bout_12), .B3_Bout_13(B3_Bout_13), .B3_Bout_14(B3_Bout_14), .B3_Bout_15(B3_Bout_15), 
                    .B3_Bout_16(B3_Bout_16), .B3_Bout_17(B3_Bout_17), .B3_Bout_18(B3_Bout_18), .B3_Bout_19(B3_Bout_19), .B3_Bout_20(B3_Bout_20), .B3_Bout_21(B3_Bout_21), .B3_Bout_22(B3_Bout_22), .B3_Bout_23(B3_Bout_23), 
                    .B3_Bout_24(B3_Bout_24), .B3_Bout_25(B3_Bout_25), .B3_Bout_26(B3_Bout_26), .B3_Bout_27(B3_Bout_27), .B3_Bout_28(B3_Bout_28), .B3_Bout_29(B3_Bout_29), .B3_Bout_30(B3_Bout_30), .B3_Bout_31(B3_Bout_31),
                    .B3_Bout_0_Val(B3_Bout_0_Val),  .B3_o_0_val(B3_o_0_val)
);
wire            B4_Bout_0, B4_Bout_1, B4_Bout_2, B4_Bout_3, B4_Bout_4, B4_Bout_5, B4_Bout_6, B4_Bout_7, 
                B4_Bout_8, B4_Bout_9, B4_Bout_10, B4_Bout_11, B4_Bout_12, B4_Bout_13, B4_Bout_14, B4_Bout_15, 
                B4_Bout_16, B4_Bout_17, B4_Bout_18, B4_Bout_19, B4_Bout_20, B4_Bout_21, B4_Bout_22, B4_Bout_23, 
                B4_Bout_24, B4_Bout_25, B4_Bout_26, B4_Bout_27, B4_Bout_28, B4_Bout_29, B4_Bout_30, B4_Bout_31;
wire            B4_o_0_val, B4_Bout_0_Val;

Block4_Top Block4(  .clk(clk),         .rst_n(B3_o_0_val),
                    .Bin_0(B3_Bout_0), .Bin_1(B3_Bout_1), .Bin_2(B3_Bout_2), .Bin_3(B3_Bout_3), .Bin_4(B3_Bout_4), .Bin_5(B3_Bout_5), .Bin_6(B3_Bout_6), .Bin_7(B3_Bout_7), 
                    .Bin_8(B3_Bout_8), .Bin_9(B3_Bout_9), .Bin_10(B3_Bout_10), .Bin_11(B3_Bout_11), .Bin_12(B3_Bout_12), .Bin_13(B3_Bout_13), .Bin_14(B3_Bout_14), .Bin_15(B3_Bout_15), 
                    .Bin_16(B3_Bout_16), .Bin_17(B3_Bout_17), .Bin_18(B3_Bout_18), .Bin_19(B3_Bout_19), .Bin_20(B3_Bout_20), .Bin_21(B3_Bout_21), .Bin_22(B3_Bout_22), .Bin_23(B3_Bout_23), 
                    .Bin_24(B3_Bout_24), .Bin_25(B3_Bout_25), .Bin_26(B3_Bout_26), .Bin_27(B3_Bout_27), .Bin_28(B3_Bout_28), .Bin_29(B3_Bout_29), .Bin_30(B3_Bout_30), .Bin_31(B3_Bout_31), 
                    .Bin_0_Val(B3_Bout_0_Val),
                    //上面是B3的输出与B4的输入连接
                    .B4_Bout_0(B4_Bout_0), .B4_Bout_1(B4_Bout_1), .B4_Bout_2(B4_Bout_2), .B4_Bout_3(B4_Bout_3), .B4_Bout_4(B4_Bout_4), .B4_Bout_5(B4_Bout_5), .B4_Bout_6(B4_Bout_6), .B4_Bout_7(B4_Bout_7), 
                    .B4_Bout_8(B4_Bout_8), .B4_Bout_9(B4_Bout_9), .B4_Bout_10(B4_Bout_10), .B4_Bout_11(B4_Bout_11), .B4_Bout_12(B4_Bout_12), .B4_Bout_13(B4_Bout_13), .B4_Bout_14(B4_Bout_14), .B4_Bout_15(B4_Bout_15), 
                    .B4_Bout_16(B4_Bout_16), .B4_Bout_17(B4_Bout_17), .B4_Bout_18(B4_Bout_18), .B4_Bout_19(B4_Bout_19), .B4_Bout_20(B4_Bout_20), .B4_Bout_21(B4_Bout_21), .B4_Bout_22(B4_Bout_22), .B4_Bout_23(B4_Bout_23), 
                    .B4_Bout_24(B4_Bout_24), .B4_Bout_25(B4_Bout_25), .B4_Bout_26(B4_Bout_26), .B4_Bout_27(B4_Bout_27), .B4_Bout_28(B4_Bout_28), .B4_Bout_29(B4_Bout_29), .B4_Bout_30(B4_Bout_30), .B4_Bout_31(B4_Bout_31),
                    .B4_o_0_val(B4_o_0_val), .B4_Bout_0_Val(B4_Bout_0_Val) 
);

wire            B5_o_0_val, B5_Bout_0_Val;
wire            B5_Bout_0, B5_Bout_1, B5_Bout_2, B5_Bout_3, B5_Bout_4, B5_Bout_5, B5_Bout_6, B5_Bout_7, B5_Bout_8, B5_Bout_9, B5_Bout_10, B5_Bout_11, B5_Bout_12, B5_Bout_13, B5_Bout_14, B5_Bout_15, 
                B5_Bout_16, B5_Bout_17, B5_Bout_18, B5_Bout_19, B5_Bout_20, B5_Bout_21, B5_Bout_22, B5_Bout_23, B5_Bout_24, B5_Bout_25, B5_Bout_26, B5_Bout_27, B5_Bout_28, B5_Bout_29, B5_Bout_30, B5_Bout_31, 
                B5_Bout_32, B5_Bout_33, B5_Bout_34, B5_Bout_35, B5_Bout_36, B5_Bout_37, B5_Bout_38, B5_Bout_39, B5_Bout_40, B5_Bout_41, B5_Bout_42, B5_Bout_43, B5_Bout_44, B5_Bout_45, B5_Bout_46, B5_Bout_47, 
                B5_Bout_48, B5_Bout_49, B5_Bout_50, B5_Bout_51, B5_Bout_52, B5_Bout_53, B5_Bout_54, B5_Bout_55, B5_Bout_56, B5_Bout_57, B5_Bout_58, B5_Bout_59, B5_Bout_60, B5_Bout_61, B5_Bout_62, B5_Bout_63;
Block5_Top Block5(  .clk(clk),         .rst_n(B4_o_0_val),
                    .Bin_0(B4_Bout_0), .Bin_1(B4_Bout_1), .Bin_2(B4_Bout_2), .Bin_3(B4_Bout_3), .Bin_4(B4_Bout_4), .Bin_5(B4_Bout_5), .Bin_6(B4_Bout_6), .Bin_7(B4_Bout_7), 
                    .Bin_8(B4_Bout_8), .Bin_9(B4_Bout_9), .Bin_10(B4_Bout_10), .Bin_11(B4_Bout_11), .Bin_12(B4_Bout_12), .Bin_13(B4_Bout_13), .Bin_14(B4_Bout_14), .Bin_15(B4_Bout_15), 
                    .Bin_16(B4_Bout_16), .Bin_17(B4_Bout_17), .Bin_18(B4_Bout_18), .Bin_19(B4_Bout_19), .Bin_20(B4_Bout_20), .Bin_21(B4_Bout_21), .Bin_22(B4_Bout_22), .Bin_23(B4_Bout_23), 
                    .Bin_24(B4_Bout_24), .Bin_25(B4_Bout_25), .Bin_26(B4_Bout_26), .Bin_27(B4_Bout_27), .Bin_28(B4_Bout_28), .Bin_29(B4_Bout_29), .Bin_30(B4_Bout_30), .Bin_31(B4_Bout_31),
                    .Bin_0_Val(B4_Bout_0_Val),
                    //上面是B4的输出与B5的输入连接
                    .B5_Bout_0(B5_Bout_0), .B5_Bout_1(B5_Bout_1), .B5_Bout_2(B5_Bout_2), .B5_Bout_3(B5_Bout_3), .B5_Bout_4(B5_Bout_4), .B5_Bout_5(B5_Bout_5), .B5_Bout_6(B5_Bout_6), .B5_Bout_7(B5_Bout_7), 
                    .B5_Bout_8(B5_Bout_8), .B5_Bout_9(B5_Bout_9), .B5_Bout_10(B5_Bout_10), .B5_Bout_11(B5_Bout_11), .B5_Bout_12(B5_Bout_12), .B5_Bout_13(B5_Bout_13), .B5_Bout_14(B5_Bout_14), .B5_Bout_15(B5_Bout_15), 
                    .B5_Bout_16(B5_Bout_16), .B5_Bout_17(B5_Bout_17), .B5_Bout_18(B5_Bout_18), .B5_Bout_19(B5_Bout_19), .B5_Bout_20(B5_Bout_20), .B5_Bout_21(B5_Bout_21), .B5_Bout_22(B5_Bout_22), .B5_Bout_23(B5_Bout_23), 
                    .B5_Bout_24(B5_Bout_24), .B5_Bout_25(B5_Bout_25), .B5_Bout_26(B5_Bout_26), .B5_Bout_27(B5_Bout_27), .B5_Bout_28(B5_Bout_28), .B5_Bout_29(B5_Bout_29), .B5_Bout_30(B5_Bout_30), .B5_Bout_31(B5_Bout_31),
                    .B5_Bout_32(B5_Bout_32), .B5_Bout_33(B5_Bout_33), .B5_Bout_34(B5_Bout_34), .B5_Bout_35(B5_Bout_35), .B5_Bout_36(B5_Bout_36), .B5_Bout_37(B5_Bout_37), .B5_Bout_38(B5_Bout_38), .B5_Bout_39(B5_Bout_39), 
                    .B5_Bout_40(B5_Bout_40), .B5_Bout_41(B5_Bout_41), .B5_Bout_42(B5_Bout_42), .B5_Bout_43(B5_Bout_43), .B5_Bout_44(B5_Bout_44), .B5_Bout_45(B5_Bout_45), .B5_Bout_46(B5_Bout_46), .B5_Bout_47(B5_Bout_47), 
                    .B5_Bout_48(B5_Bout_48), .B5_Bout_49(B5_Bout_49), .B5_Bout_50(B5_Bout_50), .B5_Bout_51(B5_Bout_51), .B5_Bout_52(B5_Bout_52), .B5_Bout_53(B5_Bout_53), .B5_Bout_54(B5_Bout_54), .B5_Bout_55(B5_Bout_55), 
                    .B5_Bout_56(B5_Bout_56), .B5_Bout_57(B5_Bout_57), .B5_Bout_58(B5_Bout_58), .B5_Bout_59(B5_Bout_59), .B5_Bout_60(B5_Bout_60), .B5_Bout_61(B5_Bout_61), .B5_Bout_62(B5_Bout_62), .B5_Bout_63(B5_Bout_63), 
                    .B5_o_0_val(B5_o_0_val), .B5_Bout_0_Val(B5_Bout_0_Val)
);

Block6_Top Block6(  .clk(clk),         .rst_n(B5_o_0_val), .Bin_0_Val(B5_Bout_0_Val),
                    .Bin_0(B5_Bout_0), .Bin_1(B5_Bout_1), .Bin_2(B5_Bout_2), .Bin_3(B5_Bout_3), .Bin_4(B5_Bout_4), .Bin_5(B5_Bout_5), .Bin_6(B5_Bout_6), .Bin_7(B5_Bout_7), 
                    .Bin_8(B5_Bout_8), .Bin_9(B5_Bout_9), .Bin_10(B5_Bout_10), .Bin_11(B5_Bout_11), .Bin_12(B5_Bout_12), .Bin_13(B5_Bout_13), .Bin_14(B5_Bout_14), 
                    .Bin_15(B5_Bout_15), .Bin_16(B5_Bout_16), .Bin_17(B5_Bout_17), .Bin_18(B5_Bout_18), .Bin_19(B5_Bout_19), .Bin_20(B5_Bout_20), .Bin_21(B5_Bout_21), .Bin_22(B5_Bout_22), 
                    .Bin_23(B5_Bout_23), .Bin_24(B5_Bout_24), .Bin_25(B5_Bout_25), .Bin_26(B5_Bout_26), .Bin_27(B5_Bout_27), .Bin_28(B5_Bout_28), .Bin_29(B5_Bout_29), .Bin_30(B5_Bout_30), 
                    .Bin_31(B5_Bout_31), .Bin_32(B5_Bout_32), .Bin_33(B5_Bout_33), .Bin_34(B5_Bout_34), .Bin_35(B5_Bout_35), .Bin_36(B5_Bout_36), .Bin_37(B5_Bout_37), .Bin_38(B5_Bout_38), 
                    .Bin_39(B5_Bout_39), .Bin_40(B5_Bout_40), .Bin_41(B5_Bout_41), .Bin_42(B5_Bout_42), .Bin_43(B5_Bout_43), .Bin_44(B5_Bout_44), .Bin_45(B5_Bout_45), .Bin_46(B5_Bout_46), 
                    .Bin_47(B5_Bout_47), .Bin_48(B5_Bout_48), .Bin_49(B5_Bout_49), .Bin_50(B5_Bout_50), .Bin_51(B5_Bout_51), .Bin_52(B5_Bout_52), .Bin_53(B5_Bout_53), .Bin_54(B5_Bout_54), 
                    .Bin_55(B5_Bout_55), .Bin_56(B5_Bout_56), .Bin_57(B5_Bout_57), .Bin_58(B5_Bout_58), .Bin_59(B5_Bout_59), .Bin_60(B5_Bout_60), .Bin_61(B5_Bout_61), .Bin_62(B5_Bout_62), .Bin_63(B5_Bout_63),
                    .class(class)
);
endmodule
