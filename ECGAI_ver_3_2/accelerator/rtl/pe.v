`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/03 09:06:33
// Design Name: 
// Module Name: pe
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

module pe #(parameter kernel_size = 7)(
  input                         clk,         
  input                         rst_n,       
  input     [kernel_size-1:0]   input_data,   
  input     [kernel_size-1:0]   weight_data,
  input                         new_weight_val,  
  output reg  signed    [3:0]   out, 
  output reg  [kernel_size-1:0] in_data_to_next_pe,
  output reg                    next_pe_en       
);
  reg           [6:0]   weight_data_buffer;
  
  wire          [6:0]   xnor_result;            
  wire          [2:0]   p;
  
//  always @(posedge clk or negedge rst_n)begin
//    if(!rst_n) begin
//        weight_data_buffer <= 7'b0;
//    end
//    else 
//        weight_data_buffer <= weight_data;
//  end
  always@(posedge new_weight_val)begin
//    if(new_weight_val)begin
        weight_data_buffer <= weight_data;
//    end
  end
  
  assign xnor_result = rst_n? (input_data ~^ weight_data_buffer) : 0 ;
  assign p = rst_n? (xnor_result[0]+xnor_result[1]+xnor_result[2]+xnor_result[3]+xnor_result[4]+xnor_result[5] + xnor_result[6]) : 0;
 
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      next_pe_en <= 0;
      out <= 0;
      in_data_to_next_pe <= 0;
    end      
    else begin
      out <= (p<<1) - kernel_size;
      in_data_to_next_pe <= input_data;
      next_pe_en <= 1;
    end
  end
  
  
endmodule
