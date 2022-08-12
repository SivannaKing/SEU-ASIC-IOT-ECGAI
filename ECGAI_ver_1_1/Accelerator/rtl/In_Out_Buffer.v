// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Lizhiqing
// @Email        : lizhiqing@seu.edu.cn
// @File Name    : In_Out_Buffer.v
// @Module Name  : In_Out_Buffer
// @Created Time : 2020-04-15 09:54
//
// @Abstract     : This module is the buffer to storage Map data. Receive address from Memory_Controller,
//					read original ECG signal from SPI and feature map from Output_Regfile, and write these
//					data to Input_Regfile for calculation.
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-04-15  	Lizhiqing         v1.0a           initial version 
// 2020-06-03	Huangjunguang      v2.0		delay between vld and data
// ******************************************************************************

`timescale 1ns / 1ns
`define DDR_DW			64
`define DDR_AW			32
`define transfer_size	64
`define wt_bw			8
`define ecg_bw			8
`define Bm				8

module In_Out_Buffer(
	//Global signals
	input							clk_cal,
	input							rst_cal_n,
	
	// Signals from Memory controller
	input			[3:0]			nn_layer_cnt,				//	Current layer index
	input			[12:0]			wr_addr,
	input			[12:0]			rd_addr,
	input							SPI_start,		
	
	// Signals with Input_Regfile or SPI
	input							Mem_Data_Ivld,
	output	signed 	[7:0]			IOB_Data_O0, IOB_Data_O1, IOB_Data_O2, IOB_Data_O3, 
									IOB_Data_O4, IOB_Data_O5, IOB_Data_O6, IOB_Data_O7,
	output	reg						IOB_Data_O_vld,

	// Signals with R&P
	input							IOB_Data_I_vld,
	input	signed	[7:0]			IOB_Data_I0, IOB_Data_I1, IOB_Data_I2, IOB_Data_I3, 
									IOB_Data_I4, IOB_Data_I5, IOB_Data_I6, IOB_Data_I7,
	
	// Signals with FC
	input							IOB_FC_vld,
	input	signed	[7:0]			IOB_FC_I0, IOB_FC_I1, IOB_FC_I2, IOB_FC_I3, 
									IOB_FC_I4, IOB_FC_I5, IOB_FC_I6, IOB_FC_I7,	
	// Signals with ECG in
	input							IOB_Data_I_vld_ECG,
	input	signed	[7:0]			IOB_Data_I0_ECG, IOB_Data_I1_ECG, IOB_Data_I2_ECG, IOB_Data_I3_ECG, 
									IOB_Data_I4_ECG, IOB_Data_I5_ECG, IOB_Data_I6_ECG, IOB_Data_I7_ECG
);
			wire					IOB_Data_vld;
			wire	[7:0]			IOB_Data_0, IOB_Data_1, IOB_Data_2, IOB_Data_3, IOB_Data_4, IOB_Data_5, IOB_Data_6, IOB_Data_7;
			
			wire	[7:0]			ram1_Odata0, ram1_Odata1, ram1_Odata2, ram1_Odata3, ram1_Odata4, ram1_Odata5, ram1_Odata6, ram1_Odata7;
			wire	[7:0]			ram2_Odata0, ram2_Odata1, ram2_Odata2, ram2_Odata3, ram2_Odata4, ram2_Odata5, ram2_Odata6, ram2_Odata7;
			
			reg						IOB_Din_vld;
			reg		[7:0]			IOB_Din_0, IOB_Din_1, IOB_Din_2, IOB_Din_3,
									IOB_Din_4, IOB_Din_5, IOB_Din_6, IOB_Din_7;
									
			
	always@(*)begin
		if(!rst_cal_n)begin
			IOB_Din_vld = 0;
			IOB_Din_0 = 0;
			IOB_Din_1 = 0;
			IOB_Din_2 = 0;
			IOB_Din_3 = 0;
			IOB_Din_4 = 0;
			IOB_Din_5 = 0;
			IOB_Din_6 = 0;
			IOB_Din_7 = 0;
		end
		else begin
			if(nn_layer_cnt <= 4'd6)begin
				IOB_Din_vld = IOB_Data_I_vld;
				IOB_Din_0 = IOB_Data_I0;
				IOB_Din_1 = IOB_Data_I1;
				IOB_Din_2 = IOB_Data_I2;
				IOB_Din_3 = IOB_Data_I3;
				IOB_Din_4 = IOB_Data_I4;
				IOB_Din_5 = IOB_Data_I5;
				IOB_Din_6 = IOB_Data_I6;
				IOB_Din_7 = IOB_Data_I7;			
			end
			else if(nn_layer_cnt == 4'd7 || nn_layer_cnt == 4'd8)begin
				IOB_Din_vld = IOB_FC_vld;
				IOB_Din_0 = IOB_FC_I0;
				IOB_Din_1 = IOB_FC_I1;
				IOB_Din_2 = IOB_FC_I2;
				IOB_Din_3 = IOB_FC_I3;
				IOB_Din_4 = IOB_FC_I4;
				IOB_Din_5 = IOB_FC_I5;
				IOB_Din_6 = IOB_FC_I6;
				IOB_Din_7 = IOB_FC_I7;				
			end
			else begin
				IOB_Din_vld = IOB_Data_I_vld;
				IOB_Din_0 = IOB_Data_I0;
				IOB_Din_1 = IOB_Data_I1;
				IOB_Din_2 = IOB_Data_I2;
				IOB_Din_3 = IOB_Data_I3;
				IOB_Din_4 = IOB_Data_I4;
				IOB_Din_5 = IOB_Data_I5;
				IOB_Din_6 = IOB_Data_I6;
				IOB_Din_7 = IOB_Data_I7;			
			end
		end
	end
			
	assign	IOB_Data_vld = (SPI_start)? IOB_Data_I_vld_ECG : IOB_Din_vld;
	assign	IOB_Data_0 = (SPI_start)? IOB_Data_I0_ECG : IOB_Din_0;
	assign	IOB_Data_1 = (SPI_start)? IOB_Data_I1_ECG : IOB_Din_1;
	assign	IOB_Data_2 = (SPI_start)? IOB_Data_I2_ECG : IOB_Din_2;
	assign	IOB_Data_3 = (SPI_start)? IOB_Data_I3_ECG : IOB_Din_3;
	assign	IOB_Data_4 = (SPI_start)? IOB_Data_I4_ECG : IOB_Din_4;
	assign	IOB_Data_5 = (SPI_start)? IOB_Data_I5_ECG : IOB_Din_5;
	assign	IOB_Data_6 = (SPI_start)? IOB_Data_I6_ECG : IOB_Din_6;
	assign	IOB_Data_7 = (SPI_start)? IOB_Data_I7_ECG : IOB_Din_7;
	
	assign	IOB_Data_O0 = (nn_layer_cnt[0])? ram1_Odata0 : ram2_Odata0;
	assign	IOB_Data_O1 = (nn_layer_cnt[0])? ram1_Odata1 : ram2_Odata1;
	assign	IOB_Data_O2 = (nn_layer_cnt[0])? ram1_Odata2 : ram2_Odata2;
	assign	IOB_Data_O3 = (nn_layer_cnt[0])? ram1_Odata3 : ram2_Odata3;
	assign	IOB_Data_O4 = (nn_layer_cnt[0])? ram1_Odata4 : ram2_Odata4;
	assign	IOB_Data_O5 = (nn_layer_cnt[0])? ram1_Odata5 : ram2_Odata5;
	assign	IOB_Data_O6 = (nn_layer_cnt[0])? ram1_Odata6 : ram2_Odata6;
	assign	IOB_Data_O7 = (nn_layer_cnt[0])? ram1_Odata7 : ram2_Odata7;
	
	wire	wen_ram1,wen_ram2;
	
	assign wen_ram1 = ~nn_layer_cnt[0] && IOB_Data_vld;
	assign wen_ram2 =  nn_layer_cnt[0] && IOB_Data_vld;
	
	
	always@(posedge clk_cal or negedge rst_cal_n)begin
		if(!rst_cal_n)
			IOB_Data_O_vld 		<= 1'b0;
		else
			IOB_Data_O_vld <= Mem_Data_Ivld;
	end


//----------------------------------------------------------------------------------
//SRAM
//----------------------------------------------------------------------------------
    //  port B signal write, port A signal read
	memory_map1  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_10(.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_0), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata0));
	memory_map2  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_11 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_1), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata1));
	memory_map3  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_12 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_2), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata2));
	memory_map4  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_13 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_3), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata3));
	memory_map5  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_14 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_4), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata4));
	memory_map6  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_15 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_5), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata5));
	memory_map7  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_16 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_6), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata6));
	memory_map8  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_17 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_7), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata7));
	
	
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_00 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_0), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata0));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_01 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_1), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata1));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_02 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_2), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata2));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_03 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_3), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata3));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_04 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_4), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata4));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_05 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_5), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata5));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_06 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_6), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata6));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_07 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_7), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata7));
																																																	 

endmodule

