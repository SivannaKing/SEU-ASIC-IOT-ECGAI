`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/20 11:08:24
// Design Name: 
// Module Name: Maxpooling
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


module Maxpooling_B1(
    input           clk,
    input           rst_n,
    input           system_rst_n,
    input   [31:0]  DOUTA_0, DOUTA_1, DOUTA_2, DOUTA_3, 
                    DOUTA_4, DOUTA_5, DOUTA_6, DOUTA_7,
                    
    output  reg     [7:0]       ADDR,
                                
    output  reg                 WEA,    //OutPutBufferAddr模块中用的是1来存数据，maxpooling中则应该�?0来取SPRAM的数�?
                                
    output  wire                ENA,
    output  wire                Bin_0, Bin_1, Bin_2, Bin_3, Bin_4, Bin_5, Bin_6, Bin_7,
    output  reg                 max_val, binary_val                   
);

//***************************读取阈�?�函数并存储在自己的寄存器中************************
reg     [2:0]     addr;
wire              enable;
wire    [23:0]    data_o;
reg     [3:0]     thre_cnt;
reg     [7:0]     loadthrehold, loadthrehold_e1;
//ThreholdBuffer_ROM_B1  #(.ADDR_WIDTH(3), .DATA_WIDTH(24),.DATA_DEPTH(8)) ThreholdBuffer_B1(.clk(clk),  .enable(enable),  .addr(addr),  .data_o(data_o));
ThreholdBuffer_ROM_B1_IP ThreholdBuffer_B1 (
  .clka(clk),    // input wire clka
  .ena(enable),      // input wire ena
  .addra(addr),  // input wire [2 : 0] addra
  .douta(data_o)  // output wire [21 : 0] douta
);
always@(posedge clk or negedge system_rst_n)begin
    if(!system_rst_n)begin
        addr <= 0;
    end else begin
        if(thre_cnt < 8 )begin
            addr <= addr + 1 ;
        end else if(thre_cnt == 8)begin
            addr <= 0;
        end
    end
end

always@(posedge clk or negedge system_rst_n)begin
    if(!system_rst_n)begin
        thre_cnt <= 0;
        loadthrehold_e1 <= 0;
    end else begin
        if(thre_cnt < 8)begin
            thre_cnt <= thre_cnt + 1;
            loadthrehold_e1 <= {loadthrehold_e1[6:0], 1'b1};
        end
        else if(thre_cnt == 8)begin
            thre_cnt <= 8;
        end
    end
end

always@(posedge clk)begin
    loadthrehold <= loadthrehold_e1;
end

assign enable = (thre_cnt!= 8 || thre_cnt!= 0);

//reg [21:0] threhold_ram [7 : 0];
////8个�?�道，每个�?�道20bit的�?�，左边10bit是thre_plus，右边是10bit是thre_minus
//initial begin
//     $readmemb("/home/mrpp/my_work/ECG/ECG-BNN/Data/Threhold/block1_thre.txt", threhold_ram);
//end



assign ENA = !WEA;


reg     [2:0]       cnt;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;    
    end
    else begin
        if(cnt == 4) 
            cnt <= 1;
        else         
            cnt <= cnt + 1;  //1~4计数
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        max_val <= 0;
    end
    else begin
        if(ADDR == 1 && cnt == 2)begin
            max_val <= 1;
        end
        else if(ADDR == 225 && cnt == 4)begin
            max_val <= 0;
        end    
    end
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        binary_val <= 0;
    end
    else if(max_val)begin
        binary_val <= 1;   //binary_val比它慢一�?
    end
    
end

reg     max_val_d1;
always@(posedge clk)begin
    max_val_d1 <= max_val;
end

//8个�?�道产生的的7�?4bit输入(合计28bit)
reg     [27:0]      Conpare_In_seven_0, Conpare_In_seven_1, Conpare_In_seven_2, Conpare_In_seven_3, Conpare_In_seven_4, Conpare_In_seven_5, Conpare_In_seven_6, Conpare_In_seven_7; 
reg     [23:0]      Temp_0, Temp_1, Temp_2, Temp_3, Temp_4, Temp_5, Temp_6, Temp_7;
always@(*)begin
    if(!rst_n)begin
        WEA = 1;
    end
    else begin
        if(ADDR < 225)begin
            WEA = 0;          
        end
        else if(ADDR == 225)begin
            if(cnt < 3)
                WEA = 0;
            else
                WEA = 1;
        end
        else
            WEA = 1;
    end
end


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ADDR <= 0;
    else begin
        if(cnt == 0)
            ADDR <= ADDR + 1;
        else if(ADDR < 226 && cnt == 4)begin
                ADDR <= ADDR + 1;
        end
    end
        

end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Conpare_In_seven_0 <= 0;
        Temp_0 <= 0;
        
        Conpare_In_seven_1 <= 0;
        Temp_1 <= 0;
        
        Conpare_In_seven_2 <= 0;
        Temp_2 <= 0;
        
        Conpare_In_seven_3 <= 0;
        Temp_3 <= 0;
        
        Conpare_In_seven_4 <= 0;
        Temp_4 <= 0;
        
        Conpare_In_seven_5 <= 0;
        Temp_5 <= 0;
        
        Conpare_In_seven_6 <= 0;
        Temp_6 <= 0;
        
        Conpare_In_seven_7 <= 0;
        Temp_7 <= 0;
    end
    else if(ADDR <= 225) begin
        case(cnt)
        1:begin
            Conpare_In_seven_0 <= DOUTA_0[31:4];
            Temp_0 <= DOUTA_0[23:0];
            
            Conpare_In_seven_1 <= DOUTA_1[31:4];
            Temp_1 <= DOUTA_1[23:0];
            
            Conpare_In_seven_2 <= DOUTA_2[31:4];
            Temp_2 <= DOUTA_2[23:0];
            
            Conpare_In_seven_3 <= DOUTA_3[31:4];
            Temp_3 <= DOUTA_3[23:0];
            
            Conpare_In_seven_4 <= DOUTA_4[31:4];
            Temp_4 <= DOUTA_4[23:0];
            
            Conpare_In_seven_5 <= DOUTA_5[31:4];
            Temp_5 <= DOUTA_5[23:0];
            
            Conpare_In_seven_6 <= DOUTA_6[31:4];
            Temp_6 <= DOUTA_6[23:0];
            
            Conpare_In_seven_7 <= DOUTA_7[31:4];
            Temp_7 <= DOUTA_7[23:0];   
        end
        2:begin
            Conpare_In_seven_0 <= {Temp_0[23:0],DOUTA_0[31:28]};
            Conpare_In_seven_1 <= {Temp_1[23:0],DOUTA_1[31:28]};
            Conpare_In_seven_2 <= {Temp_2[23:0],DOUTA_2[31:28]};
            Conpare_In_seven_3 <= {Temp_3[23:0],DOUTA_3[31:28]};
            Conpare_In_seven_4 <= {Temp_4[23:0],DOUTA_4[31:28]};
            Conpare_In_seven_5 <= {Temp_5[23:0],DOUTA_5[31:28]};
            Conpare_In_seven_6 <= {Temp_6[23:0],DOUTA_6[31:28]};
            Conpare_In_seven_7 <= {Temp_7[23:0],DOUTA_7[31:28]};
        end
        3:begin
            Conpare_In_seven_0 <= {Temp_0[15:0],DOUTA_0[31:20]};
            Conpare_In_seven_1 <= {Temp_1[15:0],DOUTA_1[31:20]};
            Conpare_In_seven_2 <= {Temp_2[15:0],DOUTA_2[31:20]};
            Conpare_In_seven_3 <= {Temp_3[15:0],DOUTA_3[31:20]};
            Conpare_In_seven_4 <= {Temp_4[15:0],DOUTA_4[31:20]};
            Conpare_In_seven_5 <= {Temp_5[15:0],DOUTA_5[31:20]};
            Conpare_In_seven_6 <= {Temp_6[15:0],DOUTA_6[31:20]};
            Conpare_In_seven_7 <= {Temp_7[15:0],DOUTA_7[31:20]};
        end
        4:begin
            Conpare_In_seven_0 <= {Temp_0[7:0],DOUTA_0[31:12]};
            Conpare_In_seven_1 <= {Temp_1[7:0],DOUTA_1[31:12]};
            Conpare_In_seven_2 <= {Temp_2[7:0],DOUTA_2[31:12]};
            Conpare_In_seven_3 <= {Temp_3[7:0],DOUTA_3[31:12]};
            Conpare_In_seven_4 <= {Temp_4[7:0],DOUTA_4[31:12]};
            Conpare_In_seven_5 <= {Temp_5[7:0],DOUTA_5[31:12]};
            Conpare_In_seven_6 <= {Temp_6[7:0],DOUTA_6[31:12]};
            Conpare_In_seven_7 <= {Temp_7[7:0],DOUTA_7[31:12]};
        end
        default: begin
            Conpare_In_seven_0 <= 0;
            Temp_0 <= 0;
        end
        endcase
    end
    else begin
        Conpare_In_seven_0 <= 0;
        Temp_0 <= 0;    
        
        Conpare_In_seven_1 <= 0;
        Temp_1 <= 0;
        
        Conpare_In_seven_2 <= 0;
        Temp_2 <= 0;
        
        Conpare_In_seven_3 <= 0;
        Temp_3 <= 0;
        
        Conpare_In_seven_4 <= 0;
        Temp_4 <= 0;
        
        Conpare_In_seven_5 <= 0;
        Temp_5 <= 0;
        
        Conpare_In_seven_6 <= 0;
        Temp_6 <= 0;
        
        Conpare_In_seven_7 <= 0;
        Temp_7 <= 0;
    end     
end

wire signed  [3:0]   max_0, max_1, max_2, max_3, max_4, max_5, max_6, max_7;
wire   B_0, B_1, B_2, B_3, B_4, B_5, B_6, B_7;

assign Bin_0 = max_val_d1? B_0:0;
assign Bin_1 = max_val_d1? B_1:0;
assign Bin_2 = max_val_d1? B_2:0;
assign Bin_3 = max_val_d1? B_3:0;
assign Bin_4 = max_val_d1? B_4:0;
assign Bin_5 = max_val_d1? B_5:0;
assign Bin_6 = max_val_d1? B_6:0;
assign Bin_7 = max_val_d1? B_7:0;


Compare_Block1 Channel_0_max(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_0), .max_value(max_0), .loadthrehold(loadthrehold[0]), .threhold(data_o), .binary(B_0));
Compare_Block1 Channel_1_max(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_1), .max_value(max_1), .loadthrehold(loadthrehold[1]), .threhold(data_o), .binary(B_1));
Compare_Block1 Channel_2_max(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_2), .max_value(max_2), .loadthrehold(loadthrehold[2]), .threhold(data_o), .binary(B_2));
Compare_Block1 Channel_3_max(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_3), .max_value(max_3), .loadthrehold(loadthrehold[3]), .threhold(data_o), .binary(B_3));
Compare_Block1 Channel_4_max(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_4), .max_value(max_4), .loadthrehold(loadthrehold[4]), .threhold(data_o), .binary(B_4));
Compare_Block1 Channel_5_max(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_5), .max_value(max_5), .loadthrehold(loadthrehold[5]), .threhold(data_o), .binary(B_5));
Compare_Block1 Channel_6_max(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_6), .max_value(max_6), .loadthrehold(loadthrehold[6]), .threhold(data_o), .binary(B_6));
Compare_Block1 Channel_7_max(.clk(clk), .rst_n(rst_n), .in_Data(Conpare_In_seven_7), .max_value(max_7), .loadthrehold(loadthrehold[7]), .threhold(data_o), .binary(B_7));



    

endmodule
