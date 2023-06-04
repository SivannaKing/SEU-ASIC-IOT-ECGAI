`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/05 15:29:25
// Design Name: 
// Module Name: swu_2
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


module swu_2(
    input               clk,
    input               rst_n,
    output  reg [6:0]   slide_data,
    output  wire        trans_done,
    output  reg         ecg_data_val
);
parameter DEPTH = 29;
wire                enable;
reg     [4:0]       addr;
wire    [31:0]      data_o;
//swu_rom_2 SWU_ROM_2(.clk(clk), .rst_n(rst_n), .enable(enable), .addr(addr), .data_o(data_o));
ECG_2_IP SWU_ROM_2 (
  .clka(clk),    // input wire clka
  .ena(enable),      // input wire ena
  .addra(addr),  // input wire [4 : 0] addra
  .douta(data_o)  // output wire [31 : 0] douta
);

reg [4:0] cnt;
reg [5:0] temp_end; //缓存32bit的最�?6bit，用来与下一行的凑成步长�?2�?7bit数据�?


always @(posedge clk or negedge rst_n)begin
    if(!rst_n || cnt==0)begin
        slide_data <= 7'b0000_000;
    end else if(cnt <= 13)begin
        slide_data <= data_o[31-((cnt-1)<<1) -: 7];
    end
    else case(cnt)
        14: slide_data <= {temp_end[5:0], data_o[31]};
        15: slide_data <= {temp_end[3:0], data_o[31 :29]};
        16: slide_data <= {temp_end[1:0], data_o[31 : 27]};
    endcase
end

//always @(*)begin
//    if(cnt <= 13)begin
//        slide_data = data_o[31-((cnt-1)<<1) -: 7];
//    end
//    else case(cnt)
//        14: slide_data = {temp_end[5:0], data_o[31]};
//        15: slide_data = {temp_end[3:0], data_o[31 :29]};
//        16: slide_data = {temp_end[1:0], data_o[31 : 27]};
//    endcase
////        slide_data <= {temp_end[5 - 2*(cnt-13) : 0], rom[i][31 : 31-2*(cnt-13)]}; error : 'cnt' is not a constant
//end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        cnt <= 0;       
    end
    else if (cnt == 16)begin
        cnt <= 1; 
    end
    else
        cnt <= cnt + 1;
end



always @ (posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        temp_end <= 0;
    end
    else if(cnt == 13)begin
        temp_end <= data_o[5:0];
    end
    else if (cnt == 16)begin
        temp_end <= 0;
    end
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        addr <= 0;
    end
    else if(addr < DEPTH - 1 && cnt == 12) begin
        addr <= addr + 1;
    end
end

//�?后一行处�?
reg     delay_trans1, delay_trans2;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        delay_trans1 <= 0;
    end
    else if(addr == 28 && cnt == 3)begin
         delay_trans1 <= 1;
    end
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        delay_trans2 <= 0;
    end
    else begin
        delay_trans2 <= delay_trans1;
    end
end

assign trans_done= (~delay_trans2) & delay_trans1;
assign enable = (rst_n==1) && (delay_trans1==0);


//ecg_data_val信号，用来生成pe阵列的enable
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ecg_data_val <= 0;
    else if (cnt == 1)
        ecg_data_val <= 1;

end
endmodule
