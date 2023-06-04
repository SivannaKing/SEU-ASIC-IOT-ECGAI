`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/05 20:38:12
// Design Name: 
// Module Name: PE_array
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


module PE_Array_B1(
    input                       clk,
    input                       rst_n,
    input                       new_weight_val,
    input               [6:0]   w_00, w_10, w_20, w_30, w_40, w_50, w_60, w_70,   //由外部的weight buffer提供
    input               [6:0]   slide_data_0, slide_data_1, slide_data_2, slide_data_3,  //由外部的SWU提供
    output  wire signed [3:0]   o_00, o_01, o_02, o_03,
                                o_10, o_11, o_12, o_13,
                                o_20, o_21, o_22, o_23,
                                o_30, o_31, o_32, o_33,
                                o_40, o_41, o_42, o_43,
                                o_50, o_51, o_52, o_53,
                                o_60, o_61, o_62, o_63,
                                o_70, o_71, o_72, o_73   //4列8行的PE的输出
);
    
//第一列的8个PE
wire [6:0]  in_data_to_next_pe_10, in_data_to_next_pe_20, in_data_to_next_pe_30, in_data_to_next_pe_40, in_data_to_next_pe_50, in_data_to_next_pe_60, in_data_to_next_pe_70;
wire        pe_10_en, pe_20_en, pe_30_en, pe_40_en, pe_50_en, pe_60_en, pe_70_en;

pe PE_00(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(slide_data_0), 
            .weight_data(w_00), 
            .out(o_00), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_10), 
            .next_pe_en(pe_10_en)
            );
pe PE_10(   .clk(clk), 
            .rst_n(pe_10_en), 
            .input_data(in_data_to_next_pe_10), 
            .weight_data(w_10), 
            .out(o_10), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_20),
            .next_pe_en(pe_20_en)
            );
pe PE_20(   .clk(clk), 
            .rst_n(pe_20_en), 
            .input_data(in_data_to_next_pe_20), 
            .weight_data(w_20), 
            .out(o_20), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_30),
            .next_pe_en(pe_30_en)
            );
pe PE_30(   .clk(clk), 
            .rst_n(pe_30_en), 
            .input_data(in_data_to_next_pe_30), 
            .weight_data(w_30), 
            .out(o_30), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_40),
            .next_pe_en(pe_40_en)
            );
pe PE_40(   .clk(clk), 
            .rst_n(pe_40_en), 
            .input_data(in_data_to_next_pe_40), 
            .weight_data(w_40), 
            .out(o_40), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_50),
            .next_pe_en(pe_50_en)
            ); 
pe PE_50(   .clk(clk), 
            .rst_n(pe_50_en), 
            .input_data(in_data_to_next_pe_50), 
            .weight_data(w_50), 
            .out(o_50), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_60),
            .next_pe_en(pe_60_en)
            );        
pe PE_60(   .clk(clk), 
            .rst_n(pe_60_en), 
            .input_data(in_data_to_next_pe_60), 
            .weight_data(w_60), 
            .out(o_60), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_70),
            .next_pe_en(pe_70_en)
            );  
pe PE_70(   .clk(clk), 
            .rst_n(pe_70_en), 
            .input_data(in_data_to_next_pe_70), 
            .weight_data(w_70), 
            .out(o_70), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe()
            );
            
 //第二列的8个PE
wire [6:0]  in_data_to_next_pe_11, in_data_to_next_pe_21, in_data_to_next_pe_31, in_data_to_next_pe_41, in_data_to_next_pe_51, in_data_to_next_pe_61, in_data_to_next_pe_71;
wire        pe_11_en, pe_21_en, pe_31_en, pe_41_en, pe_51_en, pe_61_en, pe_71_en;

pe PE_01(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(slide_data_1), 
            .weight_data(w_00), 
            .out(o_01), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_11), 
            .next_pe_en(pe_11_en)
            );
pe PE_11(   .clk(clk), 
            .rst_n(pe_11_en), 
            .input_data(in_data_to_next_pe_11), 
            .weight_data(w_10), 
            .out(o_11), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_21),
            .next_pe_en(pe_21_en)
            );
pe PE_21(   .clk(clk), 
            .rst_n(pe_21_en), 
            .input_data(in_data_to_next_pe_21), 
            .weight_data(w_20), 
            .out(o_21), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_31),
            .next_pe_en(pe_31_en)
            );
pe PE_31(   .clk(clk), 
            .rst_n(pe_31_en), 
            .input_data(in_data_to_next_pe_31), 
            .weight_data(w_30), 
            .out(o_31), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_41),
            .next_pe_en(pe_41_en)
            );
pe PE_41(   .clk(clk), 
            .rst_n(pe_41_en), 
            .input_data(in_data_to_next_pe_41), 
            .weight_data(w_40), 
            .out(o_41), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_51),
            .next_pe_en(pe_51_en)
            ); 
pe PE_51(   .clk(clk), 
            .rst_n(pe_51_en), 
            .input_data(in_data_to_next_pe_51), 
            .weight_data(w_50), 
            .out(o_51), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_61),
            .next_pe_en(pe_61_en)
            );        
pe PE_61(   .clk(clk), 
            .rst_n(pe_61_en), 
            .input_data(in_data_to_next_pe_61), 
            .weight_data(w_60), 
            .out(o_61), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_71),
            .next_pe_en(pe_71_en)
            );  
pe PE_71(   .clk(clk), 
            .rst_n(pe_71_en), 
            .input_data(in_data_to_next_pe_71), 
            .weight_data(w_70), 
            .out(o_71), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe()
            );

//第3列的8个PE
wire [6:0]  in_data_to_next_pe_12, in_data_to_next_pe_22, in_data_to_next_pe_32, in_data_to_next_pe_42, in_data_to_next_pe_52, in_data_to_next_pe_62, in_data_to_next_pe_72;
wire        pe_12_en, pe_22_en, pe_32_en, pe_42_en, pe_52_en, pe_62_en, pe_72_en;

pe PE_02(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(slide_data_2), 
            .weight_data(w_00), 
            .out(o_02), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_12), 
            .next_pe_en(pe_12_en)
            );
pe PE_12(   .clk(clk), 
            .rst_n(pe_12_en), 
            .input_data(in_data_to_next_pe_12), 
            .weight_data(w_10), 
            .out(o_12), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_22),
            .next_pe_en(pe_22_en)
            );
pe PE_22(   .clk(clk), 
            .rst_n(pe_22_en), 
            .input_data(in_data_to_next_pe_22), 
            .weight_data(w_20), 
            .out(o_22), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_32),
            .next_pe_en(pe_32_en)
            );
pe PE_32(   .clk(clk), 
            .rst_n(pe_32_en), 
            .input_data(in_data_to_next_pe_32), 
            .weight_data(w_30), 
            .out(o_32), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_42),
            .next_pe_en(pe_42_en)
            );
pe PE_42(   .clk(clk), 
            .rst_n(pe_42_en), 
            .input_data(in_data_to_next_pe_42), 
            .weight_data(w_40), 
            .out(o_42), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_52),
            .next_pe_en(pe_52_en)
            ); 
pe PE_52(   .clk(clk), 
            .rst_n(pe_52_en), 
            .input_data(in_data_to_next_pe_52), 
            .weight_data(w_50), 
            .out(o_52), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_62),
            .next_pe_en(pe_62_en)
            );        
pe PE_62(   .clk(clk), 
            .rst_n(pe_62_en), 
            .input_data(in_data_to_next_pe_62), 
            .weight_data(w_60), 
            .out(o_62), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_72),
            .next_pe_en(pe_72_en)
            );  
pe PE_72(   .clk(clk), 
            .rst_n(pe_72_en), 
            .input_data(in_data_to_next_pe_72), 
            .weight_data(w_70), 
            .out(o_72), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(),
            .next_pe_en()
            );

//第4列的8个PE
wire [6:0]  in_data_to_next_pe_13, in_data_to_next_pe_23, in_data_to_next_pe_33, in_data_to_next_pe_43, in_data_to_next_pe_53, in_data_to_next_pe_63, in_data_to_next_pe_73;
wire        pe_13_en, pe_23_en, pe_33_en, pe_43_en, pe_53_en, pe_63_en, pe_73_en;

pe PE_03(   .clk(clk), 
            .rst_n(rst_n), 
            .input_data(slide_data_3), 
            .weight_data(w_00), 
            .out(o_03), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_13), 
            .next_pe_en(pe_13_en)
            );
pe PE_13(   .clk(clk), 
            .rst_n(pe_13_en), 
            .input_data(in_data_to_next_pe_13), 
            .weight_data(w_10), 
            .out(o_13), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_23),
            .next_pe_en(pe_23_en)
            );
pe PE_23(   .clk(clk), 
            .rst_n(pe_23_en), 
            .input_data(in_data_to_next_pe_23), 
            .weight_data(w_20), 
            .out(o_23), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_33),
            .next_pe_en(pe_33_en)
            );
pe PE_33(   .clk(clk), 
            .rst_n(pe_33_en), 
            .input_data(in_data_to_next_pe_33), 
            .weight_data(w_30), 
            .out(o_33), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_43),
            .next_pe_en(pe_43_en)
            );
pe PE_43(   .clk(clk), 
            .rst_n(pe_43_en), 
            .input_data(in_data_to_next_pe_43), 
            .weight_data(w_40), 
            .out(o_43), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_53),
            .next_pe_en(pe_53_en)
            ); 
pe PE_53(   .clk(clk), 
            .rst_n(pe_53_en), 
            .input_data(in_data_to_next_pe_53), 
            .weight_data(w_50), 
            .out(o_53), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_63),
            .next_pe_en(pe_63_en)
            );        
pe PE_63(   .clk(clk), 
            .rst_n(pe_63_en), 
            .input_data(in_data_to_next_pe_63), 
            .weight_data(w_60), 
            .out(o_63), 
            .new_weight_val(new_weight_val), 
            .in_data_to_next_pe(in_data_to_next_pe_73),
            .next_pe_en(pe_73_en)
            );  
pe PE_73(   .clk(clk), 
            .rst_n(pe_73_en), 
            .input_data(in_data_to_next_pe_73), 
            .weight_data(w_70), 
            .out(o_73), 
            .new_weight_val(new_weight_val),
            .in_data_to_next_pe(),
            .next_pe_en()
            );              
endmodule
