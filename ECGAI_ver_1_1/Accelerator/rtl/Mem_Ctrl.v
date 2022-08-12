// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Lizhiqing
// @Email        : lizhiqing@seu.edu.cn
// @File Name    : Men_Ctrl.v
// @Module Name  : Men_Ctrl
// @Created Time : 2020-04-15 09:54
//
// @Abstract     : This module is master contrl unit of ECG ,achieving various 
//               ways of data reuse by controlling data transmission and computing.
//               
//
// Modification History
// *****************************************************************************************************************************
// Date				BY				Version				Change Description
// -----------------------------------------------------------------------------------------------------------------------------
// 2020-04-15  	Lizhiqing			v1.0a				initial version 
// 2020-05-01	Lizhiqing			v2.0a				FETCH INPUT MAP
// 2020-05-19	Lizhiqing			v2.0b				WEIGHT ADDRESS GENERATOR IN CALCULATION
// 2020-05-25	Lizhiqing			v2.0simple			FETCH LAYER PARAMTER & WEIGHT ADDRESS GENERATOR IN OR_FT_WT
// 2020-06-03	Huangjunguang       v2.0		        change wr_addr to wire
// *****************************************************************************************************************************

`timescale 1ns / 1ns
`define DDR_DW			64
`define DDR_AW			32
`define transfer_size	64
`define wt_bw			8
`define ecg_bw			8
`define Bm				8
`define	C				8
`define R				16


module Mem_Ctrl(
	//Global signals
	input					clk_cal,
	input					rst_cal_n,
	
	// State signals with mcu
	input		[7 :0]		mc_cs,					// Current state of accelerator
	input		[7 :0]		mc_ns,					// Next state of accelerator
	input		[5 :0]		or_cs,					// Current state of calculation
	input		[5 :0]		or_ns,					// Next state of calculation
	output	reg				memct_init_cmplt,		// Reset Initial complite
	input		[3 :0]		nn_layer_cnt,			// Current layer index, should be 1 when mc_cs[FT_ECG]
	
	// Input ECG paramters from mcu
	input		[11:0]		ecg_len,				// Lenth of input ecg signal
	
	// Signals with PE_Array
	input					pe_end,
	output	reg				rd_done,				// turn pe_end from 1 to 0
	output		[10:0]		cal_cycle,				// newly added
	output		[10:0]		pass_cycle,				// newly added
    output      [1 :0]      Relu_max,               // added in ECG_Test_v2
	
	// Signals with Input_Regfile and InOutBuffer
	output		[7 :0]		K,
	output		[7 :0]		S,
	output	reg	[5 :0]		Bm_cnt,
	output	reg	[3 :0]		ft_N_cnt,
	output  reg	[12:0]  	rd_addr,
	output	reg				Data_O_vld,
	output		[12:0]		wr_addr,
	input					Data_I_vld,				//newly added with R&P
	input 					Data_I_vld_ECG,
	// Signals with Weight_Buffer
	output	reg				wt_I_vld,				// added in 2.0simple
	output	reg	[10:0]		wt_I_addr,				// added in 2.0simple
	output	reg	[10:0]		wt_C0_addr, wt_C1_addr, wt_C2_addr, wt_C3_addr,
							wt_C4_addr, wt_C5_addr, wt_C6_addr, wt_C7_addr,
							
	output	reg				//wt_C0_O_vld_r, wzx
							wt_C0_O_vld, wt_C1_O_vld, wt_C2_O_vld, wt_C3_O_vld,		//name chaged in 2.0simple
							wt_C4_O_vld, wt_C5_O_vld, wt_C6_O_vld, wt_C7_O_vld,

	// Signals with R&P
	output	 	[2 :0]		Pool_K,					// Pooling size of this layer		added in 2.0simple
	output		[1 :0]		Pool_S,					// Pooling stride of this layer		added in 2.0simple
	output					final_ftNchange_flag,	// newly added with R&P
    output                  final_column,           
	output		[2 :0]		final_zeros,			// newly added with R&P
	
	// Signals for transaction of weights
	//output	[`DDR_DW-1:0]	ft_wt_rddata,			// weights of current layer
	//output					ft_wt_vld,
	
	// Address of weight, data and parameter from mcu
	input	[`DDR_AW-1:0]	nn_lyr_param_saddr,		// Start address of layer parameters
	input	[`DDR_AW-1:0]	nn_wt_saddr,			// Start address of weights
	
	// Transmission state signals to mcu
	output	reg				ft_lyr_param_done,
	output	reg				ft_ecg_done,
	output					ft_wt_done,
	output					lyr_cal_done
);

	//-------------------------------STATE OF ACCELERATOR------------------------------
	//ACCELERATOR CONTROL STATE DECLARATIONS
	//---------------------------------------------------------------------------------	

	localparam	[7:0]		IDLE		= 8'd0;
	localparam	[7:0]		FT_ADDR		= 8'd1;
	localparam	[7:0]		ECG_UD		= 8'd2;
	localparam	[7:0]		FT_ECG		= 8'd3;
	localparam	[7:0]		FT_PARAM	= 8'd4;
	localparam	[7:0]		CONV_CAL	= 8'd5;
	localparam	[7:0]		LY_DONE		= 8'd6;
	localparam	[7:0]		INF_DONE	= 8'd7;
	// localparam	[7:0]		remain		= 8'b0000_0000;
	
	
	//---------------------------------STATE OF CALCULATION----------------------------
	//CALCULATION CONTROL STATE DECLARATIONS
	//---------------------------------------------------------------------------------

	localparam	[5:0]		OR_IDLE		= 6'd0;
	localparam	[5:0]		OR_FT_WT	= 6'd1;
	localparam	[5:0]		OR_CAL		= 6'd2;
	localparam	[5:0]		OR_DONE		= 6'd3;
	// localparam	[5:0]		remain		= 6'b000000;

//****************************************************************************************
// -----------------------------Memory Controller initial---------------------------------
//****************************************************************************************
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			memct_init_cmplt <= 1'b0;
		else
			memct_init_cmplt <= 1'b1;


//********************************************************************************************
// -------------------------------------FETCH INPUT MAP---------------------------------------
//********************************************************************************************
			reg					rd_lyr_done;				// The completion signal of read all input maps in this layer
			reg					wr_lyr_done;				// The completion signal of write all output maps in this layer 
		// Signals of writing layer1 input map in In_Out_Buffer
			wire	[8:0]		ft_ecg_times;
			reg		[12:0]		ft_ecg_cnt;
			wire	[12:0]		ft_ecg_cnt_nxt;
			
		// Signals of writing layer2-layer6 output map in In_Out_Buffer
			reg		[6:0]		N_cnt;						// Start from 1
			wire	[9:0]		omap_addr_span;				// address span of one output map
			reg		[9:0]		omap_addr_span_cnt;
			wire	[12:0]		wr_addr_nxt;
			wire				wr_lyr_done_w;
		
		//Signals of reading layer1-layer6 input map from In_Out_Buffer
			reg		[6:0]		M_cnt;						// Start from 1
			wire	[9:0]		imap_addr_span;				// address length of one map
			wire	[9:0]		cal_times;					// calculation times of one map
			reg		[8:0]		cal_cnt;
			wire	[3:0]		ft_N_times;					// fetch times of one input map
			wire	[5:0]		Bm_times;					// transmission cycle per calculation
			wire	[12:0]		rd_addr_nxt;
			
		// Layer paramets to other modules
			wire	[11:0]		IX;						// Input data length
			wire	[11:0]		OX;						// Output data length
			wire	[6:0]		M;						// In channels of this layer
			wire	[6:0]		N;						// Out channels of this layer
			wire	[9:0]		Hu;						// Map points in Input wirefile of this layer
            wire    [11:0]      OX_aft_conv;            // Ouput data length after convolution

	//----------------------------------------------------------------------------------
	//WRITE LAYER1 INPUT MAP TO MAP BUFFER
	//----------------------------------------------------------------------------------
	assign	ft_ecg_times = (ecg_len[2:0]==3'b0)?(ecg_len)>>3:((ecg_len>>3)+1);
			
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			ft_ecg_cnt <= 8'b0;
		else if(Data_I_vld_ECG && mc_cs[FT_ECG])					// replace Data_I_vld with Data_I_vld_ECG
			ft_ecg_cnt <= ft_ecg_cnt_nxt;
		else
			ft_ecg_cnt <= ft_ecg_cnt;
	
	assign ft_ecg_cnt_nxt = (ft_ecg_cnt==ft_ecg_times-1'b1)?8'b0 : ft_ecg_cnt+1'b1;
	
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			ft_ecg_done <= 1'b0;
		else if(ft_ecg_cnt==ft_ecg_times-1'b1)
			ft_ecg_done <= 1'b1;
		else
			ft_ecg_done <= 1'b0;

	//----------------------------------------------------------------------------------
	//WRITE LAYER1-LAYER6 OUTPUT MAP TO MAP BUFFER
	//----------------------------------------------------------------------------------
	assign	omap_addr_span = (OX[2:0]==3'b0)?(OX>>3):((OX>>3)+1'b1);
	assign	final_column = ((omap_addr_span_cnt==omap_addr_span-1) && pe_end && rd_lyr_done)? 1'b1 : 1'b0;
	assign	final_zeros = final_column?(8-OX[2:0]):3'b0;

	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			N_cnt <= 7'b0;
		else if((or_cs[OR_FT_WT] && or_ns[OR_CAL]))
			N_cnt <= 7'b1;
		else if(N_cnt==N) begin
			if(nn_layer_cnt<=4'd7)
				N_cnt <= 7'b1;
			else begin
				if(Data_I_vld) N_cnt <= 7'b1;
				else	N_cnt <= N_cnt;
			end			
		end
		else if(Data_I_vld && !wr_lyr_done)
			N_cnt <= N_cnt + 1'b1;
		else
			N_cnt <= N_cnt;
		
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			omap_addr_span_cnt <= 1'b0;
		else if(or_cs[OR_FT_WT] && or_ns[OR_CAL])
			omap_addr_span_cnt <= 1'b0;
		else if(omap_addr_span_cnt==omap_addr_span && nn_layer_cnt==4'd7)
			omap_addr_span_cnt <= 1'b0;
		else if(omap_addr_span_cnt==omap_addr_span-1'b1 && N_cnt==N && nn_layer_cnt<=4'd6)
			omap_addr_span_cnt <= 1'b0;
		else if(N_cnt==N && Data_I_vld && !wr_lyr_done)
			omap_addr_span_cnt <= omap_addr_span_cnt + 1'b1;
		else
			omap_addr_span_cnt <= omap_addr_span_cnt;
			
	assign  wr_addr = (mc_cs[FT_ECG])? ft_ecg_cnt : 
						(Data_I_vld)? ((N_cnt-1'b1)*omap_addr_span + omap_addr_span_cnt) : 0;
	assign	wr_addr_nxt = (N_cnt-1'b1)*omap_addr_span + omap_addr_span_cnt;
	//wire lyr8_flag;
	//assign	lyr8_flag = (N_cnt==3 && Data_I_vld && nn_layer_cnt==4'd8)?1'b1:1'b0;
	// assign	wr_lyr_done_w = (nn_layer_cnt<=4'd7)?(((omap_addr_span_cnt==omap_addr_span-1'b1) && N_cnt==N && Data_I_vld)?1'b1:1'b0):
								// (((omap_addr_span_cnt==omap_addr_span-1'b1) && N_cnt==(N-7'd14) && Data_I_vld)?1'b1:1'b0);
	assign	wr_lyr_done_w = ((omap_addr_span_cnt==omap_addr_span-1'b1) && N_cnt==N && Data_I_vld)?1'b1:1'b0;
	
	reg			wr_lyr_done_1;
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			begin
				wr_lyr_done <= 1'b0;
				wr_lyr_done_1 <= 1'b0;
			end
		else
			begin
				wr_lyr_done <= wr_lyr_done_1;
				wr_lyr_done_1 <= wr_lyr_done_w;
			end

	assign lyr_cal_done = (or_cs[OR_CAL] && wr_lyr_done&&rd_lyr_done)?1'b1:1'b0;

	//----------------------------------------------------------------------------------
	//READ LAYER1-LAYER6 INPUT MAP FROM MAP BUFFER
	//----------------------------------------------------------------------------------
	assign	imap_addr_span = (IX[2:0]==3'b0)?(IX>>3):((IX>>3)+1'b1);
	assign	ft_N_times = (N[2:0]==3'b0)?(N>>3):((N>>3)+1'b1);
	assign	Bm_times = (Hu[2:0]==3'b0)?(Hu>>3):((Hu>>3)+1'b1);
    assign  cal_times = (nn_layer_cnt >  7) ? 10'd1 :
                        (nn_layer_cnt == 7) ? 10'd5 :
                        (nn_layer_cnt <= 6 && (OX_aft_conv[3:0]==4'b0)) ? OX_aft_conv[11:4] : 
                                                                          OX_aft_conv[11:4]+1; 	
      /* assign  cal_times = (nn_layer_cnt<=4'd6)?(((imap_addr_span-Bm_times)%(2*S))?(((imap_addr_span-Bm_times)>>S) + 2):(((imap_addr_span-Bm_times)>>S) + 1))
							:(nn_layer_cnt==4'd7)?10'd5:10'd1;   */         
    //assign  cal_times = (nn_layer_cnt<=4'd6)?(((imap_addr_span-Bm_times)%(2*S))?(((imap_addr_span-Bm_times)>>S) + 2):(((imap_addr_span-Bm_times)>>S) + 1))
	//						:(nn_layer_cnt==4'd7)? 10'd5:10'd1;
	
	//	Output valid signal
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			Data_O_vld <= 1'b0;
		else if(rd_lyr_done)
			Data_O_vld <= 1'b0;
		else if(pe_end && ~(Bm_cnt==Bm_times) && or_cs[OR_CAL] && !rd_done)
			Data_O_vld <= 1'b1;
		else
			Data_O_vld <= 1'b0;
	
	// Counter of calculation times of current map
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			cal_cnt <= 0;
		else if(or_cs[OR_FT_WT] && or_ns[OR_CAL])
			cal_cnt <= 1;
		else if((M_cnt==M) && rd_done && (ft_N_cnt==ft_N_times) && (cal_cnt<=cal_times))
			cal_cnt <= cal_cnt + 1'b1;
		else
			cal_cnt <= cal_cnt;
			
	// Counter of fetch Nt times
	reg	[3:0]	final_N_cnt;
	always @(posedge clk_cal)
		if(!or_cs[OR_CAL] || final_N_cnt==15)
			final_N_cnt <= 0;
		else if(final_column)
			final_N_cnt <= final_N_cnt + 1;
	assign	final_ftNchange_flag = (final_N_cnt==15)?1:0;
	
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			ft_N_cnt <= 4'b0;
		else if(or_cs[OR_FT_WT] && or_ns[OR_CAL])
			ft_N_cnt <= 4'b1;
		else if((M_cnt==M) && rd_done && (ft_N_cnt==ft_N_times))
			ft_N_cnt <= 4'b1;
		else if((M_cnt==M) && rd_done && (ft_N_cnt!=ft_N_times))
			ft_N_cnt <= ft_N_cnt + 1'b1;
		else if(final_column && ft_N_cnt==ft_N_times && final_N_cnt==15)
			ft_N_cnt <= 1'b1;
		else if(final_column && final_ftNchange_flag)
			ft_N_cnt <= ft_N_cnt + 1'b1;

	// Counter of map index
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			M_cnt <= 7'b0;
		else if(or_cs[OR_FT_WT] && or_ns[OR_CAL])
			M_cnt <= 7'b1;
		else if(rd_lyr_done)
			M_cnt <= 7'b0;
		else if((M_cnt==M) && rd_done) // && (ft_N_cnt!=ft_N_times))
			M_cnt <= 7'b1;  
		else if(rd_done && (M_cnt!=M))
			M_cnt <= M_cnt + 7'b1;
		else
			M_cnt <= M_cnt;
			
	// Counter of fetch Hu
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			Bm_cnt <= 6'b0;
		else if(or_cs[OR_FT_WT] && or_ns[OR_CAL])
			Bm_cnt <= 6'b0;
		else if(rd_lyr_done)
			Bm_cnt <= 6'b0;
		else if(Bm_cnt==Bm_times)
			Bm_cnt <= 6'b0;
		else if(pe_end && or_cs[OR_CAL])
			Bm_cnt <= Bm_cnt + 6'b1;
		else
			Bm_cnt <= 6'b0;	
			
	// Read done signal
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			rd_done <= 1'b0;
		else if(pe_end && (Bm_cnt==Bm_times))
			rd_done <= 1'b1;
		else
			rd_done <= 1'b0;
			
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			rd_addr <= 13'b0;
		else if(pe_end)
			rd_addr <= rd_addr_nxt;
		
assign	rd_addr_nxt = (M_cnt-1'b1)*imap_addr_span + (cal_cnt-1'b1)*S*2 + Bm_cnt;

// changed from block assignment to non-block assignment
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			rd_lyr_done <= 1'b0;
		else if(lyr_cal_done)
			rd_lyr_done <= 1'b0;
		else if((M_cnt==M) && (cal_cnt==cal_times) && (ft_N_cnt==ft_N_times) && rd_done)
			rd_lyr_done <= 1'b1;

//********************************************************************************************
// -------------------------WEIGHT ADDRESS GENERATOR IN OR_FT_WT------------------------------
//********************************************************************************************	
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			wt_I_vld <= 0;
		else if(or_cs[IDLE] && or_ns[OR_FT_WT] && !ft_wt_done)
			wt_I_vld <= 1;
		else if(ft_wt_done)
			wt_I_vld <= 0;
	
	assign ft_wt_done = (wt_I_addr==K*M*N/8 - 1)?1:0;
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			wt_I_addr <= 11'b0;
		else if(wt_I_vld)
			wt_I_addr <= wt_I_addr + 1'b1;
		else
			wt_I_addr <= 11'b0;
	

//********************************************************************************************
// -------------------------WEIGHT ADDRESS GENERATOR IN CALCULATION---------------------------
//********************************************************************************************
			wire	[10:0]		wt_C0_addr_nxt;
			reg		[6:0]		wt_M_cnt;
			reg		[8:0]		K_cnt;
			reg		[3:0]		wt_N_cnt;
			reg					rd_done_temp;
				
	always @(posedge clk_cal)
		rd_done_temp <= rd_done;

	always @(posedge clk_cal or negedge rst_cal_n)				// output port
		if(!rst_cal_n)
			wt_C0_O_vld <= 1'b0;
		else if(rd_done_temp)
			wt_C0_O_vld <= 1'b1;
		else if((!pe_end && (K_cnt>=K)) || !or_cs[OR_CAL])
			wt_C0_O_vld <= 1'b0;
			
	    always @(posedge clk_cal or negedge rst_cal_n)
			if(!rst_cal_n)
				begin
//                    wt_C0_O_vld_r <= 0;wzx
					wt_C1_O_vld <= 0;
					wt_C2_O_vld <= 0;
					wt_C3_O_vld <= 0;
					wt_C4_O_vld <= 0;
					wt_C5_O_vld <= 0;
					wt_C6_O_vld <= 0;
					wt_C7_O_vld <= 0;
				end
			else if(nn_layer_cnt==4'd7)						// newly adder for gap and fc
				begin
//                    wt_C0_O_vld_r <= 0;wzx
					wt_C1_O_vld <= 0;
					wt_C2_O_vld <= 0;
					wt_C3_O_vld <= 0;
					wt_C4_O_vld <= 0;
					wt_C5_O_vld <= 0;
					wt_C6_O_vld <= 0;
					wt_C7_O_vld <= 0;
				end
			else
				begin
//                    wt_C0_O_vld_r <= wt_C0_O_vld;wzx
					wt_C1_O_vld <= wt_C0_O_vld;
					wt_C2_O_vld <= wt_C1_O_vld;
					wt_C3_O_vld <= wt_C2_O_vld;
					wt_C4_O_vld <= wt_C3_O_vld;
					wt_C5_O_vld <= wt_C4_O_vld;
					wt_C6_O_vld <= wt_C5_O_vld;
					wt_C7_O_vld <= wt_C6_O_vld;
				end

	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			wt_N_cnt <= 0;
		else if(or_cs[OR_FT_WT] && or_ns[OR_CAL])
			wt_N_cnt <= 0;
		else if(rd_done)
			wt_N_cnt <= ft_N_cnt;

	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			wt_M_cnt <= 0;
		else if(or_cs[OR_FT_WT] && or_ns[OR_CAL])
			wt_M_cnt <= 0;
		else if(rd_done)
			wt_M_cnt <= M_cnt;

	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			K_cnt <= 0;
		else if(rd_done)
			K_cnt <= 0;
		else if(or_cs[OR_CAL])
			K_cnt <= K_cnt + 1'b1;

	always @(posedge clk_cal or negedge rst_cal_n)			// output port
		if(!rst_cal_n)
			wt_C0_addr <= 0;
		else if((or_cs[1] && or_ns[2]) || (wt_C0_addr == K*M*ft_N_times-1'b1))
			wt_C0_addr <= 0;
		else if(or_cs[2] && wt_C0_O_vld) begin
            //if(wt_C0_addr_nxt>K*M*ft_N_times)
              //  wt_C0_addr <= 0;
            //else
			    wt_C0_addr <= wt_C0_addr_nxt;
            end
	assign	wt_C0_addr_nxt = (wt_N_cnt-1)*K*M+(wt_M_cnt-1)*K+K_cnt; 
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			begin
				wt_C1_addr <= 0;
				wt_C2_addr <= 0;
				wt_C3_addr <= 0;
				wt_C4_addr <= 0;
				wt_C5_addr <= 0;
				wt_C6_addr <= 0;
				wt_C7_addr <= 0;
			end
		else
			begin
				wt_C1_addr <= wt_C0_addr;
				wt_C2_addr <= wt_C1_addr;
				wt_C3_addr <= wt_C2_addr;
				wt_C4_addr <= wt_C3_addr;
				wt_C5_addr <= wt_C4_addr;
				wt_C6_addr <= wt_C5_addr;
				wt_C7_addr <= wt_C6_addr;
			end

//********************************************************************************************
// ---------------------------------- FETCH LAYER PARAMTER------------------------------------
//********************************************************************************************	
	reg	[`DDR_DW-1:0]	nn_param_mem[80:0];									// Memory for parameters storage	


	// --------------------Output of successful transmission a batch of kernels------------
	reg	[`DDR_AW-1:0]	nn_lyr_param_addr;			// add in spu, replace nn_lyr_param_saddr
	
	always @(posedge clk_cal or negedge rst_cal_n)
		if(!rst_cal_n)
			begin
				nn_lyr_param_addr <= 0;
				ft_lyr_param_done <= 0;
			end
		else if((mc_cs[FT_ECG] && mc_ns[FT_PARAM]) || (mc_cs[LY_DONE] && mc_ns[FT_PARAM]))
			begin
				nn_lyr_param_addr <= nn_lyr_param_saddr + (nn_layer_cnt-1)*10;	// nn_lyr_param_saddr=0
				//readmem - Synthesis Unsupported Simulation ONLY
				$readmemb("E:\\Xilinx\\VivadoProject\\ECGLPDLA_ver1_0\\param_ver1_0.txt", nn_param_mem);
				ft_lyr_param_done <= 1;
			end
		else
			ft_lyr_param_done <= 0;
			
	// ---------------------------Assignment for parameters--------------------------------
	assign	IX								= nn_param_mem[nn_lyr_param_addr + 0];
	assign	OX								= nn_param_mem[nn_lyr_param_addr + 1];
	assign	M								= nn_param_mem[nn_lyr_param_addr + 2][6:0];
	assign	N								= nn_param_mem[nn_lyr_param_addr + 3][6:0];
	assign	Hu								= nn_param_mem[nn_lyr_param_addr + 4][9:0];
	assign	K								= nn_param_mem[nn_lyr_param_addr + 5][7:0];
	assign	S								= nn_param_mem[nn_lyr_param_addr + 6][7:0];
	assign	Pool_K							= nn_param_mem[nn_lyr_param_addr + 7][2:0];
	assign	Pool_S							= nn_param_mem[nn_lyr_param_addr + 8][1:0];
    assign  Relu_max                        = nn_param_mem[nn_lyr_param_addr + 8][11:10];       // added in ECG_Test_v2
    assign  OX_aft_conv                     = nn_param_mem[nn_lyr_param_addr + 9];

	
	assign	cal_cycle = K*M;
	assign	pass_cycle = `R + `C + K - 1-2;
	// always@(posedge clk_cal or negedge rst_cal_n)begin
		// if(!rst_cal_n)
			// begin
				// IX		<= 0;
				// OX		<= 0;
				// M		<= 0;
				// N		<= 0;
				// Hu		<= 0;
				// K		<= 0;
				// S		<= 0;
				// Pool_K	<= 0;
				// Pool_S	<= 0;
			// end
		// else begin
			// case(nn_layer_cnt)
			// 4'd1:begin
				// IX		<= 12'b111000010000;
				// OX		<= 12'b001101111110;
				// M		<= 7'b0000001;
				// N		<= 7'b0001000;
				// Hu		<= 10'b0000101110;
				// K		<= 8'b00010000;
				// S		<= 8'b00000010;
				// Pool_K	<= 3'b111;
				// Pool_S	<= 2'b10;			
			// end
			// 4'd2:begin
				// IX		<= 12'b001101111110;
				// OX		<= 12'b000011011100;
				// M		<= 7'b0001000;
				// N		<= 7'b0010000;
				// Hu		<= 10'b0000101010;
				// K		<= 8'b00001100;
				// S		<= 8'b00000010;
				// Pool_K	<= 3'b100;
				// Pool_S	<= 2'b10;			
			// end	
			// 4'd3:begin
				// IX		<= 12'b000011011100;
				// OX		<= 12'b000001101001;
				// M		<= 7'b0010000;
				// N		<= 7'b0100000;
				// Hu		<= 10'b0000010111;
				// K		<= 8'b00001000;
				// S		<= 8'b00000001;
				// Pool_K	<= 3'b101;
				// Pool_S	<= 2'b10;			
			// end
			// 4'd4:begin
				// IX		<= 12'b000001101001;
				// OX		<= 12'b000000110000;
				// M		<= 7'b0100000;
				// N		<= 7'b1000000;
				// Hu		<= 10'b0000010111;
				// K		<= 8'b00001000;
				// S		<= 8'b00000001;
				// Pool_K	<= 3'b100;
				// Pool_S	<= 2'b10;			
			// end		
			// 4'd5:begin
				// IX		<= 12'b000000110000;
				// OX		<= 12'b000000010110;
				// M		<= 7'b1000000;
				// N		<= 7'b1000000;
				// Hu		<= 10'b0000010011;
				// K		<= 8'b00000100;
				// S		<= 8'b00000001;
				// Pool_K	<= 3'b010;
				// Pool_S	<= 2'b10;			
			// end
			// 4'd6:begin
				// IX		<= 12'b000000010110;
				// OX		<= 12'b000000001010;
				// M		<= 7'b1000000;
				// N		<= 7'b1001000;
				// Hu		<= 10'b0000010010;
				// K		<= 8'b00000011;
				// S		<= 8'b00000001;
				// Pool_K	<= 3'b010;
				// Pool_S	<= 2'b10;			
			// end
			// 4'd7:begin
				// IX		<= 12'b010010000000;
				// OX		<= 12'b000001001000;
				// M		<= 7'b0000001;
				// N		<= 7'b0000001;
				// Hu		<= 10'b0100000000;
				// K		<= 8'b00010000;
				// S		<= 8'b00010000;
				// Pool_K	<= 3'b0;
				// Pool_S	<= 2'b0;			
			// end
			// 4'd8:begin
				// IX		<= 12'b000001001000;
				// OX		<= 12'b000000000001;
				// M		<= 7'b0000001;
				// N		<= 7'b0010001;
				// Hu		<= 10'b0001001000;
				// K		<= 8'b01001000;
				// S		<= 8'b01001000;
				// Pool_K	<= 3'b0;
				// Pool_S	<= 2'b0;			
			// end
			// default:begin
				// IX		<= 0;
				// OX		<= 0;
				// M		<= 0;
				// N		<= 0;
				// Hu		<= 0;
				// K		<= 0;
				// S		<= 0;
				// Pool_K	<= 0;
				// Pool_S	<= 0;			
			// end			
			// endcase
		// end
	// end
	
	// always @(posedge clk_cal or negedge rst_cal_n)
		// if(!rst_cal_n) begin
			// cal_cycle  <= 0;
			// pass_cycle <= 0;
		// end
		// else begin
			// cal_cycle  <= K*M;
			// pass_cycle <= K+21;
		// end
		
		
//********************************************************************************************
// ---------------------------------------FETCH WEIGHT----------------------------------------
//********************************************************************************************
	
endmodule
