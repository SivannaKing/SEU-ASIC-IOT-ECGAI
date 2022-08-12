// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : Output_regfile.v
// @Module Name  : Output_regfile
// @Created Time : 2020-05-22 23:29
//
// @Abstract     : This module is to sort the output of PE array               
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-05-22  	Huangjunguang      v1.0          initial version 
// 
// ******************************************************************************
//


/*
P_K=7 4 5 4 2 2
P_S=2 2 2 2 2 2
*/

`timescale 1ns / 100ps
`define byte_width 8
`define halfword_width 16
`define sevenbyte_width 56
		
module Output_regfile (
		input                               clk_cal,
		input                               rst_cal_n,     
		input       [5:0]                   or_cs,
        input       [`byte_width-1:0]       ORegfile_IData,
		input                               ORegfile_IData_vld,
        input       [2:0]                   P,
		input       [1:0]                   S,
        output reg  [`sevenbyte_width-1:0]  ORegfile_OData,  
        output wire                         ORegfile_OData_vld
);
		parameter R = 16;

		reg         [`byte_width-1:0]       regfile [0:31];         // the size is set to contain 2 times calculate results
		reg         [4:0]                   waddr;
		reg         [5:0]                   raddr;
		wire        [5:0]                   raddr_w;
		wire        [5:0]                   raddr2_w;
		wire        [5:0]                   raddr3_w;
		reg                                 ORegfile_OvldR;
		reg                                 ren;
		wire        [5:0]                   mode_cnt;
		
		reg         [1:0]                   mode;
		integer i=0;
		//WRITE part
		always@( posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				waddr <= 5'b0;	
				mode <= 2'b0;
			end
			else begin
				if(ORegfile_IData_vld) begin
					regfile[waddr] <= ORegfile_IData;
					waddr <= waddr + 1'b1;
					if(waddr == 5'd15)
						mode <= 2'b01;
					else if(waddr == 5'd31) begin //31=(2*R - 1)
						waddr <= 5'b0;
						mode <= 2'b10;
					end
				end
				else if(or_cs == 6'd8) begin //每一层结束之后都复位一下waddr
					waddr <= 5'b0;
				end
			end
		end

		
		//READ part
		
		//write down edge catch
		reg d_last,fst_edge;
		wire temp;
		always @(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				fst_edge <= 1'b0;
			else if(or_cs == 6'd8)//每一层结束之后都复位一下fst_edge
				fst_edge <= 1'b0;
			else begin
				if(temp)
					fst_edge <= temp| fst_edge;
				else
					fst_edge <= fst_edge;
			end
		end

		always @(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) 
				d_last <= 1'b0;
			else if(or_cs == 6'd8)//每一层结束之后都复位一下fst_edge
				d_last <= 1'b0;
			else
				d_last <= ORegfile_IData_vld;
		end
			
		assign temp = d_last & ~ORegfile_IData_vld;  

		//read out
		always@(posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				raddr  <= 6'b0;
				ORegfile_OvldR <= 1'b0;
				ORegfile_OData <= `sevenbyte_width'b0;
			end
			else begin
				if((!ORegfile_IData_vld && ren) && fst_edge)begin
					ORegfile_OvldR <= 1'b1;
					case(P)
					3'd7:begin
						if(raddr >= 6'd26)begin //26=(2*R- 5 -1)=2*R- (P-S) -1
							ORegfile_OData <= {regfile[raddr3_w],regfile[raddr2_w],ORegfile_OData[`sevenbyte_width-1:`halfword_width]};
						end
						else begin
							for(i=0;i<7;i=i+1)begin
								ORegfile_OData[`byte_width*i +:`byte_width] <= regfile[raddr + i];
							end
						end
					end
					3'd5:begin
						if(raddr >= 6'd28)begin //28=(2*R- (5-2) -1)
							ORegfile_OData <= {ORegfile_OData[`sevenbyte_width-1:40], regfile[raddr3_w],regfile[raddr2_w],ORegfile_OData[39:`halfword_width]};
						end
						else begin
							for(i=0;i<5;i=i+1)begin
								ORegfile_OData[`byte_width*i +:`byte_width] <= regfile[raddr + i];
							end
						end
					end
					3'd4:begin
						// if(nn_layer_cnt==4'd2)begin
						if(raddr >= 6'd29)begin //29=(2*R- 2 -1)
							ORegfile_OData <= {ORegfile_OData[`sevenbyte_width-1:32], regfile[raddr3_w], regfile[raddr2_w] ,ORegfile_OData[31:`halfword_width]};
						end
						else begin
							for(i=0;i<4;i=i+1)begin
								ORegfile_OData[`byte_width*i +:`byte_width] <= regfile[raddr + i];
							end
						end
						// end
						// else begin
							// if(raddr >= 6'd28)begin //28=(2*R- 3 -1)
								// ORegfile_OData <= {ORegfile_OData[55:`halfword_width], regfile[raddr3_w], ORegfile_OData[31:8]};
							// end
							// else begin
								// for(i=0;i<4;i=i+1)begin
									// ORegfile_OData[8*i +:8] <= regfile[raddr + i];
								// end
							// end
						// end					
					end
					3'd2:begin
						if(raddr >= 6'd31)begin //31=(2*R- (P-S) -1)
							ORegfile_OData <= {ORegfile_OData[`sevenbyte_width-1:`halfword_width], regfile[raddr3_w], regfile[raddr2_w]};
						end
						else begin
							for(i=0;i<2;i=i+1)begin
								ORegfile_OData[`byte_width*i +:`byte_width] <= regfile[raddr + i];
							end
						end
					end	
					default:begin
							ORegfile_OvldR <= 1'b0;
							ORegfile_OData <= 'b0;
					end		
					endcase
					
					raddr <= raddr_w;
				end
				else if(or_cs == 6'd8)begin //每一层结束之后都复位一下raddr
					raddr <= 0;
				end
				else begin
					ORegfile_OvldR <= 1'b0;

				end
				 
			end
		end
		
		
		always@(*)begin
			if(P != 2)begin
				if( (mode_cnt>6'd32) && mode==2'b10 ) begin //level 2 end
					ren <= 1'b0;
				end
				else if( (mode_cnt>=6'd32) && mode==2'b01 ) begin //level 3 
					ren <= 1'b1;
				end
				else if( (mode_cnt>16) && mode==2'b01 ) begin  //level 1 end
					ren <= 1'b0;
				end
				else if( (mode_cnt>16) && mode==2'b10 ) begin //level 2 start
					ren <= 1'b1;
				end
				else begin //level 1 start
					ren <= 1'b1;
				end
			end
			else begin
				if(mode_cnt == 18 && mode==2'b01)
					ren <= 1'b0;
				else if(mode_cnt == 2 && mode==2'b10)
					ren <= 1'b0;
				else
					ren <= 1'b1;
			end
		end
		


		assign mode_cnt = raddr + P;
		
		assign raddr_w  = (raddr < 2*R-S && or_cs == 6'd4)? raddr + S : 6'b0; //地址只在计算状态的时候才变化
				
		assign raddr2_w = (raddr+P-2>31 && or_cs == 6'd4)? raddr+P-2-32 : raddr+P-2;
		
		assign raddr3_w = (raddr+P-1>31 && or_cs == 6'd4)? raddr+P-1-32 : raddr+P-1;
				
		assign ORegfile_OData_vld = ORegfile_OvldR;
		
		
		
endmodule
