`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 20:45:49
// Design Name: 
// Module Name: PE_Row_B6
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


module PE_Row_B6(
    input                           clk,
    input                           rst_n,
    input                           new_weight_val,
    input                   [6:0]   w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7, w_8, w_9, w_10, w_11, w_12, w_13, w_14, w_15,
                                    w_16, w_17, w_18, w_19, w_20, w_21, w_22, w_23, w_24, w_25, w_26, w_27, w_28, w_29, w_30, w_31,
                                    w_32, w_33, w_34, w_35, w_36, w_37, w_38, w_39, w_40, w_41, w_42, w_43, w_44, w_45, w_46, w_47, 
                                    w_48, w_49, w_50, w_51, w_52, w_53, w_54, w_55, w_56, w_57, w_58, w_59, w_60, w_61, w_62, w_63,
    input                   [6:0]   Slide_data_0, Slide_data_1, Slide_data_2, Slide_data_3, Slide_data_4, Slide_data_5, Slide_data_6, Slide_data_7,
                                    Slide_data_8, Slide_data_9, Slide_data_10, Slide_data_11, Slide_data_12, Slide_data_13, Slide_data_14, Slide_data_15,
                                    Slide_data_16, Slide_data_17, Slide_data_18, Slide_data_19, Slide_data_20, Slide_data_21, Slide_data_22, Slide_data_23, 
                                    Slide_data_24, Slide_data_25, Slide_data_26, Slide_data_27, Slide_data_28, Slide_data_29, Slide_data_30, Slide_data_31,
                                    Slide_data_32, Slide_data_33, Slide_data_34, Slide_data_35, Slide_data_36, Slide_data_37, Slide_data_38, Slide_data_39, 
                                    Slide_data_40, Slide_data_41, Slide_data_42, Slide_data_43, Slide_data_44, Slide_data_45, Slide_data_46, Slide_data_47, 
                                    Slide_data_48, Slide_data_49, Slide_data_50, Slide_data_51, Slide_data_52, Slide_data_53, Slide_data_54, Slide_data_55, 
                                    Slide_data_56, Slide_data_57, Slide_data_58, Slide_data_59, Slide_data_60, Slide_data_61, Slide_data_62, Slide_data_63,
    output    wire          [6:0]   in_data_to_next_pe_0, in_data_to_next_pe_1, in_data_to_next_pe_2, in_data_to_next_pe_3, 
                                    in_data_to_next_pe_4, in_data_to_next_pe_5, in_data_to_next_pe_6, in_data_to_next_pe_7,
                                    in_data_to_next_pe_8, in_data_to_next_pe_9, in_data_to_next_pe_10, in_data_to_next_pe_11, 
                                    in_data_to_next_pe_12, in_data_to_next_pe_13, in_data_to_next_pe_14, in_data_to_next_pe_15,
                                    in_data_to_next_pe_16, in_data_to_next_pe_17, in_data_to_next_pe_18, in_data_to_next_pe_19, 
                                    in_data_to_next_pe_20, in_data_to_next_pe_21, in_data_to_next_pe_22, in_data_to_next_pe_23, 
                                    in_data_to_next_pe_24, in_data_to_next_pe_25, in_data_to_next_pe_26, in_data_to_next_pe_27, 
                                    in_data_to_next_pe_28, in_data_to_next_pe_29, in_data_to_next_pe_30, in_data_to_next_pe_31,
                                    in_data_to_next_pe_32, in_data_to_next_pe_33, in_data_to_next_pe_34, in_data_to_next_pe_35, 
                                    in_data_to_next_pe_36, in_data_to_next_pe_37, in_data_to_next_pe_38, in_data_to_next_pe_39, 
                                    in_data_to_next_pe_40, in_data_to_next_pe_41, in_data_to_next_pe_42, in_data_to_next_pe_43, 
                                    in_data_to_next_pe_44, in_data_to_next_pe_45, in_data_to_next_pe_46, in_data_to_next_pe_47, 
                                    in_data_to_next_pe_48, in_data_to_next_pe_49, in_data_to_next_pe_50, in_data_to_next_pe_51, 
                                    in_data_to_next_pe_52, in_data_to_next_pe_53, in_data_to_next_pe_54, in_data_to_next_pe_55, 
                                    in_data_to_next_pe_56, in_data_to_next_pe_57, in_data_to_next_pe_58, in_data_to_next_pe_59, 
                                    in_data_to_next_pe_60, in_data_to_next_pe_61, in_data_to_next_pe_62, in_data_to_next_pe_63,
                                     
    output    wire                  next_row_en,
    output    reg  signed   [9:0]   result,
    output    reg                   out_val
);
wire signed [3:0]  o_00, o_01, o_02, o_03, o_04, o_05, o_06, o_07,o_08, o_09, o_10, o_11, o_12, o_13, o_14, o_15, 
                   o_16, o_17, o_18, o_19, o_20, o_21, o_22, o_23, o_24, o_25, o_26, o_27, o_28, o_29, o_30, o_31,
                   o_32, o_33, o_34, o_35, o_36, o_37, o_38, o_39, o_40, o_41, o_42, o_43, o_44, o_45, o_46, o_47,
                   o_48, o_49, o_50, o_51, o_52, o_53, o_54, o_55, o_56, o_57, o_58, o_59, o_60, o_61, o_62, o_63;

pe PE_00(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_0), 
            .weight_data(w_0), 
            .out(o_00), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_0), 
            .next_pe_en(next_row_en)
            );


pe PE_01(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_1), 
            .weight_data(w_1), 
            .out(o_01), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_1), 
            .next_pe_en()
            );

pe PE_02(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_2), 
            .weight_data(w_2), 
            .out(o_02), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_2), 
            .next_pe_en()
            );

pe PE_03(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_3), 
            .weight_data(w_3), 
            .out(o_03), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_3), 
            .next_pe_en()
            );

pe PE_04(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_4), 
            .weight_data(w_4), 
            .out(o_04), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_4), 
            .next_pe_en()
            );

pe PE_05(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_5), 
            .weight_data(w_5), 
            .out(o_05), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_5), 
            .next_pe_en()
            );

pe PE_06(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_6), 
            .weight_data(w_6), 
            .out(o_06), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_6), 
            .next_pe_en()
            );

pe PE_07(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_7), 
            .weight_data(w_7), 
            .out(o_07), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_7), 
            .next_pe_en()
            );

pe PE_08(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_8), 
            .weight_data(w_8), 
            .out(o_08), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_8), 
            .next_pe_en()
            );

pe PE_09(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_9), 
            .weight_data(w_9), 
            .out(o_09), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_9), 
            .next_pe_en()
            );
// PE_10
pe PE_10(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_10), 
            .weight_data(w_10), 
            .out(o_10), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_10), 
            .next_pe_en()
            );

// PE_11
pe PE_11(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_11), 
            .weight_data(w_11), 
            .out(o_11), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_11), 
            .next_pe_en()
            );

// PE_12
pe PE_12(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_12), 
            .weight_data(w_12), 
            .out(o_12), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_12), 
            .next_pe_en()
            );

// PE_13
pe PE_13(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_13), 
            .weight_data(w_13), 
            .out(o_13), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_13), 
            .next_pe_en()
            );

// PE_14
pe PE_14(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_14), 
            .weight_data(w_14), 
            .out(o_14), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_14), 
            .next_pe_en()
            );

pe PE_15(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_15), 
            .weight_data(w_15), 
            .out(o_15), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_15), 
            .next_pe_en()
            );

pe PE_16(  .clk(clk), 
                    .rst_n(rst_n), 
                    .input_data(Slide_data_16), 
                    .weight_data(w_16), 
                    .out(o_16), 
                    .new_weight_val(new_weight_val), 
                    .in_data_to_next_pe(in_data_to_next_pe_16), 
                    .next_pe_en()
                    );
                    
        
pe PE_17(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_17), 
            .weight_data(w_17), 
            .out(o_17), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_17), 
            .next_pe_en()
            );
            

pe PE_18(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_18), 
            .weight_data(w_18), 
            .out(o_18), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_18), 
            .next_pe_en()
            );
            

pe PE_19(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_19), 
            .weight_data(w_19), 
            .out(o_19), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_19), 
            .next_pe_en()
            );
            

pe PE_20(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_20), 
            .weight_data(w_20), 
            .out(o_20), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_20), 
            .next_pe_en()
            );
            

pe PE_21(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_21), 
            .weight_data(w_21), 
            .out(o_21), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_21), 
            .next_pe_en()
            );
            

pe PE_22(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_22), 
            .weight_data(w_22), 
            .out(o_22), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_22), 
            .next_pe_en()
            );
            

pe PE_23(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_23), 
            .weight_data(w_23), 
            .out(o_23), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_23), 
            .next_pe_en()
            );
            

pe PE_24(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_24), 
            .weight_data(w_24), 
            .out(o_24), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_24), 
            .next_pe_en()
            );
            

pe PE_25(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_25), 
            .weight_data(w_25), 
            .out(o_25), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_25), 
            .next_pe_en()
            );
            

pe PE_26(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_26), 
            .weight_data(w_26), 
            .out(o_26), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_26), 
            .next_pe_en()
            );
            

pe PE_27(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_27), 
            .weight_data(w_27), 
            .out(o_27), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_27), 
            .next_pe_en()
            );
            

pe PE_28(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_28), 
            .weight_data(w_28), 
            .out(o_28), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_28), 
            .next_pe_en()
            );
            

pe PE_29(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_29), 
            .weight_data(w_29), 
            .out(o_29), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_29), 
            .next_pe_en()
            );
            

pe PE_30(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_30), 
            .weight_data(w_30), 
            .out(o_30), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_30), 
            .next_pe_en()
            );
            

pe PE_31(  .clk(clk), 
            .rst_n(rst_n), 
            .input_data(Slide_data_31), 
            .weight_data(w_31), 
            .out(o_31), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_31), 
            .next_pe_en()
            );
pe PE_32(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_32), 
                .weight_data(w_32), 
                .out(o_32), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_32), 
                .next_pe_en()
                );
        
        pe PE_33(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_33), 
                .weight_data(w_33), 
                .out(o_33), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_33), 
                .next_pe_en()
                );
        
        pe PE_34(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_34), 
                .weight_data(w_34), 
                .out(o_34), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_34), 
                .next_pe_en()
                );
        
        pe PE_35(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_35), 
                .weight_data(w_35), 
                .out(o_35), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_35), 
                .next_pe_en()
                );
        
        pe PE_36(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_36), 
                .weight_data(w_36), 
                .out(o_36), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_36), 
                .next_pe_en()
                );
        
        pe PE_37(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_37), 
                .weight_data(w_37), 
                .out(o_37), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_37), 
                .next_pe_en()
                );
        
        pe PE_38(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_38), 
                .weight_data(w_38), 
                .out(o_38), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_38), 
                .next_pe_en()
                );
        
        pe PE_39(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_39), 
                .weight_data(w_39), 
                .out(o_39), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_39), 
                .next_pe_en()
                );
        
        pe PE_40(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_40), 
                .weight_data(w_40), 
                .out(o_40), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_40), 
                .next_pe_en()
                );
        
        pe PE_41(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_41), 
                .weight_data(w_41), 
                .out(o_41), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_41), 
                .next_pe_en()
                );
        
        pe PE_42(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_42), 
                .weight_data(w_42), 
                .out(o_42), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_42), 
                .next_pe_en()
                );
        
        pe PE_43(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_43), 
                .weight_data(w_43), 
                .out(o_43), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_43), 
                .next_pe_en()
                );
        
        pe PE_44(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_44), 
                .weight_data(w_44), 
                .out(o_44), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_44), 
                .next_pe_en()
                );
        
        pe PE_45(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_45), 
                .weight_data(w_45), 
                .out(o_45), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_45), 
                .next_pe_en()
                );
        
        pe PE_46(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_46), 
                .weight_data(w_46), 
                .out(o_46), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_46), 
                .next_pe_en()
                );
        
        pe PE_47(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_47), 
                .weight_data(w_47), 
                .out(o_47), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_47), 
                .next_pe_en()
                );
        
        pe PE_48(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_48), 
                .weight_data(w_48), 
                .out(o_48), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_48), 
                .next_pe_en()
                );
        
        pe PE_49(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_49), 
                .weight_data(w_49), 
                .out(o_49), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_49), 
                .next_pe_en()
                );
        
        pe PE_50(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_50), 
                .weight_data(w_50), 
                .out(o_50), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_50), 
                .next_pe_en()
                );
        
        pe PE_51(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_51), 
                .weight_data(w_51), 
                .out(o_51), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_51), 
                .next_pe_en()
                );
        
        pe PE_52(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_52), 
                .weight_data(w_52), 
                .out(o_52), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_52), 
                .next_pe_en()
                );
        
        pe PE_53(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_53), 
                .weight_data(w_53), 
                .out(o_53), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_53), 
                .next_pe_en()
                );
        
        pe PE_54(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_54), 
                .weight_data(w_54), 
                .out(o_54), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_54), 
                .next_pe_en()
                );
        
        pe PE_55(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_55), 
                .weight_data(w_55), 
                .out(o_55), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_55), 
                .next_pe_en()
                );
        
        pe PE_56(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_56), 
                .weight_data(w_56), 
                .out(o_56), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_56), 
                .next_pe_en()
                );
        
        pe PE_57(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_57), 
                .weight_data(w_57), 
                .out(o_57), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_57), 
                .next_pe_en()
                );
        
        pe PE_58(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_58), 
                .weight_data(w_58), 
                .out(o_58), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_58), 
                .next_pe_en()
                );
        
        pe PE_59(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_59), 
                .weight_data(w_59), 
                .out(o_59), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_59), 
                .next_pe_en()
                );
        
        pe PE_60(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_60), 
                .weight_data(w_60), 
                .out(o_60), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_60), 
                .next_pe_en()
                );
        
        pe PE_61(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_61), 
                .weight_data(w_61), 
                .out(o_61), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_61), 
                .next_pe_en()
                );
        
        pe PE_62(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_62), 
                .weight_data(w_62), 
                .out(o_62), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_62), 
                .next_pe_en()
                );
        
        pe PE_63(  .clk(clk), 
                .rst_n(rst_n), 
                .input_data(Slide_data_63), 
                .weight_data(w_63), 
                .out(o_63), 
                .new_weight_val(new_weight_val), 
                .in_data_to_next_pe(in_data_to_next_pe_63), 
                .next_pe_en()
                );
        
reg   signed  [7:0]   add_temp_0, add_temp_1, add_temp_2, add_temp_3;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        add_temp_0 <= 0;
    end
    else begin
        add_temp_0 <= o_00 + o_01 + o_02 + o_03 + o_04 + o_05 + o_06 + o_07 + o_08 + o_09 + o_10 + o_11 + o_12 + o_13 + o_14 + o_15 ;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        add_temp_1 <= 0;
    end
    else begin
        add_temp_1 <= o_16 +o_17 +o_18 +o_19 +o_20 +o_21 +o_22 +o_23 +o_24 +o_25 +o_26 +o_27 +o_28 +o_29 +o_30 +o_31 ;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        add_temp_2 <= 0;
    end
    else begin
        add_temp_2 <= o_32 +o_33 +o_34 +o_35 +o_36 +o_37 +o_38 +o_39 +o_40 +o_41 +o_42 +o_43 +o_44 +o_45 +o_46 +o_47 ;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        add_temp_3 <= 0;
    end
    else begin
        add_temp_3 <= o_48 +o_49 +o_50 +o_51 +o_52 +o_53 +o_54 +o_55 +o_56 +o_57 +o_58 +o_59 +o_60 +o_61 +o_62 +o_63;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        result <= 0;
    end
    else begin
        result <= add_temp_0 + add_temp_1 + add_temp_2 + add_temp_3;
    end
end




reg   [2:0]  cnt;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
        out_val <= 0;
    end
    else begin
        if(cnt == 2)begin
            out_val <= 1;
            cnt <= 2;
        end
        else begin
            cnt <= cnt + 1;
        end
    end
end
endmodule
