
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
		input wire  s00_axi_aclk,           //全局时钟
		input wire  s00_axi_aresetn,        //全局复位
		//写地址通道信号
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,//写地址
		input wire [2 : 0] s00_axi_awprot,    //保护类型
		input wire  s00_axi_awvalid,           //有效
		
		output wire  s00_axi_awready,          //从设备准备好接收
		
		//写数据通道
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata, //写数据
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb, //写数据有效字节线，用来表明哪8bits数据是有效的
		input wire  s00_axi_wvalid, //有效
		output wire  s00_axi_wready, //表明从机可以接收写数据
		
	//写响应通道	
		output wire [1 : 0] s00_axi_bresp, //写响应，表明写事务的状态
		output wire  s00_axi_bvalid,      //写响应有效
		input wire  s00_axi_bready,       //表明主机能够接收写响应 
	
	    //读地址通道
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,  //读地址
		input wire [2 : 0] s00_axi_arprot,     //保护类型，传输的特权级及安全等级
		input wire  s00_axi_arvalid,    //有效信号，表明此通道的地址控制信号有效
		
		output wire  s00_axi_arready,   //从设备已经准备好接受地址和控制信息
		
	//读数据通道	
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata, //读数据
		output wire [1 : 0] s00_axi_rresp,      //读响应，表明读传输状态
		output wire  s00_axi_rvalid,     //读有效
		input wire  s00_axi_rready       //表明从机可以接收读数据
	);
	
	
	wire				SPI_start;
	wire   [7:0]		FC_OMap1;
	wire   [3:0]		nn_layer_cnt;
	wire				FC_OVld;	
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
		.S_AXI_RREADY(s00_axi_rready)
	);

	// Add user logic here
	ECG_Top u_ECG_Top(
			.clk_cal            	( s00_axi_aclk          ),
			.rst_cal_n              ( s00_axi_aresetn       ),
			.SPI_start				( SPI_start				),
			.FC_OMap1				( FC_OMap1				),
			.nn_layer_cnt			( nn_layer_cnt			),
			.FC_OVld				( FC_OVld				)
		);
	// User logic ends

	endmodule
