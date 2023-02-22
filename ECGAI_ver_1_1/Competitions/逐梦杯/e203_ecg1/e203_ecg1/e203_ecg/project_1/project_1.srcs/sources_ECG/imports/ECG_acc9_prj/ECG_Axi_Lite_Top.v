
`timescale 1 ns / 1 ps

	module ECG_Axi_Lite_Top #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 5
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
	
	
	wire				SPI_start;
	wire   [7:0]		FC_OMap1;
	wire   [3:0]		nn_layer_cnt;
	wire				FC_OVld;	
	wire   [7:0]       weight_data_O0;
	wire   [13:0]      wt_I_addr_sf;
	
	wire   [7:0]       read1,read2;
	wire   [8:0]		wr_addr_sf;
    wire   [7:0]       IOB_Data_O0_sf;
    wire   [7:0]      IOB_Data_O1_sf;
    wire   [13:0]     wt_C0_addr_sf;
    wire   [13:0]     wt_C1_addr_sf;
    wire   [8:0]      rd_addr_sf;
    wire   [7:0]      weight_data_O1;
    wire              SPI_start_temp;
 /*   wire [7:0] sf_addr_reg0;
    wire [7:0] sf_addr_reg1;
    wire [7:0] sf_addr_reg2;
    wire [7:0] sf_addr_reg3;
    wire [7:0] sf_addr_reg4;
    
    wire [7:0] sf_reg0;
    wire [7:0] sf_reg1;
    wire [7:0] sf_reg2;
    wire [7:0] sf_reg3;
    wire [7:0] sf_reg4;
    
    
        wire [7:0] sf_maddr_reg0;
    wire [7:0] sf_maddr_reg1;
    wire [7:0] sf_maddr_reg2;
    wire [7:0] sf_maddr_reg3;
    wire [7:0] sf_maddr_reg4;
    
    wire [7:0] sf_mreg0;
    wire [7:0] sf_mreg1;
    wire [7:0] sf_mreg2;
    wire [7:0] sf_mreg3;
    wire [7:0] sf_mreg4;*/
    
    wire [31:0] SF_FC_REG1;
    wire [31:0] SF_FC_REG2;
    wire [31:0] SF_FC_REG3;
    wire [31:0] SF_FC_REG4;
    wire [7:0] SF_FC_REG5;
    
    
    wire Enable_trans;
    wire Busy;
    wire [7:0] w_weight;
    wire enable_rise_reg;
    wire enable_rise;
    wire  wait_tran;
    wire final_flag;
    wire tran_start;
    
    
// Instantiation of Axi Bus Interface S00_AXI
	axi_lite_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) axi_lite_v1_0_S00_AXI_inst (
		.SPI_start				( SPI_start				),
		.FC_OMap1				( FC_OMap1				),
		.nn_layer_cnt			( nn_layer_cnt			),
		.FC_OVld				( FC_OVld				),
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
		.weight_data_O0(weight_data_O0),
		.wt_I_addr_sf(wt_I_addr_sf),
		.read1(read1),
		.read2(read2),
		.wr_addr_sf(wr_addr_sf),
		.IOB_Data_O0_sf(IOB_Data_O0_sf),
		.IOB_Data_O1_sf(IOB_Data_O1_sf),
		.wt_C0_addr_sf(wt_C0_addr_sf),
		.rd_addr_sf(rd_addr_sf),
		.wt_C1_addr_sf(wt_C1_addr_sf),
		.weight_data_O1(weight_data_O1),
		.SPI_start_temp(SPI_start_temp),
      /*  .sf_addr_reg0(sf_addr_reg0),
        .sf_addr_reg1(sf_addr_reg1),
        .sf_addr_reg2(sf_addr_reg2),
        .sf_addr_reg3(sf_addr_reg3),
        .sf_addr_reg4(sf_addr_reg4),
        .sf_reg0(sf_reg0),
        .sf_reg1(sf_reg1),
        .sf_reg2(sf_reg2),
        .sf_reg3(sf_reg3),
        .sf_reg4(sf_reg4),
        
         .sf_maddr_reg0(sf_maddr_reg0),
         .sf_maddr_reg1(sf_maddr_reg1),
         .sf_maddr_reg2(sf_maddr_reg2),
         .sf_maddr_reg3(sf_maddr_reg3),
         .sf_maddr_reg4(sf_maddr_reg4),
         .sf_mreg0(sf_mreg0),
         .sf_mreg1(sf_mreg1),
         .sf_mreg2(sf_mreg2),
         .sf_mreg3(sf_mreg3),
         .sf_mreg4(sf_mreg4),*/
                                                     
                                                     
         .SF_FC_REG1(SF_FC_REG1),
         .SF_FC_REG2(SF_FC_REG2),
         .SF_FC_REG3(SF_FC_REG3),
         .SF_FC_REG4(SF_FC_REG4),
         .SF_FC_REG5(SF_FC_REG5),
         .Busy(Busy),
         .Enable_trans(Enable_trans),
         .w_weight(w_weight),
         .enable_rise_reg(enable_rise_reg),
         .enable_rise(enable_rise),
         .wait_tran(wait_tran),
         .final_flag(final_flag),
         .tran_start(tran_start)
	);

	// Add user logic here
	ECG_Top u_ECG_Top(
			.clk_cal            	( s00_axi_aclk          ),
			.rst_cal_n              ( s00_axi_aresetn       ),
			.SPI_start				( SPI_start				),
			.FC_OMap1				( FC_OMap1				),
			.nn_layer_cnt			( nn_layer_cnt			),
			.FC_OVld				( FC_OVld				),
			.weight_data_O0         (weight_data_O0         ),
			.wt_I_addr_sf           (wt_I_addr_sf           ),
			.wr_addr_sf(wr_addr_sf),
            .IOB_Data_O0_sf(IOB_Data_O0_sf),
            .IOB_Data_O1_sf(IOB_Data_O1_sf),
            .wt_C0_addr_sf(wt_C0_addr_sf),
            .rd_addr_sf(rd_addr_sf),
            .wt_C1_addr_sf(wt_C1_addr_sf),
            .weight_data_O1(weight_data_O1),
            .SPI_start_temp(SPI_start_temp),
          /*  .sf_addr_reg0(sf_addr_reg0),
            .sf_addr_reg1(sf_addr_reg1),
            .sf_addr_reg2(sf_addr_reg2),
            .sf_addr_reg3(sf_addr_reg3),
            .sf_addr_reg4(sf_addr_reg4),
            .sf_reg0(sf_reg0),
            .sf_reg1(sf_reg1),
            .sf_reg2(sf_reg2),
            .sf_reg3(sf_reg3),
            .sf_reg4(sf_reg4),
            
            
            .sf_maddr_reg0(sf_maddr_reg0),
            .sf_maddr_reg1(sf_maddr_reg1),
            .sf_maddr_reg2(sf_maddr_reg2),
            .sf_maddr_reg3(sf_maddr_reg3),
            .sf_maddr_reg4(sf_maddr_reg4),
            .sf_mreg0(sf_mreg0),
            .sf_mreg1(sf_mreg1),
            .sf_mreg2(sf_mreg2),
            .sf_mreg3(sf_mreg3),
            .sf_mreg4(sf_mreg4),*/
                        
                        
            .SF_FC_REG1(SF_FC_REG1),
            .SF_FC_REG2(SF_FC_REG2),
            .SF_FC_REG3(SF_FC_REG3),
            .SF_FC_REG4(SF_FC_REG4),
            .SF_FC_REG5(SF_FC_REG5),
             .Busy(Busy),
             .Enable_trans(Enable_trans),
             .w_weight(w_weight),
             .enable_rise_reg(enable_rise_reg),
             .enable_rise(enable_rise),
             .wait_tran(wait_tran),
             .final_flag(final_flag),
             .tran_start(tran_start)
            
		);
	// User logic ends

	endmodule
