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
									IOB_FC_I4, IOB_FC_I5, IOB_FC_I6, IOB_FC_I7
	// Signals with ECG in
	// input							IOB_Data_I_vld_ECG
	// input	signed	[7:0]			IOB_Data_I0_ECG, IOB_Data_I1_ECG, IOB_Data_I2_ECG, IOB_Data_I3_ECG, 
									// IOB_Data_I4_ECG, IOB_Data_I5_ECG, IOB_Data_I6_ECG, IOB_Data_I7_ECG
);
			// wire					IOB_Data_vld;
			// wire	[7:0]			IOB_Data_0, IOB_Data_1, IOB_Data_2, IOB_Data_3, IOB_Data_4, IOB_Data_5, IOB_Data_6, IOB_Data_7;
			
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

	
	assign	IOB_Data_O0 = (nn_layer_cnt[0])? ram1_Odata0 : ram2_Odata0;
	assign	IOB_Data_O1 = (nn_layer_cnt[0])? ram1_Odata1 : ram2_Odata1;
	assign	IOB_Data_O2 = (nn_layer_cnt[0])? ram1_Odata2 : ram2_Odata2;
	assign	IOB_Data_O3 = (nn_layer_cnt[0])? ram1_Odata3 : ram2_Odata3;
	assign	IOB_Data_O4 = (nn_layer_cnt[0])? ram1_Odata4 : ram2_Odata4;
	assign	IOB_Data_O5 = (nn_layer_cnt[0])? ram1_Odata5 : ram2_Odata5;
	assign	IOB_Data_O6 = (nn_layer_cnt[0])? ram1_Odata6 : ram2_Odata6;
	assign	IOB_Data_O7 = (nn_layer_cnt[0])? ram1_Odata7 : ram2_Odata7;

     
	
	wire	wen_ram1,wen_ram2;
	
	assign wen_ram1 = ~nn_layer_cnt[0] && IOB_Din_vld;
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



//----------------------------------------------------------------------------------
// middle value
//----------------------------------------------------------------------------------

//integer bank0;
//integer bank1;
//integer bank2;
//integer bank3;
//integer bank4;
//integer bank5;
//integer bank6;
//integer bank7;

//reg [7:0]    register1 [1023:0];
//reg [7:0]    register2 [1023:0];
//reg [7:0]    register3 [1023:0];
//reg [7:0]    register4 [1023:0];
//reg [7:0]    register5 [1023:0];
//reg [7:0]    register6 [1023:0];
//reg [7:0]    register7 [1023:0];
//reg [7:0]    register8 [1023:0];
//integer i;
//always  @(posedge clk_cal or rst_cal_n ) begin
//           if (rst_cal_n  == 1'b0) begin             //初始�?
//             for(i=0; i<1024;i=i+1) begin
//                  register1[i] <= 8'b0000_0000;
//                  register2[i] <= 8'b0000_0000;
//                  register3[i] <= 8'b0000_0000;
//                  register4[i] <= 8'b0000_0000;
//                  register5[i] <= 8'b0000_0000;
//                  register6[i] <= 8'b0000_0000;
//                  register7[i] <= 8'b0000_0000;
//                  register8[i] <= 8'b0000_0000;

//                end
//           end
//            else  if ( (wen_ram2==1'd1)&&( SPI_start==1'd0 )&&(nn_layer_cnt==4'd9) ) begin 
//             register1[wr_addr] <= IOB_Data_0;
//             register2[wr_addr] <= IOB_Data_1;
//             register3[wr_addr] <= IOB_Data_2;
//             register4[wr_addr] <= IOB_Data_3;
//             register5[wr_addr] <= IOB_Data_4;
//             register6[wr_addr] <= IOB_Data_5;
//             register7[wr_addr] <= IOB_Data_6;
//             register8[wr_addr] <= IOB_Data_7;
//             end
//   end


//reg [3:0] nn_count;
//initial 
//begin 
//bank0 = $fopen("/home/klin/soc/cfgtest/cfg_9/ECG_acc9/middle_value/layer9/bank0.txt","w");
//bank1=$fopen("/home/klin/soc/cfgtest/cfg_9/ECG_acc9/middle_value/layer9/bank1.txt","w");
//bank2=$fopen("/home/klin/soc/cfgtest/cfg_9/ECG_acc9/middle_value/layer9/bank2.txt","w");
//bank3=$fopen("/home/klin/soc/cfgtest/cfg_9/ECG_acc9/middle_value/layer9/bank3.txt","w");
//bank4=$fopen("/home/klin/soc/cfgtest/cfg_9/ECG_acc9/middle_value/layer9/bank4.txt","w");
//bank5=$fopen("/home/klin/soc/cfgtest/cfg_9/ECG_acc9/middle_value/layer9/bank5.txt","w");
//bank6=$fopen("/home/klin/soc/cfgtest/cfg_9/ECG_acc9/middle_value/layer9/bank6.txt","w");
//bank7=$fopen("/home/klin/soc/cfgtest/cfg_9/ECG_acc9/middle_value/layer9/bank7.txt","w");
//nn_count<=0;
//end



//integer j;
//always @(posedge clk_cal) begin
//      nn_count<=nn_layer_cnt;
//      if((nn_layer_cnt == 4'd10)&&(nn_count == 4'd9)) begin
//      for (j=0; j<1000; j=j+1) begin   
//            $fwrite(bank0,"%b\n",register1[j]);
//            $fwrite(bank1,"%b\n",register2[j]);
//            $fwrite(bank2,"%b\n",register3[j]);
//            $fwrite(bank3,"%b\n",register4[j]);
//            $fwrite(bank4,"%b\n",register5[j]);
//            $fwrite(bank5,"%b\n",register6[j]);
//            $fwrite(bank6,"%b\n",register7[j]);
//            $fwrite(bank7,"%b\n",register8[j]);
//        end            
        
//            $fclose(bank0);
//            $fclose(bank1);
//            $fclose(bank2);
//            $fclose(bank3);
//            $fclose(bank4);
//            $fclose(bank5);
//            $fclose(bank6);
//            $fclose(bank7);
        
//      end
//end
      

//---------------------------------------------------------------------------------
//SRAM
//----------------------------------------------------------------------------------
/*
	map_mem_gen_0 map_00 (.clka(clk_cal),	 .ena(1'b1),	.wea(wen_ram1),	   .addra(wr_addr),    .dina(IOB_Din_0),	.clkb(clk_cal),	   .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),	 .addrb(rd_addr),	 .doutb(ram1_Odata0)	);
    map_mem_gen_1 map_01 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1),    .addra(wr_addr),    .dina(IOB_Din_1),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata1)    );
    map_mem_gen_2 map_02 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1),    .addra(wr_addr),    .dina(IOB_Din_2),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata2)    );
    map_mem_gen_3 map_03 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1),    .addra(wr_addr),    .dina(IOB_Din_3),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata3)    );
    map_mem_gen_4 map_04 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1),    .addra(wr_addr),    .dina(IOB_Din_4),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata4)    );
    map_mem_gen_5 map_05 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1),    .addra(wr_addr),    .dina(IOB_Din_5),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata5)    );
    map_mem_gen_6 map_06 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1),    .addra(wr_addr),    .dina(IOB_Din_6),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata6)    );
    map_mem_gen_7 map_07 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram1),    .addra(wr_addr),    .dina(IOB_Din_7),    .clkb(clk_cal),    .enb(nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram1_Odata7)    );
    
    map_mem_gen_8 map_10 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_0),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata0)    );
    map_mem_gen_8 map_11 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_1),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata1)    );
    map_mem_gen_8 map_12 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_2),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata2)    );
    map_mem_gen_8 map_13 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_3),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata3)    );
    map_mem_gen_8 map_14 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_4),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata4)    );
    map_mem_gen_8 map_15 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_5),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata5)    );
    map_mem_gen_8 map_16 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_6),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata6)    );
    map_mem_gen_8 map_17 (.clka(clk_cal),    .ena(1'b1),    .wea(wen_ram2),    .addra(wr_addr),    .dina(IOB_Din_7),    .clkb(clk_cal),    .enb(!nn_layer_cnt[0] & Mem_Data_Ivld1),    .addrb(rd_addr),    .doutb(ram2_Odata7)    );
*/    /*
    //  port B signal write, port A signal read
	memory_map1  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_10(.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_0), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata0));
	memory_map2  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_11 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_1), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata1));
	memory_map3  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_12 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_2), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata2));
	memory_map4  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_13 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_3), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata3));
	memory_map5  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_14 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_4), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata4));
	memory_map6  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_15 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_5), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata5));
	memory_map7  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_16 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_6), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata6));
	memory_map8  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_17 (.clk(clk_cal), .rst_n(rst_cal_n), .SPI_start(SPI_start), .wrenb(wen_ram1), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_7), .rdena(nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram1_Odata7));
	
	
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_00 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_0), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata0));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_01 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_1), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata1));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_02 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_2), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata2));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_03 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_3), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata3));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_04 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_4), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata4));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_05 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_5), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata5));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_06 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_6), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata6));
	memory  #(
    .ADDR_WIDTH(13),
    .DATA_WIDTH(8),
    .DATA_DEPTH(2048)
	) map_07 (.clk(clk_cal), .rst_n(rst_cal_n), .wrenb(wen_ram2), .csen(1'b1), .addr_b(wr_addr), .data_b(IOB_Data_7), .rdena(~nn_layer_cnt[0] & Mem_Data_Ivld), .addr_a(rd_addr), .data_a(ram2_Odata7));
*/																																																	 

endmodule

