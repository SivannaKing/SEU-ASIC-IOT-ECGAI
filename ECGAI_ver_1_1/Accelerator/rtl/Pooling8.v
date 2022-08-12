// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : Pooling8.v
// @Module Name  : Pooling8
// @Created Time : 2020-12-17 09:53
//
// @Abstract     : This module is sum of Pools              
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-12-17  	Huangjunguang      v1.0          initial version 
// 
// ******************************************************************************


`timescale 1ns/1ns
`define byte_width 8
`define halfword_width 16
`define sevenbyte_width 56


module Pooling8 (

		input clk_cal,
		input rst_cal_n,     
	
		input [2:0] P,			
		input [`sevenbyte_width-1:0] Pool_IData1,
		input [`sevenbyte_width-1:0] Pool_IData2,
		input [`sevenbyte_width-1:0] Pool_IData3,
		input [`sevenbyte_width-1:0] Pool_IData4,
		input [`sevenbyte_width-1:0] Pool_IData5,
		input [`sevenbyte_width-1:0] Pool_IData6,
		input [`sevenbyte_width-1:0] Pool_IData7,
		input [`sevenbyte_width-1:0] Pool_IData8,
		input Pool_IData_vld1,
		input Pool_IData_vld2,
		input Pool_IData_vld3,
		input Pool_IData_vld4,
		input Pool_IData_vld5,
		input Pool_IData_vld6,
		input Pool_IData_vld7,
		input Pool_IData_vld8,
		
		output Pool_OData_vld1,
		output Pool_OData_vld2,
		output Pool_OData_vld3,
		output Pool_OData_vld4,
		output Pool_OData_vld5,
		output Pool_OData_vld6,
		output Pool_OData_vld7,
		output Pool_OData_vld8,
		output [`byte_width-1:0] Pool_OData1,
		output [`byte_width-1:0] Pool_OData2,
		output [`byte_width-1:0] Pool_OData3,
		output [`byte_width-1:0] Pool_OData4,
		output [`byte_width-1:0] Pool_OData5,
		output [`byte_width-1:0] Pool_OData6,
		output [`byte_width-1:0] Pool_OData7,
		output [`byte_width-1:0] Pool_OData8
	);
	

	Pooling 
		u_pooling1(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						.P						( P						), 
						.Pool_IData				( Pool_IData1			),
						.Pool_IData_vld			( Pool_IData_vld1		),
						.Pool_OData				( Pool_OData1			),
						.Pool_OData_vld			( Pool_OData_vld1		)
					);	

	Pooling 
		u_pooling2(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						.P						( P						), 
						.Pool_IData				( Pool_IData2			),
						.Pool_IData_vld			( Pool_IData_vld2		),
						.Pool_OData				( Pool_OData2			),
						.Pool_OData_vld			( Pool_OData_vld2		)
					);	

	Pooling 
		u_pooling3(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						.P						( P						), 
						.Pool_IData				( Pool_IData3			),
						.Pool_IData_vld			( Pool_IData_vld3		),
						.Pool_OData				( Pool_OData3			),
						.Pool_OData_vld			( Pool_OData_vld3		)
					);	
	Pooling 
		u_pooling4(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						.P						( P						), 
						.Pool_IData				( Pool_IData4			),
						.Pool_IData_vld			( Pool_IData_vld4		),
						.Pool_OData				( Pool_OData4			),
						.Pool_OData_vld			( Pool_OData_vld4		)
					);	

	Pooling 
		u_pooling5(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						.P						( P						), 
						.Pool_IData				( Pool_IData5			),
						.Pool_IData_vld			( Pool_IData_vld5		),
						.Pool_OData				( Pool_OData5			),
						.Pool_OData_vld			( Pool_OData_vld5		)
					);	

	Pooling 
		u_pooling6(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						.P						( P						), 
						.Pool_IData				( Pool_IData6			),
						.Pool_IData_vld			( Pool_IData_vld6		),
						.Pool_OData				( Pool_OData6			),
						.Pool_OData_vld			( Pool_OData_vld6		)
					);	

	Pooling 
		u_pooling7(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						.P						( P						), 
						.Pool_IData				( Pool_IData7			),
						.Pool_IData_vld			( Pool_IData_vld7		),
						.Pool_OData				( Pool_OData7			),
						.Pool_OData_vld			( Pool_OData_vld7		)
					);	

	Pooling 
		u_pooling8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						.P						( P						), 
						.Pool_IData				( Pool_IData8			),
						.Pool_IData_vld			( Pool_IData_vld8		),
						.Pool_OData				( Pool_OData8			),
						.Pool_OData_vld			( Pool_OData_vld8		)
					);	



endmodule
