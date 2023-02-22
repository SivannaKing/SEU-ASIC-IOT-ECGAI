// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Lizhiqing
// @Email        : lizhiqing@seu.edu.cn
// @File Name    : Configurator.v
// @Module Name  : Configurator
// @Created Time : 2020-03-17 09:54
//
// @Abstract     : This module is master contrl unit of ECG ,achieving various 
//               ways of data reuse by controlling data transmission and computing.
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-03-17  	Lizhiqing         v1.0a           initial version
// 2020-05-19	Lizhiqing		  v2.0b			  remake
// ******************************************************************************
`timescale 1ns / 1ns
`define DDR_DW			64
`define DDR_AW			32
`define	burst_len		128
`define	transfer_size	64
`define	wt_bw			8
`define	ecg_bw			8
`define Bm			    8
`define	C			    8
`define R			    16

module	Configurator(
	input					clk_cal,
	input					rst_cal_n,
	
	// I/O ports of mcu
	input					SPI_start,
	// input					SPI_done,
	output		[5:0]		or_cs,
	output      [7:0]       mc_cs,
	
	// Signals between Mem_Ctrl and PE_Array
	input					pe_end,					// added in v2.0b
	output					rd_done,				// added in v2.0b
	output		[10:0]		cal_cycle,				// added in v2.0b
	output		[10:0]		pass_cycle,
    output      [1 :0]      Relu_max,               // added in ECG_Test_v2
	
	// Signals among Mem_Ctrl and Input_Regfile and InOutBuffer
	output	 	[7:0]		K,						// added in v2.0b
	output	 	[7:0]		S,						// added in v2.0b
	output		[6:0]		Bm_cnt,					// added in v2.0b
	output   	[8:0]  	    rd_addr,				// added in v2.0b
	output					Data_O_vld,				// added in v2.0b
	output					Data_O_vld1,	        // add for ip mem question
	output		[8:0]		wr_addr,				// added in v2.0b
	input					Data_I_vld,				// added in v2.0b
	// input					Data_I_vld_ECG,
	
	// Output between Mem_Ctrl and Weight_Buffer	// added in v2.0b
	output	 				wt_I_vld,				// added in 2.0simple
	output	 	[13:0]		wt_I_addr,				// added in 2.0simple
	output	 	[13:0]		wt_C0_addr, wt_C1_addr, wt_C2_addr, wt_C3_addr,
						    wt_C4_addr, wt_C5_addr, wt_C6_addr, wt_C7_addr,
							
	output	 				wt_C0_O_vld, wt_C0_O_vld1, wt_C1_O_vld, wt_C2_O_vld,
						    wt_C3_O_vld, wt_C4_O_vld, wt_C5_O_vld,
						    wt_C6_O_vld, wt_C7_O_vld,
	
	// Signals between Mem_Ctrl and R&P
	output		[3:0]		Pool_K,					// Pooling size of this layer		added in 2.0simple
	output		[2:0]		Pool_S,					// Pooling stride of this layer		added in 2.0simple
	output					final_column,			// added in v2.0b
    output                  final_ftNchange_flag,
	output		[2:0]		final_zeros,			// added in v2.0b
	output		[3:0]		ft_N_cnt,
	
	// Signals for transaction of input feature map
	// output	[`DDR_DW-1:0]	ft_ecg_rddata,
	// output					ft_ecg_vld,
	
	// Signals for transaction of weights
	// output	[`DDR_DW-1:0]	ft_wt_rddata,			// weights of current layer
	// output					ft_wt_vld, 
	output		[3:0]		nn_layer_cnt,
  
        output                            w_half_end ,                 //sf add  zero padding
        output                            zero_padd_enable ,
        output          [9:0]             omap_addr_span_cnt

       
);
			
		//wire	[7:0]		mc_cs;
		wire	[7:0]		mc_ns;
		// wire [5:0]		or_cs;
		wire	[5:0]		or_ns;
		wire				ft_lyr_param_done;
		wire				ft_wt_done;
		wire				ft_ecg_done;
		wire				memct_init_cmplt;
			
		wire	[11:0]		ecg_len;
		wire	[3:0]		ecg_leads;
		wire	[7:0]		ft_Nt_cnt;
		// wire [3:0]		nn_layer_cnt;
			
		wire  [`DDR_AW:1]	nn_ecg_saddr;
		wire  [`DDR_AW:1]	nn_wt_saddr;
		wire  [`DDR_AW:1]	nn_lyr_param_saddr;
			
		// wire				rd_lyr_done;				// added in v2.0b
		// wire				wr_lyr_done;				// added in v2.0b
		wire 				lyr_cal_done;			// added in v2.0b
		
               

                

	SPU_ECG cfg_SPU_ECG(
			.clk_cal            	( clk_cal				),
			.rst_cal_n              ( rst_cal_n				),
			.SPI_start				( SPI_start				),
			// .SPI_done				( SPI_done				),
			.ft_lyr_param_done		( ft_lyr_param_done		),
			.ft_wt_done				( ft_wt_done			),
			.ft_ecg_done			( ft_ecg_done			),
			.memct_init_cmplt		( memct_init_cmplt		),
			.mc_cs                	( mc_cs					),
			.mc_ns                	( mc_ns					),
			.or_cs                	( or_cs					),
			.or_ns                	( or_ns					),
			.nn_layer_cnt			( nn_layer_cnt			),
			.ecg_len				( ecg_len				),
			.nn_ecg_saddr			( nn_ecg_saddr			),
			.nn_wt_saddr			( nn_wt_saddr			),
			.nn_lyr_param_saddr		( nn_lyr_param_saddr	),
			.lyr_cal_done			( lyr_cal_done			)		
		) ;


	Mem_Ctrl cfg_Mem_Ctrl(
			.clk_cal            	( clk_cal		        ),
			.rst_cal_n          	( rst_cal_n				),
			.mc_cs                	( mc_cs					),
			.mc_ns                	( mc_ns					),
			.or_cs                	( or_cs					),
			.or_ns                	( or_ns					),
			.memct_init_cmplt		( memct_init_cmplt		),
			.nn_layer_cnt			( nn_layer_cnt			),
			.ecg_len				( ecg_len				),
			.pe_end					( pe_end				),		// added in v2.0b
			.rd_done				( rd_done				),		// added in v2.0b
			.cal_cycle				( cal_cycle				),		// added in v2.0b
			.pass_cycle				( pass_cycle			),		// added in v2.0b
			.K						( K          		    ),		// added in v2.0b
			.S						( S          		    ),		// added in v2.0b
			.Bm_cnt					( Bm_cnt				),		// added in v2.0b
			.rd_addr				( rd_addr				),		// added in v2.0b
			.Data_O_vld				( Data_O_vld			),		// added in v2.0b
			.Data_O_vld1			( Data_O_vld1			),
			.wr_addr				( wr_addr				),		// added in v2.0b
			.Data_I_vld				( Data_I_vld			),		// added in v2.0b
			// .Data_I_vld_ECG			( Data_I_vld_ECG		),
			.wt_I_vld				( wt_I_vld				),
			.wt_I_addr				( wt_I_addr				),
			.wt_C0_addr				( wt_C0_addr			),		// added in v2.0b
			.wt_C1_addr				( wt_C1_addr			),		// added in v2.0b
			.wt_C2_addr				( wt_C2_addr			),		// added in v2.0b
			.wt_C3_addr				( wt_C3_addr			),		// added in v2.0b
			.wt_C4_addr				( wt_C4_addr			),		// added in v2.0b
			.wt_C5_addr				( wt_C5_addr			),		// added in v2.0b
			.wt_C6_addr				( wt_C6_addr			),		// added in v2.0b
			.wt_C7_addr				( wt_C7_addr			),		// added in v2.0b
			.wt_C0_O_vld			( wt_C0_O_vld			),		// added in v2.0b
			.wt_C0_O_vld1			( wt_C0_O_vld1			),
			.wt_C1_O_vld			( wt_C1_O_vld			),		// added in v2.0b
			.wt_C2_O_vld			( wt_C2_O_vld			),		// added in v2.0b
			.wt_C3_O_vld			( wt_C3_O_vld			),		// added in v2.0b
			.wt_C4_O_vld			( wt_C4_O_vld			),		// added in v2.0b
			.wt_C5_O_vld			( wt_C5_O_vld			),		// added in v2.0b
			.wt_C6_O_vld			( wt_C6_O_vld			),		// added in v2.0b
			.wt_C7_O_vld			( wt_C7_O_vld			),		// added in v2.0b
			.Pool_K					( Pool_K				),		// added in v2.0b
			.Pool_S					( Pool_S				),		// added in v2.0b
            .Relu_max               ( Relu_max              ),      // added in ECG_Test_v2
			.final_ftNchange_flag	( final_ftNchange_flag	),		// added in v2.0b
            .final_column           ( final_column          ),
			.final_zeros			( final_zeros			),		// added in v2.0b
			.ft_N_cnt				( ft_N_cnt				),		// added in v2.0b
			// .ft_wt_rddata			( ft_wt_rddata			),
			// .ft_wt_vld				( ft_wt_vld				),
			.nn_lyr_param_saddr		( nn_lyr_param_saddr	),
			.nn_wt_saddr			( nn_wt_saddr			),
			.ft_lyr_param_done		( ft_lyr_param_done		),
			.ft_ecg_done			( ft_ecg_done			),
			.ft_wt_done				( ft_wt_done			),
			.lyr_cal_done			( lyr_cal_done			),	// added in v2.0b
                        .w_half_end                     ( w_half_end                     ),
                        .zero_padd_enable               (zero_padd_enable                 ),      // sf add 
                        .omap_addr_span_cnt             (omap_addr_span_cnt               )
		);

endmodule
