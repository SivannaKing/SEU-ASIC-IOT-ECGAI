
module sirv_expl_axi_slv #(
    parameter AW = 32,
    parameter DW = 32 
)(
//读地址通道
  input  axi_arvalid,//有效信号，表明此通道的地址控制信号有效
  output axi_arready,//从设备已经准备好接受地址和控制信息
  input  [AW-1:0] axi_araddr,//读地址
  input  [3:0] axi_arcache,
  input  [2:0] axi_arprot,//保护类型，传输的特权级及安全等级
  input  [1:0] axi_arlock,
  input  [1:0] axi_arburst,
  input  [3:0] axi_arlen,
  input  [2:0] axi_arsize,
//写地址通道信号
  input  axi_awvalid,//有效
  output axi_awready,//从设备准备好接收
  input  [AW-1:0] axi_awaddr,//写地址
  input  [3:0] axi_awcache,
  input  [2:0] axi_awprot,//保护类型
  input  [1:0] axi_awlock,
  input  [1:0] axi_awburst,
  input  [3:0] axi_awlen,
  input  [2:0] axi_awsize,
//读数据通道
  output axi_rvalid,//读有效
  input  axi_rready,//表明从机可以接收读数据
  output [DW-1:0] axi_rdata,//读数据
  output [1:0] axi_rresp,//读响应，表明读传输状态
  output axi_rlast,
//写数据通道
  input  axi_wvalid,//有效
  output axi_wready,//表明从机可以接收写数据
  input  [DW-1:0] axi_wdata,//写数据
  input  [(DW/8)-1:0] axi_wstrb,//写数据有效字节线，用来表明哪8bits数据是有效的
  input  axi_wlast,
	//写响应通道	
  output axi_bvalid,//写响应有效
  input  axi_bready,//写响应，表明写事务的状态
  output [1:0] axi_bresp,//表明主机能够接收写响应 

  input  clk,  //全局时钟
  input  rst_n//全局复位
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
