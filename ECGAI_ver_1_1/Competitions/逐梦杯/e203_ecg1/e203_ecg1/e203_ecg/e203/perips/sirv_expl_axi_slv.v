
module sirv_expl_axi_slv #(
    parameter AW = 32,
    parameter DW = 32 
)(
//����ַͨ��
  input  axi_arvalid,//��Ч�źţ�������ͨ���ĵ�ַ�����ź���Ч
  output axi_arready,//���豸�Ѿ�׼���ý��ܵ�ַ�Ϳ�����Ϣ
  input  [AW-1:0] axi_araddr,//����ַ
  input  [3:0] axi_arcache,
  input  [2:0] axi_arprot,//�������ͣ��������Ȩ������ȫ�ȼ�
  input  [1:0] axi_arlock,
  input  [1:0] axi_arburst,
  input  [3:0] axi_arlen,
  input  [2:0] axi_arsize,
//д��ַͨ���ź�
  input  axi_awvalid,//��Ч
  output axi_awready,//���豸׼���ý���
  input  [AW-1:0] axi_awaddr,//д��ַ
  input  [3:0] axi_awcache,
  input  [2:0] axi_awprot,//��������
  input  [1:0] axi_awlock,
  input  [1:0] axi_awburst,
  input  [3:0] axi_awlen,
  input  [2:0] axi_awsize,
//������ͨ��
  output axi_rvalid,//����Ч
  input  axi_rready,//�����ӻ����Խ��ն�����
  output [DW-1:0] axi_rdata,//������
  output [1:0] axi_rresp,//����Ӧ������������״̬
  output axi_rlast,
//д����ͨ��
  input  axi_wvalid,//��Ч
  output axi_wready,//�����ӻ����Խ���д����
  input  [DW-1:0] axi_wdata,//д����
  input  [(DW/8)-1:0] axi_wstrb,//д������Ч�ֽ��ߣ�����������8bits��������Ч��
  input  axi_wlast,
	//д��Ӧͨ��	
  output axi_bvalid,//д��Ӧ��Ч
  input  axi_bready,//д��Ӧ������д�����״̬
  output [1:0] axi_bresp,//���������ܹ�����д��Ӧ 

  input  clk,  //ȫ��ʱ��
  input  rst_n//ȫ�ָ�λ
);

//  assign axi_rvalid = axi_arvalid;
//  assign axi_arready = axi_rready;


 // assign axi_rresp = 2'b0;
  assign axi_rlast = 1'b1;

  assign axi_bvalid = axi_wvalid;
//  assign axi_wready = axi_bready;
  assign axi_bresp  = 2'b0;

//  assign axi_awready = 1'b1;

ECG_Axi_Lite_Top ecg(

.s00_axi_aclk(clk),
.s00_axi_aresetn(rst_n),

.s00_axi_awaddr(axi_awaddr),
.s00_axi_awprot(axi_awprot),
.s00_axi_awvalid(axi_awvalid),
.s00_axi_awready(axi_awready),

.s00_axi_wdata(axi_wdata),
.s00_axi_wstrb(axi_wstrb),
.s00_axi_wvalid(axi_wvalid),
.s00_axi_wready(axi_wready),

.s00_axi_araddr(axi_araddr),
.s00_axi_arprot(axi_arprot),
.s00_axi_arvalid(axi_arvalid),
.s00_axi_arready(axi_arready),

.s00_axi_rdata(axi_rdata),
.s00_axi_rresp(axi_rresp),
.s00_axi_rvalid(axi_rvalid),
.s00_axi_rready(axi_rready)
);










endmodule
