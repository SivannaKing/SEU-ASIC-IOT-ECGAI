// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Lizhiqing
// @Email        : lizhiqing@seu.edu.cn
// @File Name    : Weight_buffer.v
// @Module Name  : weight_buffer_ECG
// @Created Time : 2020-03-23 09:54
//
// @Abstract     : This module is weight buffer of ECG accelerator, it is used to read
//				   or write weight for PEArray further calculation.
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// ------------------------------------------------------------------------------
// 2020-03-17  	Lizhiqing         v1.0a           initial version 
// 2020-05-20  	Lizhiqing         v2.0b           Read data from weight buffer
// 2020-06-03	Huangjunguang      v2.0			  delay between vld and data
// ******************************************************************************

`timescale 1ns / 1ns
`define DDR_DW			64
`define DDR_AW			32
`define	burst_len		128
`define	transfer_size	64
`define	wt_bw			8
`define	ecg_bw			8

module Weight_buffer(
	// Global Signals
	input					clk_cal,
	input					rst_cal_n,
	input	[3:0]	  layer2weight_cnt,	
	// Write Signals 
	// input		[5:0]		Nt,
	// input		[8:0]		KKM,
	// input		[5:0]		KKM8,
	// input		[`DDR_DW:1]	data_in,					// data from memory_contrller
	// input					data_in_vld,				// data valid signal from memory contrller
	
	// Write Signals 
	input		[10:0]	wt_I_addr,					// data from memory_contrller
	input						wt_I_vld,					// data valid signal from memory contrller	
	
	// Signal from Mem_Ctrl
	input		[10:0]		wt_C0_addr, wt_C1_addr, wt_C2_addr, wt_C3_addr,
							wt_C4_addr, wt_C5_addr, wt_C6_addr, wt_C7_addr,
							
	input					wt_C0_O_vld, wt_C1_O_vld, wt_C2_O_vld,		//name chaged in 2.0simple
							wt_C3_O_vld, wt_C4_O_vld, wt_C5_O_vld,
							wt_C6_O_vld, wt_C7_O_vld,
	
	// Read Signals
	output	reg			wt_Ovld0,
	output	reg			wt_Ovld1,
	output	reg			wt_Ovld2,
	output	reg			wt_Ovld3,
	output	reg			wt_Ovld4,
	output	reg			wt_Ovld5,
	output	reg			wt_Ovld6,
	output	reg			wt_Ovld7,
	output  [7:0] 		kernel_C0_O,
	output  [7:0] 		kernel_C1_O,
	output  [7:0] 		kernel_C2_O,
	output  [7:0] 		kernel_C3_O,
	output  [7:0] 		kernel_C4_O,
	output  [7:0] 		kernel_C5_O,
	output  [7:0] 		kernel_C6_O,
	output  [7:0] 		kernel_C7_O
	);
			// Write Signals
			// reg	[31:0]		write_flag;
			// reg	[8:0]		KKM8_cnt;
			// reg	[5:0]		Nt_cnt;
			// reg	[5:0]		addr_wr;
			// reg	[`DDR_DW:1]	data_in_temp0;
			// reg				data_in_vld_temp0;
			
			// Read Signals

	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			wt_Ovld0 <= 1'b0;
		else
			wt_Ovld0 <= wt_C0_O_vld;

	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			begin
				wt_Ovld1 <= 0;
				wt_Ovld2 <= 0;
				wt_Ovld3 <= 0;
				wt_Ovld4 <= 0;
				wt_Ovld5 <= 0;
				wt_Ovld6 <= 0;
				wt_Ovld7 <= 0;
			end
		else
			begin
				wt_Ovld1 <= wt_Ovld0;
				wt_Ovld2 <= wt_Ovld1;
				wt_Ovld3 <= wt_Ovld2;
				wt_Ovld4 <= wt_Ovld3;
				wt_Ovld5 <= wt_Ovld4;
				wt_Ovld6 <= wt_Ovld5;
				wt_Ovld7 <= wt_Ovld6;
			end			
//****************************************************************************************
// Write data in weight buffer
//****************************************************************************************
	// always @(posedge clk_tran or negedge rst_tran_n)
		// if(!rst_tran_n)
			// begin
				// write_flag 			<=	32'b0;
				// Nt_cnt 				<=	6'b0;
				// KKM8_cnt			<=	9'b0;
				// addr_wr				<=	6'b0;
				// data_in_temp0		<= 	`DDR_DW'b0;
				// data_in_vld_temp0	<= 	1'b0;
			// end
		// else
			// begin
				// data_in_temp0 		<=	data_in;
				// data_in_vld_temp0	<=	data_in_vld;
				// write_flag			<=	(32'b1 << Nt_cnt);
				// if(data_in_vld)
					// begin
						// if(KKM8_cnt < (KKM8-1'b1))
							// begin
								// KKM8_cnt	<=	KKM8_cnt + 1'b1;
							// end
						// else
							// begin
								// KKM8_cnt	<=	9'b0;
								// if(Nt_cnt < (Nt-1'b1))
									// begin
										// Nt_cnt	<=	Nt_cnt + 1'b1;
									// end
								// else
									// begin
										// Nt_cnt	<=	6'b0;
									// end
							// end
						// addr_wr		<=	KKM8_cnt;
					// end
				// else
					// begin
						// KKM8_cnt	<=	KKM8_cnt;
						// Nt_cnt		<=	Nt_cnt;
						// addr_wr		<=	addr_wr;
					// end
			// end
			
			
//****************************************************************************************
// Read data from weight buffer
//****************************************************************************************

    //  port B signal write, port A signal read
	weight_memory1  #(
    .ADDR_WIDTH(11),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) U00_weight_buf_mem (.clk(clk_cal), .rst_n(rst_cal_n), .layer2weight_cnt(layer2weight_cnt), .wrenb(wt_I_vld ),.csen(1'b1), .addr_b(11'b0), .data_b(8'b0), .rdena(wt_C0_O_vld), .addr_a(wt_C0_addr), .data_a(kernel_C0_O));
	weight_memory2  #(
    .ADDR_WIDTH(11),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) U01_weight_buf_mem (.clk(clk_cal), .rst_n(rst_cal_n), .layer2weight_cnt(layer2weight_cnt), .wrenb(wt_I_vld ),.csen(1'b1), .addr_b(11'b0), .data_b(8'b0), .rdena(wt_C1_O_vld), .addr_a(wt_C1_addr), .data_a(kernel_C1_O));
	weight_memory3  #(
    .ADDR_WIDTH(11),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) U02_weight_buf_mem (.clk(clk_cal), .rst_n(rst_cal_n), .layer2weight_cnt(layer2weight_cnt), .wrenb(wt_I_vld ),.csen(1'b1), .addr_b(11'b0), .data_b(8'b0), .rdena(wt_C2_O_vld), .addr_a(wt_C2_addr), .data_a(kernel_C2_O));
	weight_memory4  #(
    .ADDR_WIDTH(11),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) U03_weight_buf_mem (.clk(clk_cal), .rst_n(rst_cal_n), .layer2weight_cnt(layer2weight_cnt), .wrenb(wt_I_vld ),.csen(1'b1), .addr_b(11'b0), .data_b(8'b0), .rdena(wt_C3_O_vld), .addr_a(wt_C3_addr), .data_a(kernel_C3_O));
	weight_memory5  #(
    .ADDR_WIDTH(11),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) U04_weight_buf_mem (.clk(clk_cal), .rst_n(rst_cal_n), .layer2weight_cnt(layer2weight_cnt), .wrenb(wt_I_vld ),.csen(1'b1), .addr_b(11'b0), .data_b(8'b0), .rdena(wt_C4_O_vld), .addr_a(wt_C4_addr), .data_a(kernel_C4_O));
	weight_memory6  #(
    .ADDR_WIDTH(11),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) U05_weight_buf_mem (.clk(clk_cal), .rst_n(rst_cal_n), .layer2weight_cnt(layer2weight_cnt), .wrenb(wt_I_vld ),.csen(1'b1), .addr_b(11'b0), .data_b(8'b0), .rdena(wt_C5_O_vld), .addr_a(wt_C5_addr), .data_a(kernel_C5_O));
	weight_memory7  #(
    .ADDR_WIDTH(11),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) U06_weight_buf_mem (.clk(clk_cal), .rst_n(rst_cal_n), .layer2weight_cnt(layer2weight_cnt), .wrenb(wt_I_vld ),.csen(1'b1), .addr_b(11'b0), .data_b(8'b0), .rdena(wt_C6_O_vld), .addr_a(wt_C6_addr), .data_a(kernel_C6_O));
	weight_memory8  #(
    .ADDR_WIDTH(11),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) U07_weight_buf_mem (.clk(clk_cal), .rst_n(rst_cal_n), .layer2weight_cnt(layer2weight_cnt), .wrenb(wt_I_vld ),.csen(1'b1), .addr_b(11'b0), .data_b(8'b0), .rdena(wt_C7_O_vld), .addr_a(wt_C7_addr), .data_a(kernel_C7_O));

endmodule
