`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 16:29:27
// Design Name: 
// Module Name: AKX_PLUS_B
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AKX_PLUS_B(
    input               clk,
    input               rst_n,
    input               o_0_val,  
    input  signed [9:0] max_0, max_1, max_2, max_3, max_4,
    input               Max_out_Val,
    output  reg  [2:0]  class       
    );
    
    reg     [6:0]       cnt_27; //计数加到27就停止
    reg   signed  [14:0]      channel_ge0_sum, channel_le0_sum;
    reg   signed  [14:0]      channel_ge1_sum, channel_le1_sum;
    reg   signed  [14:0]      channel_ge2_sum, channel_le2_sum;
    reg   signed  [14:0]      channel_ge3_sum, channel_le3_sum;
    reg   signed  [14:0]      channel_ge4_sum, channel_le4_sum;
    
    reg     Max_out_Val_d1, Max_out_Val_d2, Max_out_Val_d3, Max_out_Val_d4;
    
    always@(posedge clk or negedge o_0_val)begin
        if(!o_0_val)begin
            cnt_27 <= 0;
        end
        else begin
            if(cnt_27!=66)begin
                cnt_27 <= cnt_27 +1;
            end
            else begin
                cnt_27 <= 66;
            end
        end
    
    end
    
    always@(posedge clk)begin
        Max_out_Val_d1 <= Max_out_Val;
        Max_out_Val_d2 <= Max_out_Val_d1;
        Max_out_Val_d3 <= Max_out_Val_d2;
        Max_out_Val_d4 <= Max_out_Val_d3;
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            channel_ge0_sum <= 0;
            channel_le0_sum <= 0;
            
            channel_ge1_sum <= 0;
            channel_le1_sum <= 0;
            
            channel_ge2_sum <= 0;
            channel_le2_sum <= 0;
            
            channel_ge3_sum <= 0;
            channel_le3_sum <= 0;
            
            channel_ge4_sum <= 0;
            channel_le4_sum <= 0;
        end
        else begin
            if(cnt_27 != 65)begin
                if(Max_out_Val)begin
                    case(max_0[9])
                        0:  channel_ge0_sum <= channel_ge0_sum + max_0;
                        1:  channel_le0_sum <= channel_le0_sum + max_0;
                    endcase
                end
                if(Max_out_Val_d1)begin
                    case(max_1[9])
                        0:  channel_ge1_sum <= channel_ge1_sum + max_1;
                        1:  channel_le1_sum <= channel_le1_sum + max_1;
                    endcase
                end
                if(Max_out_Val_d2)begin
                        case(max_2[9])
                            0:  channel_ge2_sum <= channel_ge2_sum + max_2;
                            1:  channel_le2_sum <= channel_le2_sum + max_2;
                        endcase
                end
                if(Max_out_Val_d3)begin
                        case(max_3[9])
                            0:  channel_ge3_sum <= channel_ge3_sum + max_3;
                            1:  channel_le3_sum <= channel_le3_sum + max_3;
                        endcase
                end           
                if(Max_out_Val_d4)begin
                        case(max_4[9])
                            0:  channel_ge4_sum <= channel_ge4_sum + max_4;
                            1:  channel_le4_sum <= channel_le4_sum + max_4;
                        endcase
                end
            end else begin
                channel_ge0_sum <= 0;
                channel_le0_sum <= 0;
                
                channel_ge1_sum <= 0;
                channel_le1_sum <= 0;
                
                channel_ge2_sum <= 0;
                channel_le2_sum <= 0;
                
                channel_ge3_sum <= 0;
                channel_le3_sum <= 0;
                
                channel_ge4_sum <= 0;
                channel_le4_sum <= 0;
            end      
        end
    end
    
    reg   signed  [28:0]     y_0, y_1, y_2, y_3, y_4;
    
//    always@(posedge clk)begin
//        if(cnt_27==61)begin
//            y_0 <= channel_ge0_sum * 14'd399 + channel_le0_sum * 14'd142 + 27*(14'd2672);
//        end
//        if(cnt_27==62)begin
//            y_1 <= channel_ge1_sum * 14'd711 + channel_le1_sum * 14'd253 + 27*(14'd2937);
//        end
//        if(cnt_27==63)begin
//            y_2 <= channel_ge2_sum * 14'd651 + channel_le2_sum * 14'd231  - 27*(14'd1557);
//        end
//        if(cnt_27==64)begin
//            y_3 <= channel_ge3_sum * 14'd671 + channel_le3_sum * 14'd238  - 27*(14'd8191);
//        end
//        if(cnt_27==65)begin
//            y_4 <= channel_ge4_sum * 14'd1066 + channel_le4_sum * 14'd379  - 27*(14'd7765);
//        end
//    end
    
        always@(posedge clk)begin
        if(cnt_27==61)begin
            y_0 <= channel_ge0_sum * 399 + channel_le0_sum * 142 + 27*(2672);
        end
        if(cnt_27==62)begin
            y_1 <= channel_ge1_sum * 711 + channel_le1_sum * 253 + 27*(2937);
        end
        if(cnt_27==63)begin
            y_2 <= channel_ge2_sum * 651 + channel_le2_sum * 231  - 27*(1557);
        end
        if(cnt_27==64)begin
            y_3 <= channel_ge3_sum * 671 + channel_le3_sum * 238  - 27*(8191);
        end
        if(cnt_27==65)begin
            y_4 <= channel_ge4_sum * 1066 + channel_le4_sum * 379  - 27*(7765);
        end
    end
    
   always @(posedge clk)begin
        if(cnt_27 == 66)begin
            if (y_0 >= y_1 && y_0 >= y_2 && y_0 >= y_3 && y_0 >= y_4) begin
                class <= 0;
            end else if (y_1 >= y_2 && y_1 >= y_3 && y_1 >= y_4) begin
                class <= 1;
            end else if (y_2 >= y_3 && y_2 >= y_4) begin
                class <= 2;
            end else if (y_3 >= y_4) begin
                class <= 3;
            end else begin
                class <= 4;
            end
         end
    end
    
endmodule
