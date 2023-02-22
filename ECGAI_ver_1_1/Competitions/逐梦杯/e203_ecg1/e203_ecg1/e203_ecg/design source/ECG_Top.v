// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : ACC_Top.v
// @Module Name  : ACC_Top
// @Created Time : 2020-05-18 15:54
//
// @Abstract     : This module is accelerator top file for test
//               
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-05-18  	Huangjunguang      v1.0          initial version 
// 2020-06-03	Huangjunguang      v2.0		     add 3 buffers output vld
// ******************************************************************************
`timescale 1ns / 1ns
`define DDR_DW			64
`define DDR_AW			32
`define	burst_len		128
`define	transfer_size	64
`define	wt_bw			8
`define	ecg_bw			8
`define byte_width 8
`define halfword_width 16
`define eightbyte_width 64

module ECG_Top(
				//======================================================================================
					input					clk_cal, 					//accelerator clk
					input					rst_cal_n,					//accelerator rst
				//======================================================================================	
					// I/O ports of mcu
					input					SPI_start,
					// input					SPI_done,								

					// input					Data_I_vld_ECG,
					// input	signed	[7:0]	Data_I0_ECG, Data_I1_ECG, Data_I2_ECG, Data_I3_ECG, Data_I4_ECG, Data_I5_ECG, Data_I6_ECG, Data_I7_ECG,
					output  [7:0]			FC_OMap1,
					output  [3:0]			nn_layer_cnt,
					output					FC_OVld
			);
 	//====================================================================== Configurator ==========================================================================
	// Signals between Mem_Ctrl and PE_Array
	// wire							pe_end;					// added in v2.0b
	wire							rd_done;				// added in v2.0b
	wire			[10:0]			cal_cycle;				// added in v2.0b
	wire			[10:0]			pass_cycle;	
	// Signals among Mem_Ctrl and Input_Regfile and InOutBuffer
	wire			[7:0]			K;						// added in v2.0b
	wire			[7:0]			S;						// added in v2.0b
	wire			[6:0]			Bm_cnt;					// added in v2.0b
	wire   			[8:0]  		rd_addr;				// added in v2.0b
	wire							Data_O_vld;				// added in v2.0b
	wire							Mem_Data_Ivld,Mem_Data_Ivld1;			//new!!!!!6.2
	wire			[8:0]			wr_addr;				// added in v2.0b
	
	// Output between Mem_Ctrl and Weight_Buffer	// added in v2.0b
	wire			[13:0]			wt_I_addr;					// data from memory_contrller       sf add 11bit->12bit
	wire							wt_I_vld;					// data valid signal from memory contrller	
	wire			[13:0]			wt_C0_addr, wt_C1_addr, wt_C2_addr, wt_C3_addr,
									wt_C4_addr, wt_C5_addr, wt_C6_addr, wt_C7_addr;

	wire	 						wt_C0_O_vld, wt_C0_O_vld1,wt_C1_O_vld, wt_C2_O_vld,
									wt_C3_O_vld, wt_C4_O_vld, wt_C5_O_vld,
									wt_C6_O_vld, wt_C7_O_vld;
	// Signals with output regfile
	wire			[3:0]			Pool_K;					// Pooling size of this layer
	wire			[2:0]			Pool_S;					// Pooling stride of this layer
    wire            [1:0]           Relu_max;               // max value of relu of this layer, added in ECG_Test_v2
	wire			[3:0]			ft_N_cnt;
	wire			[5:0]			or_cs;
    wire            [7:0]           mc_cs;
	// Signals between Mem_Ctrl and R&P
	wire							final_column;	// added in v2.0b
    wire                            final_ftNchange_flag;
	wire			[2:0]			final_zeros;	// added in v2.0b
	
	// Signals for transaction of input feature map
	// wire			[`DDR_DW:1]		ft_ecg_rddata;
	// wire							ft_ecg_vld;
	
	// Signals for transaction of weights
	// wire			[`DDR_DW:1]		ft_wt_rddata;	// weights of current layer
	// wire							ft_wt_vld;
	
	//FCOvld & RPOvld
	wire 							Out_vld;
	
	//====================================================================== InOut Buffer ========================================================================
	// Signals from Memory controller
	// wire			[3:0]			nn_layer_cnt;				//	Current layer index
	
	// Signals with Input_Regfile or SPI
	wire							IOB_Data_O_vld;
	wire	 	 	[7:0]			IOB_Data_O0, IOB_Data_O1, IOB_Data_O2, IOB_Data_O3, IOB_Data_O4, IOB_Data_O5, IOB_Data_O6, IOB_Data_O7;
	
	//===================================================================== Input_Regfile ==========================================================================
	// Signals with PE_Array
	wire							pe_end;
	wire			[7:0]			IR_Data_O0, IR_Data_O1, IR_Data_O2, IR_Data_O3, IR_Data_O4, IR_Data_O5, IR_Data_O6, IR_Data_O7, 
									IR_Data_O8, IR_Data_O9, IR_Data_Oa, IR_Data_Ob, IR_Data_Oc, IR_Data_Od, IR_Data_Oe, IR_Data_Of;
	wire							IR_Data_O_vld; 

	//====================================================================== Weight Buffer ========================================================================	
	// Read Signals to PE
	wire							wt_Ovld0, wt_Ovld1, wt_Ovld2, wt_Ovld3,
									wt_Ovld4, wt_Ovld5, wt_Ovld6, wt_Ovld7;
	wire 		 	[7:0] 			weight_data_O0, weight_data_O1, weight_data_O2, weight_data_O3, 
									weight_data_O4, weight_data_O5, weight_data_O6, weight_data_O7;	

									
	//======================================================================  PE Array ============================================================================							
	// Signals with Output Regfile
	wire 		 	[`halfword_width-1:0] 			PE_OMap1, PE_OMap2, PE_OMap3, PE_OMap4, 
									PE_OMap5, PE_OMap6, PE_OMap7, PE_OMap8;
	wire							PE_OMapVld1, PE_OMapVld2, PE_OMapVld3, PE_OMapVld4,
									PE_OMapVld5, PE_OMapVld6, PE_OMapVld7, PE_OMapVld8;
	// Signals with IOB(FC)
	wire			[7:0]			FC_OMap2,FC_OMap3,FC_OMap4,
									FC_OMap5,FC_OMap6,FC_OMap7,FC_OMap8;	
	// wire							FC_OVld;

	//======================================================================  Relu ================================================================================
	wire			[`byte_width-1:0]	Relu_Dout1,Relu_Dout2,Relu_Dout3,Relu_Dout4,
							Relu_Dout5,Relu_Dout6,Relu_Dout7,Relu_Dout8;
	wire						Relu_Dout_vld1,Relu_Dout_vld2,Relu_Dout_vld3,Relu_Dout_vld4,
							Relu_Dout_vld5,Relu_Dout_vld6,Relu_Dout_vld7,Relu_Dout_vld8;

	//====================================================================== Output_Regfile =======================================================================	
	wire	 		[`eightbyte_width-1:0]		ORegfile_OData1, ORegfile_OData2, ORegfile_OData3, ORegfile_OData4, 
								ORegfile_OData5, ORegfile_OData6, ORegfile_OData7, ORegfile_OData8;
	wire							ORegfile_OData_vld1, ORegfile_OData_vld2, ORegfile_OData_vld3, ORegfile_OData_vld4,
								ORegfile_OData_vld5, ORegfile_OData_vld6, ORegfile_OData_vld7, ORegfile_OData_vld8;

	//====================================================================== Pooling =========================================================================	    
	wire                        Pool_OData_vld1,Pool_OData_vld2,Pool_OData_vld3,Pool_OData_vld4,
		                        Pool_OData_vld5,Pool_OData_vld6,Pool_OData_vld7,Pool_OData_vld8;
    wire  [`byte_width-1:0]     Pool_OData1,Pool_OData2,Pool_OData3,Pool_OData4,
	                            Pool_OData5,Pool_OData6,Pool_OData7,Pool_OData8;

	//====================================================================== Pool2IOB =========================================================================	
	wire 		    [7:0] 		RP_OData1, RP_OData2, RP_OData3, RP_OData4,
								RP_OData5, RP_OData6, RP_OData7, RP_OData8;
	wire						RP_OVld;
    reg                         lyr_end;
    reg                         lyr_end1;
       //==================================================sf add============================================================/
     wire  w_half_end;
   
     wire   [9:0] omap_addr_span_cnt;
     


      // layer7 cut
      wire     layer7_cut1_enable,layer7_cut2_enable,layer7_cut3_enable,layer7_cut4_enable ,layer7_cut5_enable ,layer7_cut6_enable ,layer7_cut7_enable ,layer7_cut8_enable   ;                 
								
	assign Out_vld = (nn_layer_cnt<=4'd7)?RP_OVld:FC_OVld;
    always@(posedge clk_cal) begin
        lyr_end1 <= mc_cs[4];
        lyr_end  <= lyr_end1;
    end
	//============================================================================================================================================================
	Configurator
		u_configurator(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						// I/O ports of mcu
						.SPI_start				( SPI_start				),
						// .SPI_done				( SPI_done				),
						.or_cs					( or_cs					),
                        .mc_cs                  ( mc_cs                 ),
						// Signals between Mem_Ctrl and PE_Array
						.pe_end					( pe_end				),		// added in v2.0b
						.rd_done				( rd_done				),		// added in v2.0b
						.cal_cycle				( cal_cycle				),		// added in v2.0b
						.pass_cycle				( pass_cycle			),		// added in v2.0b
						// Signals among Mem_Ctrl and Input_Regfile and InOutBuffer
						.K						( K          			),		// added in v2.0b
						.S						( S          		    ),		// added in v2.0b
						.Bm_cnt					( Bm_cnt				),		// added in v2.0b
						.rd_addr				( rd_addr				),		// added in v2.0b
						.Data_O_vld				( Mem_Data_Ivld			),		// added in v2.0b
						.Data_O_vld1			( Mem_Data_Ivld1		),
						.wr_addr				( wr_addr				),		// added in v2.0b
						.Data_I_vld				( Out_vld				),		// added in v2.0b
						// .Data_I_vld_ECG			( Data_I_vld_ECG		),
						// Signals between Mem_Ctrl and Weight_Buffer
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
						// Signals with output regfile
						.Pool_K					( Pool_K				),		// added in v2.0b
						.Pool_S					( Pool_S				),		// added in v2.0b
                        .Relu_max               ( Relu_max              ),      // added in ECG_Test_v2
						.ft_N_cnt				( ft_N_cnt				),
						// Signals between Mem_Ctrl and R&P
    			        .final_ftNchange_flag	( final_ftNchange_flag	),		// added in v2.0b
						.final_column			( final_column			),		// added in v2.0b
						.final_zeros			( final_zeros			),		// added in v2.0b
						// Signals for transaction of input feature map
						// .ft_ecg_rddata			( ft_ecg_rddata			),
						// .ft_ecg_vld				( ft_ecg_vld			),
						// Signals for transaction of weights
						// .ft_wt_rddata			( ft_wt_rddata			),
						// .ft_wt_vld				( ft_wt_vld				),
						.nn_layer_cnt			( nn_layer_cnt			),
                                                .w_half_end                     (w_half_end                     ),   //sf add
                                                .zero_padd_enable               (zero_padd_enable               ),    //sf add
                                                .omap_addr_span_cnt             (omap_addr_span_cnt             )   //sf add
                                            
                                               
					);
	//============================================================================================================================================================
	In_Out_Buffer
		u_inout_buffer(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						// Signals from Memory controller
						.nn_layer_cnt           ( nn_layer_cnt	        ),
						.wr_addr                ( wr_addr               ),
						.rd_addr            	( rd_addr            	),
						// .SPI_start				( SPI_start				),
						.Mem_Data_Ivld			( Mem_Data_Ivld			),
						.Mem_Data_Ivld1			( Mem_Data_Ivld1		),
						// Signals with Input_Regfile
						.IOB_Data_O_vld         ( IOB_Data_O_vld        ),
						.IOB_Data_O0            ( IOB_Data_O0           ),
						.IOB_Data_O1            ( IOB_Data_O1           ),
						.IOB_Data_O2            ( IOB_Data_O2           ),
						.IOB_Data_O3            ( IOB_Data_O3           ),
						.IOB_Data_O4            ( IOB_Data_O4           ),
						.IOB_Data_O5            ( IOB_Data_O5           ),
						.IOB_Data_O6            ( IOB_Data_O6           ),
						.IOB_Data_O7            ( IOB_Data_O7           ),
						// Signals with R&P
						.IOB_Data_I_vld         ( RP_OVld				),
						.IOB_Data_I0            ( RP_OData1             ),
						.IOB_Data_I1            ( RP_OData2             ),
						.IOB_Data_I2            ( RP_OData3             ),
						.IOB_Data_I3            ( RP_OData4             ),
						.IOB_Data_I4            ( RP_OData5             ),
						.IOB_Data_I5            ( RP_OData6             ),
						.IOB_Data_I6            ( RP_OData7             ),
						.IOB_Data_I7            ( RP_OData8             ),
						// Signals with FC
						.IOB_FC_I0				( FC_OMap1				),
						.IOB_FC_I1				( FC_OMap2				),
						.IOB_FC_I2				( FC_OMap3				),
						.IOB_FC_I3				( FC_OMap4				),
						.IOB_FC_I4				( FC_OMap5				),
						.IOB_FC_I5				( FC_OMap6				),
						.IOB_FC_I6				( FC_OMap7				),
						.IOB_FC_I7				( FC_OMap8				),
						.IOB_FC_vld				( FC_OVld				),
						// Signals with ECG in
						// .IOB_Data_I_vld_ECG     ( Data_I_vld_ECG        ),
						// .IOB_Data_I0_ECG        ( Data_I0_ECG           ),
						// .IOB_Data_I1_ECG        ( Data_I1_ECG           ),
						// .IOB_Data_I2_ECG        ( Data_I2_ECG           ),
						// .IOB_Data_I3_ECG        ( Data_I3_ECG           ),
						// .IOB_Data_I4_ECG        ( Data_I4_ECG           ),
						// .IOB_Data_I5_ECG        ( Data_I5_ECG           ),
						// .IOB_Data_I6_ECG        ( Data_I6_ECG           ),
						// .IOB_Data_I7_ECG        ( Data_I7_ECG           ),
                        .omap_addr_span_cnt     (omap_addr_span_cnt     )       //sf add	
                                                      		
					);	
	//============================================================================================================================================================
	Input_Regfile
		u_input_regfile(
						.clk_cal            	( clk_cal				),
						.rst_cal_n              ( rst_cal_n				),
						.nn_layer_cnt           ( nn_layer_cnt	        ),
						.K						( K          			),
						.S						( S						),
						// Signals with In_Out_buffer
						.IR_Data_I_vld          ( IOB_Data_O_vld        ),
						.IR_Data_I0            	( IOB_Data_O0           ),
						.IR_Data_I1            	( IOB_Data_O1           ),
						.IR_Data_I2            	( IOB_Data_O2           ),
						.IR_Data_I3            	( IOB_Data_O3           ),
						.IR_Data_I4            	( IOB_Data_O4           ),
						.IR_Data_I5            	( IOB_Data_O5           ),
						.IR_Data_I6            	( IOB_Data_O6           ),
						.IR_Data_I7            	( IOB_Data_O7           ),
						.Bm_cnt_in				( Bm_cnt				),
                                  							
						// Signals with PE_Array
						.pe_end					( pe_end				),	
						.IR_Data_O_vld          ( IR_Data_O_vld	        ),	
						.IR_Data_O0            	( IR_Data_O0           	),
						.IR_Data_O1            	( IR_Data_O1            ),
						.IR_Data_O2            	( IR_Data_O2            ),
						.IR_Data_O3            	( IR_Data_O3            ),
						.IR_Data_O4            	( IR_Data_O4            ),
						.IR_Data_O5            	( IR_Data_O5            ),
						.IR_Data_O6            	( IR_Data_O6            ),
						.IR_Data_O7            	( IR_Data_O7            ),	
						.IR_Data_O8            	( IR_Data_O8            ),
						.IR_Data_O9            	( IR_Data_O9            ),
						.IR_Data_Oa            	( IR_Data_Oa            ),
						.IR_Data_Ob            	( IR_Data_Ob            ),
						.IR_Data_Oc            	( IR_Data_Oc            ),
						.IR_Data_Od            	( IR_Data_Od            ),
						.IR_Data_Oe            	( IR_Data_Oe            ),
						.IR_Data_Of            	( IR_Data_Of            ),	
						// Signals with Mem_Ctrl weight address generator
						.Weight_Data_Ovld		( wt_C0_O_vld1			)
					);
	
	
	//============================================================================================================================================================
	Weight_buffer
		u_weight_buffer(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						
						.layer2weight_cnt		( nn_layer_cnt			),
						// Signal from Mem_Ctrl
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
						.wt_C1_O_vld			( wt_C1_O_vld			),		// added in v2.0b
						.wt_C2_O_vld			( wt_C2_O_vld			),		// added in v2.0b
						.wt_C3_O_vld			( wt_C3_O_vld			),		// added in v2.0b
						.wt_C4_O_vld			( wt_C4_O_vld			),		// added in v2.0b
						.wt_C5_O_vld			( wt_C5_O_vld			),		// added in v2.0b
						.wt_C6_O_vld			( wt_C6_O_vld			),		// added in v2.0b
						.wt_C7_O_vld			( wt_C7_O_vld			),		// added in v2.0b					
						// Read Signals
						.wt_Ovld0				( wt_Ovld0				),		// added in v2.0b
						.wt_Ovld1				( wt_Ovld1				),		// added in v2.0b
						.wt_Ovld2				( wt_Ovld2				),		// added in v2.0b
						.wt_Ovld3				( wt_Ovld3				),		// added in v2.0b
						.wt_Ovld4				( wt_Ovld4				),		// added in v2.0b
						.wt_Ovld5				( wt_Ovld5				),		// added in v2.0b
						.wt_Ovld6				( wt_Ovld6				),		// added in v2.0b
						.wt_Ovld7				( wt_Ovld7				),		// added in v2.0b	
						.kernel_C0_O			( weight_data_O0		),
						.kernel_C1_O			( weight_data_O1		),
						.kernel_C2_O			( weight_data_O2		),
						.kernel_C3_O			( weight_data_O3		),
						.kernel_C4_O			( weight_data_O4		),
						.kernel_C5_O			( weight_data_O5		),
						.kernel_C6_O			( weight_data_O6		),
						.kernel_C7_O			( weight_data_O7		)
					);
		
	//============================================================================================================================================================
	PEarray16_8
		u_pearray16_8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						//Signals with cfg
						.or_cs			( or_cs			),
						.nn_layer_cnt           ( nn_layer_cnt	        ),
						.rd_done              	( rd_done               ),
						.Calcycle               ( cal_cycle             ),
						.pass_cycle		( pass_cycle			),
						//Signals with Input_Regfile
						.IMap1               	( IR_Data_O0            ),
						.IMap2               	( IR_Data_O1            ),
						.IMap3               	( IR_Data_O2            ),
						.IMap4               	( IR_Data_O3            ),
						.IMap5               	( IR_Data_O4            ),
						.IMap6               	( IR_Data_O5            ),
						.IMap7               	( IR_Data_O6            ),
						.IMap8               	( IR_Data_O7            ),
						.IMap9               	( IR_Data_O8            ),
						.IMap10               	( IR_Data_O9            ),
						.IMap11               	( IR_Data_Oa            ),
						.IMap12               	( IR_Data_Ob            ),
						.IMap13               	( IR_Data_Oc            ),
						.IMap14               	( IR_Data_Od            ),
						.IMap15               	( IR_Data_Oe            ),
						.IMap16               	( IR_Data_Of            ),
						.ImapVld				( IR_Data_O_vld			),
						//Signals with Weight buffer
						.IWeight1               ( weight_data_O0        ),
						.IWeight2               ( weight_data_O1        ),
						.IWeight3               ( weight_data_O2        ),
						.IWeight4               ( weight_data_O3        ),
						.IWeight5               ( weight_data_O4        ),
						.IWeight6               ( weight_data_O5        ),
						.IWeight7               ( weight_data_O6        ),
						.IWeight8               ( weight_data_O7        ),	
						.IweightVld1			( wt_Ovld0				),		// added in v2.0b
						.IweightVld2			( wt_Ovld1				),		// added in v2.0b
						.IweightVld3			( wt_Ovld2				),		// added in v2.0b
						.IweightVld4			( wt_Ovld3				),		// added in v2.0b
						.IweightVld5			( wt_Ovld4				),		// added in v2.0b
						.IweightVld6			( wt_Ovld5				),		// added in v2.0b
						.IweightVld7			( wt_Ovld6				),		// added in v2.0b
						.IweightVld8			( wt_Ovld7				),		// added in v2.0b							
						//Signals with Output Regfile
						.PE_OMap1				( PE_OMap1				),
						.PE_OMap2				( PE_OMap2				),
						.PE_OMap3				( PE_OMap3				),
						.PE_OMap4				( PE_OMap4				),
						.PE_OMap5				( PE_OMap5				),
						.PE_OMap6				( PE_OMap6				),
						.PE_OMap7				( PE_OMap7				),
						.PE_OMap8				( PE_OMap8				),
						.PE_OMapVld1			( PE_OMapVld1			),
						.PE_OMapVld2			( PE_OMapVld2			),
						.PE_OMapVld3			( PE_OMapVld3			),
						.PE_OMapVld4			( PE_OMapVld4			),
						.PE_OMapVld5			( PE_OMapVld5			),
						.PE_OMapVld6			( PE_OMapVld6			),
						.PE_OMapVld7			( PE_OMapVld7			),
						.PE_OMapVld8			( PE_OMapVld8			),
						.PE_end					( pe_end				),
						//FC
						.FC_OMap1				( FC_OMap1				),
						.FC_OMap2				( FC_OMap2				),
						.FC_OMap3				( FC_OMap3				),
						.FC_OMap4				( FC_OMap4				),
						.FC_OMap5				( FC_OMap5				),
						.FC_OMap6				( FC_OMap6				),
						.FC_OMap7				( FC_OMap7				),
						.FC_OMap8				( FC_OMap8				),
						.FC_OVld				( FC_OVld				)
					);

	//============================================================================================================================================================
	Relu8
		u_relu8(
						// .clk_cal            	( clk_cal            	),
						//.nn_layer_cnt           ( nn_layer_cnt	        ),
						.Relu_Din1				(PE_OMap1),
						.Relu_Din2				(PE_OMap2),
						.Relu_Din3				(PE_OMap3),	
						.Relu_Din4				(PE_OMap4),
						.Relu_Din5				(PE_OMap5),
						.Relu_Din6				(PE_OMap6),
						.Relu_Din7				(PE_OMap7),	
						.Relu_Din8				(PE_OMap8),	
						.Relu_Din_vld1				(PE_OMapVld1),
						.Relu_Din_vld2				(PE_OMapVld2),
						.Relu_Din_vld3				(PE_OMapVld3),
						.Relu_Din_vld4				(PE_OMapVld4),
						.Relu_Din_vld5				(PE_OMapVld5),
						.Relu_Din_vld6				(PE_OMapVld6),
						.Relu_Din_vld7				(PE_OMapVld7),
						.Relu_Din_vld8				(PE_OMapVld8),
						.Relu_max				(Relu_max[1]),
						.Relu_Dout1				(Relu_Dout1),
						.Relu_Dout2				(Relu_Dout2),
						.Relu_Dout3				(Relu_Dout3),
						.Relu_Dout4				(Relu_Dout4),
						.Relu_Dout5				(Relu_Dout5),
						.Relu_Dout6				(Relu_Dout6),
						.Relu_Dout7				(Relu_Dout7),
						.Relu_Dout8				(Relu_Dout8),
						.Relu_Dout_vld1				(Relu_Dout_vld1),
						.Relu_Dout_vld2				(Relu_Dout_vld2),
						.Relu_Dout_vld3				(Relu_Dout_vld3),
						.Relu_Dout_vld4				(Relu_Dout_vld4),
						.Relu_Dout_vld5				(Relu_Dout_vld5),
						.Relu_Dout_vld6				(Relu_Dout_vld6),
						.Relu_Dout_vld7				(Relu_Dout_vld7),
						.Relu_Dout_vld8				(Relu_Dout_vld8)
			);	


	//============================================================================================================================================================
	Output_regfile8_9 
		u_output_regfile72(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						
						.P						( Pool_K				), 
						.S						( Pool_S				),
						// .nn_layer_cnt 			( nn_layer_cnt			),
						.ft_N_cnt				( ft_N_cnt				),
						.or_cs					( or_cs					),
						
						.ORegfile_IData1        (Relu_Dout1		),
						.ORegfile_IData2        (Relu_Dout2		),
						.ORegfile_IData3        (Relu_Dout3		),
						.ORegfile_IData4        (Relu_Dout4		),
						.ORegfile_IData5        (Relu_Dout5		),
						.ORegfile_IData6        (Relu_Dout6		),
						.ORegfile_IData7        (Relu_Dout7		),
						.ORegfile_IData8        (Relu_Dout8	        ),
						.ORegfile_IData_vld1	(Relu_Dout_vld1		),
						.ORegfile_IData_vld2	(Relu_Dout_vld2		),
						.ORegfile_IData_vld3	(Relu_Dout_vld3		),
						.ORegfile_IData_vld4	(Relu_Dout_vld4		),
						.ORegfile_IData_vld5	(Relu_Dout_vld5		),
						.ORegfile_IData_vld6	(Relu_Dout_vld6		),
						.ORegfile_IData_vld7	(Relu_Dout_vld7		),
						.ORegfile_IData_vld8	(Relu_Dout_vld8		),


						.ORegfile_OData1		( ORegfile_OData1		),
						.ORegfile_OData2		( ORegfile_OData2		),
						.ORegfile_OData3		( ORegfile_OData3		),
						.ORegfile_OData4		( ORegfile_OData4		),
						.ORegfile_OData5		( ORegfile_OData5		),
						.ORegfile_OData6		( ORegfile_OData6		),
						.ORegfile_OData7		( ORegfile_OData7		),
						.ORegfile_OData8		( ORegfile_OData8		),
						.ORegfile_OData_vld1	( ORegfile_OData_vld1	),
						.ORegfile_OData_vld2	( ORegfile_OData_vld2	),
						.ORegfile_OData_vld3	( ORegfile_OData_vld3	),
						.ORegfile_OData_vld4	( ORegfile_OData_vld4	),
						.ORegfile_OData_vld5	( ORegfile_OData_vld5	),
						.ORegfile_OData_vld6	( ORegfile_OData_vld6	),
						.ORegfile_OData_vld7	( ORegfile_OData_vld7	),
						.ORegfile_OData_vld8	( ORegfile_OData_vld8	)
					);
    //============================================================================================================================================================
    Pooling8 
        u_pooling8(
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						.P						( Pool_K				), 
						.Pool_IData1			( ORegfile_OData1		),
						.Pool_IData2			( ORegfile_OData2		),
						.Pool_IData3			( ORegfile_OData3		),
						.Pool_IData4			( ORegfile_OData4		),
						.Pool_IData5			( ORegfile_OData5		),
						.Pool_IData6			( ORegfile_OData6		),
						.Pool_IData7			( ORegfile_OData7		),
						.Pool_IData8			( ORegfile_OData8		),	
						.Pool_IData_vld1		( ORegfile_OData_vld1	),
						.Pool_IData_vld2		( ORegfile_OData_vld2	),
						.Pool_IData_vld3		( ORegfile_OData_vld3	),
						.Pool_IData_vld4		( ORegfile_OData_vld4	),
						.Pool_IData_vld5		( ORegfile_OData_vld5	),
						.Pool_IData_vld6		( ORegfile_OData_vld6	),
						.Pool_IData_vld7		( ORegfile_OData_vld7	),
						.Pool_IData_vld8		( ORegfile_OData_vld8	),		
						.Pool_OData1			( Pool_OData1		),
						.Pool_OData2			( Pool_OData2		),
						.Pool_OData3			( Pool_OData3		),
						.Pool_OData4			( Pool_OData4		),
						.Pool_OData5			( Pool_OData5		),
						.Pool_OData6			( Pool_OData6		),
						.Pool_OData7			( Pool_OData7		),
						.Pool_OData8			( Pool_OData8		),	
						.Pool_OData_vld1		( Pool_OData_vld1	),
						.Pool_OData_vld2		( Pool_OData_vld2	),
						.Pool_OData_vld3		( Pool_OData_vld3	),
						.Pool_OData_vld4		( Pool_OData_vld4	),
						.Pool_OData_vld5		( Pool_OData_vld5	),
						.Pool_OData_vld6		( Pool_OData_vld6	),
						.Pool_OData_vld7		( Pool_OData_vld7	),
						.Pool_OData_vld8		( Pool_OData_vld8	)
                                               // .nn_layer_cnt                   (nn_layer_cnt           )
	            );
	//============================================================================================================================================================
	Pool2IOB 
		u_pool2iob72(                  
						.clk_cal            	( clk_cal            	),
						.rst_cal_n              ( rst_cal_n             ),
						.N8_cnt				    ( ft_N_cnt				),
						.final_column			( final_column			),
                        .final_ftNchange_flag	( final_ftNchange_flag	),	
                        .lyr_end                ( lyr_end               ),
						.RP_IData1				( Pool_OData1		    ),
						.RP_IData2				( Pool_OData2	    	),
						.RP_IData3				( Pool_OData3	    	),
						.RP_IData4				( Pool_OData4	    	),
						.RP_IData5				( Pool_OData5	    	),
						.RP_IData6				( Pool_OData6	    	),
						.RP_IData7				( Pool_OData7	    	),
						.RP_IData8				( Pool_OData8	    	),	
						.RP_IData_vld1			( Pool_OData_vld1   	),
						.RP_IData_vld2			( Pool_OData_vld2   	),
						.RP_IData_vld3			( Pool_OData_vld3   	),
						.RP_IData_vld4			( Pool_OData_vld4   	),
						.RP_IData_vld5			( Pool_OData_vld5   	),
						.RP_IData_vld6			( Pool_OData_vld6   	),
						.RP_IData_vld7			( Pool_OData_vld7   	),
						.RP_IData_vld8			( Pool_OData_vld8	    ),						
						.RP_OData1				( RP_OData1				),
						.RP_OData2				( RP_OData2				),
						.RP_OData3				( RP_OData3				),
						.RP_OData4				( RP_OData4				),
						.RP_OData5				( RP_OData5				),
						.RP_OData6				( RP_OData6				),
						.RP_OData7				( RP_OData7				),
						.RP_OData8				( RP_OData8				),
						.RP_OVld				( RP_OVld				),
                                                .w_half_end                             (w_half_end                             ),    // sf add
                                                .zero_padd_enable                       (zero_padd_enable                       ),   // sf add
                                                .nn_layer_cnt                           (nn_layer_cnt           )  // sf add
					);	

endmodule
