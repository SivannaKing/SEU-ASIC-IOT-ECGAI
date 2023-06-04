`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 09:25:07
// Design Name: 
// Module Name: PE_Array_B2
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


module PE_Array_B2(
    input                       clk,
    input                       rst_n,
    input               [15:0]  new_weight_val,
    input               [6:0]   w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7,   //由外部的weight buffer提供
    input               [6:0]   Slide_data_0, Slide_data_1, Slide_data_2, Slide_data_3, Slide_data_4, Slide_data_5, Slide_data_6, Slide_data_7,  //由外部的SWU提供
    output  wire signed [6:0]   o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7, o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15,
    output  wire                o_0_val  
);
wire                    o_1_val, o_2_val, o_3_val, o_4_val, o_5_val, o_6_val, o_7_val, o_8_val, o_9_val, o_10_val, o_11_val, o_12_val, o_13_val, o_14_val, o_15_val;
wire        [6:0]       in_data_to_next_pe_00, in_data_to_next_pe_01, in_data_to_next_pe_02, in_data_to_next_pe_03,  //0
                        in_data_to_next_pe_04, in_data_to_next_pe_05, in_data_to_next_pe_06, in_data_to_next_pe_07,
                        
                        in_data_to_next_pe_10, in_data_to_next_pe_11, in_data_to_next_pe_12, in_data_to_next_pe_13, //1
                        in_data_to_next_pe_14, in_data_to_next_pe_15, in_data_to_next_pe_16, in_data_to_next_pe_17,
                        
                        in_data_to_next_pe_20, in_data_to_next_pe_21, in_data_to_next_pe_22, in_data_to_next_pe_23,  //2
                        in_data_to_next_pe_24, in_data_to_next_pe_25, in_data_to_next_pe_26, in_data_to_next_pe_27,
                        
                        in_data_to_next_pe_30, in_data_to_next_pe_31, in_data_to_next_pe_32, in_data_to_next_pe_33,  //3
                        in_data_to_next_pe_34, in_data_to_next_pe_35, in_data_to_next_pe_36, in_data_to_next_pe_37,
                        
                        in_data_to_next_pe_40, in_data_to_next_pe_41, in_data_to_next_pe_42, in_data_to_next_pe_43,  //4
                        in_data_to_next_pe_44, in_data_to_next_pe_45, in_data_to_next_pe_46, in_data_to_next_pe_47,
                        
                        in_data_to_next_pe_50, in_data_to_next_pe_51, in_data_to_next_pe_52, in_data_to_next_pe_53,  //5
                        in_data_to_next_pe_54, in_data_to_next_pe_55, in_data_to_next_pe_56, in_data_to_next_pe_57,
                        
                        in_data_to_next_pe_60, in_data_to_next_pe_61, in_data_to_next_pe_62, in_data_to_next_pe_63,  //6
                        in_data_to_next_pe_64, in_data_to_next_pe_65, in_data_to_next_pe_66, in_data_to_next_pe_67,
                        
                        in_data_to_next_pe_70, in_data_to_next_pe_71, in_data_to_next_pe_72, in_data_to_next_pe_73,  //7
                        in_data_to_next_pe_74, in_data_to_next_pe_75, in_data_to_next_pe_76, in_data_to_next_pe_77,
                        
                        in_data_to_next_pe_80, in_data_to_next_pe_81, in_data_to_next_pe_82, in_data_to_next_pe_83,  //8
                        in_data_to_next_pe_84, in_data_to_next_pe_85, in_data_to_next_pe_86, in_data_to_next_pe_87,
                        
                        in_data_to_next_pe_90, in_data_to_next_pe_91, in_data_to_next_pe_92, in_data_to_next_pe_93,  //9
                        in_data_to_next_pe_94, in_data_to_next_pe_95, in_data_to_next_pe_96, in_data_to_next_pe_97,
                        
                        in_data_to_next_pe_10_0, in_data_to_next_pe_10_1, in_data_to_next_pe_10_2, in_data_to_next_pe_10_3,  //10  
                        in_data_to_next_pe_10_4, in_data_to_next_pe_10_5, in_data_to_next_pe_10_6, in_data_to_next_pe_10_7,
                        
                        in_data_to_next_pe_11_0, in_data_to_next_pe_11_1, in_data_to_next_pe_11_2, in_data_to_next_pe_11_3,  //11
                        in_data_to_next_pe_11_4, in_data_to_next_pe_11_5, in_data_to_next_pe_11_6, in_data_to_next_pe_11_7,
                        
                        in_data_to_next_pe_12_0, in_data_to_next_pe_12_1, in_data_to_next_pe_12_2, in_data_to_next_pe_12_3,  //12
                        in_data_to_next_pe_12_4, in_data_to_next_pe_12_5, in_data_to_next_pe_12_6, in_data_to_next_pe_12_7,
                        
                        in_data_to_next_pe_13_0, in_data_to_next_pe_13_1, in_data_to_next_pe_13_2, in_data_to_next_pe_13_3,  //13
                        in_data_to_next_pe_13_4, in_data_to_next_pe_13_5, in_data_to_next_pe_13_6, in_data_to_next_pe_13_7,
                        
                        in_data_to_next_pe_14_0, in_data_to_next_pe_14_1, in_data_to_next_pe_14_2, in_data_to_next_pe_14_3,  //14
                        in_data_to_next_pe_14_4, in_data_to_next_pe_14_5, in_data_to_next_pe_14_6, in_data_to_next_pe_14_7,
                        
                        in_data_to_next_pe_15_0, in_data_to_next_pe_15_1, in_data_to_next_pe_15_2, in_data_to_next_pe_15_3,  //15
                        in_data_to_next_pe_15_4, in_data_to_next_pe_15_5, in_data_to_next_pe_15_6, in_data_to_next_pe_15_7;

wire                    row_1_en, row_2_en,  row_3_en,  row_4_en,  row_5_en,  row_6_en,  row_7_en, row_8_en, 
                        row_9_en, row_10_en, row_11_en, row_12_en, row_13_en, row_14_en, row_15_en;


PE_Row_B2   PE_R0_B2(   .clk(clk), .rst_n(rst_n), .new_weight_val(new_weight_val[0]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(Slide_data_0), .Slide_data_1(Slide_data_1),
                        .Slide_data_2(Slide_data_2), .Slide_data_3(Slide_data_3), 
                        .Slide_data_4(Slide_data_4), .Slide_data_5(Slide_data_5),
                        .Slide_data_6(Slide_data_6), .Slide_data_7(Slide_data_7),
                        .in_data_to_next_pe_0(in_data_to_next_pe_10), .in_data_to_next_pe_1(in_data_to_next_pe_11),
                        .in_data_to_next_pe_2(in_data_to_next_pe_12), .in_data_to_next_pe_3(in_data_to_next_pe_13),
                        .in_data_to_next_pe_4(in_data_to_next_pe_14), .in_data_to_next_pe_5(in_data_to_next_pe_15),
                        .in_data_to_next_pe_6(in_data_to_next_pe_16), .in_data_to_next_pe_7(in_data_to_next_pe_17),
                        .next_row_en(row_1_en),  
                        .result(o_0),
                        .out_val(o_0_val)  
);

PE_Row_B2   PE_R1_B2(   .clk(clk), .rst_n(row_1_en), .new_weight_val(new_weight_val[1]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_10), .Slide_data_1(in_data_to_next_pe_11),
                        .Slide_data_2(in_data_to_next_pe_12), .Slide_data_3(in_data_to_next_pe_13), 
                        .Slide_data_4(in_data_to_next_pe_14), .Slide_data_5(in_data_to_next_pe_15),
                        .Slide_data_6(in_data_to_next_pe_16), .Slide_data_7(in_data_to_next_pe_17),
                        .in_data_to_next_pe_0(in_data_to_next_pe_20), .in_data_to_next_pe_1(in_data_to_next_pe_21),
                        .in_data_to_next_pe_2(in_data_to_next_pe_22), .in_data_to_next_pe_3(in_data_to_next_pe_23),
                        .in_data_to_next_pe_4(in_data_to_next_pe_24), .in_data_to_next_pe_5(in_data_to_next_pe_25),
                        .in_data_to_next_pe_6(in_data_to_next_pe_26), .in_data_to_next_pe_7(in_data_to_next_pe_27),
                        .next_row_en(row_2_en),
                        .result(o_1),
                        .out_val(o_1_val)   
);

PE_Row_B2   PE_R2_B2(   .clk(clk), .rst_n(row_2_en), .new_weight_val(new_weight_val[2]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_20), .Slide_data_1(in_data_to_next_pe_21),
                        .Slide_data_2(in_data_to_next_pe_22), .Slide_data_3(in_data_to_next_pe_23), 
                        .Slide_data_4(in_data_to_next_pe_24), .Slide_data_5(in_data_to_next_pe_25),
                        .Slide_data_6(in_data_to_next_pe_26), .Slide_data_7(in_data_to_next_pe_27),
                        .in_data_to_next_pe_0(in_data_to_next_pe_30), .in_data_to_next_pe_1(in_data_to_next_pe_31),
                        .in_data_to_next_pe_2(in_data_to_next_pe_32), .in_data_to_next_pe_3(in_data_to_next_pe_33),
                        .in_data_to_next_pe_4(in_data_to_next_pe_34), .in_data_to_next_pe_5(in_data_to_next_pe_35),
                        .in_data_to_next_pe_6(in_data_to_next_pe_36), .in_data_to_next_pe_7(in_data_to_next_pe_37),
                        .next_row_en(row_3_en),
                        .result(o_2),
                        .out_val(o_2_val)   
);

PE_Row_B2   PE_R3_B2(   .clk(clk), .rst_n(row_3_en), .new_weight_val(new_weight_val[3]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_30), .Slide_data_1(in_data_to_next_pe_31),
                        .Slide_data_2(in_data_to_next_pe_32), .Slide_data_3(in_data_to_next_pe_33), 
                        .Slide_data_4(in_data_to_next_pe_34), .Slide_data_5(in_data_to_next_pe_35),
                        .Slide_data_6(in_data_to_next_pe_36), .Slide_data_7(in_data_to_next_pe_37),
                        .in_data_to_next_pe_0(in_data_to_next_pe_40), .in_data_to_next_pe_1(in_data_to_next_pe_41),
                        .in_data_to_next_pe_2(in_data_to_next_pe_42), .in_data_to_next_pe_3(in_data_to_next_pe_43),
                        .in_data_to_next_pe_4(in_data_to_next_pe_44), .in_data_to_next_pe_5(in_data_to_next_pe_45),
                        .in_data_to_next_pe_6(in_data_to_next_pe_46), .in_data_to_next_pe_7(in_data_to_next_pe_47),
                        .next_row_en(row_4_en),
                        .result(o_3),
                        .out_val(o_3_val)   
);

PE_Row_B2   PE_R4_B2(   .clk(clk), .rst_n(row_4_en), .new_weight_val(new_weight_val[4]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_40), .Slide_data_1(in_data_to_next_pe_41),
                        .Slide_data_2(in_data_to_next_pe_42), .Slide_data_3(in_data_to_next_pe_43), 
                        .Slide_data_4(in_data_to_next_pe_44), .Slide_data_5(in_data_to_next_pe_45),
                        .Slide_data_6(in_data_to_next_pe_46), .Slide_data_7(in_data_to_next_pe_47),
                        .in_data_to_next_pe_0(in_data_to_next_pe_50), .in_data_to_next_pe_1(in_data_to_next_pe_51),
                        .in_data_to_next_pe_2(in_data_to_next_pe_52), .in_data_to_next_pe_3(in_data_to_next_pe_53),
                        .in_data_to_next_pe_4(in_data_to_next_pe_54), .in_data_to_next_pe_5(in_data_to_next_pe_55),
                        .in_data_to_next_pe_6(in_data_to_next_pe_56), .in_data_to_next_pe_7(in_data_to_next_pe_57),
                        .next_row_en(row_5_en),
                        .result(o_4),
                        .out_val(o_4_val)   
);


PE_Row_B2   PE_R5_B2(   .clk(clk), .rst_n(row_5_en), .new_weight_val(new_weight_val[5]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_50), .Slide_data_1(in_data_to_next_pe_51),
                        .Slide_data_2(in_data_to_next_pe_52), .Slide_data_3(in_data_to_next_pe_53), 
                        .Slide_data_4(in_data_to_next_pe_54), .Slide_data_5(in_data_to_next_pe_55),
                        .Slide_data_6(in_data_to_next_pe_56), .Slide_data_7(in_data_to_next_pe_57),
                        .in_data_to_next_pe_0(in_data_to_next_pe_60), .in_data_to_next_pe_1(in_data_to_next_pe_61),
                        .in_data_to_next_pe_2(in_data_to_next_pe_62), .in_data_to_next_pe_3(in_data_to_next_pe_63),
                        .in_data_to_next_pe_4(in_data_to_next_pe_64), .in_data_to_next_pe_5(in_data_to_next_pe_65),
                        .in_data_to_next_pe_6(in_data_to_next_pe_66), .in_data_to_next_pe_7(in_data_to_next_pe_67),
                        .next_row_en(row_6_en),
                        .result(o_5),
                        .out_val(o_5_val)   
);

PE_Row_B2   PE_R6_B2(   .clk(clk), .rst_n(row_6_en), .new_weight_val(new_weight_val[6]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_60), .Slide_data_1(in_data_to_next_pe_61),
                        .Slide_data_2(in_data_to_next_pe_62), .Slide_data_3(in_data_to_next_pe_63), 
                        .Slide_data_4(in_data_to_next_pe_64), .Slide_data_5(in_data_to_next_pe_65),
                        .Slide_data_6(in_data_to_next_pe_66), .Slide_data_7(in_data_to_next_pe_67),
                        .in_data_to_next_pe_0(in_data_to_next_pe_70), .in_data_to_next_pe_1(in_data_to_next_pe_71),
                        .in_data_to_next_pe_2(in_data_to_next_pe_72), .in_data_to_next_pe_3(in_data_to_next_pe_73),
                        .in_data_to_next_pe_4(in_data_to_next_pe_74), .in_data_to_next_pe_5(in_data_to_next_pe_75),
                        .in_data_to_next_pe_6(in_data_to_next_pe_76), .in_data_to_next_pe_7(in_data_to_next_pe_77),
                        .next_row_en(row_7_en),
                        .result(o_6),
                        .out_val(o_6_val)   
);

PE_Row_B2   PE_R7_B2(   .clk(clk), .rst_n(row_7_en), .new_weight_val(new_weight_val[7]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_70), .Slide_data_1(in_data_to_next_pe_71),
                        .Slide_data_2(in_data_to_next_pe_72), .Slide_data_3(in_data_to_next_pe_73), 
                        .Slide_data_4(in_data_to_next_pe_74), .Slide_data_5(in_data_to_next_pe_75),
                        .Slide_data_6(in_data_to_next_pe_76), .Slide_data_7(in_data_to_next_pe_77),
                        .in_data_to_next_pe_0(in_data_to_next_pe_80), .in_data_to_next_pe_1(in_data_to_next_pe_81),
                        .in_data_to_next_pe_2(in_data_to_next_pe_82), .in_data_to_next_pe_3(in_data_to_next_pe_83),
                        .in_data_to_next_pe_4(in_data_to_next_pe_84), .in_data_to_next_pe_5(in_data_to_next_pe_85),
                        .in_data_to_next_pe_6(in_data_to_next_pe_86), .in_data_to_next_pe_7(in_data_to_next_pe_87),
                        .next_row_en(row_8_en),
                        .result(o_7),
                        .out_val(o_7_val)   
);

PE_Row_B2   PE_R8_B2(   .clk(clk), .rst_n(row_8_en), .new_weight_val(new_weight_val[8]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_80), .Slide_data_1(in_data_to_next_pe_81),
                        .Slide_data_2(in_data_to_next_pe_82), .Slide_data_3(in_data_to_next_pe_83), 
                        .Slide_data_4(in_data_to_next_pe_84), .Slide_data_5(in_data_to_next_pe_85),
                        .Slide_data_6(in_data_to_next_pe_86), .Slide_data_7(in_data_to_next_pe_87),
                        .in_data_to_next_pe_0(in_data_to_next_pe_90), .in_data_to_next_pe_1(in_data_to_next_pe_91),
                        .in_data_to_next_pe_2(in_data_to_next_pe_92), .in_data_to_next_pe_3(in_data_to_next_pe_93),
                        .in_data_to_next_pe_4(in_data_to_next_pe_94), .in_data_to_next_pe_5(in_data_to_next_pe_95),
                        .in_data_to_next_pe_6(in_data_to_next_pe_96), .in_data_to_next_pe_7(in_data_to_next_pe_97),
                        .next_row_en(row_9_en),
                        .result(o_8),
                        .out_val(o_8_val)   
);

PE_Row_B2   PE_R9_B2(   .clk(clk), .rst_n(row_9_en), .new_weight_val(new_weight_val[9]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_90), .Slide_data_1(in_data_to_next_pe_91),
                        .Slide_data_2(in_data_to_next_pe_92), .Slide_data_3(in_data_to_next_pe_93), 
                        .Slide_data_4(in_data_to_next_pe_94), .Slide_data_5(in_data_to_next_pe_95),
                        .Slide_data_6(in_data_to_next_pe_96), .Slide_data_7(in_data_to_next_pe_97),
                        .in_data_to_next_pe_0(in_data_to_next_pe_10_0), .in_data_to_next_pe_1(in_data_to_next_pe_10_1),
                        .in_data_to_next_pe_2(in_data_to_next_pe_10_2), .in_data_to_next_pe_3(in_data_to_next_pe_10_3),
                        .in_data_to_next_pe_4(in_data_to_next_pe_10_4), .in_data_to_next_pe_5(in_data_to_next_pe_10_5),
                        .in_data_to_next_pe_6(in_data_to_next_pe_10_6), .in_data_to_next_pe_7(in_data_to_next_pe_10_7),
                        .next_row_en(row_10_en),
                        .result(o_9),
                        .out_val(o_9_val)   
);

PE_Row_B2   PE_R10_B2(  .clk(clk), .rst_n(row_10_en), .new_weight_val(new_weight_val[10]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_10_0), .Slide_data_1(in_data_to_next_pe_10_1),
                        .Slide_data_2(in_data_to_next_pe_10_2), .Slide_data_3(in_data_to_next_pe_10_3), 
                        .Slide_data_4(in_data_to_next_pe_10_4), .Slide_data_5(in_data_to_next_pe_10_5),
                        .Slide_data_6(in_data_to_next_pe_10_6), .Slide_data_7(in_data_to_next_pe_10_7),
                        .in_data_to_next_pe_0(in_data_to_next_pe_11_0), .in_data_to_next_pe_1(in_data_to_next_pe_11_1),
                        .in_data_to_next_pe_2(in_data_to_next_pe_11_2), .in_data_to_next_pe_3(in_data_to_next_pe_11_3),
                        .in_data_to_next_pe_4(in_data_to_next_pe_11_4), .in_data_to_next_pe_5(in_data_to_next_pe_11_5),
                        .in_data_to_next_pe_6(in_data_to_next_pe_11_6), .in_data_to_next_pe_7(in_data_to_next_pe_11_7),
                        .next_row_en(row_11_en),
                        .result(o_10),
                        .out_val(o_10_val)   
);

PE_Row_B2   PE_R11_B2(  .clk(clk), .rst_n(row_11_en), .new_weight_val(new_weight_val[11]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_11_0), .Slide_data_1(in_data_to_next_pe_11_1),
                        .Slide_data_2(in_data_to_next_pe_11_2), .Slide_data_3(in_data_to_next_pe_11_3), 
                        .Slide_data_4(in_data_to_next_pe_11_4), .Slide_data_5(in_data_to_next_pe_11_5),
                        .Slide_data_6(in_data_to_next_pe_11_6), .Slide_data_7(in_data_to_next_pe_11_7),
                        .in_data_to_next_pe_0(in_data_to_next_pe_12_0), .in_data_to_next_pe_1(in_data_to_next_pe_12_1),
                        .in_data_to_next_pe_2(in_data_to_next_pe_12_2), .in_data_to_next_pe_3(in_data_to_next_pe_12_3),
                        .in_data_to_next_pe_4(in_data_to_next_pe_12_4), .in_data_to_next_pe_5(in_data_to_next_pe_12_5),
                        .in_data_to_next_pe_6(in_data_to_next_pe_12_6), .in_data_to_next_pe_7(in_data_to_next_pe_12_7),
                        .next_row_en(row_12_en),
                        .result(o_11),
                        .out_val(o_11_val)   
);

PE_Row_B2   PE_R12_B2(  .clk(clk), .rst_n(row_12_en), .new_weight_val(new_weight_val[12]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_12_0), .Slide_data_1(in_data_to_next_pe_12_1),
                        .Slide_data_2(in_data_to_next_pe_12_2), .Slide_data_3(in_data_to_next_pe_12_3), 
                        .Slide_data_4(in_data_to_next_pe_12_4), .Slide_data_5(in_data_to_next_pe_12_5),
                        .Slide_data_6(in_data_to_next_pe_12_6), .Slide_data_7(in_data_to_next_pe_12_7),
                        .in_data_to_next_pe_0(in_data_to_next_pe_13_0), .in_data_to_next_pe_1(in_data_to_next_pe_13_1),
                        .in_data_to_next_pe_2(in_data_to_next_pe_13_2), .in_data_to_next_pe_3(in_data_to_next_pe_13_3),
                        .in_data_to_next_pe_4(in_data_to_next_pe_13_4), .in_data_to_next_pe_5(in_data_to_next_pe_13_5),
                        .in_data_to_next_pe_6(in_data_to_next_pe_13_6), .in_data_to_next_pe_7(in_data_to_next_pe_13_7),
                        .next_row_en(row_13_en),
                        .result(o_12),
                        .out_val(o_12_val)   
);

PE_Row_B2   PE_R13_B2(  .clk(clk), .rst_n(row_13_en), .new_weight_val(new_weight_val[13]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_13_0), .Slide_data_1(in_data_to_next_pe_13_1),
                        .Slide_data_2(in_data_to_next_pe_13_2), .Slide_data_3(in_data_to_next_pe_13_3), 
                        .Slide_data_4(in_data_to_next_pe_13_4), .Slide_data_5(in_data_to_next_pe_13_5),
                        .Slide_data_6(in_data_to_next_pe_13_6), .Slide_data_7(in_data_to_next_pe_13_7),
                        .in_data_to_next_pe_0(in_data_to_next_pe_14_0), .in_data_to_next_pe_1(in_data_to_next_pe_14_1),
                        .in_data_to_next_pe_2(in_data_to_next_pe_14_2), .in_data_to_next_pe_3(in_data_to_next_pe_14_3),
                        .in_data_to_next_pe_4(in_data_to_next_pe_14_4), .in_data_to_next_pe_5(in_data_to_next_pe_14_5),
                        .in_data_to_next_pe_6(in_data_to_next_pe_14_6), .in_data_to_next_pe_7(in_data_to_next_pe_14_7),
                        .next_row_en(row_14_en),
                        .result(o_13),
                        .out_val(o_13_val)   
);

PE_Row_B2   PE_R14_B2(  .clk(clk), .rst_n(row_14_en), .new_weight_val(new_weight_val[14]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_14_0), .Slide_data_1(in_data_to_next_pe_14_1),
                        .Slide_data_2(in_data_to_next_pe_14_2), .Slide_data_3(in_data_to_next_pe_14_3), 
                        .Slide_data_4(in_data_to_next_pe_14_4), .Slide_data_5(in_data_to_next_pe_14_5),
                        .Slide_data_6(in_data_to_next_pe_14_6), .Slide_data_7(in_data_to_next_pe_14_7),
                        .in_data_to_next_pe_0(in_data_to_next_pe_15_0), .in_data_to_next_pe_1(in_data_to_next_pe_15_1),
                        .in_data_to_next_pe_2(in_data_to_next_pe_15_2), .in_data_to_next_pe_3(in_data_to_next_pe_15_3),
                        .in_data_to_next_pe_4(in_data_to_next_pe_15_4), .in_data_to_next_pe_5(in_data_to_next_pe_15_5),
                        .in_data_to_next_pe_6(in_data_to_next_pe_15_6), .in_data_to_next_pe_7(in_data_to_next_pe_15_7),
                        .next_row_en(row_15_en),
                        .result(o_14),
                        .out_val(o_14_val)   
);

PE_Row_B2   PE_R15_B2(  .clk(clk), .rst_n(row_15_en), .new_weight_val(new_weight_val[15]),
                        .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3), 
                        .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
                        .Slide_data_0(in_data_to_next_pe_15_0), .Slide_data_1(in_data_to_next_pe_15_1),
                        .Slide_data_2(in_data_to_next_pe_15_2), .Slide_data_3(in_data_to_next_pe_15_3), 
                        .Slide_data_4(in_data_to_next_pe_15_4), .Slide_data_5(in_data_to_next_pe_15_5),
                        .Slide_data_6(in_data_to_next_pe_15_6), .Slide_data_7(in_data_to_next_pe_15_7),
                        .in_data_to_next_pe_0(), .in_data_to_next_pe_1(),
                        .in_data_to_next_pe_2(), .in_data_to_next_pe_3(),
                        .in_data_to_next_pe_4(), .in_data_to_next_pe_5(),
                        .in_data_to_next_pe_6(), .in_data_to_next_pe_7(),
                        .next_row_en(),
                        .result(o_15),
                        .out_val(o_15_val)   
);
         
endmodule

