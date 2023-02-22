// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : Relu.v
// @Module Name  : Relu
// @Created Time : 2020-12-09 09:32
//
// @Abstract     : This module is to relu            
//               
//
// Modification History
// ******************************************************************************
// Date		    BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-12-09  	Huangjunguang      v1.0          initial version 
// 
// ******************************************************************************

`timescale 1ns / 1ns
`define byte_width 8
`define halfword_width 16


module Relu(
		input  [`halfword_width-1:0]		Relu_Din,
		input					Relu_Din_vld,
		input  					Relu_max,

		output	reg [`byte_width-1:0]		Relu_Dout,
		output 					Relu_Dout_vld
	);	


	always@(*)begin
		if(Relu_Din_vld)  begin
			if(Relu_max)
				Relu_Dout  = ( (Relu_Din[15] == 1'b0) && ((|Relu_Din[14:11]) == 1'b1) ) ? 8'h40 :
							(Relu_Din[15]==1'b1) ? 8'd0 : 
								Relu_Din[4] ? {Relu_Din[15],Relu_Din[11:5]+1'b1} : {Relu_Din[15],Relu_Din[11:5]};//Relu_Din[15:0]
			else
				Relu_Dout  = ( (Relu_Din[15] == 1'b0) && ((|Relu_Din[14:10]) == 1'b1) ) ? 8'h20 :
							(Relu_Din[15]==1'b1) ? 8'd0 : 
								Relu_Din[4] ? {Relu_Din[15],Relu_Din[11:5]+1'b1} : {Relu_Din[15],Relu_Din[11:5]};//Relu_Din[15:0]	
                           	
		end
		else
			Relu_Dout = 8'b0;

	end

	assign  Relu_Dout_vld = Relu_Din_vld;


endmodule
