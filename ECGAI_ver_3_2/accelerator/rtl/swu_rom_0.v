module swu_rom_0#(parameter DEPTH = 29)
(
    input               clk,
    input               rst_n,
    input               enable,
    input       [4:0]   addr,
    output  reg [31:0]  data_o
);
    
    
//    (* ram_style = "block" *)reg [31:0] rom [DEPTH - 1 : 0];
    reg [31:0] rom [DEPTH - 1 : 0];
    initial begin
        $readmemb("G:\\ECG_BNN_9160\\Data\\ECG\\ecg_a0.txt", rom);
    end
    always@(posedge clk)begin
//        if(!rst_n)begin
//            data_o <= 0;
//        end
//        else 
        if(enable)begin
            data_o <=  rom[addr];
        end
//        else
//            data_o <= 0;
    end
endmodule