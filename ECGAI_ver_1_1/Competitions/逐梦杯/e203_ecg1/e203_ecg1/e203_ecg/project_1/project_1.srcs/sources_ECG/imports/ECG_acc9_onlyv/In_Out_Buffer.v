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
	input                   [9:0]                        omap_addr_span_cnt,
	// Signals from Memory controller
	input			[3:0]			nn_layer_cnt,				//	Current layer index
	input			[8:0]			wr_addr,
	input			[8:0]			rd_addr,
	// input							SPI_start,		
	


	// Signals with Input_Regfile or SPI
	input							Mem_Data_Ivld,
	input							Mem_Data_Ivld1,
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
	input                           SPI_start,
  /*  output reg [7:0] sf_maddr_reg0,
    output reg [7:0] sf_maddr_reg1,
    output reg [7:0] sf_maddr_reg2,
    output reg [7:0] sf_maddr_reg3,
    output reg [7:0] sf_maddr_reg4,
    
    output reg [7:0] sf_mreg0,
    output reg [7:0] sf_mreg1,
    
    output reg [7:0] sf_mreg2,
    output reg [7:0] sf_mreg3,
    output reg [7:0] sf_mreg4,*/
    
    input [3:0] ft_N_cnt,
    output reg [31:0] SF_FC_REG1,
    output reg [31:0] SF_FC_REG2,
    output reg [31:0] SF_FC_REG3,
    output reg [31:0] SF_FC_REG4,
    output reg [7:0] SF_FC_REG5,
    
    input wire Enable_trans,
    output wire Busy,
    input wire [7:0] w_weight,
    output reg enable_rise_reg,
    output wire enable_rise,
    output wire wait_tran,
    output reg final_flag,
	input wire tran_start,
	input wire mode_cnt
    
	// Signals with ECG in
	// input							IOB_Data_I_vld_ECG
	// input	signed	[7:0]			IOB_Data_I0_ECG, IOB_Data_I1_ECG, IOB_Data_I2_ECG, IOB_Data_I3_ECG, 
									// IOB_Data_I4_ECG, IOB_Data_I5_ECG, IOB_Data_I6_ECG, IOB_Data_I7_ECG
);
			// wire					IOB_Data_vld;
			// wire	[7:0]			IOB_Data_0, IOB_Data_1, IOB_Data_2, IOB_Data_3, IOB_Data_4, IOB_Data_5, IOB_Data_6, IOB_Data_7;
			
			
//*******************************sf test  2021 12 7***************************************
                wire wt_Ovld1_tmp;
                reg [3:0] sf_cnt;
                //reg [7:0] sf_addr_reg0,sf_addr_reg1,sf_addr_reg2,sf_addr_reg3,sf_addr_reg4;
            
              /*  always @(posedge clk_cal or negedge rst_cal_n)begin
                    if(!rst_cal_n)
                        sf_cnt<=0;
                    else if(sf_cnt==4'd7)
                        sf_cnt<=sf_cnt;
                    else if(Mem_Data_Ivld)
                        sf_cnt<=sf_cnt+1;
                    end
                    
                always@(posedge clk_cal or negedge rst_cal_n)begin
                    if(!rst_cal_n)begin
                        sf_maddr_reg0 <=0;
                        sf_maddr_reg1 <=0;
                        sf_maddr_reg2 <=0;
                        sf_maddr_reg3 <=0;
                        sf_maddr_reg4 <=0;
                        end
                    else if((sf_cnt==4'd0)&&Mem_Data_Ivld)
                        sf_maddr_reg0<=rd_addr;
                    else if((sf_cnt==4'd1)&&Mem_Data_Ivld)
                        sf_maddr_reg1<=rd_addr;
                    else if((sf_cnt==4'd2)&&Mem_Data_Ivld)
                        sf_maddr_reg2<=rd_addr;
                    else if((sf_cnt==4'd3)&&Mem_Data_Ivld)
                        sf_maddr_reg3<=rd_addr;
                    else if((sf_cnt==4'd4)&&Mem_Data_Ivld)
                        sf_maddr_reg4<=rd_addr;
                    else begin
                        sf_maddr_reg0 <=sf_maddr_reg0;
                        sf_maddr_reg1 <=sf_maddr_reg1;
                        sf_maddr_reg2 <=sf_maddr_reg2;
                        sf_maddr_reg3 <=sf_maddr_reg3;
                        sf_maddr_reg4 <=sf_maddr_reg4;
                        end
                        end
                    
            
                always@(posedge clk_cal or negedge rst_cal_n)begin
                    if(!rst_cal_n)begin
                        sf_mreg0 <=0;
                        sf_mreg1 <=0;
                        sf_mreg2 <=0;
                        sf_mreg3 <=0;
                        sf_mreg4 <=0;
                        end
                    else if((sf_cnt==4'd2)&&IOB_Data_O_vld)
                        sf_mreg0<=IOB_Data_O0;
                    else if((sf_cnt==4'd3)&&IOB_Data_O_vld)
                        sf_mreg1<=IOB_Data_O0;
                    else if((sf_cnt==4'd4)&&IOB_Data_O_vld)
                        sf_mreg2<=IOB_Data_O0;
                    else if((sf_cnt==4'd5)&&IOB_Data_O_vld)
                        sf_mreg3<=IOB_Data_O0;
                    else if((sf_cnt==4'd6)&&IOB_Data_O_vld)
                        sf_mreg4<=IOB_Data_O0;
                    else begin
                        sf_mreg0 <=sf_mreg0;
                        sf_mreg1 <=sf_mreg1;
                        sf_mreg2 <=sf_mreg2;
                        sf_mreg3 <=sf_mreg3;
                        sf_mreg4 <=sf_mreg4;
                        end
                        end           
                        */
                
                
                 always@(posedge clk_cal or negedge rst_cal_n)begin
                       if(!rst_cal_n)begin     
                            SF_FC_REG1<=0;
                            SF_FC_REG2<=0;
                            SF_FC_REG3<=0;
                            SF_FC_REG4<=0;
                            SF_FC_REG5<=0;
                            end
                       else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd2)&&(wr_addr==9'd0)&&IOB_FC_vld)
                            SF_FC_REG1[7:0]<=IOB_FC_I0;
                       else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd2)&&(wr_addr==9'd1)&&IOB_FC_vld)
                            SF_FC_REG1[15:8]<=IOB_FC_I0;
                       else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd2)&&(wr_addr==9'd2)&&IOB_FC_vld)
                            SF_FC_REG1[23:16]<=IOB_FC_I0;
                       else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd2)&&(wr_addr==9'd3)&&IOB_FC_vld)
                            SF_FC_REG1[31:24]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd2)&&(wr_addr==9'd4)&&IOB_FC_vld)
                            SF_FC_REG2[7:0]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd2)&&(wr_addr==9'd5)&&IOB_FC_vld)
                            SF_FC_REG2[15:8]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd2)&&(wr_addr==9'd6)&&IOB_FC_vld)
                            SF_FC_REG2[23:16]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd2)&&(wr_addr==9'd7)&&IOB_FC_vld)
                            SF_FC_REG2[31:24]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd3)&&(wr_addr==9'd8)&&IOB_FC_vld)
                            SF_FC_REG3[7:0]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd3)&&(wr_addr==9'd9)&&IOB_FC_vld)
                            SF_FC_REG3[15:8]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd3)&&(wr_addr==9'd10)&&IOB_FC_vld)
                            SF_FC_REG3[23:16]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd3)&&(wr_addr==9'd11)&&IOB_FC_vld)
                            SF_FC_REG3[31:24]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd3)&&(wr_addr==9'd12)&&IOB_FC_vld)
                            SF_FC_REG4[7:0]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd3)&&(wr_addr==9'd13)&&IOB_FC_vld)
                            SF_FC_REG4[15:8]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd3)&&(wr_addr==9'd14)&&IOB_FC_vld)
                            SF_FC_REG4[23:16]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd3)&&(wr_addr==9'd15)&&IOB_FC_vld)
                            SF_FC_REG4[31:24]<=IOB_FC_I0;
                      else if((nn_layer_cnt==4'd9)&&(ft_N_cnt==4'd1)&&(wr_addr==9'd16)&&IOB_FC_vld)
                            SF_FC_REG5<=IOB_FC_I0;          
                        end          
                        
                        
                        
 //*********************************read cancel***************************************
wire wen_ram1_0,wen_ram1_1,wen_ram1_2,wen_ram1_3,wen_ram1_4,wen_ram1_5,wen_ram1_6,wen_ram1_7;
                     


wire [7:0] IOB_Din_00,IOB_Din_01,IOB_Din_02,IOB_Din_03,IOB_Din_04,IOB_Din_05,IOB_Din_06,IOB_Din_07;

 //***************** ****************************************************			






			
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
			if(nn_layer_cnt <= 4'd6)
                            begin

                                if (nn_layer_cnt == 4'd1 && omap_addr_span_cnt ==  13'd56)
                                    begin

                                      IOB_Din_vld = IOB_Data_I_vld;
                                      IOB_Din_0 = IOB_Data_I0;
                                      IOB_Din_1 = IOB_Data_I1;
                                      IOB_Din_2 = IOB_Data_I2;
	                              IOB_Din_3 = IOB_Data_I3;
	                              IOB_Din_4 = IOB_Data_I4;
	                              IOB_Din_5 = IOB_Data_I5;
	                              IOB_Din_6 = 0;
	                              IOB_Din_7 = 0;     
                                  end 
                               else if (nn_layer_cnt == 4'd1 && omap_addr_span_cnt ==  13'd57)
                                   begin
	                               IOB_Din_vld = IOB_Data_I_vld;
	                               IOB_Din_0 = 0;
	                               IOB_Din_1 = 0;
	                               IOB_Din_2 = 0;
	                               IOB_Din_3 = 0;
	                               IOB_Din_4 = 0;
	                               IOB_Din_5 = 0;
	                               IOB_Din_6 = 0;
	                               IOB_Din_7 = 0;
                                   end
                              else if (nn_layer_cnt == 4'd2 && omap_addr_span_cnt ==  13'd14)	
                                   begin

                                       IOB_Din_vld = IOB_Data_I_vld;
                                       IOB_Din_0 = IOB_Data_I0;
                                       IOB_Din_1 = IOB_Data_I1;
                                       IOB_Din_2 = IOB_Data_I2;
	                               IOB_Din_3 = 0;
	                               IOB_Din_4 = 0;
	                               IOB_Din_5 = 0;
	                               IOB_Din_6 = 0;
	                               IOB_Din_7 = 0; 
		
                                   end
                             else if (nn_layer_cnt == 4'd3 && omap_addr_span_cnt ==  13'd7)	
                                   begin

                                       IOB_Din_vld = IOB_Data_I_vld;
                                       IOB_Din_0 = IOB_Data_I0;
                                       IOB_Din_1 = 0;
                                       IOB_Din_2 = 0;
                                       IOB_Din_3 = 0;
                                       IOB_Din_4 = 0;
                                       IOB_Din_5 = 0;
                                       IOB_Din_6 = 0;
                                       IOB_Din_7 = 0; 
		
                                   end
                            else if (nn_layer_cnt == 4'd4 && omap_addr_span_cnt ==  13'd3)	
                                   begin

                                       IOB_Din_vld = IOB_Data_I_vld;
                                       IOB_Din_0 = IOB_Data_I0;
                                       IOB_Din_1 = IOB_Data_I1;
                                       IOB_Din_2 = IOB_Data_I2;
                                       IOB_Din_3 = IOB_Data_I3;
                                       IOB_Din_4 = 0;
                                       IOB_Din_5 = 0;
                                       IOB_Din_6 = 0;
                                       IOB_Din_7 = 0; 
		
                                   end
                           else if (nn_layer_cnt == 4'd5 && omap_addr_span_cnt ==  13'd1)	
                                   begin

                                       IOB_Din_vld = IOB_Data_I_vld;
                                       IOB_Din_0 = IOB_Data_I0;
                                       IOB_Din_1 = IOB_Data_I1;
                                       IOB_Din_2 = IOB_Data_I2;
	                               IOB_Din_3 = IOB_Data_I3;
	                               IOB_Din_4 = IOB_Data_I4;
	                               IOB_Din_5 = IOB_Data_I5;
	                               IOB_Din_6 = 0; 
	                               IOB_Din_7 = 0; 
		
                                   end
                           else if (nn_layer_cnt == 4'd6 && omap_addr_span_cnt ==  13'd0)	
                                   begin

                                       IOB_Din_vld = IOB_Data_I_vld;
                                       IOB_Din_0 = IOB_Data_I0;
                                       IOB_Din_1 = IOB_Data_I1;
                                       IOB_Din_2 = IOB_Data_I2;
	                               IOB_Din_3 = IOB_Data_I3;
	                               IOB_Din_4 = IOB_Data_I4;
	                               IOB_Din_5 = IOB_Data_I5;
	                               IOB_Din_6 = IOB_Data_I6;
	                               IOB_Din_7 = 0; 
		
                                   end
                           else
                                   begin
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

			else if(nn_layer_cnt == 4'd7 )
                            begin
				       IOB_Din_vld = IOB_Data_I_vld;
                                       IOB_Din_0 = IOB_Data_I0;
                                       IOB_Din_1 = IOB_Data_I1;
                                       IOB_Din_2 = IOB_Data_I2;
	                               IOB_Din_3 = 0;
	                               IOB_Din_4 = 0;
	                               IOB_Din_5 = 0;
	                               IOB_Din_6 = 0;
	                               IOB_Din_7 = 0; 			
			    end
                        else if(nn_layer_cnt == 4'd8)
                            begin
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
                        else if(nn_layer_cnt == 4'd9)
                            begin
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
			
	// assign	IOB_Data_vld = (SPI_start)? IOB_Data_I_vld_ECG : IOB_Din_vld;
	// assign	IOB_Data_0 = (SPI_start)? IOB_Data_I0_ECG : IOB_Din_0;
	// assign	IOB_Data_1 = (SPI_start)? IOB_Data_I1_ECG : IOB_Din_1;
	// assign	IOB_Data_2 = (SPI_start)? IOB_Data_I2_ECG : IOB_Din_2;
	// assign	IOB_Data_3 = (SPI_start)? IOB_Data_I3_ECG : IOB_Din_3;
	// assign	IOB_Data_4 = (SPI_start)? IOB_Data_I4_ECG : IOB_Din_4;
	// assign	IOB_Data_5 = (SPI_start)? IOB_Data_I5_ECG : IOB_Din_5;
	// assign	IOB_Data_6 = (SPI_start)? IOB_Data_I6_ECG : IOB_Din_6;
	// assign	IOB_Data_7 = (SPI_start)? IOB_Data_I7_ECG : IOB_Din_7;

	wire	wen_ram1,wen_ram2;
	
	  
	assign	IOB_Data_O0 = (nn_layer_cnt[0])? ram1_Odata0 : ram2_Odata0;
	assign	IOB_Data_O1 = (nn_layer_cnt[0])? ram1_Odata1 : ram2_Odata1;
	assign	IOB_Data_O2 = (nn_layer_cnt[0])? ram1_Odata2 : ram2_Odata2;
	assign	IOB_Data_O3 = (nn_layer_cnt[0])? ram1_Odata3 : ram2_Odata3;
	assign	IOB_Data_O4 = (nn_layer_cnt[0])? ram1_Odata4 : ram2_Odata4;
	assign	IOB_Data_O5 = (nn_layer_cnt[0])? ram1_Odata5 : ram2_Odata5;
	assign	IOB_Data_O6 = (nn_layer_cnt[0])? ram1_Odata6 : ram2_Odata6;
	assign	IOB_Data_O7 = (nn_layer_cnt[0])? ram1_Odata7 : ram2_Odata7;

	assign wen_ram1 =  (mode_cnt)?1:(~nn_layer_cnt[0] && IOB_Din_vld);
    assign wen_ram2 =  nn_layer_cnt[0] && IOB_Din_vld;
	
	reg IOB_Data_O_vld_tmp;
	always@(posedge clk_cal or negedge rst_cal_n)begin
		if(!rst_cal_n)begin
			IOB_Data_O_vld 		<= 1'b0;
			IOB_Data_O_vld_tmp  <= 1'b0;
		end
		else begin
		    IOB_Data_O_vld_tmp <= Mem_Data_Ivld;
			IOB_Data_O_vld <= IOB_Data_O_vld_tmp;
		end
	end

reg [8:0] mem_cnt;
reg [2:0] cal_cnt_sf;
reg [2:0] col_cnt;
reg buffer_enable;
wire [7:0] val_input;
reg Enable_trans_reg;


reg [7:0] wt_addr_0;
reg [7:0] wen;

always@(posedge clk_cal or negedge rst_cal_n)begin
    if(!rst_cal_n)
      Enable_trans_reg <= 0;
    else 
      Enable_trans_reg <= Enable_trans;
    end
assign enable_rise = !Enable_trans_reg&&Enable_trans;
always@(posedge clk_cal or negedge rst_cal_n)begin
    if(!rst_cal_n)
      enable_rise_reg <= 0;
    else 
      enable_rise_reg <= enable_rise;
    end   
assign Busy = enable_rise||enable_rise_reg;
assign val_input = w_weight;
always@(posedge clk_cal or negedge rst_cal_n)begin
    if(!rst_cal_n)begin
      col_cnt<=0;
      buffer_enable <= 0;
      //val_input <= 0;
      end
    /*else if(enable_rise_reg)begin
      buffer_enable <= 0;
      val_input <= 0;
      col_cnt<=col_cnt;
      end*/
    else if(enable_rise_reg)begin
      if(col_cnt==3'd7)
          col_cnt<=0;
      else begin 
          col_cnt<=col_cnt+1;
      buffer_enable <= 1;
      //val_input <= w_weight;
      end
      end  
     else if((wr_addr1==10'd451)&&(col_cnt==3'd6))
        col_cnt<=0;    
    else begin
        buffer_enable <= 0;
        //val_input <= 0;
        col_cnt<=col_cnt;
        end
  end
reg [3:0] col_cnt_reg2;
wire col_cnt_sel;
always@(posedge clk_cal or negedge rst_cal_n)begin
    if(!rst_cal_n)
        col_cnt_reg2 <= 0;
    else 
        col_cnt_reg2 <= col_cnt;
    end
assign col_cnt_sel = (col_cnt_reg2==4'd7&&col_cnt==3'd0)?1:0;
always@(posedge clk_cal or negedge rst_cal_n)begin
    if(!rst_cal_n)
      mem_cnt<=0;
    else if(col_cnt_sel)
      mem_cnt<=mem_cnt+1;
    else if((mem_cnt==9'd451)&&(col_cnt==3'd6))
      mem_cnt<=0;
    end
assign wait_tran = ((mem_cnt==9'd451)&&(col_cnt==3'd6))?1:0;
wire [9:0] wr_addr1,wr_addr3;
reg  [9:0] wr_addr1_reg;
always@(posedge clk_cal or negedge rst_cal_n)begin
    if(!rst_cal_n)
        wr_addr1_reg <= 0;
    else
        wr_addr1_reg <= mem_cnt;
    end
reg [9:0]mem_cnt_reg;
always@(posedge clk_cal or negedge rst_cal_n)begin
    if(!rst_cal_n)
        mem_cnt_reg <= 0;
    else 
        mem_cnt_reg <= mem_cnt;
    end
always@(posedge clk_cal or negedge rst_cal_n)begin
    if(!rst_cal_n)
        final_flag<=0;
    else if((mem_cnt==9'd451)&&(col_cnt==3'd6))
        final_flag<=1;
    else 
        final_flag<=0;
        end
        
//assign final_flag = (mem_cnt_reg==10'd451)&&(mem_cnt==10'd0);     
  
assign wr_addr1 = (col_cnt_sel)?(wr_addr1_reg+1):((mode_cnt)?mem_cnt:wr_addr);
//assign wr_addr3 = (col_cnt_sel)?(wr_addr1_reg+1):((mode_cnt)?wr_addr:mem_cnt);                   
always@(*)
  case(col_cnt)
      3'd0: wen = 8'd1;
      3'd1: wen = 8'd2;
      3'd2: wen = 8'd4;
      3'd3: wen = 8'd8;
      3'd4: wen = 8'd16;
      3'd5: wen = 8'd32;
      3'd6: wen = 8'd64;
      3'd7: wen = 8'd128;
      default:wen = 0;
  endcase

assign {wen_ram1_7,wen_ram1_6,wen_ram1_5,wen_ram1_4,wen_ram1_3,wen_ram1_2,wen_ram1_1,wen_ram1_0} = (mode_cnt)?wen:8'b11111111;
//assign {wen_ram3_7,wen_ram3_6,wen_ram3_5,wen_ram3_4,wen_ram3_3,wen_ram3_2,wen_ram3_1,wen_ram3_0} = (mode_cnt)?8'b11111111:wen;

assign IOB_Din_00 = (mode_cnt)?val_input:IOB_Din_0; 
assign IOB_Din_01 = (mode_cnt)?val_input:IOB_Din_1; 
assign IOB_Din_02 = (mode_cnt)?val_input:IOB_Din_2; 
assign IOB_Din_03 = (mode_cnt)?val_input:IOB_Din_3; 
assign IOB_Din_04 = (mode_cnt)?val_input:IOB_Din_4; 
assign IOB_Din_05 = (mode_cnt)?val_input:IOB_Din_5; 
assign IOB_Din_06 = (mode_cnt)?val_input:IOB_Din_6; 
assign IOB_Din_07 = (mode_cnt)?val_input:IOB_Din_7; 

/*assign IOB_Din_20 = (mode_cnt)?IOB_Din_0:val_input; 
assign IOB_Din_21 = (mode_cnt)?IOB_Din_1:val_input; 
assign IOB_Din_22 = (mode_cnt)?IOB_Din_2:val_input; 
assign IOB_Din_23 = (mode_cnt)?IOB_Din_3:val_input; 
assign IOB_Din_24 = (mode_cnt)?IOB_Din_4:val_input; 
assign IOB_Din_25 = (mode_cnt)?IOB_Din_5:val_input; 
assign IOB_Din_26 = (mode_cnt)?IOB_Din_6:val_input; 
assign IOB_Din_27 = (mode_cnt)?IOB_Din_7:val_input; */

      

//---------------------------------------------------------------------------------
//SRAM
//----------------------------------------------------------------------------------

	blk_mem_gen_0 map_00 (.clka(clk_cal),	 .ena(1'b1),	.wea(wen_ram1_0&&wen_ram1),	   .addra(wr_addr1),    .dina(IOB_Din_00),	.clkb(clk_cal),	     .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),	 .addrb(rd_addr),	 .doutb(ram1_Odata0)	);
    blk_mem_gen_1 map_01 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1_1&&wen_ram1),    .addra(wr_addr1),    .dina(IOB_Din_01),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata1)    );
    blk_mem_gen_2 map_02 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1_2&&wen_ram1),    .addra(wr_addr1),    .dina(IOB_Din_02),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata2)    );
    blk_mem_gen_3 map_03 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1_3&&wen_ram1),    .addra(wr_addr1),    .dina(IOB_Din_03),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata3)    );
    blk_mem_gen_4 map_04 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1_4&&wen_ram1),    .addra(wr_addr1),    .dina(IOB_Din_04),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata4)    );
    blk_mem_gen_5 map_05 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1_5&&wen_ram1),    .addra(wr_addr1),    .dina(IOB_Din_05),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata5)    );
    blk_mem_gen_6 map_06 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1_6&&wen_ram1),    .addra(wr_addr1),    .dina(IOB_Din_06),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata6)    );
    blk_mem_gen_7 map_07 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1_7&&wen_ram1),    .addra(wr_addr1),    .dina(IOB_Din_07),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata7)    );
    
    blk_mem_gen_8 map_10 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_0),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata0)    );
    blk_mem_gen_8 map_11 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_1),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata1)    );
    blk_mem_gen_8 map_12 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_2),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata2)    );
    blk_mem_gen_8 map_13 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_3),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata3)    );
    blk_mem_gen_8 map_14 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_4),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata4)    );
    blk_mem_gen_8 map_15 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_5),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata5)    );
    blk_mem_gen_8 map_16 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_6),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata6)    );
    blk_mem_gen_8 map_17 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_7),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata7)    );
   
    /*blk_mem_gen_8 map_20 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram3_0&&wen_ram3),    .addra(wr_addr3),    .dina(IOB_Din_20),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram3_Odata0)    );
    blk_mem_gen_8 map_21 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram3_1&&wen_ram3),    .addra(wr_addr3),    .dina(IOB_Din_21),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram3_Odata1)    );
    blk_mem_gen_8 map_22 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram3_2&&wen_ram3),    .addra(wr_addr3),    .dina(IOB_Din_22),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram3_Odata2)    );
    blk_mem_gen_8 map_23 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram3_3&&wen_ram3),    .addra(wr_addr3),    .dina(IOB_Din_23),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram3_Odata3)    );
    blk_mem_gen_8 map_24 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram3_4&&wen_ram3),    .addra(wr_addr3),    .dina(IOB_Din_24),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram3_Odata4)    );
    blk_mem_gen_8 map_25 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram3_5&&wen_ram3),    .addra(wr_addr3),    .dina(IOB_Din_25),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram3_Odata5)    );
    blk_mem_gen_8 map_26 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram3_6&&wen_ram3),    .addra(wr_addr3),    .dina(IOB_Din_26),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram3_Odata6)    );
    blk_mem_gen_8 map_27 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram3_7&&wen_ram3),    .addra(wr_addr3),    .dina(IOB_Din_27),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram3_Odata7)    );*/
   
///////////////////////////////////////////////////////////////////////////////////////////////////////////// 

   
endmodule


