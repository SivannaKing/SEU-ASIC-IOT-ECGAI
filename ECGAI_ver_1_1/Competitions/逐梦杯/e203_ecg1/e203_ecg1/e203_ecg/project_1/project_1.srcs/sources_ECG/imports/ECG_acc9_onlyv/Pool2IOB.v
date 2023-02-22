// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : Pooling8.v
// @Module Name  : Pooling8
// @Created Time : 2020-05-23 12:52
//
// @Abstract     : This module is RP2IOB              
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-05-23  	Huangjunguang      v1.0          initial version 
// 
// ******************************************************************************


`timescale 1ns/1ns
`define byte_width 8
`define halfword_width 16
`define eightbyte_width 64


module Pool2IOB (



		input clk_cal,
		input rst_cal_n,     
	
		input [3:0]	N8_cnt,
        input       lyr_end,
		input 		final_column,
        input       final_ftNchange_flag,

        input                   w_half_end,     // sf add
	input                   zero_padd_enable,    //sf add
        input   [3 :0]		nn_layer_cnt,	
		input [`byte_width-1:0] RP_IData1,
		input [`byte_width-1:0] RP_IData2,
		input [`byte_width-1:0] RP_IData3,
		input [`byte_width-1:0] RP_IData4,
		input [`byte_width-1:0] RP_IData5,
		input [`byte_width-1:0] RP_IData6,
		input [`byte_width-1:0] RP_IData7,
		input [`byte_width-1:0] RP_IData8,
		input RP_IData_vld1,
		input RP_IData_vld2,
		input RP_IData_vld3,
		input RP_IData_vld4,
		input RP_IData_vld5,
		input RP_IData_vld6,
		input RP_IData_vld7,
		input RP_IData_vld8,
		
		output reg RP_OVld,
		output reg  [`byte_width-1:0] RP_OData1,
		output reg  [`byte_width-1:0] RP_OData2,
		output reg  [`byte_width-1:0] RP_OData3,
		output reg  [`byte_width-1:0] RP_OData4,
		output reg  [`byte_width-1:0] RP_OData5,
		output reg  [`byte_width-1:0] RP_OData6,
		output reg  [`byte_width-1:0] RP_OData7,
		output reg  [`byte_width-1:0] RP_OData8
	);
	
//=========================================================== RP_IData & Ivld ============================================================//	
		reg 	 		RP_IData_vld1_1,RP_IData_vld1_2,RP_IData_vld1_3,RP_IData_vld1_4,
						RP_IData_vld1_5,RP_IData_vld1_6,RP_IData_vld1_7,RP_IData_vld1_8;
		reg 	 		RP_IData_vld2_1,RP_IData_vld2_2,RP_IData_vld2_3,RP_IData_vld2_4,
						RP_IData_vld2_5,RP_IData_vld2_6,RP_IData_vld2_7,RP_IData_vld2_8;
		reg 	 		RP_IData_vld3_1,RP_IData_vld3_2,RP_IData_vld3_3,RP_IData_vld3_4,
						RP_IData_vld3_5,RP_IData_vld3_6,RP_IData_vld3_7,RP_IData_vld3_8;
		reg 	 		RP_IData_vld4_1,RP_IData_vld4_2,RP_IData_vld4_3,RP_IData_vld4_4,
						RP_IData_vld4_5,RP_IData_vld4_6,RP_IData_vld4_7,RP_IData_vld4_8;
		reg 	 		RP_IData_vld5_1,RP_IData_vld5_2,RP_IData_vld5_3,RP_IData_vld5_4,
						RP_IData_vld5_5,RP_IData_vld5_6,RP_IData_vld5_7,RP_IData_vld5_8;
		reg 	 		RP_IData_vld6_1,RP_IData_vld6_2,RP_IData_vld6_3,RP_IData_vld6_4,
						RP_IData_vld6_5,RP_IData_vld6_6,RP_IData_vld6_7,RP_IData_vld6_8;
		reg 	 		RP_IData_vld7_1,RP_IData_vld7_2,RP_IData_vld7_3,RP_IData_vld7_4,
						RP_IData_vld7_5,RP_IData_vld7_6,RP_IData_vld7_7,RP_IData_vld7_8;
		reg 	 		RP_IData_vld8_1,RP_IData_vld8_2,RP_IData_vld8_3,RP_IData_vld8_4,
						RP_IData_vld8_5,RP_IData_vld8_6,RP_IData_vld8_7,RP_IData_vld8_8;
		reg 	 		RP_IData_vld9_1,RP_IData_vld9_2,RP_IData_vld9_3,RP_IData_vld9_4,
						RP_IData_vld9_5,RP_IData_vld9_6,RP_IData_vld9_7,RP_IData_vld9_8;

//=========================================================== register ============================================================//	
		reg [`byte_width-1:0] register1_1 [15:0]; reg [`byte_width-1:0] register1_2 [15:0]; reg [`byte_width-1:0] register1_3 [15:0]; reg [`byte_width-1:0] register1_4 [15:0];
		reg [`byte_width-1:0] register1_5 [15:0]; reg [`byte_width-1:0] register1_6 [15:0]; reg [`byte_width-1:0] register1_7 [15:0]; reg [`byte_width-1:0] register1_8 [15:0];

		reg [`byte_width-1:0] register2_1 [15:0]; reg [`byte_width-1:0] register2_2 [15:0]; reg [`byte_width-1:0] register2_3 [15:0]; reg [`byte_width-1:0] register2_4 [15:0];
		reg [`byte_width-1:0] register2_5 [15:0]; reg [`byte_width-1:0] register2_6 [15:0]; reg [`byte_width-1:0] register2_7 [15:0]; reg [`byte_width-1:0] register2_8 [15:0];

		reg [`byte_width-1:0] register3_1 [15:0]; reg [`byte_width-1:0] register3_2 [15:0]; reg [`byte_width-1:0] register3_3 [15:0]; reg [`byte_width-1:0] register3_4 [15:0];
		reg [`byte_width-1:0] register3_5 [15:0]; reg [`byte_width-1:0] register3_6 [15:0]; reg [`byte_width-1:0] register3_7 [15:0]; reg [`byte_width-1:0] register3_8 [15:0];

		reg [`byte_width-1:0] register4_1 [15:0]; reg [`byte_width-1:0] register4_2 [15:0]; reg [`byte_width-1:0] register4_3 [15:0]; reg [`byte_width-1:0] register4_4 [15:0];
		reg [`byte_width-1:0] register4_5 [15:0]; reg [`byte_width-1:0] register4_6 [15:0]; reg [`byte_width-1:0] register4_7 [15:0]; reg [`byte_width-1:0] register4_8 [15:0];

		reg [`byte_width-1:0] register5_1 [15:0]; reg [`byte_width-1:0] register5_2 [15:0]; reg [`byte_width-1:0] register5_3 [15:0]; reg [`byte_width-1:0] register5_4 [15:0];
		reg [`byte_width-1:0] register5_5 [15:0]; reg [`byte_width-1:0] register5_6 [15:0]; reg [`byte_width-1:0] register5_7 [15:0]; reg [`byte_width-1:0] register5_8 [15:0];

		reg [`byte_width-1:0] register6_1 [15:0]; reg [`byte_width-1:0] register6_2 [15:0]; reg [`byte_width-1:0] register6_3 [15:0]; reg [`byte_width-1:0] register6_4 [15:0];
		reg [`byte_width-1:0] register6_5 [15:0]; reg [`byte_width-1:0] register6_6 [15:0]; reg [`byte_width-1:0] register6_7 [15:0]; reg [`byte_width-1:0] register6_8 [15:0];

		reg [`byte_width-1:0] register7_1 [15:0]; reg [`byte_width-1:0] register7_2 [15:0]; reg [`byte_width-1:0] register7_3 [15:0]; reg [`byte_width-1:0] register7_4 [15:0];
		reg [`byte_width-1:0] register7_5 [15:0]; reg [`byte_width-1:0] register7_6 [15:0]; reg [`byte_width-1:0] register7_7 [15:0]; reg [`byte_width-1:0] register7_8 [15:0];

		reg [`byte_width-1:0] register8_1 [15:0]; reg [`byte_width-1:0] register8_2 [15:0]; reg [`byte_width-1:0] register8_3 [15:0]; reg [`byte_width-1:0] register8_4 [15:0];
		reg [`byte_width-1:0] register8_5 [15:0]; reg [`byte_width-1:0] register8_6 [15:0]; reg [`byte_width-1:0] register8_7 [15:0]; reg [`byte_width-1:0] register8_8 [15:0];

		reg [`byte_width-1:0] register9_1 [15:0]; reg [`byte_width-1:0] register9_2 [15:0]; reg [`byte_width-1:0] register9_3 [15:0]; reg [`byte_width-1:0] register9_4 [15:0];
		reg [`byte_width-1:0] register9_5 [15:0]; reg [`byte_width-1:0] register9_6 [15:0]; reg [`byte_width-1:0] register9_7 [15:0]; reg [`byte_width-1:0] register9_8 [15:0];	

//=========================================================== integer ============================================================//	
		integer i1_1, i1_2, i1_3, i1_4, i1_5, i1_6, i1_7, i1_8;	
		integer i2_1, i2_2, i2_3, i2_4, i2_5, i2_6, i2_7, i2_8;	
		integer i3_1, i3_2, i3_3, i3_4, i3_5, i3_6, i3_7, i3_8;	
		integer i4_1, i4_2, i4_3, i4_4, i4_5, i4_6, i4_7, i4_8;	
		integer i5_1, i5_2, i5_3, i5_4, i5_5, i5_6, i5_7, i5_8;	
		integer i6_1, i6_2, i6_3, i6_4, i6_5, i6_6, i6_7, i6_8;	
		integer i7_1, i7_2, i7_3, i7_4, i7_5, i7_6, i7_7, i7_8;	
		integer i8_1, i8_2, i8_3, i8_4, i8_5, i8_6, i8_7, i8_8;	
		integer i9_1, i9_2, i9_3, i9_4, i9_5, i9_6, i9_7, i9_8;	

//=========================================================== waddr ============================================================//	
		reg [3:0] waddr1_1, waddr1_2, waddr1_3, waddr1_4, waddr1_5, waddr1_6, waddr1_7, waddr1_8;
		reg [3:0] waddr2_1, waddr2_2, waddr2_3, waddr2_4, waddr2_5, waddr2_6, waddr2_7, waddr2_8;
		reg [3:0] waddr3_1, waddr3_2, waddr3_3, waddr3_4, waddr3_5, waddr3_6, waddr3_7, waddr3_8;
		reg [3:0] waddr4_1, waddr4_2, waddr4_3, waddr4_4, waddr4_5, waddr4_6, waddr4_7, waddr4_8;
		reg [3:0] waddr5_1, waddr5_2, waddr5_3, waddr5_4, waddr5_5, waddr5_6, waddr5_7, waddr5_8;
		reg [3:0] waddr6_1, waddr6_2, waddr6_3, waddr6_4, waddr6_5, waddr6_6, waddr6_7, waddr6_8;
		reg [3:0] waddr7_1, waddr7_2, waddr7_3, waddr7_4, waddr7_5, waddr7_6, waddr7_7, waddr7_8;
		reg [3:0] waddr8_1, waddr8_2, waddr8_3, waddr8_4, waddr8_5, waddr8_6, waddr8_7, waddr8_8;
		reg [3:0] waddr9_1, waddr9_2, waddr9_3, waddr9_4, waddr9_5, waddr9_6, waddr9_7, waddr9_8;



//=======================================================================================================================================//
		wire [3:0] zero_padd_addr;
		
//===========================================================  input mux of 9 ============================================================//	



	
		always@(*)begin
			RP_IData_vld1_1	= 0;
			RP_IData_vld1_2	= 0;
			RP_IData_vld1_3	= 0;
			RP_IData_vld1_4	= 0;
			RP_IData_vld1_5	= 0;
			RP_IData_vld1_6	= 0;
			RP_IData_vld1_7	= 0;
			RP_IData_vld1_8	= 0;
			
			RP_IData_vld2_1	= 0;
			RP_IData_vld2_2	= 0;
			RP_IData_vld2_3	= 0;
			RP_IData_vld2_4	= 0;
			RP_IData_vld2_5	= 0;
			RP_IData_vld2_6	= 0;
			RP_IData_vld2_7	= 0;
			RP_IData_vld2_8	= 0;
			
			RP_IData_vld3_1	= 0;
			RP_IData_vld3_2	= 0;
			RP_IData_vld3_3	= 0;
			RP_IData_vld3_4	= 0;
			RP_IData_vld3_5	= 0;
			RP_IData_vld3_6	= 0;
			RP_IData_vld3_7	= 0;
			RP_IData_vld3_8	= 0;
			
			RP_IData_vld4_1	= 0;
			RP_IData_vld4_2	= 0;
			RP_IData_vld4_3	= 0;
			RP_IData_vld4_4	= 0;
			RP_IData_vld4_5	= 0;
			RP_IData_vld4_6	= 0;
			RP_IData_vld4_7	= 0;
			RP_IData_vld4_8	= 0;
			
			RP_IData_vld5_1	= 0;
			RP_IData_vld5_2	= 0;
			RP_IData_vld5_3	= 0;
			RP_IData_vld5_4	= 0;
			RP_IData_vld5_5	= 0;
			RP_IData_vld5_6	= 0;
			RP_IData_vld5_7	= 0;
			RP_IData_vld5_8	= 0;
			
			RP_IData_vld6_1	= 0;
			RP_IData_vld6_2	= 0;
			RP_IData_vld6_3	= 0;
			RP_IData_vld6_4	= 0;
			RP_IData_vld6_5	= 0;
			RP_IData_vld6_6	= 0;
			RP_IData_vld6_7	= 0;
			RP_IData_vld6_8	= 0;
			
			RP_IData_vld7_1	= 0;
			RP_IData_vld7_2	= 0;
			RP_IData_vld7_3	= 0;
			RP_IData_vld7_4	= 0;
			RP_IData_vld7_5	= 0;
			RP_IData_vld7_6	= 0;
			RP_IData_vld7_7	= 0;
			RP_IData_vld7_8	= 0;
			
			RP_IData_vld8_1	= 0;
			RP_IData_vld8_2	= 0;
			RP_IData_vld8_3	= 0;
			RP_IData_vld8_4	= 0;
			RP_IData_vld8_5	= 0;
			RP_IData_vld8_6	= 0;
			RP_IData_vld8_7	= 0;
			RP_IData_vld8_8	= 0;
			
			RP_IData_vld9_1	= 0;
			RP_IData_vld9_2	= 0;
			RP_IData_vld9_3	= 0;
			RP_IData_vld9_4	= 0;
			RP_IData_vld9_5	= 0;
			RP_IData_vld9_6	= 0;
			RP_IData_vld9_7	= 0;
			RP_IData_vld9_8	= 0;
			
			
			case(N8_cnt)
				4'b0001:begin
					RP_IData_vld1_1	= RP_IData_vld1;
					RP_IData_vld1_2	= RP_IData_vld2;
					RP_IData_vld1_3	= RP_IData_vld3;
					RP_IData_vld1_4	= RP_IData_vld4;
					RP_IData_vld1_5	= RP_IData_vld5;
					RP_IData_vld1_6	= RP_IData_vld6;
					RP_IData_vld1_7	= RP_IData_vld7;
					RP_IData_vld1_8	= RP_IData_vld8;					
				end
				4'b0010:begin
					RP_IData_vld2_1	= RP_IData_vld1;     
					RP_IData_vld2_2	= RP_IData_vld2;
					RP_IData_vld2_3	= RP_IData_vld3;
					RP_IData_vld2_4	= RP_IData_vld4;
					RP_IData_vld2_5	= RP_IData_vld5;
					RP_IData_vld2_6	= RP_IData_vld6;
					RP_IData_vld2_7	= RP_IData_vld7;
					RP_IData_vld2_8	= RP_IData_vld8;					
				end			
				4'b0011:begin
					RP_IData_vld3_1	= RP_IData_vld1;
					RP_IData_vld3_2	= RP_IData_vld2;
					RP_IData_vld3_3	= RP_IData_vld3;
					RP_IData_vld3_4	= RP_IData_vld4;
					RP_IData_vld3_5	= RP_IData_vld5;
					RP_IData_vld3_6	= RP_IData_vld6;
					RP_IData_vld3_7	= RP_IData_vld7;
					RP_IData_vld3_8	= RP_IData_vld8;						
				end
				4'b0100:begin
					RP_IData_vld4_1	= RP_IData_vld1;
					RP_IData_vld4_2	= RP_IData_vld2;
					RP_IData_vld4_3	= RP_IData_vld3;
					RP_IData_vld4_4	= RP_IData_vld4;
					RP_IData_vld4_5	= RP_IData_vld5;
					RP_IData_vld4_6	= RP_IData_vld6;
					RP_IData_vld4_7	= RP_IData_vld7;
					RP_IData_vld4_8	= RP_IData_vld8;							
				end
				4'b0101:begin
					RP_IData_vld5_1	= RP_IData_vld1;
					RP_IData_vld5_2	= RP_IData_vld2;
					RP_IData_vld5_3	= RP_IData_vld3;
					RP_IData_vld5_4	= RP_IData_vld4;
					RP_IData_vld5_5	= RP_IData_vld5;
					RP_IData_vld5_6	= RP_IData_vld6;
					RP_IData_vld5_7	= RP_IData_vld7;
					RP_IData_vld5_8	= RP_IData_vld8;					
				end
				4'b0110:begin
					RP_IData_vld6_1	= RP_IData_vld1;
					RP_IData_vld6_2	= RP_IData_vld2;
					RP_IData_vld6_3	= RP_IData_vld3;
					RP_IData_vld6_4	= RP_IData_vld4;
					RP_IData_vld6_5	= RP_IData_vld5;
					RP_IData_vld6_6	= RP_IData_vld6;
					RP_IData_vld6_7	= RP_IData_vld7;
					RP_IData_vld6_8	= RP_IData_vld8;						
				end
				4'b0111:begin
					RP_IData_vld7_1	= RP_IData_vld1;
					RP_IData_vld7_2	= RP_IData_vld2;
					RP_IData_vld7_3	= RP_IData_vld3;
					RP_IData_vld7_4	= RP_IData_vld4;
					RP_IData_vld7_5	= RP_IData_vld5;
					RP_IData_vld7_6	= RP_IData_vld6;
					RP_IData_vld7_7	= RP_IData_vld7;
					RP_IData_vld7_8	= RP_IData_vld8;				
				end
				4'b1000:begin
					RP_IData_vld8_1	= RP_IData_vld1;
					RP_IData_vld8_2	= RP_IData_vld2;
					RP_IData_vld8_3	= RP_IData_vld3;
					RP_IData_vld8_4	= RP_IData_vld4;
					RP_IData_vld8_5	= RP_IData_vld5;
					RP_IData_vld8_6	= RP_IData_vld6;
					RP_IData_vld8_7	= RP_IData_vld7;
					RP_IData_vld8_8	= RP_IData_vld8;					
				end
				4'b1001:begin
					RP_IData_vld9_1	= RP_IData_vld1;
					RP_IData_vld9_2	= RP_IData_vld2;
					RP_IData_vld9_3	= RP_IData_vld3;
					RP_IData_vld9_4	= RP_IData_vld4;
					RP_IData_vld9_5	= RP_IData_vld5;
					RP_IData_vld9_6	= RP_IData_vld6;
					RP_IData_vld9_7	= RP_IData_vld7;
					RP_IData_vld9_8	= RP_IData_vld8;					
				end
				default:begin
					RP_IData_vld1_1	= RP_IData_vld1;
					RP_IData_vld1_2	= RP_IData_vld2;
					RP_IData_vld1_3	= RP_IData_vld3;
					RP_IData_vld1_4	= RP_IData_vld4;
					RP_IData_vld1_5	= RP_IData_vld5;
					RP_IData_vld1_6	= RP_IData_vld6;
					RP_IData_vld1_7	= RP_IData_vld7;
					RP_IData_vld1_8	= RP_IData_vld8;					
				end
			endcase
		end
										

//********************************************************************
//RP output to IOB
//********************************************************************											
		reg		  rpout_last_flag;	
		reg		  final_column_temp;
		
		reg		  rp_mode1,rp_mode2,rp_mode3,rp_mode4,rp_mode5,rp_mode6,rp_mode7,rp_mode8,rp_mode9;
		wire	  rp_flag1, rp_flag2, rp_flag3, rp_flag4, rp_flag5, rp_flag6, rp_flag7, rp_flag8, rp_flag9;
//===========================================================  final output in each layer ============================================================//			
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				rpout_last_flag <= 1'b0;
				final_column_temp <= 1'b0;
			end
			else begin
				final_column_temp <= final_column;
				if(!final_column_temp && final_column)
					rpout_last_flag <= 1'b1;
				else	
					rpout_last_flag <= 1'b0;
			end
		end

//===========================================================  state controll ============================================================//		
		assign rp_flag1 = (waddr1_1 == 4'd7 || waddr1_1 == 4'd15) && RP_IData_vld1_1; 
		assign rp_flag2 = (waddr2_1 == 4'd7 || waddr2_1 == 4'd15) && RP_IData_vld2_1; 
		assign rp_flag3 = (waddr3_1 == 4'd7 || waddr3_1 == 4'd15) && RP_IData_vld3_1; 
		assign rp_flag4 = (waddr4_1 == 4'd7 || waddr4_1 == 4'd15) && RP_IData_vld4_1; 
		assign rp_flag5 = (waddr5_1 == 4'd7 || waddr5_1 == 4'd15) && RP_IData_vld5_1; 
		assign rp_flag6 = (waddr6_1 == 4'd7 || waddr6_1 == 4'd15) && RP_IData_vld6_1; 
		assign rp_flag7 = (waddr7_1 == 4'd7 || waddr7_1 == 4'd15) && RP_IData_vld7_1; 
		assign rp_flag8 = (waddr8_1 == 4'd7 || waddr8_1 == 4'd15) && RP_IData_vld8_1; 
		assign rp_flag9 = (waddr9_1 == 4'd7 || waddr9_1 == 4'd15) && RP_IData_vld9_1; 
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				rp_mode1 <= 1'b0;
			else begin
				if(RP_IData_vld1_1)begin
					if(waddr1_1 == 4'd7) 
					begin
						rp_mode1 <= 1'b0;
					end
					else if(waddr1_1 == 4'd15)  
					begin
						rp_mode1 <= 1'b1;
					end
				end
				else if(rpout_last_flag)
					rp_mode1 <= ~rp_mode1;
			end
		end

		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				rp_mode2 <= 1'b0;
			else begin
				if(RP_IData_vld2_1)begin
					if(waddr2_1 == 4'd7) 
					begin
						rp_mode2 <= 1'b0;
					end
					else if(waddr2_1 == 4'd15)  
					begin
						rp_mode2 <= 1'b1;
					end
				end
				else if(rpout_last_flag)
					rp_mode2 <= ~rp_mode2;
			end
		end

		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				rp_mode3 <= 1'b0;
			else begin
				if(RP_IData_vld3_1)begin
					if(waddr3_1 == 4'd7) 
					begin
						rp_mode3 <= 1'b0;
					end
					else if(waddr3_1 == 4'd15)  
					begin
						rp_mode3 <= 1'b1;
					end
				end
				else if(rpout_last_flag)
					rp_mode3 <= ~rp_mode3;
			end
		end

		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				rp_mode4 <= 1'b0;
			else begin
				if(RP_IData_vld4_1)begin
					if(waddr4_1 == 4'd7) 
					begin
						rp_mode4 <= 1'b0;
					end
					else if(waddr4_1 == 4'd15)  
					begin
						rp_mode4 <= 1'b1;
					end
				end
				else if(rpout_last_flag)
					rp_mode4 <= ~rp_mode4;
			end
		end

		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				rp_mode5 <= 1'b0;
			else begin
				if(RP_IData_vld5_1)begin
					if(waddr5_1 == 4'd7) 
					begin
						rp_mode5 <= 1'b0;
					end
					else if(waddr5_1 == 4'd15)  
					begin
						rp_mode5 <= 1'b1;
					end
				end
				else if(rpout_last_flag)
					rp_mode5 <= ~rp_mode5;
			end
		end

		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				rp_mode6 <= 1'b0;
			else begin
				if(RP_IData_vld6_1)begin
					if(waddr6_1 == 4'd7) 
					begin
						rp_mode6 <= 1'b0;
					end
					else if(waddr6_1 == 4'd15)  
					begin
						rp_mode6 <= 1'b1;
					end
				end
				else if(rpout_last_flag)
					rp_mode6 <= ~rp_mode6;
			end
		end

		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				rp_mode7 <= 1'b0;
			else begin
				if(RP_IData_vld7_1)begin
					if(waddr7_1 == 4'd7) 
					begin
						rp_mode7 <= 1'b0;
					end
					else if(waddr7_1 == 4'd15)  
					begin
						rp_mode7 <= 1'b1;
					end
				end
				else if(rpout_last_flag)
					rp_mode7 <= ~rp_mode7;
			end
		end

		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				rp_mode8 <= 1'b0;
			else begin
				if(RP_IData_vld8_1)begin
					if(waddr8_1 == 4'd7) 
					begin
						rp_mode8 <= 1'b0;
					end
					else if(waddr8_1 == 4'd15)  
					begin
						rp_mode8 <= 1'b1;
					end
				end
				else if(rpout_last_flag)
					rp_mode8 <= ~rp_mode8;
			end
		end

		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				rp_mode9 <= 1'b0;
			else begin
				if(RP_IData_vld9_1)begin
					if(waddr9_1 == 4'd7) 
					begin
						rp_mode9 <= 1'b0;
					end
					else if(waddr9_1 == 4'd15)  
					begin
						rp_mode9 <= 1'b1;
					end
				end
				else if(rpout_last_flag)
					rp_mode9 <= ~rp_mode9;
			end
		end


//*******************************************************************
//zero padding 
//*******************************************************************
         assign zero_padd_addr = (nn_layer_cnt==4'd1)? 4'd5:
                                 (nn_layer_cnt==4'd2)? 4'd4:
                                 (nn_layer_cnt==4'd3)? 4'd3:
                                 (nn_layer_cnt==4'd4)? 4'd2:
                                 (nn_layer_cnt==4'd5)? 4'd1:
                                 (nn_layer_cnt==4'd6)? 4'd1:
                                 (nn_layer_cnt==4'd7)? 4'd0:0;


//********************************************************************
//RP RAM addr controll
//********************************************************************	
//===========================================================  第一�?8通道 ============================================================//			
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				waddr1_1  <= 0;
			else if(zero_padd_enable)
				waddr1_1  <= zero_padd_addr;
			else if(RP_IData_vld1_1)
				waddr1_1 <= waddr1_1 + 1'b1;
			else if(lyr_end)
				waddr1_1  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				for(i1_1=0;i1_1<16;i1_1=i1_1+1) begin
					register1_1[i1_1] <= 8'b0000_0000;
				end
			else if(RP_IData_vld1_1)
				register1_1[waddr1_1] <= RP_IData1;
		end		

		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				waddr1_2  <= 0;
			else if(zero_padd_enable)
				waddr1_2  <= zero_padd_addr;
			else if(RP_IData_vld1_2)
				waddr1_2 <= waddr1_2 + 1'b1;
			else if(lyr_end)
				waddr1_2  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				for(i1_2=0;i1_2<16;i1_2=i1_2+1) begin
					register1_2[i1_2] <= 8'b0000_0000;
				end
			else if(RP_IData_vld1_2)
				register1_2[waddr1_2] <= RP_IData2;
		end			
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				waddr1_3  <= 0;
			else if(zero_padd_enable)
				waddr1_3  <= zero_padd_addr;
			else if(RP_IData_vld1_3)
				waddr1_3 <= waddr1_3 + 1'b1;
			else if(lyr_end)
				waddr1_3  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				for(i1_3=0;i1_3<16;i1_3=i1_3+1) begin
					register1_3[i1_3] <= 8'b0000_0000;
				end
			else if(RP_IData_vld1_3)
				register1_3[waddr1_3] <= RP_IData3;
		end	

		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				waddr1_4  <= 0;
			else if(zero_padd_enable)
				waddr1_4  <= zero_padd_addr;
			else if(RP_IData_vld1_4)
				waddr1_4 <= waddr1_4 + 1'b1;
			else if(lyr_end)
				waddr1_4  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				for(i1_4=0;i1_4<16;i1_4=i1_4+1) begin
					register1_4[i1_4] <= 8'b0000_0000;
				end
			else if(RP_IData_vld1_4)
				register1_4[waddr1_4] <= RP_IData4;
		end	
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				waddr1_5  <= 0;
			else if(zero_padd_enable)
				waddr1_5  <= zero_padd_addr;
			else if(RP_IData_vld1_5)
				waddr1_5 <= waddr1_5 + 1'b1;
			else if(lyr_end)
				waddr1_5  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				for(i1_5=0;i1_5<16;i1_5=i1_5+1) begin
					register1_5[i1_5] <= 8'b0000_0000;
				end
			else if(RP_IData_vld1_5)
				register1_5[waddr1_5] <= RP_IData5;
		end	
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				waddr1_6  <= 0;
			else if(zero_padd_enable)
				waddr1_6  <= zero_padd_addr;
			else if(RP_IData_vld1_6)
				waddr1_6 <= waddr1_6 + 1'b1;
			else if(lyr_end)
				waddr1_6  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				for(i1_6=0;i1_6<16;i1_6=i1_6+1) begin
					register1_6[i1_6] <= 8'b0000_0000;
				end
			else if(RP_IData_vld1_6)
				register1_6[waddr1_6] <= RP_IData6;
		end	
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				waddr1_7  <= 0;
			else if(zero_padd_enable)
				waddr1_7  <= zero_padd_addr;
			else if(RP_IData_vld1_7)
				waddr1_7 <= waddr1_7 + 1'b1;
			else if(lyr_end)
				waddr1_7  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				for(i1_7=0;i1_7<16;i1_7=i1_7+1) begin
					register1_7[i1_7] <= 8'b0000_0000;
				end
			else if(RP_IData_vld1_7)
				register1_7[waddr1_7] <= RP_IData7;
		end	
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				waddr1_8  <= 0;
			else if(zero_padd_enable)
				waddr1_8  <= zero_padd_addr;
			else if(RP_IData_vld1_8)
				waddr1_8 <= waddr1_8 + 1'b1;
			else if(lyr_end)
				waddr1_8  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n)
				for(i1_8=0;i1_8<16;i1_8=i1_8+1) begin
					register1_8[i1_8] <= 8'b0000_0000;
				end
			else if(RP_IData_vld1_8)
				register1_8[waddr1_8] <= RP_IData8;
		end	
		
		
//===========================================================  第二�?8通道 ============================================================//			
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr2_1  <= 0;
				for(i2_1=0;i2_1<16;i2_1=i2_1+1) begin
					register2_1[i2_1] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr2_1  <= zero_padd_addr;
			else if(RP_IData_vld2_1)begin
				waddr2_1 <= waddr2_1 + 1'b1;
				register2_1[waddr2_1] <= RP_IData1;
			end
			else if(lyr_end)
				waddr2_1  <= 4'b0;
		end

		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr2_2  <= 0;
				for(i2_2=0;i2_2<16;i2_2=i2_2+1) begin
					register2_2[i2_2] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr2_2  <= zero_padd_addr;
			else if(RP_IData_vld2_2)begin
				waddr2_2 <= waddr2_2 + 1'b1;
				register2_2[waddr2_2] <= RP_IData2;
			end
			else if(lyr_end)
				waddr2_2  <= 4'b0;
		end		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr2_3  <= 0;
				for(i2_3=0;i2_3<16;i2_3=i2_3+1) begin
					register2_3[i2_3] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr2_3  <= zero_padd_addr;
			else if(RP_IData_vld2_3)begin
				waddr2_3 <= waddr2_3 + 1'b1;
				register2_3[waddr2_3] <= RP_IData3;
			end
			else if(lyr_end)
				waddr2_3  <= 4'b0;
		end

		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr2_4  <= 0;
				for(i2_4=0;i2_4<16;i2_4=i2_4+1) begin
					register2_4[i2_4] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr2_4  <= zero_padd_addr;
			else if(RP_IData_vld2_4)begin
				waddr2_4 <= waddr2_4 + 1'b1;
				register2_4[waddr2_4] <= RP_IData4;
			end
			else if(lyr_end)
				waddr2_4  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr2_5  <= 0;
				for(i2_5=0;i2_5<16;i2_5=i2_5+1) begin
					register2_5[i2_5] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr2_5  <= zero_padd_addr;
			else if(RP_IData_vld2_5)begin
				waddr2_5 <= waddr2_5 + 1'b1;
				register2_5[waddr2_5] <= RP_IData5;
			end
			else if(lyr_end)
				waddr2_5  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr2_6  <= 0;
				for(i2_6=0;i2_6<16;i2_6=i2_6+1) begin
					register2_6[i2_6] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr2_6  <= zero_padd_addr;
			else if(RP_IData_vld2_6)begin
				waddr2_6 <= waddr2_6 + 1'b1;
				register2_6[waddr2_6] <= RP_IData6;
			end
			else if(lyr_end)
				waddr2_6  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr2_7  <= 0;
				for(i2_7=0;i2_7<16;i2_7=i2_7+1) begin
					register2_7[i2_7] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr2_7  <= zero_padd_addr;
			else if(RP_IData_vld2_7)begin
				waddr2_7 <= waddr2_7 + 1'b1;
				register2_7[waddr2_7] <= RP_IData7;
			end
			else if(lyr_end)
				waddr2_7  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr2_8  <= 0;
				for(i2_8=0;i2_8<16;i2_8=i2_8+1) begin
					register2_8[i2_8] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr2_8  <= zero_padd_addr;
			else if(RP_IData_vld2_8)begin
				waddr2_8 <= waddr2_8 + 1'b1;
				register2_8[waddr2_8] <= RP_IData8;
			end
			else if(lyr_end)
				waddr2_8  <= 4'b0;
		end

//===========================================================  第三�?8通道 ============================================================//			
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr3_1  <= 0;
				for(i3_1=0;i3_1<16;i3_1=i3_1+1) begin
					register3_1[i3_1] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr3_1  <= zero_padd_addr;
			else if(RP_IData_vld3_1)begin
				waddr3_1 <= waddr3_1 + 1'b1;
				register3_1[waddr3_1] <= RP_IData1;
			end
			else if(lyr_end)
				waddr3_1  <= 4'b0;
		end

		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr3_2  <= 0;
				for(i3_2=0;i3_2<16;i3_2=i3_2+1) begin
					register3_2[i3_2] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr3_2  <= zero_padd_addr;
			else if(RP_IData_vld3_2)begin
				waddr3_2 <= waddr3_2 + 1'b1;
				register3_2[waddr3_2] <= RP_IData2;
			end
			else if(lyr_end)
				waddr3_2  <= 4'b0;
		end

		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr3_3  <= 0;
				for(i3_3=0;i3_3<16;i3_3=i3_3+1) begin
					register3_3[i3_3] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr3_3  <= zero_padd_addr;
			else if(RP_IData_vld3_3)begin
				waddr3_3 <= waddr3_3 + 1'b1;
				register3_3[waddr3_3] <= RP_IData3;
			end
			else if(lyr_end)
				waddr3_3  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr3_4  <= 0;
				for(i3_4=0;i3_4<16;i3_4=i3_4+1) begin
					register3_4[i3_4] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr3_4  <= zero_padd_addr;
			else if(RP_IData_vld3_4)begin
				waddr3_4 <= waddr3_4 + 1'b1;
				register3_4[waddr3_4] <= RP_IData4;
			end
			else if(lyr_end)
				waddr3_4  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr3_5  <= 0;
				for(i3_5=0;i3_5<16;i3_5=i3_5+1) begin
					register3_5[i3_5] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr3_5  <= zero_padd_addr;
			else if(RP_IData_vld3_5)begin
				waddr3_5 <= waddr3_5 + 1'b1;
				register3_5[waddr3_5] <= RP_IData5;
			end
			else if(lyr_end)
				waddr3_5  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr3_6  <= 0;
				for(i3_6=0;i3_6<16;i3_6=i3_6+1) begin
					register3_6[i3_6] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr3_6  <= zero_padd_addr;
			else if(RP_IData_vld3_6)begin
				waddr3_6 <= waddr3_6 + 1'b1;
				register3_6[waddr3_6] <= RP_IData6;
			end
			else if(lyr_end)
				waddr3_6  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr3_7  <= 0;
				for(i3_7=0;i3_7<16;i3_7=i3_7+1) begin
					register3_7[i3_7] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr3_7  <= zero_padd_addr;
			else if(RP_IData_vld3_7)begin
				waddr3_7 <= waddr3_7 + 1'b1;
				register3_7[waddr3_7] <= RP_IData7;
			end
			else if(lyr_end)
				waddr3_7  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr3_8  <= 0;
				for(i3_8=0;i3_8<16;i3_8=i3_8+1) begin
					register3_8[i3_8] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr3_8  <= zero_padd_addr;
			else if(RP_IData_vld3_8)begin
				waddr3_8 <= waddr3_8 + 1'b1;
				register3_8[waddr3_8] <= RP_IData8;
			end
			else if(lyr_end)
				waddr3_8  <= 4'b0;
		end

//===========================================================  第四�?8通道 ============================================================//			
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr4_1  <= 0;
				for(i4_1=0;i4_1<16;i4_1=i4_1+1) begin
					register4_1[i4_1] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr4_1  <= zero_padd_addr;
			else if(RP_IData_vld4_1)begin
				waddr4_1 <= waddr4_1 + 1'b1;
				register4_1[waddr4_1] <= RP_IData1;
			end
			else if(lyr_end)
				waddr4_1  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr4_2  <= 0;
				for(i4_2=0;i4_2<16;i4_2=i4_2+1) begin
					register4_2[i4_2] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr4_2  <= zero_padd_addr;
			else if(RP_IData_vld4_2)begin
				waddr4_2 <= waddr4_2 + 1'b1;
				register4_2[waddr4_2] <= RP_IData2;
			end
			else if(lyr_end)
				waddr4_2  <= 4'b0;
		end

		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr4_3  <= 0;
				for(i4_3=0;i4_3<16;i4_3=i4_3+1) begin
					register4_3[i4_3] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr4_3  <= zero_padd_addr;
			else if(RP_IData_vld4_3)begin
				waddr4_3 <= waddr4_3 + 1'b1;
				register4_3[waddr4_3] <= RP_IData3;
			end
			else if(lyr_end)
				waddr4_3  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr4_4  <= 0;
				for(i4_4=0;i4_4<16;i4_4=i4_4+1) begin
					register4_4[i4_4] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr4_4  <= zero_padd_addr;
			else if(RP_IData_vld4_4)begin
				waddr4_4 <= waddr4_4 + 1'b1;
				register4_4[waddr4_4] <= RP_IData4;
			end
			else if(lyr_end)
				waddr4_4  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr4_5  <= 0;
				for(i4_5=0;i4_5<16;i4_5=i4_5+1) begin
					register4_5[i4_5] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr4_5  <= zero_padd_addr;
			else if(RP_IData_vld4_5)begin
				waddr4_5 <= waddr4_5 + 1'b1;
				register4_5[waddr4_5] <= RP_IData5;
			end
			else if(lyr_end)
				waddr4_5  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr4_6  <= 0;
				for(i4_6=0;i4_6<16;i4_6=i4_6+1) begin
					register4_6[i4_6] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr4_6  <= zero_padd_addr;
			else if(RP_IData_vld4_6)begin
				waddr4_6 <= waddr4_6 + 1'b1;
				register4_6[waddr4_6] <= RP_IData6;
			end
			else if(lyr_end)
				waddr4_6  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr4_7  <= 0;
				for(i4_7=0;i4_7<16;i4_7=i4_7+1) begin
					register4_7[i4_7] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr4_7  <= zero_padd_addr;
			else if(RP_IData_vld4_7)begin
				waddr4_7 <= waddr4_7 + 1'b1;
				register4_7[waddr4_7] <= RP_IData7;
			end
			else if(lyr_end)
				waddr4_7  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr4_8  <= 0;
				for(i4_8=0;i4_8<16;i4_8=i4_8+1) begin
					register4_8[i4_8] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr4_8  <= zero_padd_addr;
			else if(RP_IData_vld4_8)begin
				waddr4_8 <= waddr4_8 + 1'b1;
				register4_8[waddr4_8] <= RP_IData8;
			end
			else if(lyr_end)
				waddr4_8  <= 4'b0;
		end

//===========================================================  第五�?8通道 ============================================================//			
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr5_1  <= 0;
				for(i5_1=0;i5_1<16;i5_1=i5_1+1) begin
					register5_1[i5_1] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr5_1  <= zero_padd_addr;
			else if(RP_IData_vld5_1)begin
				waddr5_1 <= waddr5_1 + 1'b1;
				register5_1[waddr5_1] <= RP_IData1;
			end
			else if(lyr_end)
				waddr5_1  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr5_2  <= 0;
				for(i5_2=0;i5_2<16;i5_2=i5_2+1) begin
					register5_2[i5_2] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr5_2  <= zero_padd_addr;
			else if(RP_IData_vld5_2)begin
				waddr5_2 <= waddr5_2 + 1'b1;
				register5_2[waddr5_2] <= RP_IData2;
			end
			else if(lyr_end)
				waddr5_2  <= 4'b0;
		end

		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr5_3  <= 0;
				for(i5_3=0;i5_3<16;i5_3=i5_3+1) begin
					register5_3[i5_3] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr5_3  <= zero_padd_addr;
			else if(RP_IData_vld5_3)begin
				waddr5_3 <= waddr5_3 + 1'b1;
				register5_3[waddr5_3] <= RP_IData3;
			end
			else if(lyr_end)
				waddr5_3  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr5_4  <= 0;
				for(i5_4=0;i5_4<16;i5_4=i5_4+1) begin
					register5_4[i5_4] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr5_4  <= zero_padd_addr;
			else if(RP_IData_vld5_4)begin
				waddr5_4 <= waddr5_4 + 1'b1;
				register5_4[waddr5_4] <= RP_IData4;
			end
			else if(lyr_end)
				waddr5_4  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr5_5  <= 0;
				for(i5_5=0;i5_5<16;i5_5=i5_5+1) begin
					register5_5[i5_5] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr5_5  <= zero_padd_addr;
			else if(RP_IData_vld5_5)begin
				waddr5_5 <= waddr5_5 + 1'b1;
				register5_5[waddr5_5] <= RP_IData5;
			end
			else if(lyr_end)
				waddr5_5  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr5_6  <= 0;
				for(i5_6=0;i5_6<16;i5_6=i5_6+1) begin
					register5_6[i5_6] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr5_6  <= zero_padd_addr;
			else if(RP_IData_vld5_6)begin
				waddr5_6 <= waddr5_6 + 1'b1;
				register5_6[waddr5_6] <= RP_IData6;
			end
			else if(lyr_end)
				waddr5_6  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr5_7  <= 0;
				for(i5_7=0;i5_7<16;i5_7=i5_7+1) begin
					register5_7[i5_7] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr5_7  <= zero_padd_addr;
			else if(RP_IData_vld5_7)begin
				waddr5_7 <= waddr5_7 + 1'b1;
				register5_7[waddr5_7] <= RP_IData7;
			end
			else if(lyr_end)
				waddr5_7  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr5_8  <= 0;
				for(i5_8=0;i5_8<16;i5_8=i5_8+1) begin
					register5_8[i5_8] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr5_8  <= zero_padd_addr;
			else if(RP_IData_vld5_8)begin
				waddr5_8 <= waddr5_8 + 1'b1;
				register5_8[waddr5_8] <= RP_IData8;
			end
			else if(lyr_end)
				waddr5_8  <= 4'b0;
		end

//===========================================================  第六�?8通道 ============================================================//			
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr6_1  <= 0;
				for(i6_1=0;i6_1<16;i6_1=i6_1+1) begin
					register6_1[i6_1] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr6_1  <= zero_padd_addr;
			else if(RP_IData_vld6_1)begin
				waddr6_1 <= waddr6_1 + 1'b1;
				register6_1[waddr6_1] <= RP_IData1;
			end
			else if(lyr_end)
				waddr6_1  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr6_2  <= 0;
				for(i6_2=0;i6_2<16;i6_2=i6_2+1) begin
					register6_2[i6_2] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr6_2  <= zero_padd_addr;
			else if(RP_IData_vld6_2)begin
				waddr6_2 <= waddr6_2 + 1'b1;
				register6_2[waddr6_2] <= RP_IData2;
			end
			else if(lyr_end)
				waddr6_2  <= 4'b0;
		end

		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr6_3  <= 0;
				for(i6_3=0;i6_3<16;i6_3=i6_3+1) begin
					register6_3[i6_3] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr6_3  <= zero_padd_addr;
			else if(RP_IData_vld6_3)begin
				waddr6_3 <= waddr6_3 + 1'b1;
				register6_3[waddr6_3] <= RP_IData3;
			end
			else if(lyr_end)
				waddr6_3  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr6_4  <= 0;
				for(i6_4=0;i6_4<16;i6_4=i6_4+1) begin
					register6_4[i6_4] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr6_4  <= zero_padd_addr;
			else if(RP_IData_vld6_4)begin
				waddr6_4 <= waddr6_4 + 1'b1;
				register6_4[waddr6_4] <= RP_IData4;
			end
			else if(lyr_end)
				waddr6_4  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr6_5  <= 0;
				for(i6_5=0;i6_5<16;i6_5=i6_5+1) begin
					register6_5[i6_5] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr6_5  <= zero_padd_addr;
			else if(RP_IData_vld6_5)begin
				waddr6_5 <= waddr6_5 + 1'b1;
				register6_5[waddr6_5] <= RP_IData5;
			end
			else if(lyr_end)
				waddr6_5  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr6_6  <= 0;
				for(i6_6=0;i6_6<16;i6_6=i6_6+1) begin
					register6_6[i6_6] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr6_6  <= zero_padd_addr;
			else if(RP_IData_vld6_6)begin
				waddr6_6 <= waddr6_6 + 1'b1;
				register6_6[waddr6_6] <= RP_IData6;
			end
			else if(lyr_end)
				waddr6_6  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr6_7  <= 0;
				for(i6_7=0;i6_7<16;i6_7=i6_7+1) begin
					register6_7[i6_7] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr6_7  <= zero_padd_addr;
			else if(RP_IData_vld6_7)begin
				waddr6_7 <= waddr6_7 + 1'b1;
				register6_7[waddr6_7] <= RP_IData7;
			end
			else if(lyr_end)
				waddr6_7  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr6_8  <= 0;
				for(i6_8=0;i6_8<16;i6_8=i6_8+1) begin
					register6_8[i6_8] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr6_8  <= zero_padd_addr;
			else if(RP_IData_vld6_8)begin
				waddr6_8 <= waddr6_8 + 1'b1;
				register6_8[waddr6_8] <= RP_IData8;
			end
			else if(lyr_end)
				waddr6_8  <= 4'b0;
		end

//===========================================================  第七�?8通道 ============================================================//			
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr7_1  <= 0;
				for(i7_1=0;i7_1<16;i7_1=i7_1+1) begin
					register7_1[i7_1] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr7_1  <= zero_padd_addr;
			else if(RP_IData_vld7_1)begin
				waddr7_1 <= waddr7_1 + 1'b1;
				register7_1[waddr7_1] <= RP_IData1;
			end
			else if(lyr_end)
				waddr7_1  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr7_2  <= 0;
				for(i7_2=0;i7_2<16;i7_2=i7_2+1) begin
					register7_2[i7_2] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr7_2  <= zero_padd_addr;
			else if(RP_IData_vld7_2)begin
				waddr7_2 <= waddr7_2 + 1'b1;
				register7_2[waddr7_2] <= RP_IData2;
			end
			else if(lyr_end)
				waddr7_2  <= 4'b0;
		end

		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr7_3  <= 0;
				for(i7_3=0;i7_3<16;i7_3=i7_3+1) begin
					register7_3[i7_3] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr7_3  <= zero_padd_addr;
			else if(RP_IData_vld7_3)begin
				waddr7_3 <= waddr7_3 + 1'b1;
				register7_3[waddr7_3] <= RP_IData3;
			end
			else if(lyr_end)
				waddr7_3  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr7_4  <= 0;
				for(i7_4=0;i7_4<16;i7_4=i7_4+1) begin
					register7_4[i7_4] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr7_4  <= zero_padd_addr;
			else if(RP_IData_vld7_4)begin
				waddr7_4 <= waddr7_4 + 1'b1;
				register7_4[waddr7_4] <= RP_IData4;
			end
			else if(lyr_end)
				waddr7_4  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr7_5  <= 0;
				for(i7_5=0;i7_5<16;i7_5=i7_5+1) begin
					register7_5[i7_5] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr7_5  <= zero_padd_addr;
			else if(RP_IData_vld7_5)begin
				waddr7_5 <= waddr7_5 + 1'b1;
				register7_5[waddr7_5] <= RP_IData5;
			end
			else if(lyr_end)
				waddr7_5  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr7_6  <= 0;
				for(i7_6=0;i7_6<16;i7_6=i7_6+1) begin
					register7_6[i7_6] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr7_6  <= zero_padd_addr;
			else if(RP_IData_vld7_6)begin
				waddr7_6 <= waddr7_6 + 1'b1;
				register7_6[waddr7_6] <= RP_IData6;
			end
			else if(lyr_end)
				waddr7_6  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr7_7  <= 0;
				for(i7_7=0;i7_7<16;i7_7=i7_7+1) begin
					register7_7[i7_7] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr7_7  <= zero_padd_addr;
			else if(RP_IData_vld7_7)begin
				waddr7_7 <= waddr7_7 + 1'b1;
				register7_7[waddr7_7] <= RP_IData7;
			end
			else if(lyr_end)
				waddr7_7  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr7_8  <= 0;
				for(i7_8=0;i7_8<16;i7_8=i7_8+1) begin
					register7_8[i7_8] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr7_8  <= zero_padd_addr;
			else if(RP_IData_vld7_8)begin
				waddr7_8 <= waddr7_8 + 1'b1;
				register7_8[waddr7_8] <= RP_IData8;
			end
			else if(lyr_end)
				waddr7_8  <= 4'b0;
		end

//===========================================================  第八�?8通道 ============================================================//			
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr8_1  <= 0;
				for(i8_1=0;i8_1<16;i8_1=i8_1+1) begin
					register8_1[i8_1] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr8_1  <= zero_padd_addr;
			else if(RP_IData_vld8_1)begin
				waddr8_1 <= waddr8_1 + 1'b1;
				register8_1[waddr8_1] <= RP_IData1;
			end
			else if(lyr_end)
				waddr8_1  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr8_2  <= 0;
				for(i8_2=0;i8_2<16;i8_2=i8_2+1) begin
					register8_2[i8_2] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr8_2  <= zero_padd_addr;
			else if(RP_IData_vld8_2)begin
				waddr8_2 <= waddr8_2 + 1'b1;
				register8_2[waddr8_2] <= RP_IData2;
			end
			else if(lyr_end)
				waddr8_2  <= 4'b0;
		end

		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr8_3  <= 0;
				for(i8_3=0;i8_3<16;i8_3=i8_3+1) begin
					register8_3[i8_3] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr8_3  <= zero_padd_addr;
			else if(RP_IData_vld8_3)begin
				waddr8_3 <= waddr8_3 + 1'b1;
				register8_3[waddr8_3] <= RP_IData3;
			end
			else if(lyr_end)
				waddr8_3  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr8_4  <= 0;
				for(i8_4=0;i8_4<16;i8_4=i8_4+1) begin
					register8_4[i8_4] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr8_4  <= zero_padd_addr;
			else if(RP_IData_vld8_4)begin
				waddr8_4 <= waddr8_4 + 1'b1;
				register8_4[waddr8_4] <= RP_IData4;
			end
			else if(lyr_end)
				waddr8_4  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr8_5  <= 0;
				for(i8_5=0;i8_5<16;i8_5=i8_5+1) begin
					register8_5[i8_5] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr8_5  <= zero_padd_addr;
			else if(RP_IData_vld8_5)begin
				waddr8_5 <= waddr8_5 + 1'b1;
				register8_5[waddr8_5] <= RP_IData5;
			end
			else if(lyr_end)
				waddr8_5  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr8_6  <= 0;
				for(i8_6=0;i8_6<16;i8_6=i8_6+1) begin
					register8_6[i8_6] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr8_6  <= zero_padd_addr;
			else if(RP_IData_vld8_6)begin
				waddr8_6 <= waddr8_6 + 1'b1;
				register8_6[waddr8_6] <= RP_IData6;
			end
			else if(lyr_end)
				waddr8_6  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr8_7  <= 0;
				for(i8_7=0;i8_7<16;i8_7=i8_7+1) begin
					register8_7[i8_7] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr8_7  <= zero_padd_addr;
			else if(RP_IData_vld8_7)begin
				waddr8_7 <= waddr8_7 + 1'b1;
				register8_7[waddr8_7] <= RP_IData7;
			end
			else if(lyr_end)
				waddr8_7  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr8_8  <= 0;
				for(i8_8=0;i8_8<16;i8_8=i8_8+1) begin
					register8_8[i8_8] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr8_8  <= zero_padd_addr;
			else if(RP_IData_vld8_8)begin
				waddr8_8 <= waddr8_8 + 1'b1;
				register8_8[waddr8_8] <= RP_IData8;
			end
			else if(lyr_end)
				waddr8_8  <= 4'b0;
		end

//===========================================================  第九�?8通道 ============================================================//			
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr9_1  <= 0;
				for(i9_1=0;i9_1<16;i9_1=i9_1+1) begin
					register9_1[i9_1] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr9_1  <= zero_padd_addr;
			else if(RP_IData_vld9_1)begin
				waddr9_1 <= waddr9_1 + 1'b1;
				register9_1[waddr9_1] <= RP_IData1;
			end
			else if(lyr_end)
				waddr9_1  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr9_2  <= 0;
				for(i9_2=0;i9_2<16;i9_2=i9_2+1) begin
					register9_2[i9_2] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr9_2  <= zero_padd_addr;
			else if(RP_IData_vld9_2)begin
				waddr9_2 <= waddr9_2 + 1'b1;
				register9_2[waddr9_2] <= RP_IData2;
			end
			else if(lyr_end)
				waddr9_2  <= 4'b0;
		end

		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr9_3  <= 0;
				for(i9_3=0;i9_3<16;i9_3=i9_3+1) begin
					register9_3[i9_3] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr9_3  <= zero_padd_addr;
			else if(RP_IData_vld9_3)begin
				waddr9_3 <= waddr9_3 + 1'b1;
				register9_3[waddr9_3] <= RP_IData3;
			end
			else if(lyr_end)
				waddr9_3  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr9_4  <= 0;
				for(i9_4=0;i9_4<16;i9_4=i9_4+1) begin
					register9_4[i9_4] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr9_4  <= zero_padd_addr;
			else if(RP_IData_vld9_4)begin
				waddr9_4 <= waddr9_4 + 1'b1;
				register9_4[waddr9_4] <= RP_IData4;
			end
			else if(lyr_end)
				waddr9_4  <= 4'b0;
		end
		
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr9_5  <= 0;
				for(i9_5=0;i9_5<16;i9_5=i9_5+1) begin
					register9_5[i9_5] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr9_5  <= zero_padd_addr;
			else if(RP_IData_vld9_5)begin
				waddr9_5 <= waddr9_5 + 1'b1;
				register9_5[waddr9_5] <= RP_IData5;
			end
			else if(lyr_end)
				waddr9_5  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr9_6  <= 0;
				for(i9_6=0;i9_6<16;i9_6=i9_6+1) begin
					register9_6[i9_6] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr9_6  <= zero_padd_addr;
			else if(RP_IData_vld9_6)begin
				waddr9_6 <= waddr9_6 + 1'b1;
				register9_6[waddr9_6] <= RP_IData6;
			end
			else if(lyr_end)
				waddr9_6  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr9_7  <= 0;
				for(i9_7=0;i9_7<16;i9_7=i9_7+1) begin
					register9_7[i9_7] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr9_7  <= zero_padd_addr;
			else if(RP_IData_vld9_7)begin
				waddr9_7 <= waddr9_7 + 1'b1;
				register9_7[waddr9_7] <= RP_IData7;
			end
			else if(lyr_end)
				waddr9_7  <= 4'b0;
		end
		
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr9_8  <= 0;
				for(i9_8=0;i9_8<16;i9_8=i9_8+1) begin
					register9_8[i9_8] <= 8'b0000_0000;
				end
			end
			else if(zero_padd_enable)
				waddr9_8  <= zero_padd_addr;
			else if(RP_IData_vld9_8)begin
				waddr9_8 <= waddr9_8 + 1'b1;
				register9_8[waddr9_8] <= RP_IData8;
			end
			else if(lyr_end)
				waddr9_8  <= 4'b0;
		end	
//=========================================================== state output ============================================================//
		localparam [7:0] IDLE  = 8'd0; // idle state
		localparam [7:0] S1    = 8'd1; // RP_OData1
		localparam [7:0] S2    = 8'd2; // RP_OData2
		localparam [7:0] S3    = 8'd3; // RP_OData3
		localparam [7:0] S4    = 8'd4; // RP_OData4
		localparam [7:0] S5    = 8'd5; // RP_OData5
		localparam [7:0] S6    = 8'd6; // RP_OData6
		localparam [7:0] S7    = 8'd7; // RP_OData7		
		localparam [7:0] S8    = 8'd8; // RP_OData8
		
		reg		   [8:0] rp_cs;
		reg		   [8:0] rp_ns;
		
		always @(posedge clk_cal or negedge rst_cal_n) 
			if(!rst_cal_n)
				rp_cs <= 9'b1;
			else 
				rp_cs <= rp_ns;

		always @(*) begin
			rp_ns = 9'b0;
			case(1'b1)
				rp_cs[IDLE] : begin
					if(rp_flag1 || rp_flag2 || rp_flag3 || rp_flag4 || rp_flag5 || 
					   rp_flag6 || rp_flag7 || rp_flag8 || rp_flag9 ||final_ftNchange_flag)
						rp_ns[S1]   = 1'b1;
					else
						rp_ns[IDLE] = 1'b1;
				end
				rp_cs[S1]   : begin
						rp_ns[S2]   = 1'b1;
				end
				rp_cs[S2]   : begin 
						rp_ns[S3]   = 1'b1;					
				end
				rp_cs[S3]   : begin
						rp_ns[S4]   = 1'b1;
				end
				rp_cs[S4]   : begin
						rp_ns[S5]   = 1'b1;
				end
				rp_cs[S5]   : begin
						rp_ns[S6]   = 1'b1;
				end
				rp_cs[S6]   : begin
						rp_ns[S7]   = 1'b1;
				end
				rp_cs[S7]   : begin
						rp_ns[S8]   = 1'b1;
				end
				rp_cs[S8]   : begin
						rp_ns[IDLE] = 1'b1;
				end
			endcase
		end
		
		always@(*) begin
			case(N8_cnt)
				4'b0001:begin
					case(1'b1)
						rp_cs[IDLE] : begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
						rp_cs[S1]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode1 == 1'b0) begin
								RP_OData1	= register1_1[0];
								RP_OData2	= register1_1[1];
								RP_OData3	= register1_1[2];
								RP_OData4	= register1_1[3];
								RP_OData5	= register1_1[4];
								RP_OData6	= register1_1[5];
								RP_OData7	= register1_1[6];
								RP_OData8	= register1_1[7];
							end
							else begin
								RP_OData1	= register1_1[8];
								RP_OData2	= register1_1[9];
								RP_OData3	= register1_1[10];
								RP_OData4	= register1_1[11];
								RP_OData5	= register1_1[12];
								RP_OData6	= register1_1[13];
								RP_OData7	= register1_1[14];
								RP_OData8	= register1_1[15];					
							end
						end
						rp_cs[S2]   : begin                                                        
                                                        RP_OVld		= 1'b1;
							if(rp_mode1 == 1'b0) begin
								RP_OData1	= register1_2[0];
								RP_OData2	= register1_2[1];
								RP_OData3	= register1_2[2];
								RP_OData4	= register1_2[3];
								RP_OData5	= register1_2[4];
								RP_OData6	= register1_2[5];
								RP_OData7	= register1_2[6];
								RP_OData8	= register1_2[7];
							end
							else begin
								RP_OData1	= register1_2[8];
								RP_OData2	= register1_2[9];
								RP_OData3	= register1_2[10];
								RP_OData4	= register1_2[11];
								RP_OData5	= register1_2[12];
								RP_OData6	= register1_2[13];
								RP_OData7	= register1_2[14];
								RP_OData8	= register1_2[15];					
							end				
						end
						rp_cs[S3]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode1 == 1'b0) begin
								RP_OData1	= register1_3[0];
								RP_OData2	= register1_3[1];
								RP_OData3	= register1_3[2];
								RP_OData4	= register1_3[3];
								RP_OData5	= register1_3[4];
								RP_OData6	= register1_3[5];
								RP_OData7	= register1_3[6];
								RP_OData8	= register1_3[7];
							end
							else begin
								RP_OData1	= register1_3[8];
								RP_OData2	= register1_3[9];
								RP_OData3	= register1_3[10];
								RP_OData4	= register1_3[11];
								RP_OData5	= register1_3[12];
								RP_OData6	= register1_3[13];
								RP_OData7	= register1_3[14];
								RP_OData8	= register1_3[15];					
							end
						end
						rp_cs[S4]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode1 == 1'b0) begin
								RP_OData1	= register1_4[0];
								RP_OData2	= register1_4[1];
								RP_OData3	= register1_4[2];
								RP_OData4	= register1_4[3];
								RP_OData5	= register1_4[4];
								RP_OData6	= register1_4[5];
								RP_OData7	= register1_4[6];
								RP_OData8	= register1_4[7];
							end
							else begin
								RP_OData1	= register1_4[8];
								RP_OData2	= register1_4[9];
								RP_OData3	= register1_4[10];
								RP_OData4	= register1_4[11];
								RP_OData5	= register1_4[12];
								RP_OData6	= register1_4[13];
								RP_OData7	= register1_4[14];
								RP_OData8	= register1_4[15];					
							end
						end
						rp_cs[S5]   : begin
							if (w_half_end==1'b1)
                                                                RP_OVld		= 1'b0;
                                                        else
                                                                RP_OVld		= 1'b1;

							if(rp_mode1 == 1'b0) begin
								RP_OData1	= register1_5[0];
								RP_OData2	= register1_5[1];
								RP_OData3	= register1_5[2];
								RP_OData4	= register1_5[3];
								RP_OData5	= register1_5[4];
								RP_OData6	= register1_5[5];
								RP_OData7	= register1_5[6];
								RP_OData8	= register1_5[7];
							end
							else begin
								RP_OData1	= register1_5[8];
								RP_OData2	= register1_5[9];
								RP_OData3	= register1_5[10];
								RP_OData4	= register1_5[11];
								RP_OData5	= register1_5[12];
								RP_OData6	= register1_5[13];
								RP_OData7	= register1_5[14];
								RP_OData8	= register1_5[15];					
							end
						end
						rp_cs[S6]   : begin
							if (w_half_end==1'b1)
                                                                RP_OVld		= 1'b0;
                                                        else
                                                                RP_OVld		= 1'b1;

							if(rp_mode1 == 1'b0) begin
								RP_OData1	= register1_6[0];
								RP_OData2	= register1_6[1];
								RP_OData3	= register1_6[2];
								RP_OData4	= register1_6[3];
								RP_OData5	= register1_6[4];
								RP_OData6	= register1_6[5];
								RP_OData7	= register1_6[6];
								RP_OData8	= register1_6[7];
							end
							else begin
								RP_OData1	= register1_6[8];
								RP_OData2	= register1_6[9];
								RP_OData3	= register1_6[10];
								RP_OData4	= register1_6[11];
								RP_OData5	= register1_6[12];
								RP_OData6	= register1_6[13];
								RP_OData7	= register1_6[14];
								RP_OData8	= register1_6[15];					
							end
						end
						rp_cs[S7]   : begin
							if (w_half_end==1'b1)
                                                                RP_OVld		= 1'b0;
                                                        else
                                                                RP_OVld		= 1'b1;

							if(rp_mode1 == 1'b0) begin
								RP_OData1	= register1_7[0];
								RP_OData2	= register1_7[1];
								RP_OData3	= register1_7[2];
								RP_OData4	= register1_7[3];
								RP_OData5	= register1_7[4];
								RP_OData6	= register1_7[5];
								RP_OData7	= register1_7[6];
								RP_OData8	= register1_7[7];
							end
							else begin
								RP_OData1	= register1_7[8];
								RP_OData2	= register1_7[9];
								RP_OData3	= register1_7[10];
								RP_OData4	= register1_7[11];
								RP_OData5	= register1_7[12];
								RP_OData6	= register1_7[13];
								RP_OData7	= register1_7[14];
								RP_OData8	= register1_7[15];					
							end
						end
						rp_cs[S8]   : begin
							if (w_half_end==1'b1)
                                                                RP_OVld		= 1'b0;
                                                        else
                                                                RP_OVld		= 1'b1;

							if(rp_mode1 == 1'b0) begin
								RP_OData1	= register1_8[0];
								RP_OData2	= register1_8[1];
								RP_OData3	= register1_8[2];
								RP_OData4	= register1_8[3];
								RP_OData5	= register1_8[4];
								RP_OData6	= register1_8[5];
								RP_OData7	= register1_8[6];
								RP_OData8	= register1_8[7];
							end
							else begin
								RP_OData1	= register1_8[8];
								RP_OData2	= register1_8[9];
								RP_OData3	= register1_8[10];
								RP_OData4	= register1_8[11];
								RP_OData5	= register1_8[12];
								RP_OData6	= register1_8[13];
								RP_OData7	= register1_8[14];
								RP_OData8	= register1_8[15];					
							end
						end
						default		: begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
					endcase
				end
				4'b0010:begin
					case(1'b1)
						rp_cs[IDLE] : begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
						rp_cs[S1]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode2 == 1'b0) begin
								RP_OData1	= register2_1[0];
								RP_OData2	= register2_1[1];
								RP_OData3	= register2_1[2];
								RP_OData4	= register2_1[3];
								RP_OData5	= register2_1[4];
								RP_OData6	= register2_1[5];
								RP_OData7	= register2_1[6];
								RP_OData8	= register2_1[7];
							end
							else begin
								RP_OData1	= register2_1[8];
								RP_OData2	= register2_1[9];
								RP_OData3	= register2_1[10];
								RP_OData4	= register2_1[11];
								RP_OData5	= register2_1[12];
								RP_OData6	= register2_1[13];
								RP_OData7	= register2_1[14];
								RP_OData8	= register2_1[15];					
							end
						end
						rp_cs[S2]   : begin 
							RP_OVld		= 1'b1;
							if(rp_mode2 == 1'b0) begin
								RP_OData1	= register2_2[0];
								RP_OData2	= register2_2[1];
								RP_OData3	= register2_2[2];
								RP_OData4	= register2_2[3];
								RP_OData5	= register2_2[4];
								RP_OData6	= register2_2[5];
								RP_OData7	= register2_2[6];
								RP_OData8	= register2_2[7];
							end
							else begin
								RP_OData1	= register2_2[8];
								RP_OData2	= register2_2[9];
								RP_OData3	= register2_2[10];
								RP_OData4	= register2_2[11];
								RP_OData5	= register2_2[12];
								RP_OData6	= register2_2[13];
								RP_OData7	= register2_2[14];
								RP_OData8	= register2_2[15];					
							end				
						end
						rp_cs[S3]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode2 == 1'b0) begin
								RP_OData1	= register2_3[0];
								RP_OData2	= register2_3[1];
								RP_OData3	= register2_3[2];
								RP_OData4	= register2_3[3];
								RP_OData5	= register2_3[4];
								RP_OData6	= register2_3[5];
								RP_OData7	= register2_3[6];
								RP_OData8	= register2_3[7];
							end
							else begin
								RP_OData1	= register2_3[8];
								RP_OData2	= register2_3[9];
								RP_OData3	= register2_3[10];
								RP_OData4	= register2_3[11];
								RP_OData5	= register2_3[12];
								RP_OData6	= register2_3[13];
								RP_OData7	= register2_3[14];
								RP_OData8	= register2_3[15];					
							end
						end
						rp_cs[S4]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode2 == 1'b0) begin
								RP_OData1	= register2_4[0];
								RP_OData2	= register2_4[1];
								RP_OData3	= register2_4[2];
								RP_OData4	= register2_4[3];
								RP_OData5	= register2_4[4];
								RP_OData6	= register2_4[5];
								RP_OData7	= register2_4[6];
								RP_OData8	= register2_4[7];
							end
							else begin
								RP_OData1	= register2_4[8];
								RP_OData2	= register2_4[9];
								RP_OData3	= register2_4[10];
								RP_OData4	= register2_4[11];
								RP_OData5	= register2_4[12];
								RP_OData6	= register2_4[13];
								RP_OData7	= register2_4[14];
								RP_OData8	= register2_4[15];					
							end
						end
						rp_cs[S5]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode2 == 1'b0) begin
								RP_OData1	= register2_5[0];
								RP_OData2	= register2_5[1];
								RP_OData3	= register2_5[2];
								RP_OData4	= register2_5[3];
								RP_OData5	= register2_5[4];
								RP_OData6	= register2_5[5];
								RP_OData7	= register2_5[6];
								RP_OData8	= register2_5[7];
							end
							else begin
								RP_OData1	= register2_5[8];
								RP_OData2	= register2_5[9];
								RP_OData3	= register2_5[10];
								RP_OData4	= register2_5[11];
								RP_OData5	= register2_5[12];
								RP_OData6	= register2_5[13];
								RP_OData7	= register2_5[14];
								RP_OData8	= register2_5[15];					
							end
						end
						rp_cs[S6]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode2 == 1'b0) begin
								RP_OData1	= register2_6[0];
								RP_OData2	= register2_6[1];
								RP_OData3	= register2_6[2];
								RP_OData4	= register2_6[3];
								RP_OData5	= register2_6[4];
								RP_OData6	= register2_6[5];
								RP_OData7	= register2_6[6];
								RP_OData8	= register2_6[7];
							end
							else begin
								RP_OData1	= register2_6[8];
								RP_OData2	= register2_6[9];
								RP_OData3	= register2_6[10];
								RP_OData4	= register2_6[11];
								RP_OData5	= register2_6[12];
								RP_OData6	= register2_6[13];
								RP_OData7	= register2_6[14];
								RP_OData8	= register2_6[15];					
							end
						end
						rp_cs[S7]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode2 == 1'b0) begin
								RP_OData1	= register2_7[0];
								RP_OData2	= register2_7[1];
								RP_OData3	= register2_7[2];
								RP_OData4	= register2_7[3];
								RP_OData5	= register2_7[4];
								RP_OData6	= register2_7[5];
								RP_OData7	= register2_7[6];
								RP_OData8	= register2_7[7];
							end
							else begin
								RP_OData1	= register2_7[8];
								RP_OData2	= register2_7[9];
								RP_OData3	= register2_7[10];
								RP_OData4	= register2_7[11];
								RP_OData5	= register2_7[12];
								RP_OData6	= register2_7[13];
								RP_OData7	= register2_7[14];
								RP_OData8	= register2_7[15];					
							end
						end
						rp_cs[S8]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode2 == 1'b0) begin
								RP_OData1	= register2_8[0];
								RP_OData2	= register2_8[1];
								RP_OData3	= register2_8[2];
								RP_OData4	= register2_8[3];
								RP_OData5	= register2_8[4];
								RP_OData6	= register2_8[5];
								RP_OData7	= register2_8[6];
								RP_OData8	= register2_8[7];
							end
							else begin
								RP_OData1	= register2_8[8];
								RP_OData2	= register2_8[9];
								RP_OData3	= register2_8[10];
								RP_OData4	= register2_8[11];
								RP_OData5	= register2_8[12];
								RP_OData6	= register2_8[13];
								RP_OData7	= register2_8[14];
								RP_OData8	= register2_8[15];					
							end
						end
						default		: begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
					endcase
				end
				4'b0011:begin
					case(1'b1)
						rp_cs[IDLE] : begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
						rp_cs[S1]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode3 == 1'b0) begin
								RP_OData1	= register3_1[0];
								RP_OData2	= register3_1[1];
								RP_OData3	= register3_1[2];
								RP_OData4	= register3_1[3];
								RP_OData5	= register3_1[4];
								RP_OData6	= register3_1[5];
								RP_OData7	= register3_1[6];
								RP_OData8	= register3_1[7];
							end
							else begin
								RP_OData1	= register3_1[8];
								RP_OData2	= register3_1[9];
								RP_OData3	= register3_1[10];
								RP_OData4	= register3_1[11];
								RP_OData5	= register3_1[12];
								RP_OData6	= register3_1[13];
								RP_OData7	= register3_1[14];
								RP_OData8	= register3_1[15];					
							end
						end
						rp_cs[S2]   : begin 
							RP_OVld		= 1'b1;
							if(rp_mode3 == 1'b0) begin
								RP_OData1	= register3_2[0];
								RP_OData2	= register3_2[1];
								RP_OData3	= register3_2[2];
								RP_OData4	= register3_2[3];
								RP_OData5	= register3_2[4];
								RP_OData6	= register3_2[5];
								RP_OData7	= register3_2[6];
								RP_OData8	= register3_2[7];
							end
							else begin
								RP_OData1	= register3_2[8];
								RP_OData2	= register3_2[9];
								RP_OData3	= register3_2[10];
								RP_OData4	= register3_2[11];
								RP_OData5	= register3_2[12];
								RP_OData6	= register3_2[13];
								RP_OData7	= register3_2[14];
								RP_OData8	= register3_2[15];					
							end				
						end
						rp_cs[S3]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode3 == 1'b0) begin
								RP_OData1	= register3_3[0];
								RP_OData2	= register3_3[1];
								RP_OData3	= register3_3[2];
								RP_OData4	= register3_3[3];
								RP_OData5	= register3_3[4];
								RP_OData6	= register3_3[5];
								RP_OData7	= register3_3[6];
								RP_OData8	= register3_3[7];
							end
							else begin
								RP_OData1	= register3_3[8];
								RP_OData2	= register3_3[9];
								RP_OData3	= register3_3[10];
								RP_OData4	= register3_3[11];
								RP_OData5	= register3_3[12];
								RP_OData6	= register3_3[13];
								RP_OData7	= register3_3[14];
								RP_OData8	= register3_3[15];					
							end
						end
						rp_cs[S4]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode3 == 1'b0) begin
								RP_OData1	= register3_4[0];
								RP_OData2	= register3_4[1];
								RP_OData3	= register3_4[2];
								RP_OData4	= register3_4[3];
								RP_OData5	= register3_4[4];
								RP_OData6	= register3_4[5];
								RP_OData7	= register3_4[6];
								RP_OData8	= register3_4[7];
							end
							else begin
								RP_OData1	= register3_4[8];
								RP_OData2	= register3_4[9];
								RP_OData3	= register3_4[10];
								RP_OData4	= register3_4[11];
								RP_OData5	= register3_4[12];
								RP_OData6	= register3_4[13];
								RP_OData7	= register3_4[14];
								RP_OData8	= register3_4[15];					
							end
						end
						rp_cs[S5]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode3 == 1'b0) begin
								RP_OData1	= register3_5[0];
								RP_OData2	= register3_5[1];
								RP_OData3	= register3_5[2];
								RP_OData4	= register3_5[3];
								RP_OData5	= register3_5[4];
								RP_OData6	= register3_5[5];
								RP_OData7	= register3_5[6];
								RP_OData8	= register3_5[7];
							end
							else begin
								RP_OData1	= register3_5[8];
								RP_OData2	= register3_5[9];
								RP_OData3	= register3_5[10];
								RP_OData4	= register3_5[11];
								RP_OData5	= register3_5[12];
								RP_OData6	= register3_5[13];
								RP_OData7	= register3_5[14];
								RP_OData8	= register3_5[15];					
							end
						end
						rp_cs[S6]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode3 == 1'b0) begin
								RP_OData1	= register3_6[0];
								RP_OData2	= register3_6[1];
								RP_OData3	= register3_6[2];
								RP_OData4	= register3_6[3];
								RP_OData5	= register3_6[4];
								RP_OData6	= register3_6[5];
								RP_OData7	= register3_6[6];
								RP_OData8	= register3_6[7];
							end
							else begin
								RP_OData1	= register3_6[8];
								RP_OData2	= register3_6[9];
								RP_OData3	= register3_6[10];
								RP_OData4	= register3_6[11];
								RP_OData5	= register3_6[12];
								RP_OData6	= register3_6[13];
								RP_OData7	= register3_6[14];
								RP_OData8	= register3_6[15];					
							end
						end
						rp_cs[S7]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode3 == 1'b0) begin
								RP_OData1	= register3_7[0];
								RP_OData2	= register3_7[1];
								RP_OData3	= register3_7[2];
								RP_OData4	= register3_7[3];
								RP_OData5	= register3_7[4];
								RP_OData6	= register3_7[5];
								RP_OData7	= register3_7[6];
								RP_OData8	= register3_7[7];
							end
							else begin
								RP_OData1	= register3_7[8];
								RP_OData2	= register3_7[9];
								RP_OData3	= register3_7[10];
								RP_OData4	= register3_7[11];
								RP_OData5	= register3_7[12];
								RP_OData6	= register3_7[13];
								RP_OData7	= register3_7[14];
								RP_OData8	= register3_7[15];					
							end
						end
						rp_cs[S8]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode3 == 1'b0) begin
								RP_OData1	= register3_8[0];
								RP_OData2	= register3_8[1];
								RP_OData3	= register3_8[2];
								RP_OData4	= register3_8[3];
								RP_OData5	= register3_8[4];
								RP_OData6	= register3_8[5];
								RP_OData7	= register3_8[6];
								RP_OData8	= register3_8[7];
							end
							else begin
								RP_OData1	= register3_8[8];
								RP_OData2	= register3_8[9];
								RP_OData3	= register3_8[10];
								RP_OData4	= register3_8[11];
								RP_OData5	= register3_8[12];
								RP_OData6	= register3_8[13];
								RP_OData7	= register3_8[14];
								RP_OData8	= register3_8[15];					
							end
						end
						default		: begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
					endcase
				end
				4'b0100:begin
					case(1'b1)
						rp_cs[IDLE] : begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
						rp_cs[S1]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode4 == 1'b0) begin
								RP_OData1	= register4_1[0];
								RP_OData2	= register4_1[1];
								RP_OData3	= register4_1[2];
								RP_OData4	= register4_1[3];
								RP_OData5	= register4_1[4];
								RP_OData6	= register4_1[5];
								RP_OData7	= register4_1[6];
								RP_OData8	= register4_1[7];
							end
							else begin
								RP_OData1	= register4_1[8];
								RP_OData2	= register4_1[9];
								RP_OData3	= register4_1[10];
								RP_OData4	= register4_1[11];
								RP_OData5	= register4_1[12];
								RP_OData6	= register4_1[13];
								RP_OData7	= register4_1[14];
								RP_OData8	= register4_1[15];					
							end
						end
						rp_cs[S2]   : begin 
							RP_OVld		= 1'b1;
							if(rp_mode4 == 1'b0) begin
								RP_OData1	= register4_2[0];
								RP_OData2	= register4_2[1];
								RP_OData3	= register4_2[2];
								RP_OData4	= register4_2[3];
								RP_OData5	= register4_2[4];
								RP_OData6	= register4_2[5];
								RP_OData7	= register4_2[6];
								RP_OData8	= register4_2[7];
							end
							else begin
								RP_OData1	= register4_2[8];
								RP_OData2	= register4_2[9];
								RP_OData3	= register4_2[10];
								RP_OData4	= register4_2[11];
								RP_OData5	= register4_2[12];
								RP_OData6	= register4_2[13];
								RP_OData7	= register4_2[14];
								RP_OData8	= register4_2[15];					
							end				
						end
						rp_cs[S3]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode4 == 1'b0) begin
								RP_OData1	= register4_3[0];
								RP_OData2	= register4_3[1];
								RP_OData3	= register4_3[2];
								RP_OData4	= register4_3[3];
								RP_OData5	= register4_3[4];
								RP_OData6	= register4_3[5];
								RP_OData7	= register4_3[6];
								RP_OData8	= register4_3[7];
							end
							else begin
								RP_OData1	= register4_3[8];
								RP_OData2	= register4_3[9];
								RP_OData3	= register4_3[10];
								RP_OData4	= register4_3[11];
								RP_OData5	= register4_3[12];
								RP_OData6	= register4_3[13];
								RP_OData7	= register4_3[14];
								RP_OData8	= register4_3[15];					
							end
						end
						rp_cs[S4]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode4 == 1'b0) begin
								RP_OData1	= register4_4[0];
								RP_OData2	= register4_4[1];
								RP_OData3	= register4_4[2];
								RP_OData4	= register4_4[3];
								RP_OData5	= register4_4[4];
								RP_OData6	= register4_4[5];
								RP_OData7	= register4_4[6];
								RP_OData8	= register4_4[7];
							end
							else begin
								RP_OData1	= register4_4[8];
								RP_OData2	= register4_4[9];
								RP_OData3	= register4_4[10];
								RP_OData4	= register4_4[11];
								RP_OData5	= register4_4[12];
								RP_OData6	= register4_4[13];
								RP_OData7	= register4_4[14];
								RP_OData8	= register4_4[15];					
							end
						end
						rp_cs[S5]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode4 == 1'b0) begin
								RP_OData1	= register4_5[0];
								RP_OData2	= register4_5[1];
								RP_OData3	= register4_5[2];
								RP_OData4	= register4_5[3];
								RP_OData5	= register4_5[4];
								RP_OData6	= register4_5[5];
								RP_OData7	= register4_5[6];
								RP_OData8	= register4_5[7];
							end
							else begin
								RP_OData1	= register4_5[8];
								RP_OData2	= register4_5[9];
								RP_OData3	= register4_5[10];
								RP_OData4	= register4_5[11];
								RP_OData5	= register4_5[12];
								RP_OData6	= register4_5[13];
								RP_OData7	= register4_5[14];
								RP_OData8	= register4_5[15];					
							end
						end
						rp_cs[S6]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode4 == 1'b0) begin
								RP_OData1	= register4_6[0];
								RP_OData2	= register4_6[1];
								RP_OData3	= register4_6[2];
								RP_OData4	= register4_6[3];
								RP_OData5	= register4_6[4];
								RP_OData6	= register4_6[5];
								RP_OData7	= register4_6[6];
								RP_OData8	= register4_6[7];
							end
							else begin
								RP_OData1	= register4_6[8];
								RP_OData2	= register4_6[9];
								RP_OData3	= register4_6[10];
								RP_OData4	= register4_6[11];
								RP_OData5	= register4_6[12];
								RP_OData6	= register4_6[13];
								RP_OData7	= register4_6[14];
								RP_OData8	= register4_6[15];					
							end
						end
						rp_cs[S7]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode4 == 1'b0) begin
								RP_OData1	= register4_7[0];
								RP_OData2	= register4_7[1];
								RP_OData3	= register4_7[2];
								RP_OData4	= register4_7[3];
								RP_OData5	= register4_7[4];
								RP_OData6	= register4_7[5];
								RP_OData7	= register4_7[6];
								RP_OData8	= register4_7[7];
							end
							else begin
								RP_OData1	= register4_7[8];
								RP_OData2	= register4_7[9];
								RP_OData3	= register4_7[10];
								RP_OData4	= register4_7[11];
								RP_OData5	= register4_7[12];
								RP_OData6	= register4_7[13];
								RP_OData7	= register4_7[14];
								RP_OData8	= register4_7[15];					
							end
						end
						rp_cs[S8]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode4 == 1'b0) begin
								RP_OData1	= register4_8[0];
								RP_OData2	= register4_8[1];
								RP_OData3	= register4_8[2];
								RP_OData4	= register4_8[3];
								RP_OData5	= register4_8[4];
								RP_OData6	= register4_8[5];
								RP_OData7	= register4_8[6];
								RP_OData8	= register4_8[7];
							end
							else begin
								RP_OData1	= register4_8[8];
								RP_OData2	= register4_8[9];
								RP_OData3	= register4_8[10];
								RP_OData4	= register4_8[11];
								RP_OData5	= register4_8[12];
								RP_OData6	= register4_8[13];
								RP_OData7	= register4_8[14];
								RP_OData8	= register4_8[15];					
							end
						end
						default		: begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
					endcase
				end
				4'b0101:begin
					case(1'b1)
						rp_cs[IDLE] : begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
						rp_cs[S1]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode5 == 1'b0) begin
								RP_OData1	= register5_1[0];
								RP_OData2	= register5_1[1];
								RP_OData3	= register5_1[2];
								RP_OData4	= register5_1[3];
								RP_OData5	= register5_1[4];
								RP_OData6	= register5_1[5];
								RP_OData7	= register5_1[6];
								RP_OData8	= register5_1[7];
							end
							else begin
								RP_OData1	= register5_1[8];
								RP_OData2	= register5_1[9];
								RP_OData3	= register5_1[10];
								RP_OData4	= register5_1[11];
								RP_OData5	= register5_1[12];
								RP_OData6	= register5_1[13];
								RP_OData7	= register5_1[14];
								RP_OData8	= register5_1[15];					
							end
						end
						rp_cs[S2]   : begin 
							RP_OVld		= 1'b1;
							if(rp_mode5 == 1'b0) begin
								RP_OData1	= register5_2[0];
								RP_OData2	= register5_2[1];
								RP_OData3	= register5_2[2];
								RP_OData4	= register5_2[3];
								RP_OData5	= register5_2[4];
								RP_OData6	= register5_2[5];
								RP_OData7	= register5_2[6];
								RP_OData8	= register5_2[7];
							end
							else begin
								RP_OData1	= register5_2[8];
								RP_OData2	= register5_2[9];
								RP_OData3	= register5_2[10];
								RP_OData4	= register5_2[11];
								RP_OData5	= register5_2[12];
								RP_OData6	= register5_2[13];
								RP_OData7	= register5_2[14];
								RP_OData8	= register5_2[15];					
							end				
						end
						rp_cs[S3]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode5 == 1'b0) begin
								RP_OData1	= register5_3[0];
								RP_OData2	= register5_3[1];
								RP_OData3	= register5_3[2];
								RP_OData4	= register5_3[3];
								RP_OData5	= register5_3[4];
								RP_OData6	= register5_3[5];
								RP_OData7	= register5_3[6];
								RP_OData8	= register5_3[7];
							end
							else begin
								RP_OData1	= register5_3[8];
								RP_OData2	= register5_3[9];
								RP_OData3	= register5_3[10];
								RP_OData4	= register5_3[11];
								RP_OData5	= register5_3[12];
								RP_OData6	= register5_3[13];
								RP_OData7	= register5_3[14];
								RP_OData8	= register5_3[15];					
							end
						end
						rp_cs[S4]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode5 == 1'b0) begin
								RP_OData1	= register5_4[0];
								RP_OData2	= register5_4[1];
								RP_OData3	= register5_4[2];
								RP_OData4	= register5_4[3];
								RP_OData5	= register5_4[4];
								RP_OData6	= register5_4[5];
								RP_OData7	= register5_4[6];
								RP_OData8	= register5_4[7];
							end
							else begin
								RP_OData1	= register5_4[8];
								RP_OData2	= register5_4[9];
								RP_OData3	= register5_4[10];
								RP_OData4	= register5_4[11];
								RP_OData5	= register5_4[12];
								RP_OData6	= register5_4[13];
								RP_OData7	= register5_4[14];
								RP_OData8	= register5_4[15];					
							end
						end
						rp_cs[S5]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode5 == 1'b0) begin
								RP_OData1	= register5_5[0];
								RP_OData2	= register5_5[1];
								RP_OData3	= register5_5[2];
								RP_OData4	= register5_5[3];
								RP_OData5	= register5_5[4];
								RP_OData6	= register5_5[5];
								RP_OData7	= register5_5[6];
								RP_OData8	= register5_5[7];
							end
							else begin
								RP_OData1	= register5_5[8];
								RP_OData2	= register5_5[9];
								RP_OData3	= register5_5[10];
								RP_OData4	= register5_5[11];
								RP_OData5	= register5_5[12];
								RP_OData6	= register5_5[13];
								RP_OData7	= register5_5[14];
								RP_OData8	= register5_5[15];					
							end
						end
						rp_cs[S6]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode5 == 1'b0) begin
								RP_OData1	= register5_6[0];
								RP_OData2	= register5_6[1];
								RP_OData3	= register5_6[2];
								RP_OData4	= register5_6[3];
								RP_OData5	= register5_6[4];
								RP_OData6	= register5_6[5];
								RP_OData7	= register5_6[6];
								RP_OData8	= register5_6[7];
							end
							else begin
								RP_OData1	= register5_6[8];
								RP_OData2	= register5_6[9];
								RP_OData3	= register5_6[10];
								RP_OData4	= register5_6[11];
								RP_OData5	= register5_6[12];
								RP_OData6	= register5_6[13];
								RP_OData7	= register5_6[14];
								RP_OData8	= register5_6[15];					
							end
						end
						rp_cs[S7]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode5 == 1'b0) begin
								RP_OData1	= register5_7[0];
								RP_OData2	= register5_7[1];
								RP_OData3	= register5_7[2];
								RP_OData4	= register5_7[3];
								RP_OData5	= register5_7[4];
								RP_OData6	= register5_7[5];
								RP_OData7	= register5_7[6];
								RP_OData8	= register5_7[7];
							end
							else begin
								RP_OData1	= register5_7[8];
								RP_OData2	= register5_7[9];
								RP_OData3	= register5_7[10];
								RP_OData4	= register5_7[11];
								RP_OData5	= register5_7[12];
								RP_OData6	= register5_7[13];
								RP_OData7	= register5_7[14];
								RP_OData8	= register5_7[15];					
							end
						end
						rp_cs[S8]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode5 == 1'b0) begin
								RP_OData1	= register5_8[0];
								RP_OData2	= register5_8[1];
								RP_OData3	= register5_8[2];
								RP_OData4	= register5_8[3];
								RP_OData5	= register5_8[4];
								RP_OData6	= register5_8[5];
								RP_OData7	= register5_8[6];
								RP_OData8	= register5_8[7];
							end
							else begin
								RP_OData1	= register5_8[8];
								RP_OData2	= register5_8[9];
								RP_OData3	= register5_8[10];
								RP_OData4	= register5_8[11];
								RP_OData5	= register5_8[12];
								RP_OData6	= register5_8[13];
								RP_OData7	= register5_8[14];
								RP_OData8	= register5_8[15];					
							end
						end
						default		: begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
					endcase
				end
				4'b0110:begin
					case(1'b1)
						rp_cs[IDLE] : begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
						rp_cs[S1]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode6 == 1'b0) begin
								RP_OData1	= register6_1[0];
								RP_OData2	= register6_1[1];
								RP_OData3	= register6_1[2];
								RP_OData4	= register6_1[3];
								RP_OData5	= register6_1[4];
								RP_OData6	= register6_1[5];
								RP_OData7	= register6_1[6];
								RP_OData8	= register6_1[7];
							end
							else begin
								RP_OData1	= register6_1[8];
								RP_OData2	= register6_1[9];
								RP_OData3	= register6_1[10];
								RP_OData4	= register6_1[11];
								RP_OData5	= register6_1[12];
								RP_OData6	= register6_1[13];
								RP_OData7	= register6_1[14];
								RP_OData8	= register6_1[15];					
							end
						end
						rp_cs[S2]   : begin 
							RP_OVld		= 1'b1;
							if(rp_mode6 == 1'b0) begin
								RP_OData1	= register6_2[0];
								RP_OData2	= register6_2[1];
								RP_OData3	= register6_2[2];
								RP_OData4	= register6_2[3];
								RP_OData5	= register6_2[4];
								RP_OData6	= register6_2[5];
								RP_OData7	= register6_2[6];
								RP_OData8	= register6_2[7];
							end
							else begin
								RP_OData1	= register6_2[8];
								RP_OData2	= register6_2[9];
								RP_OData3	= register6_2[10];
								RP_OData4	= register6_2[11];
								RP_OData5	= register6_2[12];
								RP_OData6	= register6_2[13];
								RP_OData7	= register6_2[14];
								RP_OData8	= register6_2[15];					
							end				
						end
						rp_cs[S3]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode6 == 1'b0) begin
								RP_OData1	= register6_3[0];
								RP_OData2	= register6_3[1];
								RP_OData3	= register6_3[2];
								RP_OData4	= register6_3[3];
								RP_OData5	= register6_3[4];
								RP_OData6	= register6_3[5];
								RP_OData7	= register6_3[6];
								RP_OData8	= register6_3[7];
							end
							else begin
								RP_OData1	= register6_3[8];
								RP_OData2	= register6_3[9];
								RP_OData3	= register6_3[10];
								RP_OData4	= register6_3[11];
								RP_OData5	= register6_3[12];
								RP_OData6	= register6_3[13];
								RP_OData7	= register6_3[14];
								RP_OData8	= register6_3[15];					
							end
						end
						rp_cs[S4]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode6 == 1'b0) begin
								RP_OData1	= register6_4[0];
								RP_OData2	= register6_4[1];
								RP_OData3	= register6_4[2];
								RP_OData4	= register6_4[3];
								RP_OData5	= register6_4[4];
								RP_OData6	= register6_4[5];
								RP_OData7	= register6_4[6];
								RP_OData8	= register6_4[7];
							end
							else begin
								RP_OData1	= register6_4[8];
								RP_OData2	= register6_4[9];
								RP_OData3	= register6_4[10];
								RP_OData4	= register6_4[11];
								RP_OData5	= register6_4[12];
								RP_OData6	= register6_4[13];
								RP_OData7	= register6_4[14];
								RP_OData8	= register6_4[15];					
							end
						end
						rp_cs[S5]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode6 == 1'b0) begin
								RP_OData1	= register6_5[0];
								RP_OData2	= register6_5[1];
								RP_OData3	= register6_5[2];
								RP_OData4	= register6_5[3];
								RP_OData5	= register6_5[4];
								RP_OData6	= register6_5[5];
								RP_OData7	= register6_5[6];
								RP_OData8	= register6_5[7];
							end
							else begin
								RP_OData1	= register6_5[8];
								RP_OData2	= register6_5[9];
								RP_OData3	= register6_5[10];
								RP_OData4	= register6_5[11];
								RP_OData5	= register6_5[12];
								RP_OData6	= register6_5[13];
								RP_OData7	= register6_5[14];
								RP_OData8	= register6_5[15];					
							end
						end
						rp_cs[S6]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode6 == 1'b0) begin
								RP_OData1	= register6_6[0];
								RP_OData2	= register6_6[1];
								RP_OData3	= register6_6[2];
								RP_OData4	= register6_6[3];
								RP_OData5	= register6_6[4];
								RP_OData6	= register6_6[5];
								RP_OData7	= register6_6[6];
								RP_OData8	= register6_6[7];
							end
							else begin
								RP_OData1	= register6_6[8];
								RP_OData2	= register6_6[9];
								RP_OData3	= register6_6[10];
								RP_OData4	= register6_6[11];
								RP_OData5	= register6_6[12];
								RP_OData6	= register6_6[13];
								RP_OData7	= register6_6[14];
								RP_OData8	= register6_6[15];					
							end
						end
						rp_cs[S7]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode6 == 1'b0) begin
								RP_OData1	= register6_7[0];
								RP_OData2	= register6_7[1];
								RP_OData3	= register6_7[2];
								RP_OData4	= register6_7[3];
								RP_OData5	= register6_7[4];
								RP_OData6	= register6_7[5];
								RP_OData7	= register6_7[6];
								RP_OData8	= register6_7[7];
							end
							else begin
								RP_OData1	= register6_7[8];
								RP_OData2	= register6_7[9];
								RP_OData3	= register6_7[10];
								RP_OData4	= register6_7[11];
								RP_OData5	= register6_7[12];
								RP_OData6	= register6_7[13];
								RP_OData7	= register6_7[14];
								RP_OData8	= register6_7[15];					
							end
						end
						rp_cs[S8]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode6 == 1'b0) begin
								RP_OData1	= register6_8[0];
								RP_OData2	= register6_8[1];
								RP_OData3	= register6_8[2];
								RP_OData4	= register6_8[3];
								RP_OData5	= register6_8[4];
								RP_OData6	= register6_8[5];
								RP_OData7	= register6_8[6];
								RP_OData8	= register6_8[7];
							end
							else begin
								RP_OData1	= register6_8[8];
								RP_OData2	= register6_8[9];
								RP_OData3	= register6_8[10];
								RP_OData4	= register6_8[11];
								RP_OData5	= register6_8[12];
								RP_OData6	= register6_8[13];
								RP_OData7	= register6_8[14];
								RP_OData8	= register6_8[15];					
							end
						end
						default		: begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
					endcase
				end
				4'b0111:begin
					case(1'b1)
						rp_cs[IDLE] : begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
						rp_cs[S1]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode7 == 1'b0) begin
								RP_OData1	= register7_1[0];
								RP_OData2	= register7_1[1];
								RP_OData3	= register7_1[2];
								RP_OData4	= register7_1[3];
								RP_OData5	= register7_1[4];
								RP_OData6	= register7_1[5];
								RP_OData7	= register7_1[6];
								RP_OData8	= register7_1[7];
							end
							else begin
								RP_OData1	= register7_1[8];
								RP_OData2	= register7_1[9];
								RP_OData3	= register7_1[10];
								RP_OData4	= register7_1[11];
								RP_OData5	= register7_1[12];
								RP_OData6	= register7_1[13];
								RP_OData7	= register7_1[14];
								RP_OData8	= register7_1[15];					
							end
						end
						rp_cs[S2]   : begin 
							RP_OVld		= 1'b1;
							if(rp_mode7 == 1'b0) begin
								RP_OData1	= register7_2[0];
								RP_OData2	= register7_2[1];
								RP_OData3	= register7_2[2];
								RP_OData4	= register7_2[3];
								RP_OData5	= register7_2[4];
								RP_OData6	= register7_2[5];
								RP_OData7	= register7_2[6];
								RP_OData8	= register7_2[7];
							end
							else begin
								RP_OData1	= register7_2[8];
								RP_OData2	= register7_2[9];
								RP_OData3	= register7_2[10];
								RP_OData4	= register7_2[11];
								RP_OData5	= register7_2[12];
								RP_OData6	= register7_2[13];
								RP_OData7	= register7_2[14];
								RP_OData8	= register7_2[15];					
							end				
						end
						rp_cs[S3]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode7 == 1'b0) begin
								RP_OData1	= register7_3[0];
								RP_OData2	= register7_3[1];
								RP_OData3	= register7_3[2];
								RP_OData4	= register7_3[3];
								RP_OData5	= register7_3[4];
								RP_OData6	= register7_3[5];
								RP_OData7	= register7_3[6];
								RP_OData8	= register7_3[7];
							end
							else begin
								RP_OData1	= register7_3[8];
								RP_OData2	= register7_3[9];
								RP_OData3	= register7_3[10];
								RP_OData4	= register7_3[11];
								RP_OData5	= register7_3[12];
								RP_OData6	= register7_3[13];
								RP_OData7	= register7_3[14];
								RP_OData8	= register7_3[15];					
							end
						end
						rp_cs[S4]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode7 == 1'b0) begin
								RP_OData1	= register7_4[0];
								RP_OData2	= register7_4[1];
								RP_OData3	= register7_4[2];
								RP_OData4	= register7_4[3];
								RP_OData5	= register7_4[4];
								RP_OData6	= register7_4[5];
								RP_OData7	= register7_4[6];
								RP_OData8	= register7_4[7];
							end
							else begin
								RP_OData1	= register7_4[8];
								RP_OData2	= register7_4[9];
								RP_OData3	= register7_4[10];
								RP_OData4	= register7_4[11];
								RP_OData5	= register7_4[12];
								RP_OData6	= register7_4[13];
								RP_OData7	= register7_4[14];
								RP_OData8	= register7_4[15];					
							end
						end
						rp_cs[S5]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode7 == 1'b0) begin
								RP_OData1	= register7_5[0];
								RP_OData2	= register7_5[1];
								RP_OData3	= register7_5[2];
								RP_OData4	= register7_5[3];
								RP_OData5	= register7_5[4];
								RP_OData6	= register7_5[5];
								RP_OData7	= register7_5[6];
								RP_OData8	= register7_5[7];
							end
							else begin
								RP_OData1	= register7_5[8];
								RP_OData2	= register7_5[9];
								RP_OData3	= register7_5[10];
								RP_OData4	= register7_5[11];
								RP_OData5	= register7_5[12];
								RP_OData6	= register7_5[13];
								RP_OData7	= register7_5[14];
								RP_OData8	= register7_5[15];					
							end
						end
						rp_cs[S6]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode7 == 1'b0) begin
								RP_OData1	= register7_6[0];
								RP_OData2	= register7_6[1];
								RP_OData3	= register7_6[2];
								RP_OData4	= register7_6[3];
								RP_OData5	= register7_6[4];
								RP_OData6	= register7_6[5];
								RP_OData7	= register7_6[6];
								RP_OData8	= register7_6[7];
							end
							else begin
								RP_OData1	= register7_6[8];
								RP_OData2	= register7_6[9];
								RP_OData3	= register7_6[10];
								RP_OData4	= register7_6[11];
								RP_OData5	= register7_6[12];
								RP_OData6	= register7_6[13];
								RP_OData7	= register7_6[14];
								RP_OData8	= register7_6[15];					
							end
						end
						rp_cs[S7]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode7 == 1'b0) begin
								RP_OData1	= register7_7[0];
								RP_OData2	= register7_7[1];
								RP_OData3	= register7_7[2];
								RP_OData4	= register7_7[3];
								RP_OData5	= register7_7[4];
								RP_OData6	= register7_7[5];
								RP_OData7	= register7_7[6];
								RP_OData8	= register7_7[7];
							end
							else begin
								RP_OData1	= register7_7[8];
								RP_OData2	= register7_7[9];
								RP_OData3	= register7_7[10];
								RP_OData4	= register7_7[11];
								RP_OData5	= register7_7[12];
								RP_OData6	= register7_7[13];
								RP_OData7	= register7_7[14];
								RP_OData8	= register7_7[15];					
							end
						end
						rp_cs[S8]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode7 == 1'b0) begin
								RP_OData1	= register7_8[0];
								RP_OData2	= register7_8[1];
								RP_OData3	= register7_8[2];
								RP_OData4	= register7_8[3];
								RP_OData5	= register7_8[4];
								RP_OData6	= register7_8[5];
								RP_OData7	= register7_8[6];
								RP_OData8	= register7_8[7];
							end
							else begin
								RP_OData1	= register7_8[8];
								RP_OData2	= register7_8[9];
								RP_OData3	= register7_8[10];
								RP_OData4	= register7_8[11];
								RP_OData5	= register7_8[12];
								RP_OData6	= register7_8[13];
								RP_OData7	= register7_8[14];
								RP_OData8	= register7_8[15];					
							end
						end
						default		: begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
					endcase
				end				
				4'b1000:begin
					case(1'b1)
						rp_cs[IDLE] : begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
						rp_cs[S1]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode8 == 1'b0) begin
								RP_OData1	= register8_1[0];
								RP_OData2	= register8_1[1];
								RP_OData3	= register8_1[2];
								RP_OData4	= register8_1[3];
								RP_OData5	= register8_1[4];
								RP_OData6	= register8_1[5];
								RP_OData7	= register8_1[6];
								RP_OData8	= register8_1[7];
							end
							else begin
								RP_OData1	= register8_1[8];
								RP_OData2	= register8_1[9];
								RP_OData3	= register8_1[10];
								RP_OData4	= register8_1[11];
								RP_OData5	= register8_1[12];
								RP_OData6	= register8_1[13];
								RP_OData7	= register8_1[14];
								RP_OData8	= register8_1[15];					
							end
						end
						rp_cs[S2]   : begin 
							RP_OVld		= 1'b1;
							if(rp_mode8 == 1'b0) begin
								RP_OData1	= register8_2[0];
								RP_OData2	= register8_2[1];
								RP_OData3	= register8_2[2];
								RP_OData4	= register8_2[3];
								RP_OData5	= register8_2[4];
								RP_OData6	= register8_2[5];
								RP_OData7	= register8_2[6];
								RP_OData8	= register8_2[7];
							end
							else begin
								RP_OData1	= register8_2[8];
								RP_OData2	= register8_2[9];
								RP_OData3	= register8_2[10];
								RP_OData4	= register8_2[11];
								RP_OData5	= register8_2[12];
								RP_OData6	= register8_2[13];
								RP_OData7	= register8_2[14];
								RP_OData8	= register8_2[15];					
							end				
						end
						rp_cs[S3]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode8 == 1'b0) begin
								RP_OData1	= register8_3[0];
								RP_OData2	= register8_3[1];
								RP_OData3	= register8_3[2];
								RP_OData4	= register8_3[3];
								RP_OData5	= register8_3[4];
								RP_OData6	= register8_3[5];
								RP_OData7	= register8_3[6];
								RP_OData8	= register8_3[7];
							end
							else begin
								RP_OData1	= register8_3[8];
								RP_OData2	= register8_3[9];
								RP_OData3	= register8_3[10];
								RP_OData4	= register8_3[11];
								RP_OData5	= register8_3[12];
								RP_OData6	= register8_3[13];
								RP_OData7	= register8_3[14];
								RP_OData8	= register8_3[15];					
							end
						end
						rp_cs[S4]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode8 == 1'b0) begin
								RP_OData1	= register8_4[0];
								RP_OData2	= register8_4[1];
								RP_OData3	= register8_4[2];
								RP_OData4	= register8_4[3];
								RP_OData5	= register8_4[4];
								RP_OData6	= register8_4[5];
								RP_OData7	= register8_4[6];
								RP_OData8	= register8_4[7];
							end
							else begin
								RP_OData1	= register8_4[8];
								RP_OData2	= register8_4[9];
								RP_OData3	= register8_4[10];
								RP_OData4	= register8_4[11];
								RP_OData5	= register8_4[12];
								RP_OData6	= register8_4[13];
								RP_OData7	= register8_4[14];
								RP_OData8	= register8_4[15];					
							end
						end
						rp_cs[S5]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode8 == 1'b0) begin
								RP_OData1	= register8_5[0];
								RP_OData2	= register8_5[1];
								RP_OData3	= register8_5[2];
								RP_OData4	= register8_5[3];
								RP_OData5	= register8_5[4];
								RP_OData6	= register8_5[5];
								RP_OData7	= register8_5[6];
								RP_OData8	= register8_5[7];
							end
							else begin
								RP_OData1	= register8_5[8];
								RP_OData2	= register8_5[9];
								RP_OData3	= register8_5[10];
								RP_OData4	= register8_5[11];
								RP_OData5	= register8_5[12];
								RP_OData6	= register8_5[13];
								RP_OData7	= register8_5[14];
								RP_OData8	= register8_5[15];					
							end
						end
						rp_cs[S6]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode8 == 1'b0) begin
								RP_OData1	= register8_6[0];
								RP_OData2	= register8_6[1];
								RP_OData3	= register8_6[2];
								RP_OData4	= register8_6[3];
								RP_OData5	= register8_6[4];
								RP_OData6	= register8_6[5];
								RP_OData7	= register8_6[6];
								RP_OData8	= register8_6[7];
							end
							else begin
								RP_OData1	= register8_6[8];
								RP_OData2	= register8_6[9];
								RP_OData3	= register8_6[10];
								RP_OData4	= register8_6[11];
								RP_OData5	= register8_6[12];
								RP_OData6	= register8_6[13];
								RP_OData7	= register8_6[14];
								RP_OData8	= register8_6[15];					
							end
						end
						rp_cs[S7]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode8 == 1'b0) begin
								RP_OData1	= register8_7[0];
								RP_OData2	= register8_7[1];
								RP_OData3	= register8_7[2];
								RP_OData4	= register8_7[3];
								RP_OData5	= register8_7[4];
								RP_OData6	= register8_7[5];
								RP_OData7	= register8_7[6];
								RP_OData8	= register8_7[7];
							end
							else begin
								RP_OData1	= register8_7[8];
								RP_OData2	= register8_7[9];
								RP_OData3	= register8_7[10];
								RP_OData4	= register8_7[11];
								RP_OData5	= register8_7[12];
								RP_OData6	= register8_7[13];
								RP_OData7	= register8_7[14];
								RP_OData8	= register8_7[15];					
							end
						end
						rp_cs[S8]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode8 == 1'b0) begin
								RP_OData1	= register8_8[0];
								RP_OData2	= register8_8[1];
								RP_OData3	= register8_8[2];
								RP_OData4	= register8_8[3];
								RP_OData5	= register8_8[4];
								RP_OData6	= register8_8[5];
								RP_OData7	= register8_8[6];
								RP_OData8	= register8_8[7];
							end
							else begin
								RP_OData1	= register8_8[8];
								RP_OData2	= register8_8[9];
								RP_OData3	= register8_8[10];
								RP_OData4	= register8_8[11];
								RP_OData5	= register8_8[12];
								RP_OData6	= register8_8[13];
								RP_OData7	= register8_8[14];
								RP_OData8	= register8_8[15];					
							end
						end
						default		: begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
					endcase
				end
				4'b1001:begin
					case(1'b1)
						rp_cs[IDLE] : begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
						rp_cs[S1]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode9 == 1'b0) begin
								RP_OData1	= register9_1[0];
								RP_OData2	= register9_1[1];
								RP_OData3	= register9_1[2];
								RP_OData4	= register9_1[3];
								RP_OData5	= register9_1[4];
								RP_OData6	= register9_1[5];
								RP_OData7	= register9_1[6];
								RP_OData8	= register9_1[7];
							end
							else begin
								RP_OData1	= register9_1[8];
								RP_OData2	= register9_1[9];
								RP_OData3	= register9_1[10];
								RP_OData4	= register9_1[11];
								RP_OData5	= register9_1[12];
								RP_OData6	= register9_1[13];
								RP_OData7	= register9_1[14];
								RP_OData8	= register9_1[15];					
							end
						end
						rp_cs[S2]   : begin 
							RP_OVld		= 1'b1;
							if(rp_mode9 == 1'b0) begin
								RP_OData1	= register9_2[0];
								RP_OData2	= register9_2[1];
								RP_OData3	= register9_2[2];
								RP_OData4	= register9_2[3];
								RP_OData5	= register9_2[4];
								RP_OData6	= register9_2[5];
								RP_OData7	= register9_2[6];
								RP_OData8	= register9_2[7];
							end
							else begin
								RP_OData1	= register9_2[8];
								RP_OData2	= register9_2[9];
								RP_OData3	= register9_2[10];
								RP_OData4	= register9_2[11];
								RP_OData5	= register9_2[12];
								RP_OData6	= register9_2[13];
								RP_OData7	= register9_2[14];
								RP_OData8	= register9_2[15];					
							end				
						end
						rp_cs[S3]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode9 == 1'b0) begin
								RP_OData1	= register9_3[0];
								RP_OData2	= register9_3[1];
								RP_OData3	= register9_3[2];
								RP_OData4	= register9_3[3];
								RP_OData5	= register9_3[4];
								RP_OData6	= register9_3[5];
								RP_OData7	= register9_3[6];
								RP_OData8	= register9_3[7];
							end
							else begin
								RP_OData1	= register9_3[8];
								RP_OData2	= register9_3[9];
								RP_OData3	= register9_3[10];
								RP_OData4	= register9_3[11];
								RP_OData5	= register9_3[12];
								RP_OData6	= register9_3[13];
								RP_OData7	= register9_3[14];
								RP_OData8	= register9_3[15];					
							end
						end
						rp_cs[S4]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode9 == 1'b0) begin
								RP_OData1	= register9_4[0];
								RP_OData2	= register9_4[1];
								RP_OData3	= register9_4[2];
								RP_OData4	= register9_4[3];
								RP_OData5	= register9_4[4];
								RP_OData6	= register9_4[5];
								RP_OData7	= register9_4[6];
								RP_OData8	= register9_4[7];
							end
							else begin
								RP_OData1	= register9_4[8];
								RP_OData2	= register9_4[9];
								RP_OData3	= register9_4[10];
								RP_OData4	= register9_4[11];
								RP_OData5	= register9_4[12];
								RP_OData6	= register9_4[13];
								RP_OData7	= register9_4[14];
								RP_OData8	= register9_4[15];					
							end
						end
						rp_cs[S5]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode9 == 1'b0) begin
								RP_OData1	= register9_5[0];
								RP_OData2	= register9_5[1];
								RP_OData3	= register9_5[2];
								RP_OData4	= register9_5[3];
								RP_OData5	= register9_5[4];
								RP_OData6	= register9_5[5];
								RP_OData7	= register9_5[6];
								RP_OData8	= register9_5[7];
							end
							else begin
								RP_OData1	= register9_5[8];
								RP_OData2	= register9_5[9];
								RP_OData3	= register9_5[10];
								RP_OData4	= register9_5[11];
								RP_OData5	= register9_5[12];
								RP_OData6	= register9_5[13];
								RP_OData7	= register9_5[14];
								RP_OData8	= register9_5[15];					
							end
						end
						rp_cs[S6]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode9 == 1'b0) begin
								RP_OData1	= register9_6[0];
								RP_OData2	= register9_6[1];
								RP_OData3	= register9_6[2];
								RP_OData4	= register9_6[3];
								RP_OData5	= register9_6[4];
								RP_OData6	= register9_6[5];
								RP_OData7	= register9_6[6];
								RP_OData8	= register9_6[7];
							end
							else begin
								RP_OData1	= register9_6[8];
								RP_OData2	= register9_6[9];
								RP_OData3	= register9_6[10];
								RP_OData4	= register9_6[11];
								RP_OData5	= register9_6[12];
								RP_OData6	= register9_6[13];
								RP_OData7	= register9_6[14];
								RP_OData8	= register9_6[15];					
							end
						end
						rp_cs[S7]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode9 == 1'b0) begin
								RP_OData1	= register9_7[0];
								RP_OData2	= register9_7[1];
								RP_OData3	= register9_7[2];
								RP_OData4	= register9_7[3];
								RP_OData5	= register9_7[4];
								RP_OData6	= register9_7[5];
								RP_OData7	= register9_7[6];
								RP_OData8	= register9_7[7];
							end
							else begin
								RP_OData1	= register9_7[8];
								RP_OData2	= register9_7[9];
								RP_OData3	= register9_7[10];
								RP_OData4	= register9_7[11];
								RP_OData5	= register9_7[12];
								RP_OData6	= register9_7[13];
								RP_OData7	= register9_7[14];
								RP_OData8	= register9_7[15];					
							end
						end
						rp_cs[S8]   : begin
							RP_OVld		= 1'b1;
							if(rp_mode9 == 1'b0) begin
								RP_OData1	= register9_8[0];
								RP_OData2	= register9_8[1];
								RP_OData3	= register9_8[2];
								RP_OData4	= register9_8[3];
								RP_OData5	= register9_8[4];
								RP_OData6	= register9_8[5];
								RP_OData7	= register9_8[6];
								RP_OData8	= register9_8[7];
							end
							else begin
								RP_OData1	= register9_8[8];
								RP_OData2	= register9_8[9];
								RP_OData3	= register9_8[10];
								RP_OData4	= register9_8[11];
								RP_OData5	= register9_8[12];
								RP_OData6	= register9_8[13];
								RP_OData7	= register9_8[14];
								RP_OData8	= register9_8[15];					
							end
						end
						default		: begin
							RP_OVld		= 1'b0;
							RP_OData1	= 8'b0;
							RP_OData2	= 8'b0;
							RP_OData3	= 8'b0;
							RP_OData4	= 8'b0;
							RP_OData5	= 8'b0;
							RP_OData6	= 8'b0;
							RP_OData7	= 8'b0;
							RP_OData8	= 8'b0;
						end
					endcase
				end				
				default:begin
					RP_OVld		= 1'b0;
					if(rp_mode1 == 1'b0) begin
						RP_OData1	= 0;
						RP_OData2	= 0;
						RP_OData3	= 0;
						RP_OData4	= 0;
						RP_OData5	= 0;
						RP_OData6	= 0;
						RP_OData7	= 0;
						RP_OData8	= 0;
					end
					else begin
						RP_OData1	= 0;
						RP_OData2	= 0;
						RP_OData3	= 0;
						RP_OData4	= 0;
						RP_OData5	= 0;
						RP_OData6	= 0;
						RP_OData7	= 0;
						RP_OData8	= 0;					
					end				
				end
			endcase
		end
		
endmodule

