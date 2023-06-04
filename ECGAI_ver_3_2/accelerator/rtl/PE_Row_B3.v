`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 10:03:50
// Design Name: 
// Module Name: PE_Row_B3
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


module PE_Row_B3(
    input                           clk,
    input                           rst_n,
    input                           new_weight_val,
    input                   [6:0]   w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7, w_8, w_9, w_10, w_11, w_12, w_13, w_14, w_15,
    input                   [6:0]   Slide_data_0, Slide_data_1, Slide_data_2, Slide_data_3, Slide_data_4, Slide_data_5, Slide_data_6, Slide_data_7,
                                    Slide_data_8, Slide_data_9, Slide_data_10, Slide_data_11, Slide_data_12, Slide_data_13, Slide_data_14, Slide_data_15,
    output    wire          [6:0]   in_data_to_next_pe_0, in_data_to_next_pe_1, in_data_to_next_pe_2, in_data_to_next_pe_3, 
                                    in_data_to_next_pe_4, in_data_to_next_pe_5, in_data_to_next_pe_6, in_data_to_next_pe_7,
                                    in_data_to_next_pe_8, in_data_to_next_pe_9, in_data_to_next_pe_10, in_data_to_next_pe_11, 
                                    in_data_to_next_pe_12, in_data_to_next_pe_13, in_data_to_next_pe_14, in_data_to_next_pe_15,
    output    wire                  next_row_en,
    output    reg  signed   [7:0]   result,
    output    reg                   out_val
);
wire signed [3:0]  o_00, o_01, o_02, o_03, o_04, o_05, o_06, o_07,o_08, o_09, o_10, o_11, o_12, o_13, o_14, o_15; 

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


reg   signed  [6:0]   add_temp_0, add_temp_1;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        add_temp_0 <= 0;
    end
    else begin
        add_temp_0 <= o_00 + o_01 + o_02 + o_03 + o_04 + o_05 + o_06 + o_07;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        add_temp_1 <= 0;
    end
    else begin
        add_temp_1 <= o_08 + o_09 + o_10 + o_11 + o_12 + o_13 + o_14 + o_15;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        result <= 0;
    end
    else begin
        result <= add_temp_0 + add_temp_1;
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
