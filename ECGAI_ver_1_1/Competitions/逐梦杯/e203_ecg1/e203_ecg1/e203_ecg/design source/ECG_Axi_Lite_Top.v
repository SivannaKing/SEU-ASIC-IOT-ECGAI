
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
		input wire  s00_axi_aclk,           //ȫ��ʱ��
		input wire  s00_axi_aresetn,        //ȫ�ָ�λ
		//д��ַͨ���ź�
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,//д��ַ
		input wire [2 : 0] s00_axi_awprot,    //��������
		input wire  s00_axi_awvalid,           //��Ч
		
		output wire  s00_axi_awready,          //���豸׼���ý���
		
		//д����ͨ��
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata, //д����
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb, //д������Ч�ֽ��ߣ�����������8bits��������Ч��
		input wire  s00_axi_wvalid, //��Ч
		output wire  s00_axi_wready, //�����ӻ����Խ���д����
		
	//д��Ӧͨ��	
		output wire [1 : 0] s00_axi_bresp, //д��Ӧ������д�����״̬
		output wire  s00_axi_bvalid,      //д��Ӧ��Ч
		input wire  s00_axi_bready,       //���������ܹ�����д��Ӧ 
	
	    //����ַͨ��
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,  //����ַ
		input wire [2 : 0] s00_axi_arprot,     //�������ͣ��������Ȩ������ȫ�ȼ�
		input wire  s00_axi_arvalid,    //��Ч�źţ�������ͨ���ĵ�ַ�����ź���Ч
		
		output wire  s00_axi_arready,   //���豸�Ѿ�׼���ý��ܵ�ַ�Ϳ�����Ϣ
		
	//������ͨ��	
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata, //������
		output wire [1 : 0] s00_axi_rresp,      //����Ӧ������������״̬
		output wire  s00_axi_rvalid,     //����Ч
		input wire  s00_axi_rready       //�����ӻ����Խ��ն�����
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
