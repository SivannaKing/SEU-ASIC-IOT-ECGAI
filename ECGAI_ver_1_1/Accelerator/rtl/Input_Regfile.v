// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Lizhiqing
// @Email        : lizhiqing@seu.edu.cn
// @File Name    : Input_Regfile.v
// @Module Name  : Input_Regfile_Buffer
// @Created Time : 2020-04-17 09:54
//
// @Abstract     : This module is master contrl unit of ECG ,achieving various 
//               ways of data reuse by controlling data transmission and computing.
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// ------------------------------------------------------------------------------
// 2020-04-17  	Lizhiqing         v1.0a           initial version 
// 2020-05-20	Lizhiqing		  v2.0b			  change Data_O_vld
// 2020-06-03	Huangjunguang     v2.0		delay between vld and data
// 2020-06-19	Lizhiqing		  v2.0f		change size of regfile and adder gap wr_addr
// ******************************************************************************
`timescale	1ns/1ns
`define R			16
`define C			8
`define Bm			8

module Input_Regfile(
	//Global signals
	input					clk_cal,
	input					rst_cal_n,
	
	// Signals from SPU
	input			[3:0]	nn_layer_cnt,	// newly add
	
	// Signals with In_Out_buffer
	input			[7:0]	IR_Data_I0, IR_Data_I1, IR_Data_I2, IR_Data_I3, IR_Data_I4, IR_Data_I5, IR_Data_I6, IR_Data_I7,
	input					IR_Data_I_vld,
	input			[5:0]	Bm_cnt_in,
	
	// Signals with Mem_Ctrl
	input			[7:0]	K,
	input			[7:0]	S,
	input					Weight_Data_Ovld,	//wt_C0_O_vld, v2.0b
	
	// Signals with PE_Array
	input					pe_end,
	output	reg		[7:0]	IR_Data_O0, IR_Data_O1, IR_Data_O2, IR_Data_O3, IR_Data_O4, IR_Data_O5, IR_Data_O6, IR_Data_O7, 
							IR_Data_O8, IR_Data_O9, IR_Data_Oa, IR_Data_Ob, IR_Data_Oc, IR_Data_Od, IR_Data_Oe, IR_Data_Of,
	output	reg				IR_Data_O_vld			

);
			reg		[7:0]	Regfile	[255:0];		// 160 8-bit register files
			// Signals of write
			reg		[7:0]	wr_addr;				// Write address of Input Regfile
			// Signals of read
			reg		[7:0]	rd_addr;
			reg  	[5:0]	Bm_cnt;
//----------------------------------------------------------------------------------
//WRITE TO INPUT REGFILE
//----------------------------------------------------------------------------------
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			Bm_cnt <= 6'b0;
		else
			Bm_cnt <= Bm_cnt_in;
	
	always @(posedge clk_cal or negedge rst_cal_n)
	
		if(!rst_cal_n)
			wr_addr <= 8'b0;
		// else if(nn_layer_cnt==4'd7 && IR_Data_I_vld && Bm_cnt[0]==0)	// wr_addr of GAP
			// wr_addr <= K*Bm_cnt;
		else if(IR_Data_I_vld)
			wr_addr <= Bm_cnt*`Bm;
		else
			wr_addr <= 8'b0;

		integer		i;
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			begin
				for(i=0;i<256;i=i+1)
					Regfile[i] <= 0;
			end
		else if(IR_Data_I_vld) // && (Bm_cnt!=`Bm))
				begin
					Regfile[wr_addr+0] <= IR_Data_I0;
					Regfile[wr_addr+1] <= IR_Data_I1;
					Regfile[wr_addr+2] <= IR_Data_I2;
					Regfile[wr_addr+3] <= IR_Data_I3;
					Regfile[wr_addr+4] <= IR_Data_I4;
					Regfile[wr_addr+5] <= IR_Data_I5;
					Regfile[wr_addr+6] <= IR_Data_I6;
					Regfile[wr_addr+7] <= IR_Data_I7;
				end
//----------------------------------------------------------------------------------
//Read From Input Regfile
//----------------------------------------------------------------------------------
	// Output data to PE Array
	always @(posedge clk_cal or negedge rst_cal_n)			// should be synchronic with weight_data_Ovld
		if(!rst_cal_n)
			IR_Data_O_vld <= 1'b0;
		else
			IR_Data_O_vld <= Weight_Data_Ovld;
	
	always @(posedge clk_cal or negedge rst_cal_n)
		begin
			if(!rst_cal_n)
				rd_addr <= 8'b0;
			else if(pe_end)
				rd_addr <= 8'b0;
			else if(Weight_Data_Ovld && (rd_addr != K-1'b1))
				rd_addr <= rd_addr + 8'b1;
			else
				rd_addr <= 8'b0;
		end
		
	always @(posedge clk_cal or negedge rst_cal_n) begin
		if(!rst_cal_n)			// added reset after v2.0b
			begin
				IR_Data_O0 <= 0;
				IR_Data_O1 <= 0;
				IR_Data_O2 <= 0;
				IR_Data_O3 <= 0;
				IR_Data_O4 <= 0;
				IR_Data_O5 <= 0;
				IR_Data_O6 <= 0;
				IR_Data_O7 <= 0;
				IR_Data_O8 <= 0;
				IR_Data_O9 <= 0;
				IR_Data_Oa <= 0;
				IR_Data_Ob <= 0;
				IR_Data_Oc <= 0;
				IR_Data_Od <= 0;
				IR_Data_Oe <= 0;
				IR_Data_Of <= 0;
			end
		else begin
			if( (Weight_Data_Ovld && (rd_addr!=K-1)) || IR_Data_O_vld)
				begin
					IR_Data_O0 <= Regfile[rd_addr+0*S];
					IR_Data_O1 <= Regfile[rd_addr+1*S];
					IR_Data_O2 <= Regfile[rd_addr+2*S];
					IR_Data_O3 <= Regfile[rd_addr+3*S];
					IR_Data_O4 <= Regfile[rd_addr+4*S];
					IR_Data_O5 <= Regfile[rd_addr+5*S];
					IR_Data_O6 <= Regfile[rd_addr+6*S];
					IR_Data_O7 <= Regfile[rd_addr+7*S];
					IR_Data_O8 <= Regfile[rd_addr+8*S];
					IR_Data_O9 <= Regfile[rd_addr+9*S];
					IR_Data_Oa <= Regfile[rd_addr+10*S];
					IR_Data_Ob <= Regfile[rd_addr+11*S];
					IR_Data_Oc <= Regfile[rd_addr+12*S];
					IR_Data_Od <= Regfile[rd_addr+13*S];
					IR_Data_Oe <= Regfile[rd_addr+14*S];
					IR_Data_Of <= Regfile[rd_addr+15*S];
				end
			else 
				begin
					IR_Data_O0 <= 0;
					IR_Data_O1 <= 0;
					IR_Data_O2 <= 0;
					IR_Data_O3 <= 0;
					IR_Data_O4 <= 0;
					IR_Data_O5 <= 0;
					IR_Data_O6 <= 0;
					IR_Data_O7 <= 0;
					IR_Data_O8 <= 0;
					IR_Data_O9 <= 0;
					IR_Data_Oa <= 0;
					IR_Data_Ob <= 0;
					IR_Data_Oc <= 0;
					IR_Data_Od <= 0;
					IR_Data_Oe <= 0;
					IR_Data_Of <= 0;			
				end
		end
	end
endmodule
