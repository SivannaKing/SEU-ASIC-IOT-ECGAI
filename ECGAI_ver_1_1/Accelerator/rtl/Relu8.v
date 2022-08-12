// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : Relu8.v
// @Module Name  : Relu8
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


module Relu8(
		input					clk_cal,
		input  [3:0]				nn_layer_cnt,

		input  [`halfword_width-1:0]		Relu_Din1,
		input  [`halfword_width-1:0]		Relu_Din2,
		input  [`halfword_width-1:0]		Relu_Din3,	
		input  [`halfword_width-1:0]		Relu_Din4,
		input  [`halfword_width-1:0]		Relu_Din5,
		input  [`halfword_width-1:0]		Relu_Din6,
		input  [`halfword_width-1:0]		Relu_Din7,	
		input  [`halfword_width-1:0]		Relu_Din8,	
		input					Relu_Din_vld1,
		input					Relu_Din_vld2,
		input					Relu_Din_vld3,
		input					Relu_Din_vld4,
		input					Relu_Din_vld5,
		input					Relu_Din_vld6,
		input					Relu_Din_vld7,
		input					Relu_Din_vld8,
		input  					Relu_max,

		output	 [`byte_width-1:0]		Relu_Dout1,
		output	 [`byte_width-1:0]		Relu_Dout2,
		output	 [`byte_width-1:0]		Relu_Dout3,
		output	 [`byte_width-1:0]		Relu_Dout4,
		output	 [`byte_width-1:0]		Relu_Dout5,
		output	 [`byte_width-1:0]		Relu_Dout6,
		output	 [`byte_width-1:0]		Relu_Dout7,
		output	 [`byte_width-1:0]		Relu_Dout8,
		output 					Relu_Dout_vld1,
		output 					Relu_Dout_vld2,
		output 					Relu_Dout_vld3,
		output 					Relu_Dout_vld4,
		output 					Relu_Dout_vld5,
		output 					Relu_Dout_vld6,
		output 					Relu_Dout_vld7,
		output 					Relu_Dout_vld8
	);	


	Relu u_relu1(
		.Relu_Din(Relu_Din1),
		.Relu_Din_vld(Relu_Din_vld1),
		.Relu_max(Relu_max),

		.Relu_Dout(Relu_Dout1),
		.Relu_Dout_vld(Relu_Dout_vld1)
	);	

	Relu u_relu2(
		.Relu_Din(Relu_Din2),
		.Relu_Din_vld(Relu_Din_vld2),
		.Relu_max(Relu_max),

		.Relu_Dout(Relu_Dout2),
		.Relu_Dout_vld(Relu_Dout_vld2)
	);	

	Relu u_relu3(
		.Relu_Din(Relu_Din3),
		.Relu_Din_vld(Relu_Din_vld3),
		.Relu_max(Relu_max),

		.Relu_Dout(Relu_Dout3),
		.Relu_Dout_vld(Relu_Dout_vld3)
	);	

	Relu u_relu4(
		.Relu_Din(Relu_Din4),
		.Relu_Din_vld(Relu_Din_vld4),
		.Relu_max(Relu_max),

		.Relu_Dout(Relu_Dout4),
		.Relu_Dout_vld(Relu_Dout_vld4)
	);	

	Relu u_relu5(
		.Relu_Din(Relu_Din5),
		.Relu_Din_vld(Relu_Din_vld5),
		.Relu_max(Relu_max),

		.Relu_Dout(Relu_Dout5),
		.Relu_Dout_vld(Relu_Dout_vld5)
	);	

	Relu u_relu6(
		.Relu_Din(Relu_Din6),
		.Relu_Din_vld(Relu_Din_vld6),
		.Relu_max(Relu_max),

		.Relu_Dout(Relu_Dout6),
		.Relu_Dout_vld(Relu_Dout_vld6)
	);	

	Relu u_relu7(
		.Relu_Din(Relu_Din7),
		.Relu_Din_vld(Relu_Din_vld7),
		.Relu_max(Relu_max),

		.Relu_Dout(Relu_Dout7),
		.Relu_Dout_vld(Relu_Dout_vld7)
	);	

	Relu u_relu8(
		.Relu_Din(Relu_Din8),
		.Relu_Din_vld(Relu_Din_vld8),
		.Relu_max(Relu_max),

		.Relu_Dout(Relu_Dout8),
		.Relu_Dout_vld(Relu_Dout_vld8)
	);	



endmodule
