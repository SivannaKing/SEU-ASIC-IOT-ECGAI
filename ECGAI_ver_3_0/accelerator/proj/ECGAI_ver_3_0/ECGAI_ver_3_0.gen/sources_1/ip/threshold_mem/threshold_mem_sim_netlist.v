// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Jun  5 19:21:39 2023
// Host        : wzxY9000X running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               e:/Repository/SEU-ASIC-IOT-ECGAI/ECGAI_ver_3_0/accelerator/proj/ECGAI_ver_3_0/ECGAI_ver_3_0.gen/sources_1/ip/threshold_mem/threshold_mem_sim_netlist.v
// Design      : threshold_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z035ffg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "threshold_mem,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module threshold_mem
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [7:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.53845 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "threshold_mem.mem" *) 
  (* C_INIT_FILE_NAME = "threshold_mem.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "256" *) 
  (* C_WRITE_DEPTH_B = "256" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  threshold_mem_blk_mem_gen_v8_4_4 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
QGLtnqZzRetDH6gCWT4Js6wuLlZfrNx/VJp3sfR2NF+cxypO5AxN0oDKLJJtmdrtE/ueNDg+Qf7Z
TqBNRojORA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
B6Ger3hRvfjHkaJ+W8639Kl3TzC9TogLuklOXEiMNdc4Im+DjEUzxb3DKlzu0VW3zxZqjJ3+wsW/
LnRmPCESi5Y9eRJaLFXg79EMfoj4X+nTdHAP6yCfltBADKegZ12gpnB/8ey5yn2KA74LUtPC7jna
iyjqSfsWLGnz6UdXzwk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BX+DxgMPRyZbYojCUR9Sk8Lq+3ZigBz4yMFHQkmurfdfDzyTPJCE827eGiPyTenK1QPVhEtf9g06
0BFXq/0COPuU1BWJwdkz1c4dE6/exDwhvEh+hPx3vRY6z8fDEf6aGVIXrHDvrmddehe7yMSIpo+k
aXHR06EEdfHCFY4TggYwhcJVXjkE+ApsVuyfmEfPmYjo8hCWyQyBsUWIOY03q1+MvUjjsmTwgs9g
fh5MY9ToaLfoJxPKdCpsqrBX4LJ+VDGFlAqIcqHTE2jCmPiToZAFXB7fzf1wDjFCBlJyFVDBGi0i
m+CouLSb7X1mvVhdDZgNrZDJMV688Bu3o54vew==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DaIU/Ddc8USbZ2mURzujJDWDH1JbHl5tFVOOQ2aVaUPIA71yyE38OXVLEtF8rNmujYH30nEeQ+FV
LVJ16aaHw+iiuaqorTM3K5KLohVlN+WlcEtSXHuPNHjw8ddqtzpaX7pH1zqZH+YmfCL5oaNLqDH4
rkBnUl0/Gm/hzSwKjYhXGQFYQ+gGP99OjXakzrAqZzp/Iq4gt+Z5902/JV9thd/isHQImJ0QyK8M
EKM579iPAfXGes2mbiNYHcvDmSPYmW1zlhOE++N1EKeea7j/msnKeyhlC+hGE4Xfn4TVvqgQexCT
rp/wS/MosY6WH1aKFQlFH2hEppA7KXUaQlvG+w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
XmWoAt4X8hrCJ5yTyug4ajJW5UhfkLNibzjihWzZ4Cr9hQSvWZoTc8rjGsLPbz6Le+/9iI5KxecS
eR0wiAO+G2IkwhZgVBeZdKoFnlnTVAyLjk9wMAFXNyJZM6b1NDbfXlPcUsC6JePvPlwwdWknkSsC
r3KvgkWAS+O3xvRmaNw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hw3Y+rShKrXiUViyNU1/O2qv6TgheLHBnFMj1i9MUGrHYqh9pLfLYUgWR7S2vj4jv4S+Ks0BpP4p
dKEqVAFmTCfQNEUHaVcFPkOHgig6L4mhLY6HUUKJoRgiQepgLi/W3V+ZZPQSQFkB3CU4MsJzhXvR
yLcpDriZy8cnAHD87Zi5DrNGBzj3kigJeM0du6lCQbxtF5aEdoaNP+YTnIFtcqYhoYnswQlYt0sV
HKgFA8VzqzL5WYnpH7+1IKmFkJBHkyqHCa9wPK0qCKnxkuDj70YzPVqQ+cocdKU+/gNdpCOdZlci
F2HTxrgfrXndJru3TiDqu4UavqAe0MNuFp3t0w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XPVggoWL6aXz+MpODTOZhEUQDa0vfEnUDaYeEHXm2vGyqKJujN2c/FFAFBeBYdJATLsIsQ+BqoPc
pBbcFYXDBfOtFIW2dH6Y1OoD65KyJ/hAq8coa21kFgq4hFat5vzZ2iIfkCpTUr4vDZO7Xne8cZO9
WsHffoTCt5rS59wWm2b8I5R8Eh2TUbQg3RCyrcnD66cvcEnlXe1CNMQ4/loVJpA4IBinBf820Wjc
vw2fZbGI0jXC+ACSHOviH63Xwmn+aRV5Ppkup7IYoon/ieKapRQeASu3TTY37xSBXiInSdtMTzJ6
+4GfO4eSHVriCk/sWbuTBzfRzoSShrnHjzz5LA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L78XuiswVcgO2gtebzL7SA9BC/jJGAM0v6S9pzmyqL+QYzRneiYeGyDmsW33jEVVSTuNjTXkBLY7
yTOKQruatwe4V0OLi6174saSAmPgerSV1GyLP7KhmusLV/N61avC9TPam+tekhKeE0tds4EnJ3et
4JdLh+SE4Z4pcuqCjB5MFneIYKKWDx7siU6oesAQtoSJOesfMchX63MhOjOHFP/ch+1gHv3T45hg
IGF7V7TrdREVE4f9631tlVJ1o2Dypsmo/76Itz5WCGlTMjAnWXN8IXxKN+PZ3dyt1wjrZm2P/td+
xiGszFnSLrRvw/HferwtSmRx8q0fiHZ88roGTw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kDX5kq2QEe25429T6vQqBCFvV1McKTJRYfK99ymVNK2GGvGLXSzgwJHwB2fj9rM0wme3zYYY0vQR
x+9F4L7KLlOVY6qY3LB59uDzyXBI3mMZaS905HXHJkdZHWtQWpfHhl27LqL+8FSluaD6F+KFfYOV
CwIOVuCIp/XjxFXpNBik7YiPt4kHOlDA97IXNLnYUn/g1csGqeNWce4UTne50ggWvLYGbTFGmTjT
N67TpUiGRVRCSv8Tax72GWFIMFZk3Tlp68ZUSQEybZMWX1U9XdMdtxfvNGhf8mi5jQJ2SupSzKu4
T/+53IN9T8aLePAiGBKKG1ZBj4y1ZyYA7XYvjw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19744)
`pragma protect data_block
3AgdkXjP1Cwp46wewd/W8z59DUXu110Bymc2bvxdOjTQ+e4G0MILIwvO8FDcr5Dc9GyR5jbFpRaO
fYarRG5QDNL/ho9ca2xHb+WFdpZ6xgEbetkikRdrRFxVvMLwvqizN6YGmmZoQfN2loi+S+rxtKIM
w+MOdGOsSRUKXv8tsyVGUMtsLFLBSazgMaTQTji4hEkfBA61g1gIzRk/G6tOBCxp4+PkiwU7uqU3
b5q5da/h/EljG4AqOtfoLmHBOengyJCH970p5Ji81Af0IkkODak2Ua/90LmgHUMP59aezRK0cZbI
9qq844zFG/O6tZ+VXeHqurRRdT88eMxas4+L8/Y9R7tTtTcQF22Ql9L38xrDG3jpqdR5etCJS5Yo
wtRw/z/Q6lB7WJ9LpGzFBKI1kkLPGjTXRIahU3h3LzFlM0ZE1rahBetibd1wezNike4LrMTTMTcM
11/ic5cdT5xAqH2kLQWjxIu2TnhnD1OhGeBUBPcmF9mcG/q/pm65k1B20k7a9Nr6oHy+ytojOccZ
ytzLksw7IskTTe4lSFWz4jDpW8WkaOVtrNg9bMMX2vquliYcy2NXs612pPWz3JoTvjgPdAJN8Ejn
1W/9NdhsQ/XeF0lW8pW9QCNL6PC5pIGcSquxRFrc929GPO0yjpukIJyU/Pw6pxKjPQZoHEc/dfJZ
3Gw7xdJhFtX79T9Df5dvniiH94SQqzCGa6qBuH+Ou6LEJgFiItxR3O+P+w5MKfTAPuyWt0IJ6yF9
5eYhzL5FYYvYoGGPa2Y07KnbwzZFOknS83BWGI7Dm/AmGVOd2Sdj3CwBrzei4i/FEek+g+bC1jpN
rPqViCk7etZ4rME/A5KnFNrKfauVdJWf3Xz648hQ+z5DQhE1ayaRyyb0BkdQg27kwOUHWZcyaAd9
D4e7B2XNcaYuhQdLWznJpYOkT+083cEyQiENFPixGQCEZM0PZp5vLw+lsFVaMfNq88vtx9tq+Rwa
uxvyBwvYn/xKP5YXkvxa8XX/RVZkt9Fln80mmYBaJQY9MFeJ/OB2emA9KKF8rmH+42k94uZG0CFz
5Jb8DOfbAZbPWGb8c4724jQlNeyOWR+qa974b4OwabxjA+gi/bzBa2T12azNHmC/JggyksjMBWWB
AetXiL+F/KS5XKhZUVAJa8r5q1V3tJi8A7qQ8CcEQkLYwlZnjKQuFOGGXe/Nz8EzHYpaRT1n1lil
Ya+dm2LFIejKtokskVEkWLzyPS+LgXz2VJrxw+j+7rxvPhZFSjH2PurqCaKg1tJAUy1e0FX3gw+1
UTvonGFBzmPPLvjsEuZPbRqY1zwD3nKnSB3DL0zYMpHeKYUOVb2YqJlR0TN+iq0rI6/dC3yUZp7H
5d6G3JJTRMw/NMu6mFp/RMQ3c1dveJu1PZMnYeK37yoqotAbSJDkfbxe5INIIUTeA+M0qe60bcX+
QX/QiXx564jcIb0xguP+AT2SFfbjoTzHOg+Ai6F4IwQARUdEFlr5IkwlfbXFnJ0wDKUc97OcunWt
dIotxlkvvJAIFpmwvR1dnhUz8fEeMuyqBwWb/Q8HZTZZ+8hp2czPHqSpmj+UvFomCkgWVnwRh/0Q
IzCn3VBcr654+ZQVOwu9ge6AbYWzdIZM34YhTpPsfImGBtaOMK/qccAvr7tWBODGjuiROdcs84+0
F623nECqAQPxI/uk3VO8N++kGYOjRvpX2Qyr6ianTrNe90I+6vu7Q+VbJrXzrt4YclyAwBwaYOCp
AWoH9tn1X3pfI4cF+2ec6eOJR5iwJCXKrjDrowOVAZB8fQTECa7nn8Cug0lyY/XxN8j8stkjqaw+
me10Bh1uZZkgOOqS/ticY/P5RGcHIhFnouMWPfh9McSiLihmRv4WzfyxvW3E0u1z5+fFwsw208Wf
ZdSnjkC6JIfc89Bx9+suuqIcnzlST5ckY0KhDTmJCzmi5p7P/L4uIAjbWWOo6BLG1ljNn73MvixK
95oQeCedEp3+GVQuyq5rJfz42eZAv0uuTCN8IbmftePULAr2ZUNDMUXGLea9NctbeZMY4VCBOTsC
UooR/wgtKBI9bfetcZveWRvz3JtjvJ+H+/qXCMiX5C0EdMGGJUC+lQoLMuUXF1rDZrxm8wNv9o1V
4wEWcaBpcV5KRq/Hx6EhBeVK7UzXJPSlIhDYxh8Wzfw6eClePW9mgUaS/+Xt+5SJfajIJyXGQefR
aunRF567XfzWsTLUp7XuZPHKiLYEu4A3v4MemSlAsYQ/NTrdkvrVqG0k3LZjtAnhqPk1H74YbBgR
D6scEiAT1iew7uyrLe1lzcti/RmYXBmwzKjcBg+/crqfBOQvsLRGAyg4aRwVAzBYkHmdYTkVdtc8
fvXz59dA+Kfwp4CmX+8m9JzZ2z9+Xf3OKHfQmoL9DMMxfEa/K60PSTVsy0eLDYzXK7z6E0osdWYt
N4Gwmd1AvdvkTB08CXX7kAqkeVt/jsWLbXEVvROAPn4t2IFJzyYxDj/HNwylKUmjkpIFEOtj9Vm3
I75868DcKisHP69kBOjd0te9M8JX4CMUYulN9FZPbY+g942R+0tc6yvkZMl7yqeO41JMqWx0AWyS
mytEqgJHJoImYwju/V+qwgJjlX7w9loYCwYeukmVSBiwt1sUhuse/uQNJjo5z+b7W9fmDs9JJmEe
tAOv9qE5Ulrn0JDGgdZMzKnAr5CqWJ/DsCXh5NwWuv1XNyh+TgCmPgPLxRC440to13t8bLActCAh
c+d1od/B9P4T9fjDxkqOD2us3osqaz3vkTuJ65FrqvSbMCjjP63xWj5YWOT4yjnlz/YTrIfozKXJ
V4Wne98C8GIsVt5nMAfZwbYQsam9gR0qzDBfcdP91TSmMZm+4jq0izg28poM2B1RSdDqx7FxYMEb
AS859KDKhh20ZKViXnjmhRym/OjsLXH9WAHV6iZM+00Mrc6bczHpFz4QnjHaYwHXB3etCxdKCo0J
1qHqPzroTkNGwl42t3irPnpPdL8Syn45CHfEt/X+VV8RM5TJliHQ51vhUGWelW4JOk4m8KaNXrqa
bguZV5ko2AFgw6pCo7TvnVQFFkEidiiH73adBcPS9TSQQLZaO6o3qfXiOo7r+Idjf96crn5OO/1g
i7OnCYhYDVPaD3K8RktEd08KXX7sbP7tS/6JLwd70qCcq24grdL8aXTmR9iWCG3r38y5tOkx5zSR
nv1GNj+gmiMVblPVm90agFzuTA9659S27yFvavI/94SYxGQ77atb+p20fUSyzO0TamDkB9X/BaUF
mIa1abBSmhwWrD+tsLKQzFTigxnh9Mu23beiInwqgzDtn2TCZyfp8D2+T+yalVZ+B1qZ9wrIdFuU
Uu8doTni+3NNgIoe0Nqk3IeFVloetV1hOFIE9K6KmzVseW1BXFpZ+BBp+ajbc1ssfx78HdoEAr//
Gql6C/z86Va9TRWSSeRoVAj9Pfb4L8SNZB1Bo03X/n6lvZKzsvi/q6Dt7Xg1qkBgIifbzdFAZkRV
w0AAyuroB2Df0eXg5mhQl/Nv/hiVDZh8WvnY1sB4b2d8Oqz3prkazgoR3oObpXnnU2kso10TWObE
928SXOv6+v+T/MoICsA4asVFtfEZx0+28B4lJFlLbq+Tze8NHXRUS7RolHA2Iwwl2k3wqE2m0D+Y
SKGm63MUmlshE9HxzTfw27/P9PLqWF1UmtqynBKDn4BS/E29vQY+wvD2IJVhdPCK1VCjAc7lKWPR
Ax4RbxMc1ZooHOeu6wuWxGdI0pTymBoarkhhbjYhExmAHfNCGnBMAAGSt1zEq0R/54wNioFVFq6o
kqGdchndVnMuqmE/EUV5w8HkhdvMyISEB8YjppkH4e41WkdTiiUKvnV3yZz9VBfznH+o7lizDvNR
Qnv5KwZcXYZQLAUP7w+7CCxlTKx4kIci3j8gcbfs1S9Xi3s0mT5GRN93WYwthZxvgk684tEaTfls
nOF6IzLabSQBMvSe+3c4JrOi4cxXF8jZ27ZNyRIEcSQE2+i6FDUR36BhS2LpBPClcfbaJs/2p4b1
dcidiVYD45q/3pjK8ELA0kJlwMXStaWM+tFTDHxlZseBbpAgyUhdWkmBWmuR21xsZdW1W4OaU/OM
GDObYsKGyClnUP/zixkXi83AQVQ72ofAjuMWz1A1PdIaCg7H/PL95gtIaHokRes8N9sgSBkPI8AW
MWzPEsGHopFV/eYLJxRBywfDLtYlx6bb/caVi1FqIcMaPpewCXOiJFSURBsuoEZFMfTBX4jqHvUq
IrWev1JZdNIjtrFA9C+Jf1WQ2y3uVVlP0ybVOFvliQwdQfnhmofGWIfotqQc+veaBbOMDaba8YxU
fsHCVGWBz/lDomqixLUdNlUk8hA/dw/YW3Mhxj88/1HfIOzvmOUsdqKTwnK5xxAtPe/Kwvmq4UC9
CLO/F6/W2eGFf0uG959e+0tJE3cgMF2piDSMtR6NKlZjT4O5zuWmSlSeQsyKBTU9gJVR2KPPE8dM
tcJyGK9S1fZulTfI+5brYg2MqwRYd5/4ZHsi0tbx37KmCfXm0NMnHcM1J8c/ToF+bUjlIyJ6oC0s
hGCDzUrRCPOiRTdWGr9vkUUMvb9vdsWVN3Mj3OEt6iFzfOzwkH9qeBuWLk06vyXTn7YQqhekkVXX
lphCUY6vCE+yiz2zg5rXxdARk73oReEaYukzpP1PKHCUuLpgMIy8e30CRCwjPJZ61es+TmN0pt53
C8NE8OWeKwj+9IznnXBeTSlmK3yrn171afjQ59Exh+/px+FOZKNjBnRqroTa1lgTpA+HbLf/YsIH
wjiBZdh59LSQ0SmqDjUkYWLJ+b+UcJU3qAWr/ziv35EPQnxYg5aOhFzOW+Zu4axLnH8EVhfgF+Et
Btt+SXASEZR/nuqT5N0uLzoZhc7WaW+P9ZHP17oXrTrcqtYCza0Z1ZdX47jq6pnJzekbpwyDqcX4
qBRtbzrF83dmpfFVCCi8umxDpI/7JHEhPXppSTdEVTcoN/+/uKRYXuc92jjtQV/7hZp0WGm6qED9
Awo9tl5SoF07Zs/Bvou6Q8mA3v5rJZW8kSpVB7EdnKoG0c6LIDzXLKHXUakUA/0VvDWRrf95YEMV
RczLACjR0tr4mRXAc5olvmgqntQ+r6e0jwgegatQpUcfyNip6XFOcqjGoDXpDBY2yoaIq2KhXN8p
syxMQiq3tcx+D9pqimBh8TTONRaOd8xt7ZhjnCSAIw0nZuzCihyZYphzIHHkAd+k5std7lpc+1yp
MpSZ1+PGkRfxgbLuDBPCuQHum0FWn5wL08D2m4cNV1f6tMKQvRFzkHypVazf05Z3OfAUFvMJjLkU
ohfbeChgIBl53K3UyIdgD8V2A299fOScQrCwc97kvbAX4rWZ6idTwquFfFN6Gy9RYp7B7X5367pW
4xnXCbSmXSpeU51L+jhx2bWmpUbM7y1z/MiWdKVfmVHT7y8tYVQDgQUKb6+hP/8IGcnyY7trVSvX
CaqXislkjN7B48Am3VUE14WWPPeIP8Hi0CLuPS8oKOnl4Ss7jJZbtan3JybqfKF5CqUEFso6ZijH
a+E79UnU8B6Xi7FTUEFgEilFnKsJVs3EwIg5beIPd2vQWUiciiB35pvtfdIgOOYRiM69GzTtovbt
GXLVag5Zy9rMQ51aBUfZ6XqzIC8LW63trn0lWNOtV6dKJ5DIb5ZIO55zlQ51mAhzyVPZx0lFtuds
eU8AY0ww6+Fn18WiMC7gOXIu8Gvga6gXOMmu4jJB4A+VZ1+3FawS7fqLFjKX2Icu8GrqxZ6+7t0d
8Ng2BU7PCi4gtsC4vZUGvSYkbupJg4hgfvckFD0rpizuKXeN3wMq97cByO9IIcGRprJPLkObjLlP
CrSpDYnAp2l4nDUGrfVplJy1nQv1AJynoO/UgmkJMY+1iJ4F8M9HJ6GJspPL68g+V2+hZUxEgVu+
ynVtgsFa0idxurJ+/GgZHoJkc6JFKRkBi2glTZUIvhibQKkPjAC2vj61qLO3BoKxv0BrkZNCQRrH
foQX1SWPnM+wOou7C0JdriifSYlXzIcYczDmoEGFzOG1uFK82/JEUvCPWlG/pS5ETb2Jejv4sm/+
MlqCienM9ZPzNiv/evGUBLYbMXb50acg45TiMmIGRRWjUjFMksEfSvkGNDh8sUMJVcV+fOG3ULeZ
U41n5vQj7BvZfvX0ud3mXN4DmVadmNkqitaIMm7h3KNwDBOy4w7dXF5hcss2oi95OfgRcxNFuhdX
XNZMvqNpINFssQa53rQUraPyyHfM3fR5cBMEk9q8o/bTbsUjrGc1iSzDHRDbINlGa7oBY1gODqM5
WdOhvMOL6yxz2XP4DoYr/1doxuv9/gXa6cLk0C68GOPjNpflByt6uffhoFfMNvwWi1xdjtLJgbLT
fOoEKBkC5Xg0D2/zjCw1A4h8NonkxS9KuV/M9lkbRAz1h7PYB3HirCfUpM63kMXJy1ZCULW0xWGe
7TLKXE/H8fEMg26zCOkAi9F0r+Nkgwyrgb1qoH0GpBsV9PBwyPTubKjYlBVr7sWf5dZojcPUZ3Nr
O2xuZQ54OM99NGPZuaogb1TsoSstK9gOlWHZCBZbmfFvCAHmlrNseoB+meWzNOE/0V00IocJdd4C
DbyoWzB1OTqIhb+EgdHB8F/GSw/7OckHggvG3gg30tcA02HgfpMow1pyT1XPi9da+iOFhbrXGj5Q
rvVfD8wEGs8VTsp0PLHSoNA3pp6DkanBUnocnFLSsO+Pko0atkASK0mwl27GhxOkVxDlE9ww/8rl
hp89nKqCPPFLkC/Z+YfwitcLL4RqDC3Yqw7LnAz3vM7W3iohqYYl4oqgxbUnzhnGXuqotYZkbg2G
7wCj1onkhG3KSayYpnrMQb6zgqNbBRgCm6bO1EfFdxvjWhWorLa1dvH7cOoPgOJteVGPutJ8YsYr
QxhDBCcHZ5SLOiWqVsKygK5eigMXoehb21gBF126KVPF56PzCvkPDhcfT+YIaEUnoxETX/XyEjnE
qInFuWGEo4zZx3My6iubFpFhGMyuqfh1XicSzBWgu/xi+D5AdSxt124+VSwphPkgZo0vgp7ToXuh
/gvBGky7Dmmg83NrFhe6ulp6c/aLQq/VMnOVwGI/WvjKpekiUm2BFKW/oMxVMbc1OLy3BrIci8Uj
Vmn7KtHiU1/aIYhQKhBD0D1AEMG1zX3PALGPh6UC+QylrvqEjIudLgE+IcsaEjKfHckXhEbr8pF/
qorTl6ZNV0j6pN1pRezajzJrErZESp+Xrwo+xNu7ydd1QBA0Ot9ESNnTpsm4A/VDe1wTpz8rSJdp
1I8Jc9RytR4LM/1mg5a5hdjnRd2dfOG2Kk4CxneKMjy/EgBcUIGXKDi6/LMXPOzPA55tSeKGN5kE
mX35aFT6ggNGLnpMrII/OH/gcDN/TpZnWjIFhOqZJv4lh6Qqb9Rowg/PjApiSpt7Za/2KlKSpgmq
ZiGIPdxddTLTuceTN2K7lzuC7vR6I9pie+80vDzWVtg8c3iFPxgLVlEltxDsp5izztTmdmREc1H3
GlQv094pApuM/Th4C9WYCpwy2K5FDAaG0RZgVJyQr83gQuww0kJreU1RWedlGNfU0xeR7RyLZ7g7
AXoL+S3Lf78lbqsK1GjDacFsUEkC8wSmCbvt6J0Ec6kUXX8sSGoCXHbcLfdcebrzyKE7sOjJGTjK
HmYBuFO+ecZ3aIYg81/m/nyZpIHkw4gqlh2oviUjPR57/2Gk0IF85jZnSdR2ROOCOSxb3OQGYagv
skesMYQQOCm6M2kBhK3aFeLosOBV76unDEEFO8p7W5RLrb7d65dFw7xDxsNs0vReWPizM2iAO6NN
ThKA1lyOLSrp0R5huA4r1yKMXSgSuu0eknJQR4gsk4+B+uOw6awH2g85EwHtjHS6URq74biNmlrJ
LqabTjdFxI4BhSw8CO5iQuLHSL6PIXEAc0FxjP1+G50KOqhu8kfFNppsLtlSzST2Jyc3H4pKBWe6
9dEaTz2Sz88k47b7bmoRagI9T3Cj1/E+HcLN6PvV8H8m5O1zRBelLFDDrxMklszLHLeHJXYeaE0J
UBGDeWcXDzalbYXbHeYbHY6BQ/zNuIkFaACBzdBxrdpkEDZY6LfbY4uI1HfYCINldXHmQGVZnMT3
amH/0BoZF2P2gH+Nd9hZ7IAevFWXW5RomWbDn+wKykvjkylqeFGoPEV70duMpfVPxxFTYYNimfkr
jwj0gN45s1vdBXUrUbFPzuCfTqGtrmvPE5Jg0K1v7Gs+fCoGriGadGpPP7F1aY9X+xraoOCaBOwH
0gOv3gltLr6qMJqTBWhdI9hBa7ZEZymkML+iFJSRVS2IJ5PIRz6O9fowaSXBV7DIjUlk26D1n8x3
GG/5SmS80spXajTzKCAEU/zMEapolfl/BjCQBtbnQK/Iw8D6HZMJmynzg49elD/9zhYoqN1t4M8p
VwCRLx9rj+lsax3uYaZ/4skTfudXFXyucBq/fYU4qbnpwkTJEuT0wTqOAL3QdmRYH/gjpEIVas9/
oH6Ma6eK0ZKvdGP00ti0fNk+XQ8pJa12afeeETjJAzbN+jNle+HdBVk3JP+29iUxlfIJKrrzmz31
QWqFLKz5q32zDHqv3GZtK1ghsQ2Ly7Foi0cgycPYnQTdTaUPdSjmW6aJw3a4L+MdE3GO19wPyvLl
+9nhYzaIc/7xvS9V3FAGZbc6rzpf6vq5jnGg8iFDiJ2kTtGk1BTc2MKEmTMERh9YzOgwzj+0/iNU
zmK14+REXm22bzs44GkKyX9/lyyQAMMEZy1Rhr4ElTMEFk0o/5D6PgBj1+qmsIB8Z+d78Tg+I2je
Tqet8FnDgJ2UsfHU6u2w5r01/V/S0B26Nuo/74JMjKaetj2p/c9qurIwKXd18vmn/MkWn5ZKfe1X
3hSeIh3+Z07f0Kg1daEXAdujeDynEDNENdGaKURZxWeDIAuin2ujpciLBQw8JrXqu2saK7ojZcy/
THrUs3qIBcw27H1KHDOTTSu78Bte7H+s3Nxi3z0WKvYJ/pu0/uYlDlquRswd5b5qO/2TDAMgS12A
YegcnqhqdtUzrEMixNAAOc2OBZOglXS8C9LYEYOhuiDGWP5RZnbeZZd7/SzvRELyplC/MNz0b53N
U2ZNCCOKyWLypEcvjEWzqVIOZ+mL6aaDTacuZwvWjb5OPoqpjKUYjOc9QBb9YB9rjwci+Wf2TztK
LVHzqXgzQAFIfXAHd5ZT6vB1QBPgF4YZ2msr0rX7K93W2JMZwRSAIEjEfJuKO3MERNnK31TGSzQT
AlG15CweLI16LH29iq2wvZjCKUtg71kI7s1FedTYrHmLu+xlPl/OtTjcdtb7aGWsBO0QApkOwSNv
CY4+c7yia2EEYmkAgoqObT/KGJKKn3wbTpJG0Wq0dQaK4bsiSFwPkSD1AcdRj8qsTpTqWkNlHP9B
dbF0K3LtKx4dVb4CId5NqqDkZLpmcM2TTEbCsWu8wbPyG+3l8ZIkzafSyl5v+75FUdn6Xxinalb6
6YHpChgnask9w3Qvq7t7ftC5Auy0UkxeEqA/HRqZew1YI+X1djsYSQJiBfRy2n3Qn4vnRG8NjbtN
OGZtYMheWNnFekmlQPBNOKBY8oGCVskZ6ey8bnxAB3xwDvzqW59YDTaRNedrOb09wij4reTMIn3i
4uluVMBLBxxnmD73N2MGM2jerYu3qqIxF2LxghDTwwchCbLtE16mxhBhgf0+De7H2OqMqFkAsIYh
snno71WjokicMnX7keb0CzifzhIx8OClBqKbqH4ovWy6s1vfp79MStQZvhqS6tjqC/G7YIb0UzoW
Ed78m0rK5dZH/TMWh/cU7Uk51HUqNXGj9CEiekwXk0bLcPgYpirKJoaeaN6PJcWI8P4jHfApzwu7
akOagmK9gce0RWiweTRAQlpKhp8Ccql08h9qa6ZiMhYpTV2y4/cYTy7C+HOGubvQtsM+ByiDCOwS
pLooi4rAMiBBf9rzoYb9IfituBeHpjtnqXLXicZLUSaSrjaJZJXteU3kunW4FZChluSpkfKS1gY8
P7rbIrfLmq9cb459pgi0OTeYSY0Lm/FWqqCQX6mxGK7p2vWnRw1Xrfz7ZT6oWZA0WyOJfFUow2Ei
W+MRV1/h9x608AlemXEGmN1i2D8O0DtMQ+PbKw8TG/0guHbHSoiAiwlPRQOZYlknPx+C77S4d4ra
GyAJhGcHVUHlY+4LaY0sUkx+uoSzyucTg41jXH4oZA+IfQH7gNcvNsx/9WMQk8PnEnrc/0AZeNUI
ENPWoxiWwTehR930pExrdk35o3XIXISb6l9UmR0ckzP5SzeMOTS1/dzDYrc9h+qRA8MvbwweGW96
IC28C61jCXB+Sn8lSeq4dy7mqguvMQYMPeCWfql4Ardj2ER/J8zeKLeNg86c1fkOu+SeQBFaCXQm
w5JA6LUidpgNZMLjnxC/JqdtkWXvnh0i/ILy64k2U64PfPi54OUPZihQLlpdanQjVhTjflDaq6r9
egp489piMvuVEXHv1Ng5szw2EEFjT3B6vAsBfiojI4KQBAFM2gZmFV1/H+Us8Jz+rjEMRtUeVB/J
JITFhtOp/fQfOSsTjcQwpRJvVeN28pplTHl33oUkHWQNbDqb3pIUbeGFDjMsI1RTgYdXV+XscVzu
j61trpF/wda2J2FWaZRP5k0ZKHwqS8K0192CyV4NIbNS+XlpuGiwaolPM62aESQY1C1NRuVXU7/Q
R5tafvSUfkO7Y9QelfjtKht533CIHqK5t+JjablvQXtT5D0wPLby0CDa4yAVJVrWk3jv5M4ulpp4
WB1DYamnTdn1+NYD/aMtJ92dkte3qCsdl65yljRhKYea0QyA2KVKUGvEMIJhyXLm4tqbovo81ywz
6QCbyEujDo1eHJlqtoqY/x6+12wSGfrMQFBdAlYWN2GjWi3lQ3hwEmbsU+4t9lHmf54NgkNZrfsJ
r2GyOu9EPo0dHiBovqUCoqAIgyFpA++5gLVK2iZJ9qtA7k/lSvh/rkWXHV14VQPoJDvSG9w9K7If
zj10/6yxdr9KtlXnOuZL6ak9pPizaZcdWifGhT3Y85i+CwPVb5PuaRE0Amdu7zOUYfnYhOekPJZj
G9ggzxAdtYvMXYGqAbzUPZrdUSlvAxcH6d1NXh00J0ltU8MBchW2ZoR4vJrViRVBVcos5U/qABFd
DUDIs0LesfrUk1g6jDPo9eEICT0tGsNXsVJ0bU81q4xHovov7jndbJhwfi9ZR3s9JCsuG2W8NoTt
hUonH+gwoczDhgpKg6Tfss1CWSNrp50htX9ulODPzHgo9f6ilOMTQidxBmWWCSyTWQ1Cje1XwuI8
QhiLt67G6irDIIgUZhyub7S7UeauB74oXZ48aPTQkLXMxFxLvw2XDlwVLLl/NZrpkHLqSZu85Dkt
KHHrOa0891mF6a+Uj09OcI72r6ssru74+PquuVNk4OdpZhOaFVGK2L9L/RYY6zLLuUwq8pVpKgCf
aCnY9aykRfXFV8LLusjW8OJ54AAUIaebiPudePakNhCFirHwtXpayAg/ZVfTxozMPMAUeBLW7bV/
6U/xWpqmdDaXS7QSzVXKVB1d0PCfJCn4pvcSFF0JrDAAfCjdqdKIw1ob4DJqrKcp7pC6PuyzAjga
rAo5dXzf7cf+cpAy/SY7qdpuMC0qTDtnrHZbDrWhajKktUfmAzylb5svu38qIHg4b/+TuhohqEqD
4W8G4hvAI2A/TcPKmulMVwLoD1MY1EZFxZI7a164HlzxkLzoHNJyr6MBl6FQEi6T58diZRc5lhwv
XQygKaM4ktOQ+xqxvWbymnZgdkwejbVspFSFMyH6fHvoCD1RdWyhxxC3x6djVCmjVdCEiZkUP5+Y
z3KITuSfdGehZ8CCc60EIufDGddrm4k34P76CTMusXRsEYTA/wf4MGZ7Wayet7Dh1Xl2Fwwsk1oi
uqlS5wtOe++1QqyMUaeJSyNFgEKagrdumMiW9OP4pikNyB21uaTrv78T9Qw7RLe3UyqLpztn8dPa
H8gACVKVhq/84H2SXihko/rsWZdjvLIpsGvRUrA9yxp6/9GvvbRIAZ0ch1ZfF/VIMWJjtAfW/lh+
v8Y84kDMvdwxzfFExHDgz72Oe5UcNYCGp0ZbtBUnKUqLOm0pPGwXmXSZzrXzsIh9K0fEtWTzKs5e
Y8JQ//P25uWswn3Q7qTKtFm1OG005NQF/bMz56dPKO1nI1EVR+pkxJLANAR2s0H3+/kCok7xmeAb
vESpLBLSQxHEmJ5oUodYyYfnEWzXwaenqYN1q1aEPR2TU3RGyD1uNb+DCohHmyZShEU8RHZmfacx
lgDITZWiCbd3lgPGoR+VXTqutjlid48VUBezOJB6jKtQrEtvVjA3Y7cCdDdTxfsGq35M18j4HnNw
wJ+7pog2Eh5/ZBEhTybHE0rDGocp7C0FcyCioZWSOLrBqgjXHtThBZiWlqmGqhee/Iav9ytD1HDQ
NrJuZQi978QJ+iAg/N31+5UDNYZ+AWG3h/MtfF09Lw06YATGnoiLR/zfC/tvYrNBqDTzS43X0wAA
WmMuNqN7YuVhoPl3lUE+CZjTiwKeBD0R3FyzbNhhTjJzudzpJLCf3kA0bIldNDY/ZS0sDwDgEStr
UwG5OzHBnur7K2+9tcvX1DpfUV2PHlb9iuYmL4faCtVUzSOPsN3XEjNfFFiMEobFvh4AwHl1gXm5
fjR2DYguujkqSed196+SkaJKtlJijY+4tp1G5LRkhHNq30ggp4X8C76xKn3wGxnfjjE52ZNkbJio
KDfzosnhFKTDJ0H8ecvgOxnr3ZuEZfW0lwAnNOTI+yRHhnqdDlk0KBmF/gpy95PwilpWOo9i0aAw
8rgcXktCoXOlsZ2xxTeYxOeyf9gymes//Fn7uH3Wmwp/XL0OY+KnbXuoFyUCqwLg9iXrQB1PLLmW
1aOPc+W7Ad+dbvzQFX//socK6WVeuWHPw0bmzZ3Iwt6PbCv64urZ/wXiv25laykDI28cO5+MnFI2
U8cCOUBHyDeZFg1X71ZVOyEJypfFKV9PwCOPiGTFfdREGlBqN3euqRoMQvtPZdmzNsOyIycvVMlB
VjHbCoFvXFBa70oVxluvoDyveDAwiRNCy+xT2o1n4PMlkFC212R36Qyy40VX2uxu9Cr+ARMXFIiH
4PkNr8Fg9YiD7FP4ABPCWRUCo5pSzfWXQvwlkET82+btTOgsfngT8smsw1nnnkwZxtJCFdfpwFKF
Y7Qt4o8HfQWE9tyNpcuDiTuTB+DYA1oWWQsTHZghKd8aS1JkkyrysfuwxkD2eY1ve9hjgR/IpfSu
7Ckd0e8b4hdszC3DcIEkj5i39F36YK1v72C0rvUvvNG6iy5UQzjk89M6QMJ/h1dnocBDynUd5MJc
jWm975UYTZD1vHxu+DQGyOuawKAXIQMV9xi/wfUQAEsfK7OxIANXKZRRWUIHIdbG/JvVc8PWqIgC
jX1mgN0l6KpVDQ+539fwWGKMYmeMAJDkrozBSZvFPQEPBJRq203X0N2fMD9QofoylAhfscC7Hj0Y
ihfZ+PkSO00YY0Tv7/NkcnaJZ4pr2UrNEhfnsQ/sGIc62zc8z+UlmYeTU3DSfj3aNpUv1d4T9Upd
kifMqVkQUkMSwNoYeRvoXV89qDA1+yKa0LTvWlSLjFpXOFxADih8KWT9IJ+K+WKY7mNK+4iGSoNl
pZBdC12K+0FXwY7OQhJ1G7NyVLNOzdWr8EGKRW6PsnqSTnokvz9lJIOQrS3H5pkkEk266NoBuc14
BCwyt4jlGqg9tin9t8pN1mqJ95ouE6ie4q8SEhjU5+jDHxnZyib5xKQyCNN7p7AHdvq7eX0FpLJy
tE/XGi/fTn48sHaYcSHvLEATJMouGg4G4kRnu48NZLNJg/nbGx1dv7/aofCPUSCoM2QGxMfn1ha8
h98SaCZ19MXPFT+KmmM9so3Pa3VUKj2xJO/zktX1klHaKTzfxElziX7V3M68K8xetZZnmNlAdAVO
EqJdU0r8RjLN/6KzJkpTy2Ujg9NBYXCudjqZICVVBilxwT5QZvCjsgQvYF8LMo7bgTPjVZvpisB/
LH1UrMx09LqWceEQzOFN9YZ3iEusTPeCGEcBtdpmOJqxOP0XymOJw5L4NU+BuEXFoU8B3n02/U6B
+UCrA8eGwHQ735SddUzZPTt9QIN3949DGHj+VIyQdegLkASdfbiWV8Eb/mJDO/ABx5qz0h8b4qym
KVfJk1zZXWg3dD93GS15IleSSKqAKm2YykmCPt3owdPzBRv4r6aIT7jiEP/LQHV97TqCtse/j3an
YkUxl/pVvFfs4mMf9jnSa4UgWYqDrJeRC5WB0DRjtvgvX23tJQ8TybiCLfYPAWFMhJrkEIqQFhCM
1sQy3ntd5jCJtnKNu2zO+y/epunoT/enkraVw7Y1ojUXD+faBoMIL7MEaAIFgm3YMS1Sk7vhrHtd
G46yBJBunTWW2VPW1jIGHZWLp+IsmAISdurzamhDA5ck8RGr2LaquQ2xsA7gLKrr23/nVzwVSw2/
zm7vW/xWVKrz6QpgFR05W1LSH0HxBMvuVKM1ibn22pEtFZMNdo0b8JqaJu49jvfG7N7ntcBsyoCW
VN0F3mi0KFytnUY7tNIp7WGycPubNBAGhQhwD4XvkWG08AbggNyV0LXxWHz1vrP7lLu1je6eJi79
bWdc+yY+YgSAyhtN7otXZUcwTcEFzi9nvkMCRsCjnUYP5OWWvegxp07ZHY6e2SIRiVt4gaGmayTU
oOcwzkoOIm14rOmLvNnEZ2Rb6IOYjhZxZt/QGkWFO/7HlwVsrIaWnPhvsu+v480KUytJG3rnnrUR
dpSAsUUuy+5+/sHxeXxAC99ZlQRS+dl7CuG6wGADfMiF5PBdNxW2lrhcexznc5uZwvl/GJNQzriA
qKG6rdejgknrDBc2usJ1X1TmF5ewTknKcSa2q43EXfPX+HiGp0FePYG9nM7CTbkDt05xJggbz0oR
p1ECuYXDeYBTf1aHZPp235PZDsY9/7IUHvOkY0lusyLfzA7EwfVccz2MMgIUvkHCieK670RSYR6u
n865p7Khwz+qXtmgTWj304XlzlXZTlJ+QmZ2FCIttNObkfxSlBIFguwYcmrXpAQMT9HXBEB0sfEp
BaapyeOjPkvWt11y5y4TNZYGQtdIfxew2CygGWU5ctskgrKFOg4hAz5V62XYijZEIP4PlBiW0DBm
ov4AWAdc3fj14eYe8tfyz41KebbTF2aCyjLJRY+DIQSde+HfSUdrUCOsmIu/amuDvsBZW83akNfZ
VUiarhArs26+7wWCNvoZOTW2oJfYWIiMYeirDObhYxSv76pb55gDG61Rlp7LrB3QN+9XggZZKF75
bvKDWJyMPf1NOqmm9gD+cIviy9L+Gla/7qvvZ8KOke58he1Mae6fVXRQGmvqfwvH3piSCgtj04mZ
hhDOLIsFk5Y7jykfmnPKzzvoRwT/ZfOfv7pzGl5QaU5nvLDax6zEIWu+VA4QxHAu8fU960xxoOHV
atWkru+ZStXiI7S4R90xTEYBvaRjf2YvFLf+GJ/lfW3oGgcNiZVPIUes5+j05yUdKwR2WTJ3YVD8
aDXVYicfNxqmX3FCJ2uYIICbQWt+NIWRq18hXpPo4SQoReD+7iaI9wKyn22Qud/OWb7x0UfjmS6P
zhdcxnaBAwD7d9IdOiDWY3gQbEjgk5iZ4u89DAjTVGp08YJqqylHMi0ANUDXVxg6yZbDnVZoPxAo
5srJuWRoT0Lo2SNi6NMAij52SDJCuJiMbJZJOvdY3XEwljURuEevnjf5THDeO7CGzM1kuUlQnopR
nygOKIMH8bK4LvBrdH7Az8qTuekf6Y7HtpRLJECoiI0zGeGJa8DNyJHjaTY2DwYs5Tx5FoGK8zZs
5fY1LqoHFvUQqQ1CIYrJ8LyRbUaabi9wJ/0UHkT8FIlZDftHi2Bj8SrFjZLEKBy4lbjxDhfhHyv2
l6f09K0k4XyBgH6klGfwYAbuvKIyYxyYsRQF77CRYsnu61FbwO2JN12QMZDKBUd7J1Mdeh80q8qB
6PXj7e1lpspYIUWJaO/fLifrRNxAvmpUhdhC8n8+DYPTdBeCZiAFELYG6sixbMKCMoBYtHkmxEIA
DISRmNh9Lw3beNxU8lnEh83S2+eHnYi4Cm4OxW87wyrsr94drstL4aicC1+E+uVt/6xvSNojx5Cr
z6jVqUyhQR8M6g/vmCO/rAjiecIOElq9H4Dwp9TbLTm1RLJVnpfXVayVZ+zuHDlw9dMPs0LljXu3
YbLiGWEh68MXuoAK+0ZlCBla6Sni8QJlLKQymJR+15UxiMfEqKfKGNNFdg2OiyrOq/v4omXwSkCc
yFkiAaLgKfvhwpN9EXH/hrEmbMItq8Xn7cxXgh0rGFjnI7xxuope2QuHAezXaer0E2Vpq3yodzcm
sf5nUK2P/ueToZ8bc+uJ1N83zJYU9tX8zvKuzxqb08T4bZRDDWf6q+iSRBwVz3B4n/Yx9Gxphc36
sFz0Ed0fiVQ0Wk96x0KVwTYojVv6I7ePdu+h6nOWmSHwXt94HA2pW7FAXjEGK07D7MEX+F5/tNBC
xbuUqR+cFjxJ1dPW9Zo+q6AvHUai7EKdd7ECdA6SNgaeKDRseFBFXKSS/XGL5N1B0aFY9ByE3T+X
LEvtUspnMZh/as0UalIYkEW7viNbkk366BIgNU1VUZKqjL5akZPg9RQr8FIYZNyirCarKzMDOYiz
2nhbp+HLy5dPqqdW8BpZbZOf9mx3BJOqoVJ17cX6fhVGStOuuf2F8ph42nghR+27IzizPC/x564t
yJXCmO+TXBTp5QC7dU8tyMSe2TT1yHRvn7VQz0q0vx1mKQh4zFAgR5b/jPJ8ld7yL2o4uWU9s2V7
LAZxFm4izNXbiI5Nb9srQeYwxn2MISQP57LYqN2IA/XHriy3ukZofrfR57D3AiZLIq4v+5BSmo2g
eHpznue4zPyOG3abP9goykjBGFKif9G1zoq5FGAl18jRG/7VgLYA3Ts0n0v5lvzhmuRPGLy8Q0di
dwCzfRxeMqGr+Cdj+M5Z1m+tmiFLTvyEk57uHmB4fmQ6encI6HVRT8BYotMluV3UC6et3OfbyvhE
Av1CAgiN8rkI+szkUtFntrco0eHBB95GsSrsU6H+UzOD63CBZRZlr+Gj+ZpL/C94Hm899/Pr1tcA
gOQznoBg4EU8vR8IygcxyUGjUEMGhDls1DBhhOCRVnMqA9cTyiLMzl1Jf0C3NxEbaOiEhqB5gzCn
Gk4EXWYMiwI7dhca8aMEVj8uoYsZ1kSo4yGmUtnGtUZmuHlB1PR3A0rxgrDcNBs9OdYql2F+aGg0
gLBFtfE37j3NALgg9S+pXpPwiKkdJDJpz5eTXmWvaVt/Y9Rxzba+n/+1zHgLa5a3ffz14j2qF328
/RVsJP6t51wGTKpRsblpwEGReF2TocObNmdCw9ndeZLycK+Da6fgpwEHB/IKOVsulYTDiTVUKlI/
EZheCYdbtfJviHiqvEbdMDqA1XV2fO1gNvpiZEgJKWU0whEzFTfo+18kysfRlwfnqNtj1UXjeb3O
VVBY1vjoBs7Y4tGj8dJel7z1Kut2ZpXOkdXp0g0nT1pKVvWMUKyBUWGylLfmywE4Vyh5Zz+gOcWr
uul+o7uWoEuKdHHIY3DVwwQK4ldBHPbWOoZ+xcCN7uumzG+L94Hx8PmuAe5altz/mQ6eHZO2CxQX
HfuiMjH9uSfurWtxg9N1L2ktNZ3bsy1jdFO7HVGlLsZyA2cBj12KG13HNaztViZ3GNp/WahDnK5H
lZiV1SbCypTo0iniL3zl16iZpqnLKnee1V2nX20U9nbDVm0THiu3e6BbjLafAigDHoJsoLagfydg
pyoWLyE2XIrElzfuG1xNEHgjYgmod0VtcT2N6aXPBJnWQyIhj7xYTkA/di3ZzsuAJkpsECyjtOpu
KOnxy1NH37arl7e2BNax7y7QGihjr8c2lBZQALTnXb8Gqt/k/FqrMm48uQRmBJDxAumZsviMmXoy
PdpFYuDAcGZpDJd94pe3P/dgKmYgIEDivbSAgQ/t+T+RzdRC/2k1gc1vf8k8bHUorBt/KER/A9tV
j5/PMZuiCWEsj9C/itqtoHWF0/bIAq5dvJsF0Xd4sXAhJo3/u/HYx1gaNHbkFDBQG3OGVYEassts
w2zYLgMJH+2ipGWh4U7TyXB8aHLFM5jCewADxMSpot9H8SUVubctY8vTxO3WW7Y0TsUHgD29DT2q
t9KV27Rrwav/Rh6dhx5Sh2HOrDY1vDuRcgKT7yEYICGlfkVa3xFE3KpJE6LNxP93eBsP0g2NlAvb
M1YbWa60MVR3t3aMhx91XTF6GyONFX7W40/dIKGIZsbSabeakLzsYTyewjt2NpSsQr+WK1S0NWbh
EtSeeWGb2VDRN3MrfTlqxactjk7L3uMByxlyv/J7xhmYGxusv6g4YLn1BzGsR4Lg2Y7fVXEEwyH5
i5VdMZllG2GseP0BqsEBfbvLfSSrfU2zFlA0TcMgLEytv3HhXY1Ye67nFGwgb9XDeCopXm2H8Sqd
k7rl/llGyGBdj4KZyYxC7lML1uYCzBMMkSjitV8cO1agP5ESt5deCFiv5knEi7QikFyXtM63U9Bp
GAnDWNAj7s9BSOINCaiZeASgLcoVHUvVcXpBAq/crV7w9+ybBgEJ3cgVtZTAH8AY7+NSPLF1ohOO
qsLuK2zUGCUjR33JM44PXRzMdPc6ghQ4malnFZsxZwTZaVx1nRxLFkutnqy9O7K+YxCwG55Fa//N
hLoh4qLKlpPgH9barnqNbcuYJhTozufFCl9SgqG47r0v5ljEQUIVBJqr+hS9gXPJ9P49PlfLO1J9
CjH8OBcNyP8/TbWKs/CF1wLmd/bGTD6R36JvHinooL8IKkoERlmuw17BchsWWWIkxb5KdvzUv8Nj
fYDeMnVw+8IxaNUisgMCNTLmuXV9XCVgvaBGW/hGA3bmDMHpNLaKoYz9LQ5gSvH6xtbssp+yeAcB
pJbMCTF6SuWenYv+a7Z5bB5Fb7zo/u/vdzZ0uxuLvM7F/lxhBR2+WIOHr55bQ8XYHpYZcc9r0QPj
wbqNKKdHgdqMFS/oN9go7BavIsA4ysXBDjk+oHTIlxN30kp+dv0CtVnPaKGayfQHRmpm6fgLIxwG
NMioA3cZEIjoIpka5hVZqhYx8JGerAS+gbcyOE8JrX7P8pLk9yNCgVfzgKY7L66g+iARj3Cd5M9b
NYMSR6NMzRLH3GDflF7fjB2/oJERrJhLQpvqeXCiPgsP8CBuokVFr/wWEw/jeCrMqq3JlZaG9mPk
8p7/5iQjW0A8JSWP/EHX/Dg7z3aUx2W8SrH5ghMqPwvWK8uR+pnfZ0TK0dH12a5uOYN8rFxb2evj
ehc9FulSnDSN5J7nUTeQHM0Q7Y9fbMWsJQvsSEfzIyRQJ0TToIKOJbx73li8p1rNrNDcJ5DepTwU
QcNUFC35eK50K3ulFjyZZfykfvW9XYiRdAA2bXBY/TJs//9XKz6kW47JbqZy5KVVzSQQj9j/N71e
T8NaO3el/WVF3A7J5//WhGK+UzO0OBCaVIbF4fDjCYS4QUr43M6eSsu+m8i0oDtHeve6Skb7W/Fv
QbvnY7s8/8GUNrwr+hiXcs5RlZpUvMi2Ai/tgqdbbWeagLdhaZFVPmAtJCWg7TC6gjZ9TKxwOhrD
488O0iG+X4Sjn8b3sK31M7QOA1lZ5PGdAT+x0HG7628kfz7AHIdzhulFBwh1axsMZANoiMl5sb6V
acRUnSBknJExmcDfQRZ0kBBY9JzokDZslaWVmdgnmWI4dnFjfvshDpTC/us4TdIDr2iT51O/Aj2o
ONtuEnJ1d2vouv+6douEto5eUEJg4GhsMRwapQL6HFfe4p/sFFG2gXgL3+Ycb3h5SI2IOK/L09Id
LwUhLEaqbnD+VrRL7guNmbJmEcl9h8gWrzq6RAEpAbN8n/LAydSjSsAzpDt7OV8TPiSjVzDqZW7b
u+vJNHznFQe417CSHnBiB6UW2C4g1AoJ2FgfDBFDzrUQUY3QWoOB880c7Pys+lpEIOiolNvfxhSO
qcCyCmqru8ZBtWYYPfAhzPdQHeMwyAvVdncaUkvvQorQECFLYih9tKS1cVX3LVi6bAkNEjqh0gWg
I9+Y9Okz3jRX30rFDT2I57jGZP7Nisog9F5q+VMmZ7ruDGnVL2Z0mWjQccd2atrZC7Av4bbDQOw9
mKvFEdExeUFOkGoGdbpT84e6em9sdyKhl1SkHTG6otYcWL6RZl0e+p9NICTejdeSANqgxqiRapQo
vcbRJegG9/yQnE9yzJpmqKkhpdNZdLOG1vQW4PgW9ZimUubMCJYSABfIE9Y6HYnB7vGck9CL6Iwa
U0iJI8EM3SqvbYxofHHCDlXwOXTfV3JIwgh9GVL5cwVV4rp81e4llfcYgqC0uFrj7CL1Uf6XUDnc
xadpt4/f3wfauBgXHUuqwr0wa5pmoKWLGBvwUJZNMpRl8gEySoXTmaP5PF5ixL8qXmT6Tq7kiiyM
KxyWyBp9ZSJNVUbkJoL5x7+llXXeWRBIYGofjHKurDJ0H/ZyqN6l/nqM4/9LE4Mxt+8puPGFUyzt
Jgjinkef0m3wuF7LssRnQIZyAd2pv5cFe8b/q8y7lXeIyYY2gkC7/VRMrbE5PbQrPalnEjUBWXiO
1GG66Y/ejqTm9aHsisw76twMCP2ji3RKgn5AMD2g3R6yTT1FW/UQQieJ1TZFkh3vMNoTpC1adkSX
BczV2m3W94taUUaw467sJs0ew9G2YHm8atODFs0mHMaJgm5F4KsRID/uGzENoX7iycZoyLfiXqTn
cFiuHN7/NaKRCo+LgUXZhNi3ZTCUpzYMNYZnBnIcogRLTzMA9QW/JMXl3+nlAwPfnMfk8db/63qR
nPy3Q9Z8GnesEXk49SNwPHDo8Adrm01VWremLEqYMKBRQmZng3eJu3AaKv+V+vG8igbUvf2CpgGb
mj/YKlPJtuELpyHXTNygua0pIfLEyag4GmFNuSv4L1fAjSQuBvJqtTxXfsPWxC2zTFEcNE3OupuR
lNgf36qiDP1vb/7/qldK6hx9EjMCuR0n29Jn/e+8Wi/p479rPCsv+1hOfcPQlJESjOVdyyjWuZ+V
HRN4PTJLWzQcIz6KFiVZOP0yLJ/TXn6IC/Qd3DB5o3YOj3Ms+SLzY4VvxH/c2b8tIilgVR5GzDQR
Ew1d5er9wGT0FzSNJA03DMDv/CWYi7oFuccHVRf0MgHBTgpBvYyOu6fruj8C0DFnugX6wKLrT0va
/AF3YyzJzLZg3TIICc+xliCLd0BtZXroQDa9AoM4ngAhajTfTBl6QfutqczWLabhgAynSYaGhMnk
zSk7onYLf1LfJ3jAvrpAfBH9thRZT0rjxohvksPDW/00Mga5qFIZL0frL+Uuq+dn4wLnzC5MO+4m
ErWoPfXj5oyt9xZAlCipHTSvhC11xuhXj+9wtuC800fWQp0gjCWsz9XJbxV5eM6lpRs9K+u99hE3
GqCu3aMg4bMnLQ0tdXFW9h4F/zjRinz7s/sEkor9O1z2nl6wOJPS4B6NbRwheCF9+87/U8mrD2Ll
svE9NAGMxl4Olp3gcgan/0nrVjidYKE5QdH2weL2OeN61x3yYoDIFBpLmzGzcUtkoZ03q6onBhwI
iTzf2bYO9bAYL+QvA5aRFfvwfI2tMtgtarWtCjW9Mt45akroePpDSEWkXYQ3RHGe3dMVe7Pe4qEU
Bz9CPhVk69FfYbN4OHmjlZJYV/SQRRBDUQqVPQvfiy4bHf3nl9K1sIQ2db49lrR1wX8rCZ9aO4F8
cRsoEihJ7o7vPNv3L4O1WwHCRD3jO03XDo86aHdz6qVcOCq3PNyVbW8epnb74cdWPsWba2W3dJ94
7ZtXBwoxj3/gSoe7E2o2GhNhaVtqLEcbzv7b2o51dizHp0l8ksR7ctXz5Yopll3/SmyJc2YV52AO
+NzxauMlDppV9OO7Hp26iTJirDap+ZBncJNmZTNNhpaBI3RuSYESyf14lrhyu4nFwmyQhxzLaCuc
f8NOjfk2CzaYmd24hqqJkASoIirOtD+nhLS29lY1YfVnek26bBbyDvcgAgZ6k+ku2Jx9vHlsiJCR
/gUT3PeOA+l+e8M8bHoRefAH8pEpSFyZHoMom7E22dStonIqJD7TaXu99VWq6OETTZX/WPo/LlPe
XHV+QfIC/D/agy01PO7tJmoenbO7rKrG8odSOa/8RGgfuOYin4+Wtde+Vbfq+FRSOiV+7nqCzPt4
XnNpG+zj3lklrjJ1Q2OUo/bIFexdETmz0nMIatODghJrlq8nfpuPoKWJ6g7JgTp3I1Dsk2YnHL/C
XFKY4sArti+/nq3q3hEcim6Ah3c3/nSyJwkEJqteehORrfDRvguI0HKfJzCpVnMZT3heZtWrOAoN
aeKC25hX3wdl+kUVR5X+jDabil16o+M+lg+hyNEfsWUu9/EP1HnsAEs/0XhogVQlv4ABKZdgKiSv
GX0oFDLvwXVoSr3O/Upz0x2cikvMbBJ0HTqBtAbTKmtUvN8+esOjl+tAOTpSmIUEZPIltk68aXZU
hlMvmFCDK953xPlaE26ype6mMnQQ9mRZTWoHkoNVDpqlth/3/AmyX0ga+8GtGxssMN0H0qHpynm/
LicZxenLWTzevd20VuFiHgF1sfBQeApkit3MU7qlLJzKpXTGKFJlwgSsORFZWMnPU5kAz0Etj+fZ
MpjyVX/tvoxU5qdL2nBHrY2F9PwxtH7Q3V7bgUkFK7lHLXazmeqzgrlB0cnF8aR4NmdNVV+0Q7S+
Tb4jP2R5fEVz/7fJyIlNJmtkFAiGIGPxHWczN2DUvCTr8Hm+j/DDuZZcfYzaXEo1qEIlBdg5CM2u
+Kfeq4tmSMQG0vigqnm1l/PA70XX5SkbDatPyu6pQ2V8c6HBKW3sIpacBErpiH4JSSCDnm46kzT+
LwSyflwimTutiG/W7Lr4nNKXXx69Ma3LjagFYhU7CrMHbL0mHZq6gxS9Bj7+dChsXe8+YFw3jA4A
CT4y/DL+IryZQKGK/DGkjPCeExVOdJAtR1r8mJtIA4viHMkNF//c0sGqdyIJ6TQpEHXa+oKFBExf
TIVSIEsrdj9ubEP9QfSVxDHTbhlNsYddhtM42g59HceEZUaYrW07HgfayEhzHYJHGFftNt6QWzmB
mAGvjAWflzTae2N40a31r3zrEVaYqtc4hxhu3uTAmo2lwNY8MLobJpIWagEUaozO+/pdh7tpOtTe
dzR7aVTde0uCxZUp0vjwZ0T5ZubECtNGp/Fv/8ObyDVNgJUg13WP5gK1Ar9L9vDRcqJg4S9pUFy+
7eSUex1U6ZbiC0lwTCrhgp0OWMUx3ZBXhMghwDyAJBp1cvNWFJUUODR5V+zqTBUhNv3DcTRYozM0
lwBcRlr6zI8l8koYB1HGNepwyrIev86lhBBA+/1ZIAG177PsSzR77dk/EzTUJkp3KNlhxqnRGboA
BvZyivCs/mzP5iYx4mFvZhuQJxCI+RncK9w4FjSfmFV4I5I9ixWinwroc+0VXD8ZU5pqQmjj4BTB
lkPqM//ZPfPPkrBkv6daGCi2uBxAn3LTIceVZnqEnoojmsdhLnCNWH1I5EC2F7WOk/N8/OILlfpG
/4uyjq+iduLbdv1Z8m9NklxnRofnNX/uJ1cDqG5l7jFWsjWOadKQBpHARRpaDb7JXEgVXeGOu2DM
VcgTixLNGGN0hNrjZ7CFEUxvWvQhLJQmj6BIvpN86r6qEZ73/e6J+tIbGW5WcEvIQCCWzS07J+Ch
kGQN5yU/ynuNn8FjrXUtRDxGNtQdrAI8/jSWUTbVjj9/p21tEs/2M1nFV/cTfnW6EaIsiJiRPgft
40YEF3XqrxPOZNvyQ/THupqupEq6NK4egn3TxPqlLEshE0Gp4yWx4e+K/LX716f2A5LXuQ8+3EwW
kzU+u8ae+xyAszZaistq5/vcJWBx1JT5r3Y2LRjl4x3IgeyeuIOFzCo4MltCHzC2imhpu/vFdLAo
z6u8kssJVJjcNqiRn0hl6HhOMP4zKtDtL3sc5K7MuvwFRMJfLoR/6bnyILZzXAqTTMe7g5nsh+mg
/j2VlgVH9cc40zYkB6Nb9c0vsY5zoBLY6me9h6Zfkf36pqcyV9NIW2UCxnVBHOn/XmWpzFRbiblW
87TkT2H3X5ffxNBY3MGaYfIwNehqF+BJGbph6EK6EbjG2MARlfXovdnckGyQUxtVRZT83MXqy96D
zCgSxkE0d9i935KAmYe4MGC36djtnOYiwV9Mgh+fKt62ok430F/djL8paQUR60ru5MoqfVDwpIPr
zRjmVrzOi71cEYr0YwFeL6IUxMCV7S23o6Fx3/GJGlGIsAIHhSPCsqb6Bu0RYRA04I2RHydFHE9P
/4hitJ0+sAfzLmN/v9SVzqZMC7+14fpKwn1PDdE+P+tHQosLiy4e1V9sqkgepWkaXt8NQupQ9mj8
jIYbmRLA5nx0TC39RW7MiV2AJvH3NumrZquJ/lSdU6SM3eLnw3jU65mEEPD6aMfOJ6jc9/wVMPU6
FSFoB5Dx20sYF6dvYsCOUTeXKlVc1ePaVmaPghvchIkYT88IjfBdRKED+hKPXEaNFdsiVKy/d9CG
nJ8RAjAJAtegVQM5lVggrTm0QbiT7oRz+atkLMpskr+kLagVe7FOQ51loyJrOy3dI5EAsz7YKuDB
5YyFc+xDqggl2TFkkbiPg2aGo4kpnPhevW4S9sDEH40rhY2S+zu2L5DhD9YpLvsL/akEEeVvjtxA
V+8tARcsJhvqzg8T5yUWTSCedhpAID3Lk8Gv/wkxTvwdl78Hj/bATNV03rFLrzYCr1Ix/UB0bgaP
MbDHleg9k0zXp3N/TT7PgEymEkHOr01Jb+jFOklU9S1kXwPOXVJuOUL3/pjIn3xaoWPb0VK3QFM2
equTFDR5r/fOFDjpuMWxrKjMqudrbFqC81QGERGdOysnmhNI+2Z4Jbbyf8RGT3WGxC8yP4VNbh8e
DsHpGRtwJvU5ixCk7FApV8omgqVFloGNVCKXHdF6sxXxHhZDPe1mch+92L+6GPtcpZgeC8GZW9Zd
e7tqqU/6JwJBOwxe9xvKwjJFcTE1bcd/a0juIH7Zm//jGQ5xWF4aLk1fA7M0S3HCSCpEaFwUG/PY
q1oKlV/D2FmdlHMcXsrJT1BuEyIUzLROAdq276whAhEealHnVGFyd/dUivw54m2sIbq9G5Ue3w6a
eRTMes+5dShaxk3APHAxF5lmlkTWQfL0PzcgNRipYzEmto8MeYb2rIiQwT/1bqtRbaHywT0AEgeQ
k3l7vKB60eTE0Zj+zrLm+CWjIe/3WHRbKjxcfBzZ1tcTzDO8kEWc14Pe4mxwfkHXvMP01bpccMSf
DM4brFxku5iXdq7M78mhKDQfnEfCfI+37dc6Vj5VWxQ6pu2iVbLJv6zNUxE2P6X9cCOgblr6Zxo8
ldvq/AxIXv+nfXPWDVieiNQ5Qot4PavS6NGzAjVPw1iyXjpwhRNUDR/3+51Pn2IP66+9+iSdyBXn
Wt7+jhF3Y1pu5gzbFoceOmyXD68fAeZLn7y+4odQLAFI/sBW6DuoXB6k4GptDgfstCwzRUeCtN+n
SBed2gX9bdQGkVGoajTEOuA7zLqusNA9SWUJnMM7BdaPjBZ7jRAxTuXwzlVs7wYA+3DsTJniFH/G
K1rM7NT/eQAKCDMueRoWfJ5DkbENeOg+Maf7kQLctGYQNDqksjLKsA4lai9ho/Xq1PvI5CJrqOFW
pA8iS3fLxqfBlYzFsVvRkOa8m6vTfwMf0ZaK1yvJJOSbmGeTiwfNcx9xIkrkHRX+VannTkGza2Jr
CEuWqpCqtTBofNbE5/xGYejmXvMjkeDW4sm1C0NqTzoAixUsJMyBhuEytXwoAiUtg4CUj/el0EH9
Iib5JjZnIC7NESDlNYpdI9VJ/M4FOuy0czANJYQlanDy4BamDsRRGIZhf7birp8z9EJ56PWxzeyx
BUlBIMMwd7jSufUyY0KHt8H+iIucSzOc/TvSr01X3wVyRfn8tIU8mi4Upz7endHuTV9+T4Pd8wnM
4jRrn7t/jeeugZy23aeD9EMi8nSIVgB7/xdOoMyoGZ1xButWtzADLSgcONgbhnBZSovrw4wsM4Rj
ZNXYubbm2lRTiMzMBKi4Xvbc0SCT32fkIu7AxL290+xnpVeZrUVy4BGyA9toGOtbqP11FnPVYq+R
dvGTfCVypk8O0yIBc0RGqlsmzikxVuL1/x4ZbWpuLb7fNM6DIYDOcK7CTOjJE87eZLAlHW8/gdLx
smdr+uq1q4/5tSPSHXei46uRirZyzw==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
