// *****************************************************************************
// @Project Name : ECG_CPU 
// @Author       : Huangjunguang
// @Email        : huangjunguang@seu.edu.cn
// @File Name    : Pooling.v
// @Module Name  : Pooling
// @Created Time : 2020-05-04 12:56
//
// @Abstract     : This module is to relu and pool              
//               
//
// Modification History
// ******************************************************************************
// Date				BY           Version         Change Description
// -------------------------------------------------------------------------
// 2020-05-04  	Huangjunguang      v1.0          initial version 
// 
// ******************************************************************************

`timescale 1ns / 1ns
`define byte_width 8
`define halfword_width 16
`define sevenbyte_width 56

module Pooling (
		input                                   clk_cal,
		input                                   rst_cal_n,     
		input       [`sevenbyte_width-1:0]      Pool_IData,
		input                                   Pool_IData_vld,
		input       [2:0]                       P,
		output      [`byte_width-1:0]           Pool_OData,
		output                                  Pool_OData_vld
);

		reg Pool_en;
		reg Pool_Ovld_R;
		reg signed [`byte_width-1:0] Din1,Din2,Din3,Din4,Din5,Din6,Din7;
		reg signed [`byte_width-1:0] Otemp1,Otemp2,Otemp3;
		reg signed [`byte_width-1:0] Pool_Otemp;
		//reg signed [`byte_width-1:0] Pool_OData_R;
		

		//WRITE part
		always@( posedge clk_cal or negedge rst_cal_n) begin
			if(!rst_cal_n) begin
				Din1 <= 8'b0;
				Din2 <= 8'b0;
				Din3 <= 8'b0;
				Din4 <= 8'b0;
				Din5 <= 8'b0;
				Din6 <= 8'b0;
				Din7 <= 8'b0;
				Pool_en <= 1'b0;
			end
			else begin
				if(Pool_IData_vld) begin
					Pool_en <= 1'b1;
					{Din7,Din6,Din5,Din4,Din3,Din2,Din1} <=	Pool_IData;
				end
				else
					Pool_en <= 1'b0;
			end
		end	


		always@(*) begin
			if(Pool_en) begin
				Otemp1 = (Din1>Din2)?Din1:Din2;
				Otemp2 = (Din3>Din4)?Din3:Din4;
				Otemp3 = (Din5>Din6)?Din5:Din6;	
				case(P)
					3'd7:begin
						Pool_Otemp  = ( ((Otemp1 > Otemp2)? Otemp1:Otemp2) > ((Otemp3 > Din7)? Otemp3:Din7) )?
												((Otemp1 > Otemp2)? Otemp1:Otemp2):((Otemp3 > Din7)? Otemp3:Din7);
					end
					3'd5:begin
						Pool_Otemp  =  (Otemp1 > Otemp2)? ((Otemp1>Din5)?Otemp1:Din5) : ((Otemp2>Din5)?Otemp2:Din5);
					end
					3'd4:begin
						Pool_Otemp  =  (Otemp1>Otemp2) ? Otemp1 : Otemp2;
					end
					3'd2:begin
						Pool_Otemp = Otemp1;
					end		
					default:begin
						Pool_Otemp    = 8'b0;
						//Pool_OData_R  = 8'b0;
					end
				endcase
				Pool_Ovld_R = 1'b1;
			end
			else begin
				Otemp1 = 8'b0;
				Otemp2 = 8'b0;
				Otemp3 = 8'b0;
				Pool_Otemp   = 8'b0;
				Pool_Ovld_R  = 1'b0;
				//Pool_OData_R = 8'b0;				
			end
		end
		
		assign Pool_OData_vld = Pool_Ovld_R;
		
		assign Pool_OData     = Pool_Otemp;
		
endmodule
