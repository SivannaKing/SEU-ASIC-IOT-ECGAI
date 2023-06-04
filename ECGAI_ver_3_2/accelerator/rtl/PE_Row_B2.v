`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 14:34:40
// Design Name: 
// Module Name: PE_Row_B2
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

//Block1的第0行pe阵列，有8个(因为输入通道为8)
module PE_Row_B2(
    input                           clk,
    input                           rst_n,
    input                           new_weight_val,
    input                   [6:0]   w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7,
    input                   [6:0]   Slide_data_0, Slide_data_1, Slide_data_2, Slide_data_3, Slide_data_4, Slide_data_5, Slide_data_6, Slide_data_7,
    output    wire          [6:0]   in_data_to_next_pe_0, in_data_to_next_pe_1, in_data_to_next_pe_2, in_data_to_next_pe_3, 
                                    in_data_to_next_pe_4, in_data_to_next_pe_5, in_data_to_next_pe_6, in_data_to_next_pe_7,
    output    wire                  next_row_en,
    output    reg  signed   [6:0]   result,
    output    reg                   out_val
);

wire signed [3:0]  o_00, o_01, o_02, o_03, o_04, o_05, o_06, o_07; 
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

reg   signed  [5:0]   add_temp_0, add_temp_1;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        add_temp_0 <= 0;
    end
    else begin
        add_temp_0 <= o_00 + o_01 + o_02 + o_03;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        add_temp_1 <= 0;
    end
    else begin
        add_temp_1 <= o_04 + o_05 + o_06 + o_07;
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
