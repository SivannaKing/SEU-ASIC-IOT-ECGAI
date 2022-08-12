// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : Output_regfile8_9.v
// @Module Name  : Output_regfile8_9
// @Created Time : 2020-05-22 23:29
//
// @Abstract     : This module is to sort the output of PE array               
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-05-22  	Huangjunguang      v1.0          initial version 
// 
// ******************************************************************************

`timescale 1ns/1ns
`define byte_width 8
`define halfword_width 16
`define sevenbyte_width 56

module Output_regfile8_9(
			input						clk_cal,
			input						rst_cal_n,
			
			input		 [2:0]				P,
			input		 [1:0]				S,
			// input		 [3:0]		nn_layer_cnt,
			input		 [3:0]				ft_N_cnt,
			input		 [5:0]				or_cs,

			input  		 [`byte_width-1:0] 		ORegfile_IData1,
			input  		 [`byte_width-1:0] 		ORegfile_IData2,
			input  		 [`byte_width-1:0] 		ORegfile_IData3,
			input  		 [`byte_width-1:0] 		ORegfile_IData4,
			input  		 [`byte_width-1:0] 		ORegfile_IData5,
			input  		 [`byte_width-1:0] 		ORegfile_IData6,
			input  		 [`byte_width-1:0] 		ORegfile_IData7,
			input 		 [`byte_width-1:0] 		ORegfile_IData8,
			input						ORegfile_IData_vld1,
			input						ORegfile_IData_vld2,
			input						ORegfile_IData_vld3,
			input						ORegfile_IData_vld4,
			input						ORegfile_IData_vld5,
			input						ORegfile_IData_vld6,
			input						ORegfile_IData_vld7,
			input						ORegfile_IData_vld8,
			
			output reg	 [`sevenbyte_width-1:0]		ORegfile_OData1,
			output reg	 [`sevenbyte_width-1:0]		ORegfile_OData2,
			output reg	 [`sevenbyte_width-1:0]		ORegfile_OData3,
			output reg	 [`sevenbyte_width-1:0]		ORegfile_OData4,
			output reg	 [`sevenbyte_width-1:0]		ORegfile_OData5,
			output reg	 [`sevenbyte_width-1:0]		ORegfile_OData6,
			output reg	 [`sevenbyte_width-1:0]		ORegfile_OData7,
			output reg	 [`sevenbyte_width-1:0]		ORegfile_OData8,
			output reg 					ORegfile_OData_vld1,
			output reg 					ORegfile_OData_vld2,
			output reg 					ORegfile_OData_vld3,
			output reg 					ORegfile_OData_vld4,
			output reg 					ORegfile_OData_vld5,
			output reg 					ORegfile_OData_vld6,
			output reg 					ORegfile_OData_vld7,
			output reg 					ORegfile_OData_vld8
		);

//=========================================================== ORegfile_IData & Ivld ============================================================//	
		reg 	[`byte_width-1:0]	ORegfile_IData1_1,ORegfile_IData1_2,ORegfile_IData1_3,ORegfile_IData1_4,
			       		ORegfile_IData1_5,ORegfile_IData1_6,ORegfile_IData1_7,ORegfile_IData1_8;
		reg 	[`byte_width-1:0]	ORegfile_IData2_1,ORegfile_IData2_2,ORegfile_IData2_3,ORegfile_IData2_4,
			       		ORegfile_IData2_5,ORegfile_IData2_6,ORegfile_IData2_7,ORegfile_IData2_8;
		reg 	[`byte_width-1:0]	ORegfile_IData3_1,ORegfile_IData3_2,ORegfile_IData3_3,ORegfile_IData3_4,
			       		ORegfile_IData3_5,ORegfile_IData3_6,ORegfile_IData3_7,ORegfile_IData3_8;
		reg 	[`byte_width-1:0]	ORegfile_IData4_1,ORegfile_IData4_2,ORegfile_IData4_3,ORegfile_IData4_4,
			       		ORegfile_IData4_5,ORegfile_IData4_6,ORegfile_IData4_7,ORegfile_IData4_8;
		reg 	[`byte_width-1:0]	ORegfile_IData5_1,ORegfile_IData5_2,ORegfile_IData5_3,ORegfile_IData5_4,
			       		ORegfile_IData5_5,ORegfile_IData5_6,ORegfile_IData5_7,ORegfile_IData5_8;
		reg 	[`byte_width-1:0]	ORegfile_IData6_1,ORegfile_IData6_2,ORegfile_IData6_3,ORegfile_IData6_4,
			      		ORegfile_IData6_5,ORegfile_IData6_6,ORegfile_IData6_7,ORegfile_IData6_8;
		reg 	[`byte_width-1:0]	ORegfile_IData7_1,ORegfile_IData7_2,ORegfile_IData7_3,ORegfile_IData7_4,
			      		ORegfile_IData7_5,ORegfile_IData7_6,ORegfile_IData7_7,ORegfile_IData7_8;
		reg 	[`byte_width-1:0]	ORegfile_IData8_1,ORegfile_IData8_2,ORegfile_IData8_3,ORegfile_IData8_4,
			      		ORegfile_IData8_5,ORegfile_IData8_6,ORegfile_IData8_7,ORegfile_IData8_8;
		reg 	[`byte_width-1:0]	ORegfile_IData9_1,ORegfile_IData9_2,ORegfile_IData9_3,ORegfile_IData9_4,
						ORegfile_IData9_5,ORegfile_IData9_6,ORegfile_IData9_7,ORegfile_IData9_8;	

		reg 	 		ORegfile_IData_vld1_1,ORegfile_IData_vld1_2,ORegfile_IData_vld1_3,ORegfile_IData_vld1_4,
						ORegfile_IData_vld1_5,ORegfile_IData_vld1_6,ORegfile_IData_vld1_7,ORegfile_IData_vld1_8;
		reg 	 		ORegfile_IData_vld2_1,ORegfile_IData_vld2_2,ORegfile_IData_vld2_3,ORegfile_IData_vld2_4,
						ORegfile_IData_vld2_5,ORegfile_IData_vld2_6,ORegfile_IData_vld2_7,ORegfile_IData_vld2_8;
		reg 	 		ORegfile_IData_vld3_1,ORegfile_IData_vld3_2,ORegfile_IData_vld3_3,ORegfile_IData_vld3_4,
						ORegfile_IData_vld3_5,ORegfile_IData_vld3_6,ORegfile_IData_vld3_7,ORegfile_IData_vld3_8;
		reg 	 		ORegfile_IData_vld4_1,ORegfile_IData_vld4_2,ORegfile_IData_vld4_3,ORegfile_IData_vld4_4,
						ORegfile_IData_vld4_5,ORegfile_IData_vld4_6,ORegfile_IData_vld4_7,ORegfile_IData_vld4_8;
		reg 	 		ORegfile_IData_vld5_1,ORegfile_IData_vld5_2,ORegfile_IData_vld5_3,ORegfile_IData_vld5_4,
						ORegfile_IData_vld5_5,ORegfile_IData_vld5_6,ORegfile_IData_vld5_7,ORegfile_IData_vld5_8;
		reg 	 		ORegfile_IData_vld6_1,ORegfile_IData_vld6_2,ORegfile_IData_vld6_3,ORegfile_IData_vld6_4,
						ORegfile_IData_vld6_5,ORegfile_IData_vld6_6,ORegfile_IData_vld6_7,ORegfile_IData_vld6_8;
		reg 	 		ORegfile_IData_vld7_1,ORegfile_IData_vld7_2,ORegfile_IData_vld7_3,ORegfile_IData_vld7_4,
						ORegfile_IData_vld7_5,ORegfile_IData_vld7_6,ORegfile_IData_vld7_7,ORegfile_IData_vld7_8;
		reg 	 		ORegfile_IData_vld8_1,ORegfile_IData_vld8_2,ORegfile_IData_vld8_3,ORegfile_IData_vld8_4,
						ORegfile_IData_vld8_5,ORegfile_IData_vld8_6,ORegfile_IData_vld8_7,ORegfile_IData_vld8_8;
		reg 	 		ORegfile_IData_vld9_1,ORegfile_IData_vld9_2,ORegfile_IData_vld9_3,ORegfile_IData_vld9_4,
						ORegfile_IData_vld9_5,ORegfile_IData_vld9_6,ORegfile_IData_vld9_7,ORegfile_IData_vld9_8;					

//=========================================================== ORegfile_OData & Ovld ============================================================//	
		wire 	[`sevenbyte_width-1:0]	ORegfile_OData1_1,ORegfile_OData1_2,ORegfile_OData1_3,ORegfile_OData1_4,
			      		ORegfile_OData1_5,ORegfile_OData1_6,ORegfile_OData1_7,ORegfile_OData1_8;
		wire 	[`sevenbyte_width-1:0]	ORegfile_OData2_1,ORegfile_OData2_2,ORegfile_OData2_3,ORegfile_OData2_4,
			      		ORegfile_OData2_5,ORegfile_OData2_6,ORegfile_OData2_7,ORegfile_OData2_8;
		wire 	[`sevenbyte_width-1:0]	ORegfile_OData3_1,ORegfile_OData3_2,ORegfile_OData3_3,ORegfile_OData3_4,
			      		ORegfile_OData3_5,ORegfile_OData3_6,ORegfile_OData3_7,ORegfile_OData3_8;
		wire 	[`sevenbyte_width-1:0]	ORegfile_OData4_1,ORegfile_OData4_2,ORegfile_OData4_3,ORegfile_OData4_4,
			      		ORegfile_OData4_5,ORegfile_OData4_6,ORegfile_OData4_7,ORegfile_OData4_8;
		wire 	[`sevenbyte_width-1:0]	ORegfile_OData5_1,ORegfile_OData5_2,ORegfile_OData5_3,ORegfile_OData5_4,
			      		ORegfile_OData5_5,ORegfile_OData5_6,ORegfile_OData5_7,ORegfile_OData5_8;
		wire 	[`sevenbyte_width-1:0]	ORegfile_OData6_1,ORegfile_OData6_2,ORegfile_OData6_3,ORegfile_OData6_4,
			      		ORegfile_OData6_5,ORegfile_OData6_6,ORegfile_OData6_7,ORegfile_OData6_8;
		wire 	[`sevenbyte_width-1:0]	ORegfile_OData7_1,ORegfile_OData7_2,ORegfile_OData7_3,ORegfile_OData7_4,
			      		ORegfile_OData7_5,ORegfile_OData7_6,ORegfile_OData7_7,ORegfile_OData7_8;
		wire 	[`sevenbyte_width-1:0]	ORegfile_OData8_1,ORegfile_OData8_2,ORegfile_OData8_3,ORegfile_OData8_4,
			      		ORegfile_OData8_5,ORegfile_OData8_6,ORegfile_OData8_7,ORegfile_OData8_8;
		wire 	[`sevenbyte_width-1:0]	ORegfile_OData9_1,ORegfile_OData9_2,ORegfile_OData9_3,ORegfile_OData9_4,
						ORegfile_OData9_5,ORegfile_OData9_6,ORegfile_OData9_7,ORegfile_OData9_8;	

		wire 	 		ORegfile_OData_vld1_1,ORegfile_OData_vld1_2,ORegfile_OData_vld1_3,ORegfile_OData_vld1_4,
						ORegfile_OData_vld1_5,ORegfile_OData_vld1_6,ORegfile_OData_vld1_7,ORegfile_OData_vld1_8;
		wire 	 		ORegfile_OData_vld2_1,ORegfile_OData_vld2_2,ORegfile_OData_vld2_3,ORegfile_OData_vld2_4,
						ORegfile_OData_vld2_5,ORegfile_OData_vld2_6,ORegfile_OData_vld2_7,ORegfile_OData_vld2_8;
		wire 	 		ORegfile_OData_vld3_1,ORegfile_OData_vld3_2,ORegfile_OData_vld3_3,ORegfile_OData_vld3_4,
						ORegfile_OData_vld3_5,ORegfile_OData_vld3_6,ORegfile_OData_vld3_7,ORegfile_OData_vld3_8;
		wire 	 		ORegfile_OData_vld4_1,ORegfile_OData_vld4_2,ORegfile_OData_vld4_3,ORegfile_OData_vld4_4,
						ORegfile_OData_vld4_5,ORegfile_OData_vld4_6,ORegfile_OData_vld4_7,ORegfile_OData_vld4_8;
		wire 	 		ORegfile_OData_vld5_1,ORegfile_OData_vld5_2,ORegfile_OData_vld5_3,ORegfile_OData_vld5_4,
						ORegfile_OData_vld5_5,ORegfile_OData_vld5_6,ORegfile_OData_vld5_7,ORegfile_OData_vld5_8;
		wire 	 		ORegfile_OData_vld6_1,ORegfile_OData_vld6_2,ORegfile_OData_vld6_3,ORegfile_OData_vld6_4,
						ORegfile_OData_vld6_5,ORegfile_OData_vld6_6,ORegfile_OData_vld6_7,ORegfile_OData_vld6_8;
		wire 	 		ORegfile_OData_vld7_1,ORegfile_OData_vld7_2,ORegfile_OData_vld7_3,ORegfile_OData_vld7_4,
						ORegfile_OData_vld7_5,ORegfile_OData_vld7_6,ORegfile_OData_vld7_7,ORegfile_OData_vld7_8;
		wire 	 		ORegfile_OData_vld8_1,ORegfile_OData_vld8_2,ORegfile_OData_vld8_3,ORegfile_OData_vld8_4,
						ORegfile_OData_vld8_5,ORegfile_OData_vld8_6,ORegfile_OData_vld8_7,ORegfile_OData_vld8_8;
		wire 	 		ORegfile_OData_vld9_1,ORegfile_OData_vld9_2,ORegfile_OData_vld9_3,ORegfile_OData_vld9_4,
						ORegfile_OData_vld9_5,ORegfile_OData_vld9_6,ORegfile_OData_vld9_7,ORegfile_OData_vld9_8;

//===========================================================  mux of 9 ============================================================//						
		always@(*)begin
			(* full_case *)
			case(ft_N_cnt)
				4'b0001:begin
					ORegfile_IData1_1 		= ORegfile_IData1;
					ORegfile_IData1_2 		= ORegfile_IData2;
					ORegfile_IData1_3 		= ORegfile_IData3;
					ORegfile_IData1_4 		= ORegfile_IData4;
					ORegfile_IData1_5 		= ORegfile_IData5;
					ORegfile_IData1_6 		= ORegfile_IData6;
					ORegfile_IData1_7 		= ORegfile_IData7;
					ORegfile_IData1_8 		= ORegfile_IData8;
					ORegfile_IData_vld1_1	= ORegfile_IData_vld1;
					ORegfile_IData_vld1_2	= ORegfile_IData_vld2;
					ORegfile_IData_vld1_3	= ORegfile_IData_vld3;
					ORegfile_IData_vld1_4	= ORegfile_IData_vld4;
					ORegfile_IData_vld1_5	= ORegfile_IData_vld5;
					ORegfile_IData_vld1_6	= ORegfile_IData_vld6;
					ORegfile_IData_vld1_7	= ORegfile_IData_vld7;
					ORegfile_IData_vld1_8	= ORegfile_IData_vld8;
					
					ORegfile_OData1 		= ORegfile_OData1_1;
					ORegfile_OData2 		= ORegfile_OData1_2;
					ORegfile_OData3			= ORegfile_OData1_3;
					ORegfile_OData4 		= ORegfile_OData1_4;
					ORegfile_OData5 		= ORegfile_OData1_5;
					ORegfile_OData6 		= ORegfile_OData1_6;
					ORegfile_OData7 		= ORegfile_OData1_7;
					ORegfile_OData8 		= ORegfile_OData1_8;
					ORegfile_OData_vld1		= ORegfile_OData_vld1_1;
					ORegfile_OData_vld2		= ORegfile_OData_vld1_2;
					ORegfile_OData_vld3		= ORegfile_OData_vld1_3;
					ORegfile_OData_vld4		= ORegfile_OData_vld1_4;
					ORegfile_OData_vld5		= ORegfile_OData_vld1_5;
					ORegfile_OData_vld6		= ORegfile_OData_vld1_6;
					ORegfile_OData_vld7		= ORegfile_OData_vld1_7;
					ORegfile_OData_vld8		= ORegfile_OData_vld1_8;
				end
				4'b0010:begin
					ORegfile_IData2_1 		= ORegfile_IData1;
					ORegfile_IData2_2 		= ORegfile_IData2;
					ORegfile_IData2_3 		= ORegfile_IData3;
					ORegfile_IData2_4 		= ORegfile_IData4;
					ORegfile_IData2_5 		= ORegfile_IData5;
					ORegfile_IData2_6 		= ORegfile_IData6;
					ORegfile_IData2_7 		= ORegfile_IData7;
					ORegfile_IData2_8 		= ORegfile_IData8;
					ORegfile_IData_vld2_1	= ORegfile_IData_vld1;
					ORegfile_IData_vld2_2	= ORegfile_IData_vld2;
					ORegfile_IData_vld2_3	= ORegfile_IData_vld3;
					ORegfile_IData_vld2_4	= ORegfile_IData_vld4;
					ORegfile_IData_vld2_5	= ORegfile_IData_vld5;
					ORegfile_IData_vld2_6	= ORegfile_IData_vld6;
					ORegfile_IData_vld2_7	= ORegfile_IData_vld7;
					ORegfile_IData_vld2_8	= ORegfile_IData_vld8;	

					ORegfile_OData1 		= ORegfile_OData2_1;
					ORegfile_OData2 		= ORegfile_OData2_2;
					ORegfile_OData3			= ORegfile_OData2_3;
					ORegfile_OData4 		= ORegfile_OData2_4;
					ORegfile_OData5 		= ORegfile_OData2_5;
					ORegfile_OData6 		= ORegfile_OData2_6;
					ORegfile_OData7 		= ORegfile_OData2_7;
					ORegfile_OData8 		= ORegfile_OData2_8;
					ORegfile_OData_vld1		= ORegfile_OData_vld2_1;
					ORegfile_OData_vld2		= ORegfile_OData_vld2_2;
					ORegfile_OData_vld3		= ORegfile_OData_vld2_3;
					ORegfile_OData_vld4		= ORegfile_OData_vld2_4;
					ORegfile_OData_vld5		= ORegfile_OData_vld2_5;
					ORegfile_OData_vld6		= ORegfile_OData_vld2_6;
					ORegfile_OData_vld7		= ORegfile_OData_vld2_7;
					ORegfile_OData_vld8		= ORegfile_OData_vld2_8;					
				end			
				4'b0011:begin
					ORegfile_IData3_1 		= ORegfile_IData1;
					ORegfile_IData3_2 		= ORegfile_IData2;
					ORegfile_IData3_3 		= ORegfile_IData3;
					ORegfile_IData3_4 		= ORegfile_IData4;
					ORegfile_IData3_5 		= ORegfile_IData5;
					ORegfile_IData3_6 		= ORegfile_IData6;
					ORegfile_IData3_7 		= ORegfile_IData7;
					ORegfile_IData3_8 		= ORegfile_IData8;
					ORegfile_IData_vld3_1	= ORegfile_IData_vld1;
					ORegfile_IData_vld3_2	= ORegfile_IData_vld2;
					ORegfile_IData_vld3_3	= ORegfile_IData_vld3;
					ORegfile_IData_vld3_4	= ORegfile_IData_vld4;
					ORegfile_IData_vld3_5	= ORegfile_IData_vld5;
					ORegfile_IData_vld3_6	= ORegfile_IData_vld6;
					ORegfile_IData_vld3_7	= ORegfile_IData_vld7;
					ORegfile_IData_vld3_8	= ORegfile_IData_vld8;	

					ORegfile_OData1 		= ORegfile_OData3_1;
					ORegfile_OData2 		= ORegfile_OData3_2;
					ORegfile_OData3			= ORegfile_OData3_3;
					ORegfile_OData4 		= ORegfile_OData3_4;
					ORegfile_OData5 		= ORegfile_OData3_5;
					ORegfile_OData6 		= ORegfile_OData3_6;
					ORegfile_OData7 		= ORegfile_OData3_7;
					ORegfile_OData8 		= ORegfile_OData3_8;
					ORegfile_OData_vld1		= ORegfile_OData_vld3_1;
					ORegfile_OData_vld2		= ORegfile_OData_vld3_2;
					ORegfile_OData_vld3		= ORegfile_OData_vld3_3;
					ORegfile_OData_vld4		= ORegfile_OData_vld3_4;
					ORegfile_OData_vld5		= ORegfile_OData_vld3_5;
					ORegfile_OData_vld6		= ORegfile_OData_vld3_6;
					ORegfile_OData_vld7		= ORegfile_OData_vld3_7;
					ORegfile_OData_vld8		= ORegfile_OData_vld3_8;					
				end
				4'b0100:begin
					ORegfile_IData4_1 		= ORegfile_IData1;
					ORegfile_IData4_2 		= ORegfile_IData2;
					ORegfile_IData4_3 		= ORegfile_IData3;
					ORegfile_IData4_4 		= ORegfile_IData4;
					ORegfile_IData4_5 		= ORegfile_IData5;
					ORegfile_IData4_6 		= ORegfile_IData6;
					ORegfile_IData4_7 		= ORegfile_IData7;
					ORegfile_IData4_8 		= ORegfile_IData8;
					ORegfile_IData_vld4_1	= ORegfile_IData_vld1;
					ORegfile_IData_vld4_2	= ORegfile_IData_vld2;
					ORegfile_IData_vld4_3	= ORegfile_IData_vld3;
					ORegfile_IData_vld4_4	= ORegfile_IData_vld4;
					ORegfile_IData_vld4_5	= ORegfile_IData_vld5;
					ORegfile_IData_vld4_6	= ORegfile_IData_vld6;
					ORegfile_IData_vld4_7	= ORegfile_IData_vld7;
					ORegfile_IData_vld4_8	= ORegfile_IData_vld8;		

					ORegfile_OData1 		= ORegfile_OData4_1;
					ORegfile_OData2 		= ORegfile_OData4_2;
					ORegfile_OData3			= ORegfile_OData4_3;
					ORegfile_OData4 		= ORegfile_OData4_4;
					ORegfile_OData5 		= ORegfile_OData4_5;
					ORegfile_OData6 		= ORegfile_OData4_6;
					ORegfile_OData7 		= ORegfile_OData4_7;
					ORegfile_OData8 		= ORegfile_OData4_8;
					ORegfile_OData_vld1		= ORegfile_OData_vld4_1;
					ORegfile_OData_vld2		= ORegfile_OData_vld4_2;
					ORegfile_OData_vld3		= ORegfile_OData_vld4_3;
					ORegfile_OData_vld4		= ORegfile_OData_vld4_4;
					ORegfile_OData_vld5		= ORegfile_OData_vld4_5;
					ORegfile_OData_vld6		= ORegfile_OData_vld4_6;
					ORegfile_OData_vld7		= ORegfile_OData_vld4_7;
					ORegfile_OData_vld8		= ORegfile_OData_vld4_8;					
				end
				4'b0101:begin
					ORegfile_IData5_1 		= ORegfile_IData1;
					ORegfile_IData5_2 		= ORegfile_IData2;
					ORegfile_IData5_3 		= ORegfile_IData3;
					ORegfile_IData5_4 		= ORegfile_IData4;
					ORegfile_IData5_5 		= ORegfile_IData5;
					ORegfile_IData5_6 		= ORegfile_IData6;
					ORegfile_IData5_7 		= ORegfile_IData7;
					ORegfile_IData5_8 		= ORegfile_IData8;
					ORegfile_IData_vld5_1	= ORegfile_IData_vld1;
					ORegfile_IData_vld5_2	= ORegfile_IData_vld2;
					ORegfile_IData_vld5_3	= ORegfile_IData_vld3;
					ORegfile_IData_vld5_4	= ORegfile_IData_vld4;
					ORegfile_IData_vld5_5	= ORegfile_IData_vld5;
					ORegfile_IData_vld5_6	= ORegfile_IData_vld6;
					ORegfile_IData_vld5_7	= ORegfile_IData_vld7;
					ORegfile_IData_vld5_8	= ORegfile_IData_vld8;

					ORegfile_OData1 		= ORegfile_OData5_1;
					ORegfile_OData2 		= ORegfile_OData5_2;
					ORegfile_OData3			= ORegfile_OData5_3;
					ORegfile_OData4 		= ORegfile_OData5_4;
					ORegfile_OData5 		= ORegfile_OData5_5;
					ORegfile_OData6 		= ORegfile_OData5_6;
					ORegfile_OData7 		= ORegfile_OData5_7;
					ORegfile_OData8 		= ORegfile_OData5_8;
					ORegfile_OData_vld1		= ORegfile_OData_vld5_1;
					ORegfile_OData_vld2		= ORegfile_OData_vld5_2;
					ORegfile_OData_vld3		= ORegfile_OData_vld5_3;
					ORegfile_OData_vld4		= ORegfile_OData_vld5_4;
					ORegfile_OData_vld5		= ORegfile_OData_vld5_5;
					ORegfile_OData_vld6		= ORegfile_OData_vld5_6;
					ORegfile_OData_vld7		= ORegfile_OData_vld5_7;
					ORegfile_OData_vld8		= ORegfile_OData_vld5_8;					
				end
				4'b0110:begin
					ORegfile_IData6_1 		= ORegfile_IData1;
					ORegfile_IData6_2 		= ORegfile_IData2;
					ORegfile_IData6_3 		= ORegfile_IData3;
					ORegfile_IData6_4 		= ORegfile_IData4;
					ORegfile_IData6_5 		= ORegfile_IData5;
					ORegfile_IData6_6 		= ORegfile_IData6;
					ORegfile_IData6_7 		= ORegfile_IData7;
					ORegfile_IData6_8 		= ORegfile_IData8;
					ORegfile_IData_vld6_1	= ORegfile_IData_vld1;
					ORegfile_IData_vld6_2	= ORegfile_IData_vld2;
					ORegfile_IData_vld6_3	= ORegfile_IData_vld3;
					ORegfile_IData_vld6_4	= ORegfile_IData_vld4;
					ORegfile_IData_vld6_5	= ORegfile_IData_vld5;
					ORegfile_IData_vld6_6	= ORegfile_IData_vld6;
					ORegfile_IData_vld6_7	= ORegfile_IData_vld7;
					ORegfile_IData_vld6_8	= ORegfile_IData_vld8;	

					ORegfile_OData1 		= ORegfile_OData6_1;
					ORegfile_OData2 		= ORegfile_OData6_2;
					ORegfile_OData3			= ORegfile_OData6_3;
					ORegfile_OData4 		= ORegfile_OData6_4;
					ORegfile_OData5 		= ORegfile_OData6_5;
					ORegfile_OData6 		= ORegfile_OData6_6;
					ORegfile_OData7 		= ORegfile_OData6_7;
					ORegfile_OData8 		= ORegfile_OData6_8;
					ORegfile_OData_vld1		= ORegfile_OData_vld6_1;
					ORegfile_OData_vld2		= ORegfile_OData_vld6_2;
					ORegfile_OData_vld3		= ORegfile_OData_vld6_3;
					ORegfile_OData_vld4		= ORegfile_OData_vld6_4;
					ORegfile_OData_vld5		= ORegfile_OData_vld6_5;
					ORegfile_OData_vld6		= ORegfile_OData_vld6_6;
					ORegfile_OData_vld7		= ORegfile_OData_vld6_7;
					ORegfile_OData_vld8		= ORegfile_OData_vld6_8;					
				end
				4'b0111:begin
					ORegfile_IData7_1 		= ORegfile_IData1;
					ORegfile_IData7_2 		= ORegfile_IData2;
					ORegfile_IData7_3 		= ORegfile_IData3;
					ORegfile_IData7_4 		= ORegfile_IData4;
					ORegfile_IData7_5 		= ORegfile_IData5;
					ORegfile_IData7_6 		= ORegfile_IData6;
					ORegfile_IData7_7 		= ORegfile_IData7;
					ORegfile_IData7_8 		= ORegfile_IData8;
					ORegfile_IData_vld7_1	= ORegfile_IData_vld1;
					ORegfile_IData_vld7_2	= ORegfile_IData_vld2;
					ORegfile_IData_vld7_3	= ORegfile_IData_vld3;
					ORegfile_IData_vld7_4	= ORegfile_IData_vld4;
					ORegfile_IData_vld7_5	= ORegfile_IData_vld5;
					ORegfile_IData_vld7_6	= ORegfile_IData_vld6;
					ORegfile_IData_vld7_7	= ORegfile_IData_vld7;
					ORegfile_IData_vld7_8	= ORegfile_IData_vld8;

					ORegfile_OData1 		= ORegfile_OData7_1;
					ORegfile_OData2 		= ORegfile_OData7_2;
					ORegfile_OData3			= ORegfile_OData7_3;
					ORegfile_OData4 		= ORegfile_OData7_4;
					ORegfile_OData5 		= ORegfile_OData7_5;
					ORegfile_OData6 		= ORegfile_OData7_6;
					ORegfile_OData7 		= ORegfile_OData7_7;
					ORegfile_OData8 		= ORegfile_OData7_8;
					ORegfile_OData_vld1		= ORegfile_OData_vld7_1;
					ORegfile_OData_vld2		= ORegfile_OData_vld7_2;
					ORegfile_OData_vld3		= ORegfile_OData_vld7_3;
					ORegfile_OData_vld4		= ORegfile_OData_vld7_4;
					ORegfile_OData_vld5		= ORegfile_OData_vld7_5;
					ORegfile_OData_vld6		= ORegfile_OData_vld7_6;
					ORegfile_OData_vld7		= ORegfile_OData_vld7_7;
					ORegfile_OData_vld8		= ORegfile_OData_vld7_8;					
				end
				4'b1000:begin
					ORegfile_IData8_1 		= ORegfile_IData1;
					ORegfile_IData8_2 		= ORegfile_IData2;
					ORegfile_IData8_3 		= ORegfile_IData3;
					ORegfile_IData8_4 		= ORegfile_IData4;
					ORegfile_IData8_5 		= ORegfile_IData5;
					ORegfile_IData8_6 		= ORegfile_IData6;
					ORegfile_IData8_7 		= ORegfile_IData7;
					ORegfile_IData8_8 		= ORegfile_IData8;
					ORegfile_IData_vld8_1	= ORegfile_IData_vld1;
					ORegfile_IData_vld8_2	= ORegfile_IData_vld2;
					ORegfile_IData_vld8_3	= ORegfile_IData_vld3;
					ORegfile_IData_vld8_4	= ORegfile_IData_vld4;
					ORegfile_IData_vld8_5	= ORegfile_IData_vld5;
					ORegfile_IData_vld8_6	= ORegfile_IData_vld6;
					ORegfile_IData_vld8_7	= ORegfile_IData_vld7;
					ORegfile_IData_vld8_8	= ORegfile_IData_vld8;

					ORegfile_OData1 		= ORegfile_OData8_1;
					ORegfile_OData2 		= ORegfile_OData8_2;
					ORegfile_OData3			= ORegfile_OData8_3;
					ORegfile_OData4 		= ORegfile_OData8_4;
					ORegfile_OData5 		= ORegfile_OData8_5;
					ORegfile_OData6 		= ORegfile_OData8_6;
					ORegfile_OData7 		= ORegfile_OData8_7;
					ORegfile_OData8 		= ORegfile_OData8_8;
					ORegfile_OData_vld1		= ORegfile_OData_vld8_1;
					ORegfile_OData_vld2		= ORegfile_OData_vld8_2;
					ORegfile_OData_vld3		= ORegfile_OData_vld8_3;
					ORegfile_OData_vld4		= ORegfile_OData_vld8_4;
					ORegfile_OData_vld5		= ORegfile_OData_vld8_5;
					ORegfile_OData_vld6		= ORegfile_OData_vld8_6;
					ORegfile_OData_vld7		= ORegfile_OData_vld8_7;
					ORegfile_OData_vld8		= ORegfile_OData_vld8_8;					
				end
				4'b1001:begin
					ORegfile_IData9_1 		= ORegfile_IData1;
					ORegfile_IData9_2 		= ORegfile_IData2;
					ORegfile_IData9_3 		= ORegfile_IData3;
					ORegfile_IData9_4 		= ORegfile_IData4;
					ORegfile_IData9_5 		= ORegfile_IData5;
					ORegfile_IData9_6 		= ORegfile_IData6;
					ORegfile_IData9_7 		= ORegfile_IData7;
					ORegfile_IData9_8 		= ORegfile_IData8;
					ORegfile_IData_vld9_1	= ORegfile_IData_vld1;
					ORegfile_IData_vld9_2	= ORegfile_IData_vld2;
					ORegfile_IData_vld9_3	= ORegfile_IData_vld3;
					ORegfile_IData_vld9_4	= ORegfile_IData_vld4;
					ORegfile_IData_vld9_5	= ORegfile_IData_vld5;
					ORegfile_IData_vld9_6	= ORegfile_IData_vld6;
					ORegfile_IData_vld9_7	= ORegfile_IData_vld7;
					ORegfile_IData_vld9_8	= ORegfile_IData_vld8;	

					ORegfile_OData1 		= ORegfile_OData9_1;
					ORegfile_OData2 		= ORegfile_OData9_2;
					ORegfile_OData3			= ORegfile_OData9_3;
					ORegfile_OData4 		= ORegfile_OData9_4;
					ORegfile_OData5 		= ORegfile_OData9_5;
					ORegfile_OData6 		= ORegfile_OData9_6;
					ORegfile_OData7 		= ORegfile_OData9_7;
					ORegfile_OData8 		= ORegfile_OData9_8;
					ORegfile_OData_vld1		= ORegfile_OData_vld9_1;
					ORegfile_OData_vld2		= ORegfile_OData_vld9_2;
					ORegfile_OData_vld3		= ORegfile_OData_vld9_3;
					ORegfile_OData_vld4		= ORegfile_OData_vld9_4;
					ORegfile_OData_vld5		= ORegfile_OData_vld9_5;
					ORegfile_OData_vld6		= ORegfile_OData_vld9_6;
					ORegfile_OData_vld7		= ORegfile_OData_vld9_7;
					ORegfile_OData_vld8		= ORegfile_OData_vld9_8;					
				end
				default:begin
					ORegfile_IData1_1 		= 0;
					ORegfile_IData1_2 		= 0;
					ORegfile_IData1_3 		= 0;
					ORegfile_IData1_4 		= 0;
					ORegfile_IData1_5 		= 0;
					ORegfile_IData1_6 		= 0;
					ORegfile_IData1_7 		= 0;
					ORegfile_IData1_8 		= 0;
					ORegfile_IData_vld1_1	= 0;
					ORegfile_IData_vld1_2	= 0;
					ORegfile_IData_vld1_3	= 0;
					ORegfile_IData_vld1_4	= 0;
					ORegfile_IData_vld1_5	= 0;
					ORegfile_IData_vld1_6	= 0;
					ORegfile_IData_vld1_7	= 0;
					ORegfile_IData_vld1_8	= 0;	

					ORegfile_OData1 		= 0;
					ORegfile_OData2 		= 0;
					ORegfile_OData3			= 0;
					ORegfile_OData4 		= 0;
					ORegfile_OData5 		= 0;
					ORegfile_OData6 		= 0;
					ORegfile_OData7 		= 0;
					ORegfile_OData8 		= 0;
					ORegfile_OData_vld1		= 0;
					ORegfile_OData_vld2		= 0;
					ORegfile_OData_vld3		= 0;
					ORegfile_OData_vld4		= 0;
					ORegfile_OData_vld5		= 0;
					ORegfile_OData_vld6		= 0;
					ORegfile_OData_vld7		= 0;
					ORegfile_OData_vld8		= 0;					
				end
			endcase
		end
		
//===========================================================  第一组8通道 ============================================================//			
Output_regfile 
	u_output_regfile1_1(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData1_1     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld1_1	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData1_1		),
						.ORegfile_OData_vld		( ORegfile_OData_vld1_1	)
					);

Output_regfile 
	u_output_regfile1_2(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData1_2     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld1_2	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData1_2		),
						.ORegfile_OData_vld		( ORegfile_OData_vld1_2	)
					);					

Output_regfile 
	u_output_regfile1_3(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData1_3     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld1_3	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData1_3		),
						.ORegfile_OData_vld		( ORegfile_OData_vld1_3	)
					);	
					
Output_regfile 
	u_output_regfile1_4(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData1_4     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld1_4	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData1_4		),
						.ORegfile_OData_vld		( ORegfile_OData_vld1_4	)
					);	

Output_regfile 
	u_output_regfile1_5(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData1_5     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld1_5	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData1_5		),
						.ORegfile_OData_vld		( ORegfile_OData_vld1_5	)
					);	
					
Output_regfile 
	u_output_regfile1_6(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData1_6     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld1_6	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData1_6		),
						.ORegfile_OData_vld		( ORegfile_OData_vld1_6	)
					);

Output_regfile 
	u_output_regfile1_7(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData1_7     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld1_7	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData1_7		),
						.ORegfile_OData_vld		( ORegfile_OData_vld1_7	)
					);	
					
Output_regfile 
	u_output_regfile1_8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData1_8     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld1_8	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData1_8		),
						.ORegfile_OData_vld		( ORegfile_OData_vld1_8	)
					);					

//===========================================================  第二组8通道 ============================================================//			
Output_regfile 
	u_output_regfile2_1(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData2_1     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld2_1	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData2_1		),
						.ORegfile_OData_vld		( ORegfile_OData_vld2_1	)
					);

Output_regfile 
	u_output_regfile2_2(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData2_2     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld2_2	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData2_2		),
						.ORegfile_OData_vld		( ORegfile_OData_vld2_2	)
					);					

Output_regfile 
	u_output_regfile2_3(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData2_3     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld2_3	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData2_3		),
						.ORegfile_OData_vld		( ORegfile_OData_vld2_3	)
					);	
					
Output_regfile 
	u_output_regfile2_4(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData2_4     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld2_4	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData2_4		),
						.ORegfile_OData_vld		( ORegfile_OData_vld2_4	)
					);	

Output_regfile 
	u_output_regfile2_5(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData2_5     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld2_5	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData2_5		),
						.ORegfile_OData_vld		( ORegfile_OData_vld2_5	)
					);	
					
Output_regfile 
	u_output_regfile2_6(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData2_6     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld2_6	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData2_6		),
						.ORegfile_OData_vld		( ORegfile_OData_vld2_6	)
					);

Output_regfile 
	u_output_regfile2_7(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData2_7     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld2_7	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData2_7		),
						.ORegfile_OData_vld		( ORegfile_OData_vld2_7	)
					);	
					
Output_regfile 
	u_output_regfile2_8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData2_8     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld2_8	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData2_8		),
						.ORegfile_OData_vld		( ORegfile_OData_vld2_8	)
					);					

//===========================================================  第三组8通道 ============================================================//			
Output_regfile 
	u_output_regfile3_1(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData3_1     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld3_1	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData3_1		),
						.ORegfile_OData_vld		( ORegfile_OData_vld3_1	)
					);

Output_regfile 
	u_output_regfile3_2(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData3_2     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld3_2	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData3_2		),
						.ORegfile_OData_vld		( ORegfile_OData_vld3_2	)
					);					

Output_regfile 
	u_output_regfile3_3(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData3_3     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld3_3	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData3_3		),
						.ORegfile_OData_vld		( ORegfile_OData_vld3_3	)
					);	
					
Output_regfile 
	u_output_regfile3_4(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData3_4     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld3_4	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData3_4		),
						.ORegfile_OData_vld		( ORegfile_OData_vld3_4	)
					);	

Output_regfile 
	u_output_regfile3_5(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData3_5     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld3_5	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData3_5		),
						.ORegfile_OData_vld		( ORegfile_OData_vld3_5	)
					);	
					
Output_regfile 
	u_output_regfile3_6(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData3_6     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld3_6	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData3_6		),
						.ORegfile_OData_vld		( ORegfile_OData_vld3_6	)
					);

Output_regfile 
	u_output_regfile3_7(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData3_7     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld3_7	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData3_7		),
						.ORegfile_OData_vld		( ORegfile_OData_vld3_7	)
					);	
					
Output_regfile 
	u_output_regfile3_8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData3_8     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld3_8	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData3_8		),
						.ORegfile_OData_vld		( ORegfile_OData_vld3_8	)
					);					

//===========================================================  第四组8通道 ============================================================//			
Output_regfile 
	u_output_regfile4_1(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData4_1     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld4_1	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData4_1		),
						.ORegfile_OData_vld		( ORegfile_OData_vld4_1	)
					);

Output_regfile 
	u_output_regfile4_2(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData4_2     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld4_2	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData4_2		),
						.ORegfile_OData_vld		( ORegfile_OData_vld4_2	)
					);					

Output_regfile 
	u_output_regfile4_3(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData4_3     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld4_3	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData4_3		),
						.ORegfile_OData_vld		( ORegfile_OData_vld4_3	)
					);	
					
Output_regfile 
	u_output_regfile4_4(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData4_4     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld4_4	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData4_4		),
						.ORegfile_OData_vld		( ORegfile_OData_vld4_4	)
					);	

Output_regfile 
	u_output_regfile4_5(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData4_5     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld4_5	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData4_5		),
						.ORegfile_OData_vld		( ORegfile_OData_vld4_5	)
					);	
					
Output_regfile 
	u_output_regfile4_6(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData4_6     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld4_6	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData4_6		),
						.ORegfile_OData_vld		( ORegfile_OData_vld4_6	)
					);

Output_regfile 
	u_output_regfile4_7(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData4_7     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld4_7	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData4_7		),
						.ORegfile_OData_vld		( ORegfile_OData_vld4_7	)
					);	
					
Output_regfile 
	u_output_regfile4_8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData4_8     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld4_8	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData4_8		),
						.ORegfile_OData_vld		( ORegfile_OData_vld4_8	)
					);					

//===========================================================  第五组8通道 ============================================================//			
Output_regfile 
	u_output_regfile5_1(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData5_1     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld5_1	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData5_1		),
						.ORegfile_OData_vld		( ORegfile_OData_vld5_1	)
					);

Output_regfile 
	u_output_regfile5_2(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData5_2     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld5_2	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData5_2		),
						.ORegfile_OData_vld		( ORegfile_OData_vld5_2	)
					);					

Output_regfile 
	u_output_regfile5_3(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData5_3     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld5_3	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData5_3		),
						.ORegfile_OData_vld		( ORegfile_OData_vld5_3	)
					);	
					
Output_regfile 
	u_output_regfile5_4(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData5_4     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld5_4	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData5_4		),
						.ORegfile_OData_vld		( ORegfile_OData_vld5_4	)
					);	

Output_regfile 
	u_output_regfile5_5(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData5_5     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld5_5	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData5_5		),
						.ORegfile_OData_vld		( ORegfile_OData_vld5_5	)
					);	
					
Output_regfile 
	u_output_regfile5_6(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData5_6     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld5_6	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData5_6		),
						.ORegfile_OData_vld		( ORegfile_OData_vld5_6	)
					);

Output_regfile 
	u_output_regfile5_7(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData5_7     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld5_7	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData5_7		),
						.ORegfile_OData_vld		( ORegfile_OData_vld5_7	)
					);	
					
Output_regfile 
	u_output_regfile5_8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData5_8     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld5_8	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData5_8		),
						.ORegfile_OData_vld		( ORegfile_OData_vld5_8	)
					);					

//===========================================================  第六组8通道 ============================================================//			
Output_regfile 
	u_output_regfile6_1(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData6_1     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld6_1	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData6_1		),
						.ORegfile_OData_vld		( ORegfile_OData_vld6_1	)
					);

Output_regfile 
	u_output_regfile6_2(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData6_2     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld6_2	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData6_2		),
						.ORegfile_OData_vld		( ORegfile_OData_vld6_2	)
					);					

Output_regfile 
	u_output_regfile6_3(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData6_3     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld6_3	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData6_3		),
						.ORegfile_OData_vld		( ORegfile_OData_vld6_3	)
					);	
					
Output_regfile 
	u_output_regfile6_4(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData6_4     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld6_4	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData6_4		),
						.ORegfile_OData_vld		( ORegfile_OData_vld6_4	)
					);	

Output_regfile 
	u_output_regfile6_5(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData6_5     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld6_5	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData6_5		),
						.ORegfile_OData_vld		( ORegfile_OData_vld6_5	)
					);	
					
Output_regfile 
	u_output_regfile6_6(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData6_6     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld6_6	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData6_6		),
						.ORegfile_OData_vld		( ORegfile_OData_vld6_6	)
					);

Output_regfile 
	u_output_regfile6_7(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData6_7     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld6_7	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData6_7		),
						.ORegfile_OData_vld		( ORegfile_OData_vld6_7	)
					);	
					
Output_regfile 
	u_output_regfile6_8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData6_8     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld6_8	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData6_8		),
						.ORegfile_OData_vld		( ORegfile_OData_vld6_8	)
					);					

//===========================================================  第七组8通道 ============================================================//			
Output_regfile 
	u_output_regfile7_1(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData7_1     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld7_1	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData7_1		),
						.ORegfile_OData_vld		( ORegfile_OData_vld7_1	)
					);

Output_regfile 
	u_output_regfile7_2(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData7_2     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld7_2	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData7_2		),
						.ORegfile_OData_vld		( ORegfile_OData_vld7_2	)
					);					

Output_regfile 
	u_output_regfile7_3(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData7_3     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld7_3	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData7_3		),
						.ORegfile_OData_vld		( ORegfile_OData_vld7_3	)
					);	
					
Output_regfile 
	u_output_regfile7_4(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData7_4     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld7_4	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData7_4		),
						.ORegfile_OData_vld		( ORegfile_OData_vld7_4	)
					);	

Output_regfile 
	u_output_regfile7_5(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData7_5     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld7_5	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData7_5		),
						.ORegfile_OData_vld		( ORegfile_OData_vld7_5	)
					);	
					
Output_regfile 
	u_output_regfile7_6(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData7_6     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld7_6	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData7_6		),
						.ORegfile_OData_vld		( ORegfile_OData_vld7_6	)
					);

Output_regfile 
	u_output_regfile7_7(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData7_7     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld7_7	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData7_7		),
						.ORegfile_OData_vld		( ORegfile_OData_vld7_7	)
					);	
					
Output_regfile 
	u_output_regfile7_8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData7_8     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld7_8	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData7_8		),
						.ORegfile_OData_vld		( ORegfile_OData_vld7_8	)
					);	

//===========================================================  第七组8通道 ============================================================//			
Output_regfile 
	u_output_regfile8_1(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData8_1     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld8_1	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData8_1		),
						.ORegfile_OData_vld		( ORegfile_OData_vld8_1	)
					);

Output_regfile 
	u_output_regfile8_2(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData8_2     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld8_2	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData8_2		),
						.ORegfile_OData_vld		( ORegfile_OData_vld8_2	)
					);					

Output_regfile 
	u_output_regfile8_3(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData8_3     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld8_3	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData8_3		),
						.ORegfile_OData_vld		( ORegfile_OData_vld8_3	)
					);	
					
Output_regfile 
	u_output_regfile8_4(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData8_4     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld8_4	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData8_4		),
						.ORegfile_OData_vld		( ORegfile_OData_vld8_4	)
					);	

Output_regfile 
	u_output_regfile8_5(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData8_5     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld8_5	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData8_5		),
						.ORegfile_OData_vld		( ORegfile_OData_vld8_5	)
					);	
					
Output_regfile 
	u_output_regfile8_6(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData8_6     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld8_6	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData8_6		),
						.ORegfile_OData_vld		( ORegfile_OData_vld8_6	)
					);

Output_regfile 
	u_output_regfile8_7(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData8_7     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld8_7	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData8_7		),
						.ORegfile_OData_vld		( ORegfile_OData_vld8_7	)
					);	
					
Output_regfile 
	u_output_regfile8_8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData8_8     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld8_8	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData8_8		),
						.ORegfile_OData_vld		( ORegfile_OData_vld8_8	)
					);	

//===========================================================  第九组8通道 ============================================================//			
Output_regfile 
	u_output_regfile9_1(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData9_1     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld9_1	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData9_1		),
						.ORegfile_OData_vld		( ORegfile_OData_vld9_1	)
					);

Output_regfile 
	u_output_regfile9_2(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData9_2     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld9_2	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData9_2		),
						.ORegfile_OData_vld		( ORegfile_OData_vld9_2	)
					);					

Output_regfile 
	u_output_regfile9_3(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData9_3     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld9_3	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData9_3		),
						.ORegfile_OData_vld		( ORegfile_OData_vld9_3	)
					);	
					
Output_regfile 
	u_output_regfile9_4(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData9_4     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld9_4	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData9_4		),
						.ORegfile_OData_vld		( ORegfile_OData_vld9_4	)
					);	

Output_regfile 
	u_output_regfile9_5(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData9_5     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld9_5	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData9_5		),
						.ORegfile_OData_vld		( ORegfile_OData_vld9_5	)
					);	
					
Output_regfile 
	u_output_regfile9_6(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData9_6     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld9_6	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData9_6		),
						.ORegfile_OData_vld		( ORegfile_OData_vld9_6	)
					);

Output_regfile 
	u_output_regfile9_7(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData9_7     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld9_7	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData9_7		),
						.ORegfile_OData_vld		( ORegfile_OData_vld9_7	)
					);	
					
Output_regfile 
	u_output_regfile9_8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),		
						.ORegfile_IData         ( ORegfile_IData9_8     ),
						.ORegfile_IData_vld		( ORegfile_IData_vld9_8	),
						.P						( P						),
						.S						( S						),.or_cs(or_cs),
						.ORegfile_OData			( ORegfile_OData9_8		),
						.ORegfile_OData_vld		( ORegfile_OData_vld9_8	)
					);	
					
endmodule
