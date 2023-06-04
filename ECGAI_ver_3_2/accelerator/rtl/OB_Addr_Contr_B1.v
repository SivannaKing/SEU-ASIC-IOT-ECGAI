`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/12 15:07:26
// Design Name: 
// Module Name: Output_Buffer_B1
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


module OB_Addr_Contr_B1(
    input                       clk,
    input                       rst_n,
    input  wire signed [3:0]    o_00, o_01, o_02, o_03,
                                o_10, o_11, o_12, o_13,
                                o_20, o_21, o_22, o_23,
                                o_30, o_31, o_32, o_33,
                                o_40, o_41, o_42, o_43,
                                o_50, o_51, o_52, o_53,
                                o_60, o_61, o_62, o_63,
                                o_70, o_71, o_72, o_73,
    input                       Trans_Done_0, Trans_Done_3,
//    input                       Data_Val_0,             //这个信号是pe阵列的rst_n, 帮助本模块确认何时PE阵列输出有效
    output  reg     [31:0]      OB_Data_0, OB_Data_1, OB_Data_2, OB_Data_3, OB_Data_4, OB_Data_5, OB_Data_6, OB_Data_7,  //8个ram的32bit写入数据,
    
    output  reg     [7:0]       ADDR_0, ADDR_1, ADDR_2, ADDR_3, 
                                ADDR_4, ADDR_5, ADDR_6, ADDR_7,
                                
    output  wire                ENA_0, ENA_1, ENA_2, ENA_3, 
                                ENA_4, ENA_5, ENA_6, ENA_7,                  
    
    output  reg                 write_enable_0, write_enable_1, write_enable_2, write_enable_3,
                                write_enable_4, write_enable_5, write_enable_6, write_enable_7       
);


    assign ENA_0 = write_enable_0;
    assign ENA_1 = write_enable_1;
    assign ENA_2 = write_enable_2;
    assign ENA_3 = write_enable_3;
    assign ENA_4 = write_enable_4;
    assign ENA_5 = write_enable_5;
    assign ENA_6 = write_enable_6;
    assign ENA_7 = write_enable_7;
    
//********************************************************输出通道0********************************************************
//o00的0~451个数据在rom0的地址0~55中存储，多出来的3个与o01产生的前5个合并为32bit存在rom0的地址56中
    reg     [3:0]   cnt_00, cnt_01, cnt_02, cnt_03;     
    reg             start_cnt_01,  start_cnt_02, start_cnt_03;  //为1标志cnt_01开始计时
    
    reg     [5:0]   ADDR_cnt_00, ADDR_cnt_00_d1;
    reg     [6:0]   ADDR_cnt_01, ADDR_cnt_01_d1;
    reg     [7:0]   ADDR_cnt_02, ADDR_cnt_02_d1;
    reg     [8:0]   ADDR_cnt_03, ADDR_cnt_03_d1;
    reg     Trans_Done_0_flag, Trans_Done_3_flag ;  //为了方便计算结束后write_enable的及时关闭 
    
    
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            Trans_Done_0_flag <= 0;
        end else if(Trans_Done_0)
            Trans_Done_0_flag <= 1;
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            Trans_Done_3_flag <= 0;
        end else if(Trans_Done_3)
            Trans_Done_3_flag <= 1;
    end
    
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_00 <= 0;
            ADDR_cnt_00 <= 0;
        end
        else begin
            //cnt_00的相关赋值操作
            if(!Trans_Done_0_flag) begin
                if(cnt_00 == 8) begin
                    cnt_00 <= 1 ;
                    ADDR_cnt_00 <= ADDR_cnt_00 + 1;
                end
                else begin
                    cnt_00 <= cnt_00 + 1;
                end
            end
            else if(Trans_Done_0_flag) begin
                if(cnt_00==3) begin
//                    ADDR_cnt_00 <= ADDR_cnt_00 + 1;
                    cnt_00 <= 0; 
                end
            end        
        end   
    end

    reg         write_enable_00, write_enable_01, write_enable_02, write_enable_03;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            write_enable_00 <= 0;
        end
        else if(Trans_Done_0_flag == 0) begin
            if(cnt_00 == 8) begin
                write_enable_00 <= 1;
            end
            else begin
                write_enable_00 <= 0;
            end   
        end
        else if(Trans_Done_0_flag == 1)begin
            if(cnt_00 == 3) begin
                write_enable_00 <= 1;
            end
            else begin
                write_enable_00 <= 0;
            end
        end
    end
    reg     [31:0]      OB_Data_00;


    
    reg     [19:0]  o01_temp_5;//o01产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o01_temp_5 <= 0;
        end else if(ADDR_cnt_00 == 0 && cnt_00 <=5 && write_enable_00==0)begin
            o01_temp_5[19 - ((cnt_00-1'b1)<<2) -: 4] <= o_01;
        end
    end
    //2023.05.10综合出来说我的代码有warnings，是同一信号被多个always驱动，现进行更改，更改前的源代码注释如下
//    always@(posedge clk)begin
//        if(ADDR_cnt_00==56&&cnt_00<=3) begin
//            OB_Data_00[19:0] <= o01_temp_5;
//            OB_Data_00[31 - ((cnt_00-1'b1)<<2) -: 4] <= o_00;
//        end
//    end
    
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)begin
//            OB_Data_00 <= 32'h0000;
//        end else if(cnt_00<=8 && ADDR_cnt_00 <= 55)begin
//            OB_Data_00[31 - ((cnt_00-1'b1)<<2) -: 4] <= o_00;
//        end 
//    end
    //更改后的源代码注释如下，查看波形图最终结果，是否因这里的代码改动而差生差异: 否，更改对最终结果无影响
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_00 <= 32'h0000;
        end 
        else begin
            if(cnt_00<=8 && ADDR_cnt_00 <= 55)begin
                OB_Data_00[31 - ((cnt_00-1'b1)<<2) -: 4] <= o_00;
            end
            else if(ADDR_cnt_00 == 56 && cnt_00 <= 3) begin
                OB_Data_00[19:0] <= o01_temp_5;
                OB_Data_00[31 - ((cnt_00-1'b1)<<2) -: 4] <= o_00;
            end
        end 
    end
    
    //为了一些细节的处理，导致一个简单想法的逻辑代码很冗余，待以后再修改简化
//o_01的第6个数据开始，8个8个地将o_11的输出存入RAM的57、58、59……地址
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_01<= 0;
            ADDR_cnt_01 <= 57;
            start_cnt_01 <= 0;
        end
        else begin   //cnt_01的相关赋值操作
            if(!Trans_Done_0_flag)begin
                if (!start_cnt_01 && cnt_00 == 5) begin
                    start_cnt_01 <= 1;
                    cnt_01 <= 1;
                end
                else if (start_cnt_01 && cnt_01 == 8) begin
                    cnt_01 <= 1;
                    ADDR_cnt_01 <= ADDR_cnt_01 + 1;
                end
                else if (start_cnt_01) begin
                    cnt_01 <= cnt_01 + 1;
                end 
            end  else if(Trans_Done_0_flag)begin
                if(cnt_01==6) begin
                    cnt_01 <= 0; 
                end
            end 
        end 
    end
    
    reg     write_enable_01_d1;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            write_enable_01 <= 0;
            write_enable_01_d1 <= 0;
        end
        else if(Trans_Done_0_flag == 0) begin
            if(cnt_01 == 8) begin
                write_enable_01 <= 1;
            end
            else begin
                write_enable_01 <= 0;
            end   
        end
        else if(Trans_Done_0_flag == 1)begin
            if(cnt_01 == 6) begin
                write_enable_01_d1 <= 1;
                write_enable_01 <= write_enable_01_d1;  //延迟1个clk是因为不这样的话会在同一个clk向着ram的2个不同地址写数据
            end
            else begin
                write_enable_01_d1 <= 0;
                write_enable_01 <= write_enable_01_d1;
                
            end
        end
    end    
    
    reg     [7: 0]  o02_temp_2;//o02产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    reg     [31:0]  OB_Data_01;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o02_temp_2 <= 0;
        end else if(ADDR_cnt_00 == 0 && cnt_00 <=2 && write_enable_00==0)begin
            o02_temp_2[7 - ((cnt_00-1'b1)<<2) -: 4] <= o_02;
        end
    end
    //2023.05.10综合出来说我的代码有warnings，是同一信号被多个always驱动，现进行更改，更改前的源代码注释如下
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)begin
//            OB_Data_01 <= 32'h0000;
//        end else if(cnt_01<=8 && ADDR_cnt_01 <= 111)begin
//            OB_Data_01[31 - ((cnt_01-1'b1)<<2) -: 4] <= o_01;
//        end 
//    end

    
//    always@(posedge clk)begin
//        if(ADDR_cnt_01 == 112 && cnt_01 <= 6) begin
//            OB_Data_01[7:0] <= o02_temp_2;
//            OB_Data_01[31 - ((cnt_01-1'b1)<<2) -: 4] <= o_01;     
//        end
//    end
    //更改后的源代码注释如下，查看波形图最终结果，是否因这里的代码改动而差生差异: 否
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_01 <= 32'h0000;
        end 
        else begin
            if(cnt_01<=8 && ADDR_cnt_01 <= 111)begin
                OB_Data_01[31 - ((cnt_01-1'b1)<<2) -: 4] <= o_01;
            end
            else if(ADDR_cnt_01 == 112 && cnt_01 <= 6) begin
                OB_Data_01[7:0] <= o02_temp_2;
                OB_Data_01[31 - ((cnt_01-1'b1)<<2) -: 4] <= o_01;     
            end
        end 
    end

 //o_02的第3个数据开始，以32bit存入ram的113、114、115……地址
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_02<= 0;
            ADDR_cnt_02 <= 113;
            start_cnt_02 <= 0;
        end
        else begin   //cnt_02的相关赋值操作
            if(!Trans_Done_0_flag)begin
                if (!start_cnt_02 && cnt_00 == 2) begin
                    start_cnt_02 <= 1;
                    cnt_02 <= 1;
                end
                else if (start_cnt_02 && cnt_02 == 8) begin
                    cnt_02 <= 1;
                    ADDR_cnt_02 <= ADDR_cnt_02 + 1;
                end
                else if (start_cnt_02) begin
                    cnt_02 <= cnt_02 + 1;
                end 
            end  else if(Trans_Done_0_flag)begin
                if(cnt_02==1) begin
                    cnt_02 <= 0; 
                end
            end 
        end 
    end
    
    
    reg     write_enable_02_d1, write_enable_02_d2;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            write_enable_02 <= 0;
            write_enable_02_d1 <= 0;
            write_enable_02_d2 <= 0;
        end
        else if(Trans_Done_0_flag == 0) begin
            if(cnt_02 == 8) begin
                write_enable_02 <= 1;
            end
            else begin
                write_enable_02 <= 0;
            end   
        end
        else if(Trans_Done_0_flag == 1)begin
            if(cnt_02 == 1) begin
                write_enable_02_d2 <= 1;
                write_enable_02_d1 <= write_enable_02_d2;
                write_enable_02 <= write_enable_02_d1;  //延迟1个clk是因为不这样的话会在同一个clk向着ram的2个不同地址写数据
            end
            else begin
                write_enable_02_d2 <= 0;
                write_enable_02_d1 <= write_enable_02_d2;
                write_enable_02 <= write_enable_02_d1;
                
            end
        end
    end    
    
    reg     [27: 0]  o03_temp_7;
    reg     [31:0]  OB_Data_02;

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o03_temp_7 <= 0;
        end else if(ADDR_cnt_00 == 0 && cnt_00 <=7 && write_enable_00==0)begin
            o03_temp_7[27 - ((cnt_00-1'b1)<<2) -: 4] <= o_03;
        end
    end
//2023.05.10综合出来说我的代码有warnings，是同一信号被多个always驱动，现进行更改，更改前的源代码注释如下
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)begin
//            OB_Data_02 <= 32'h0000;
//        end else if(cnt_02<=8 && ADDR_cnt_02 <= 168)begin
//            OB_Data_02[31 - ((cnt_02-1'b1)<<2) -: 4] <= o_02;
//        end 
//    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_02 == 169 && cnt_02 <= 1) begin
//            OB_Data_02[27:0] <= o03_temp_7;
//            OB_Data_02[31 - ((cnt_02-1'b1)<<2) -: 4] <= o_02;     
//        end
//    end
//更改后的源代码注释如下，查看波形图最终结果，是否因这里的代码改动而差生差异: 否
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_02 <= 32'h0000;
        end 
        else begin
            if(cnt_02<=8 && ADDR_cnt_02 <= 168)begin
                OB_Data_02[31 - ((cnt_02-1'b1)<<2) -: 4] <= o_02;
            end
            else if(ADDR_cnt_02 == 169 && cnt_02 <= 1) begin
                OB_Data_02[27:0] <= o03_temp_7;
                OB_Data_02[31 - ((cnt_02-1'b1)<<2) -: 4] <= o_02;     
            end
        end  
    end

//o_03的第8个数据开始，8个一组存入ram的地址170、171
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_03 <= 0;
            ADDR_cnt_03 <= 170;
            start_cnt_03 <= 0;
        end
        else begin   //cnt_03的相关赋值操作
            if(!Trans_Done_3_flag)begin
                if (!start_cnt_03 && cnt_00 == 7) begin
                    start_cnt_03 <= 1;
                    cnt_03 <= 1;
                end
                else if (start_cnt_03 && cnt_03 == 8) begin
                    cnt_03 <= 1;
                    ADDR_cnt_03 <= ADDR_cnt_03 + 1;
                end
                else if (start_cnt_03) begin
                    cnt_03 <= cnt_03 + 1;
                end 
            end  else if(Trans_Done_3_flag)begin
                if(cnt_03 == 2) begin
                    cnt_03 <= 0; 
                end
            end 
        end 
    end
    
    

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            write_enable_03 <= 0;
        end
        else if(Trans_Done_3_flag == 0) begin
            if(cnt_03 == 8) begin
                write_enable_03 <= 1;
            end
            else begin
                write_enable_03 <= 0;
            end   
        end
        else if(Trans_Done_3_flag == 1)begin
            if(cnt_03 == 2) begin
                  write_enable_03 <= 1;  
            end
            else begin
                write_enable_03 <= 0;
            end
        end
    end    
    
    reg     [31:0]  OB_Data_03;

    
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)begin
//            OB_Data_03 <= 32'h0000;
//        end else if(cnt_03<=8 && ADDR_cnt_03 <= 224)begin
//            OB_Data_03[31 - ((cnt_03-1'b1)<<2) -: 4] <= o_03;
//        end 
//    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_03 == 225 && cnt_03 <= 2) begin
//            OB_Data_03[23:0] <= 0;
//            OB_Data_03[31 - ((cnt_03-1'b1)<<2) -: 4] <= o_03;     
//        end
//    end
    //更改后的源代码注释如下，查看波形图最终结果，是否因这里的代码改动而差生差异: 否
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_03 <= 32'h0000;
        end 
        else begin 
            if(cnt_03<=8 && ADDR_cnt_03 <= 224)begin
                OB_Data_03[31 - ((cnt_03-1'b1)<<2) -: 4] <= o_03;
            end 
            else if(ADDR_cnt_03 == 225 && cnt_03 <= 2) begin
                OB_Data_03[23:0] <= 0;
                OB_Data_03[31 - ((cnt_03-1'b1)<<2) -: 4] <= o_03;     
            end 
        end
    end
    
 //根据条件确定SPRAM的输出与地址的组合逻辑  
    always@(*)begin
        if(!rst_n) begin
            OB_Data_0 = 0;
            write_enable_0 = 0;
        end
        else begin
            if(write_enable_00) begin
                OB_Data_0 = OB_Data_00;
                write_enable_0 = 1;
            end
            else if(write_enable_01) begin
                OB_Data_0 = OB_Data_01;
                write_enable_0 = 1;
            end
            else if(write_enable_02)begin
                OB_Data_0 = OB_Data_02;
                write_enable_0 = 1;
            end
            else if(write_enable_03) begin
                OB_Data_0 = OB_Data_03;
                write_enable_0 = 1;
            end
            else begin
                OB_Data_0 = 0;
                write_enable_0 = 0;
            end
        end
    end
    
    always@(*)begin
        if(!rst_n)begin
            ADDR_0 = 0;
        end
        else begin 
        if(write_enable_00) begin
            ADDR_0 = ADDR_cnt_00_d1;
        end 
        else if(write_enable_01)begin
            ADDR_0 = ADDR_cnt_01_d1;
        end
        else if(write_enable_02)begin
            ADDR_0 = ADDR_cnt_02_d1;
        end
        else if(write_enable_03)begin
            ADDR_0 = ADDR_cnt_03_d1;
        end
        else
            ADDR_0 = 0;
        end

    end   
   
    always@(posedge clk)begin
        ADDR_cnt_00_d1 <= ADDR_cnt_00;
        ADDR_cnt_01_d1 <= ADDR_cnt_01;
        ADDR_cnt_02_d1 <= ADDR_cnt_02;
        ADDR_cnt_03_d1 <= ADDR_cnt_03;
    end


//********************************************************输出通道1********************************************************
//o10的0~451个数据在rom1的地址0~55中存储，多出来的3个与o11产生的前5个合并为32bit存在rom1的地址56中
    reg     [3:0]   cnt_10, cnt_11, cnt_12, cnt_13;     
//    reg             start_cnt_11,  start_cnt_12, start_cnt_13;  //为1标志cnt_01开始计时
    
    reg     [5:0]   ADDR_cnt_10, ADDR_cnt_10_d1;
    reg     [6:0]   ADDR_cnt_11, ADDR_cnt_11_d1;
    reg     [7:0]   ADDR_cnt_12, ADDR_cnt_12_d1;
    reg     [8:0]   ADDR_cnt_13, ADDR_cnt_13_d1;
//    reg     Trans_Done_0_flag_d1, Trans_Done_3_flag_d1 ;  //为了方便计算结束后write_enable的及时关闭
    reg     write_enable_10, write_enable_11, write_enable_12, write_enable_13;
    
    always@(posedge clk)begin
        cnt_10 <= cnt_00;
        cnt_11 <= cnt_01;
        cnt_12 <= cnt_02;
        cnt_13 <= cnt_03;
        ADDR_cnt_10 <= ADDR_cnt_00;
        ADDR_cnt_10_d1 <= ADDR_cnt_00_d1;
        
        ADDR_cnt_11 <= ADDR_cnt_01;
        ADDR_cnt_11_d1 <= ADDR_cnt_01_d1;
        
        ADDR_cnt_12 <= ADDR_cnt_02;
        ADDR_cnt_12_d1 <= ADDR_cnt_02_d1;
        
        ADDR_cnt_13 <= ADDR_cnt_03;
        ADDR_cnt_13_d1 <= ADDR_cnt_03_d1;
        
//        Trans_Done_0_flag_d1 <= Trans_Done_0_flag;
//        Trans_Done_3_flag_d1 <= Trans_Done_3_flag;
        
        write_enable_10 <= write_enable_00;
        write_enable_11 <= write_enable_01;
        write_enable_12 <= write_enable_02;
        write_enable_13 <= write_enable_03;
        
//        start_cnt_11 <= start_cnt_01;
//        start_cnt_12 <= start_cnt_02;
//        start_cnt_13 <= start_cnt_03;           
    end

    reg     [31:0]      OB_Data_10;
 
    reg     [19:0]  o11_temp_5;//o01产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o11_temp_5 <= 0;
        end else if(ADDR_cnt_10 == 0 && cnt_10 <=5 && write_enable_10==0)begin
            o11_temp_5[19 - ((cnt_10-1'b1)<<2) -: 4] <= o_11;
        end
    end
    //05.10 修改warning
//    always@(posedge clk)begin
//        if(ADDR_cnt_10==56 && cnt_10<=3) begin
//            OB_Data_10[19:0] <= o11_temp_5;
//            OB_Data_10[31 - ((cnt_10-1'b1)<<2) -: 4] <= o_10;
//        end
//    end
        
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)begin
//            OB_Data_10 <= 32'h0000;
//        end else if(cnt_10<=8 && ADDR_cnt_10 <= 55)begin
//            OB_Data_10[31 - ((cnt_10-1'b1)<<2) -: 4] <= o_10;
//        end 
//    end
    
        
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_10 <= 32'h0000;
        end else begin
        
        if(cnt_10<=8 && ADDR_cnt_10 <= 55)begin
            OB_Data_10[31 - ((cnt_10-1'b1)<<2) -: 4] <= o_10;
        end else if(ADDR_cnt_10==56 && cnt_10<=3) begin
            OB_Data_10[19:0] <= o11_temp_5;
            OB_Data_10[31 - ((cnt_10-1'b1)<<2) -: 4] <= o_10;
        end
        end
    end
    
    
    //为了一些细节的处理，导致一个简单想法的逻辑代码很冗余，待以后再修改简化
//o_01的第6个数据开始，8个8个地将o_11的输出存入RAM的57、58、59……地址

    
    reg     [7: 0]  o12_temp_2;//o02产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    reg     [31:0]  OB_Data_11;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o12_temp_2 <= 0;
        end else if(ADDR_cnt_10 == 0 && cnt_10 <= 2 && write_enable_10 == 0)begin
            o12_temp_2[7 - ((cnt_10-1'b1)<<2) -: 4] <= o_12;
        end
    end
    //05.10 修改
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)begin
//            OB_Data_11 <= 32'h0000;
//        end else if(cnt_11<=8 && ADDR_cnt_11 <= 111)begin
//            OB_Data_11[31 - ((cnt_11-1'b1)<<2) -: 4] <= o_11;
//        end 
//    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_11 == 112 && cnt_11 <= 6) begin
//            OB_Data_11[7:0] <= o12_temp_2;
//            OB_Data_11[31 - ((cnt_11-1'b1)<<2) -: 4] <= o_11;     
//        end
//    end
    //修改后
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_11 <= 32'h0000;
        end else begin 
        if(cnt_11<=8 && ADDR_cnt_11 <= 111)begin
            OB_Data_11[31 - ((cnt_11-1'b1)<<2) -: 4] <= o_11;
        end else if(ADDR_cnt_11 == 112 && cnt_11 <= 6) begin
            OB_Data_11[7:0] <= o12_temp_2;
            OB_Data_11[31 - ((cnt_11-1'b1)<<2) -: 4] <= o_11;     
            end
        end
    end
    
    
 //o_02的第3个数据开始，以32bit存入ram的113、114、115……地址

 
    
    reg     [27: 0]  o13_temp_7;
    reg     [31:0]   OB_Data_12;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o13_temp_7 <= 0;
        end else if(ADDR_cnt_10 == 0 && cnt_10 <= 7 && write_enable_10==0)begin
            o13_temp_7[27 - ((cnt_10-1'b1)<<2) -: 4] <= o_13;
        end
    end
    //  05.10修改
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)begin
//            OB_Data_12 <= 32'h0000;
//        end else if(cnt_12<=8 && ADDR_cnt_12 <= 168)begin
//            OB_Data_12[31 - ((cnt_12-1'b1)<<2) -: 4] <= o_12;
//        end 
//    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_12 == 169 && cnt_12 <= 1) begin
//            OB_Data_12[27:0] <= o13_temp_7;
//            OB_Data_12[31 - ((cnt_12-1'b1)<<2) -: 4] <= o_12;     
//        end
//    end
    //修改后
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_12 <= 32'h0000;
        end else begin 
            if(cnt_12<=8 && ADDR_cnt_12 <= 168)begin
                OB_Data_12[31 - ((cnt_12-1'b1)<<2) -: 4] <= o_12;
            end else if(ADDR_cnt_12 == 169 && cnt_12 <= 1) begin
                OB_Data_12[27:0] <= o13_temp_7;
                OB_Data_12[31 - ((cnt_12-1'b1)<<2) -: 4] <= o_12;     
            end   
        end
    end
//o_03的第8个数据开始，8个一组存入ram的地址170、171

    
    reg     [31:0]  OB_Data_13;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_13 <= 32'h0000;
        end else begin 
            if(cnt_13<=8 && ADDR_cnt_13 <= 224)begin
                OB_Data_13[31 - ((cnt_13-1'b1)<<2) -: 4] <= o_13;
            end
            else  if(ADDR_cnt_13 == 225 && cnt_13 <= 2) begin
                OB_Data_13[23:0] <= 0;
                OB_Data_13[31 - ((cnt_13-1'b1)<<2) -: 4] <= o_13;     
            end
        end
    end

    
 //根据条件确定SPRAM的输出与地址的组合逻辑  
    always@(*)begin
        if(!rst_n) begin
            OB_Data_1 = 0;
            write_enable_1 = 0;
        end
        else begin
            if(write_enable_10) begin
                OB_Data_1 = OB_Data_10;
                write_enable_1 = 1;
            end
            else if(write_enable_11) begin
                OB_Data_1 = OB_Data_11;
                write_enable_1 = 1;
            end
            else if(write_enable_12)begin
                OB_Data_1 = OB_Data_12;
                write_enable_1 = 1;
            end
            else if(write_enable_13) begin
                OB_Data_1 = OB_Data_13;
                write_enable_1 = 1;
            end
            else begin
                OB_Data_1 = 0;
                write_enable_1 = 0;
            end
        end
    end
    
    always@(*)begin
        if(!rst_n)begin
            ADDR_1 = 0;
        end
        else begin 
        if(write_enable_10) begin
            ADDR_1 = ADDR_cnt_10_d1;
        end 
        else if(write_enable_11)begin
            ADDR_1 = ADDR_cnt_11_d1;
        end
        else if(write_enable_12)begin
            ADDR_1 = ADDR_cnt_12_d1;
        end
        else if(write_enable_13)begin
            ADDR_1 = ADDR_cnt_13_d1;
        end
        else
            ADDR_1 = 0;
        end
    end   

//********************************************************输出通道2********************************************************
//o20的0~451个数据在rom2的地址0~55中存储，多出来的3个与o21产生的前5个合并为32bit存在rom2的地址56中
    reg     [3:0]   cnt_20, cnt_21, cnt_22, cnt_23;     
//    reg             start_cnt_21,  start_cnt_22, start_cnt_23;  //为1标志cnt_01开始计时
    
    reg     [5:0]   ADDR_cnt_20, ADDR_cnt_20_d1;
    reg     [6:0]   ADDR_cnt_21, ADDR_cnt_21_d1;
    reg     [7:0]   ADDR_cnt_22, ADDR_cnt_22_d1;
    reg     [8:0]   ADDR_cnt_23, ADDR_cnt_23_d1;
    reg     Trans_Done_0_flag_d2, Trans_Done_3_flag_d2 ;  //为了方便计算结束后write_enable的及时关闭
    reg     write_enable_20, write_enable_21, write_enable_22, write_enable_23;
    
    always@(posedge clk)begin
        cnt_20 <= cnt_10;
        cnt_21 <= cnt_11;
        cnt_22 <= cnt_12;
        cnt_23 <= cnt_13;
        ADDR_cnt_20 <= ADDR_cnt_10;
        ADDR_cnt_20_d1 <= ADDR_cnt_10_d1;
        
        ADDR_cnt_21 <= ADDR_cnt_11;
        ADDR_cnt_21_d1 <= ADDR_cnt_11_d1;
        
        ADDR_cnt_22 <= ADDR_cnt_12;
        ADDR_cnt_22_d1 <= ADDR_cnt_12_d1;
        
        ADDR_cnt_23 <= ADDR_cnt_13;
        ADDR_cnt_23_d1 <= ADDR_cnt_13_d1;
        
//        Trans_Done_0_flag_d2 <= Trans_Done_0_flag_d1;
//        Trans_Done_3_flag_d2 <= Trans_Done_3_flag_d1;
        
        write_enable_20 <= write_enable_10;
        write_enable_21 <= write_enable_11;
        write_enable_22 <= write_enable_12;
        write_enable_23 <= write_enable_13;
        
//        start_cnt_21 <= start_cnt_11;
//        start_cnt_22 <= start_cnt_12;
//        start_cnt_23 <= start_cnt_13;           
    end

    reg     [31:0]      OB_Data_20;
 
    reg     [19:0]  o21_temp_5;//o01产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o21_temp_5 <= 0;
        end else if(ADDR_cnt_20 == 0 && cnt_20 <=5 && write_enable_20==0)begin
            o21_temp_5[19 - ((cnt_20-1'b1)<<2) -: 4] <= o_21;
        end
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_20==56 && cnt_20<=3) begin
//            OB_Data_20[19:0] <= o21_temp_5;
//            OB_Data_20[31 - ((cnt_20-1'b1)<<2) -: 4] <= o_20;
//        end
//    end
        
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)begin
//            OB_Data_20 <= 32'h0000;
//        end else if(cnt_20<=8 && ADDR_cnt_20 <= 55)begin
//            OB_Data_20[31 - ((cnt_20-1'b1)<<2) -: 4] <= o_20;
//        end 
//    end
//    always@(posedge clk)begin
//        if(ADDR_cnt_20==56 && cnt_20<=3) begin
//            OB_Data_20[19:0] <= o21_temp_5;
//            OB_Data_20[31 - ((cnt_20-1'b1)<<2) -: 4] <= o_20;
//        end
//    end
        
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_20 <= 32'h0000;
        end else begin 
            if(cnt_20<=8 && ADDR_cnt_20 <= 55)begin
                OB_Data_20[31 - ((cnt_20-1'b1)<<2) -: 4] <= o_20;
            end else if(ADDR_cnt_20==56 && cnt_20<=3) begin
                OB_Data_20[19:0] <= o21_temp_5;
                OB_Data_20[31 - ((cnt_20-1'b1)<<2) -: 4] <= o_20;
            end
        end 
    end
    
    //为了一些细节的处理，导致一个简单想法的逻辑代码很冗余，待以后再修改简化
//o_01的第6个数据开始，8个8个地将o_11的输出存入RAM的57、58、59……地址

    
    reg     [7: 0]  o22_temp_2;//o02产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    reg     [31:0]  OB_Data_21;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o22_temp_2 <= 0;
        end else if(ADDR_cnt_20 == 0 && cnt_20 <= 2 && write_enable_20 == 0)begin
            o22_temp_2[7 - ((cnt_20-1'b1)<<2) -: 4] <= o_22;
        end
    end
    //05.10 修改前
//    always@(posedge clk or negedge rst_n)begin
//        if(!rst_n)begin
//            OB_Data_21 <= 32'h0000;
//        end else if(cnt_21<=8 && ADDR_cnt_21 <= 111)begin
//            OB_Data_21[31 - ((cnt_21-1'b1)<<2) -: 4] <= o_21;
//        end 
//    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_21 == 112 && cnt_21 <= 6) begin
//            OB_Data_21[7:0] <= o22_temp_2;
//            OB_Data_21[31 - ((cnt_21-1'b1)<<2) -: 4] <= o_21;     
//        end
//    end
    //修改
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_21 <= 32'h0000;
        end else begin
            if(cnt_21<=8 && ADDR_cnt_21 <= 111)begin
                OB_Data_21[31 - ((cnt_21-1'b1)<<2) -: 4] <= o_21;
            end else if(ADDR_cnt_21 == 112 && cnt_21 <= 6) begin
                OB_Data_21[7:0] <= o22_temp_2;
                OB_Data_21[31 - ((cnt_21-1'b1)<<2) -: 4] <= o_21;     
            end
        end
    end

 //o_02的第3个数据开始，以32bit存入ram的113、114、115……地址
    reg     [27: 0]  o23_temp_7;
    reg     [31:0]   OB_Data_22;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o23_temp_7 <= 0;
        end else if(ADDR_cnt_20 == 0 && cnt_20 <= 7 && write_enable_20==0)begin
            o23_temp_7[27 - ((cnt_20-1'b1)<<2) -: 4] <= o_23;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_22 <= 32'h0000;
        end else begin
            if(cnt_22<=8 && ADDR_cnt_22 <= 168)begin
                OB_Data_22[31 - ((cnt_22-1'b1)<<2) -: 4] <= o_22;
            end if(ADDR_cnt_22 == 169 && cnt_22 <= 1) begin
                OB_Data_22[27:0] <= o23_temp_7;
                OB_Data_22[31 - ((cnt_22-1'b1)<<2) -: 4] <= o_22;     
            end
         end
    end
    
//o_03的第8个数据开始，8个一组存入ram的地址170、171
    
    reg     [31:0]  OB_Data_23;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_23 <= 32'h0000;
        end else begin
            if(cnt_23<=8 && ADDR_cnt_23 <= 224)begin
                OB_Data_23[31 - ((cnt_23-1'b1)<<2) -: 4] <= o_23;
            end else if(ADDR_cnt_23 == 225 && cnt_23 <= 2) begin
                OB_Data_23[23:0] <= 0;
                OB_Data_23[31 - ((cnt_23-1'b1)<<2) -: 4] <= o_23;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_23 == 225 && cnt_23 <= 2) begin
//            OB_Data_23[23:0] <= 0;
//            OB_Data_23[31 - ((cnt_23-1'b1)<<2) -: 4] <= o_23;     
//        end
//    end
    
 //根据条件确定SPRAM的输出与地址的组合逻辑  
    always@(*)begin
        if(!rst_n) begin
            OB_Data_2 = 0;
            write_enable_2 = 0;
        end
        else begin
            if(write_enable_20) begin
                OB_Data_2 = OB_Data_20;
                write_enable_2 = 1;
            end
            else if(write_enable_21) begin
                OB_Data_2 = OB_Data_21;
                write_enable_2 = 1;
            end
            else if(write_enable_22)begin
                OB_Data_2 = OB_Data_22;
                write_enable_2 = 1;
            end
            else if(write_enable_23) begin
                OB_Data_2 = OB_Data_23;
                write_enable_2 = 1;
            end
            else begin
                OB_Data_2 = 0;
                write_enable_2 = 0;
            end
        end
    end
    
    always@(*)begin
        if(!rst_n)begin
            ADDR_2 = 0;
        end
        else begin 
        if(write_enable_20) begin
            ADDR_2 = ADDR_cnt_20_d1;
        end 
        else if(write_enable_21)begin
            ADDR_2 = ADDR_cnt_21_d1;
        end
        else if(write_enable_22)begin
            ADDR_2 = ADDR_cnt_22_d1;
        end
        else if(write_enable_23)begin
            ADDR_2 = ADDR_cnt_23_d1;
        end
        else
            ADDR_2 = 0;
        end
    end   

//********************************************************输出通道3********************************************************
//o30的0~451个数据在rom3的地址0~55中存储，多出来的3个与o31产生的前5个合并为32bit存在rom3的地址56中
    reg     [3:0]   cnt_30, cnt_31, cnt_32, cnt_33;     
//    reg             start_cnt_31,  start_cnt_32, start_cnt_33;  //为1标志cnt_01开始计时
    
    reg     [5:0]   ADDR_cnt_30, ADDR_cnt_30_d1;
    reg     [6:0]   ADDR_cnt_31, ADDR_cnt_31_d1;
    reg     [7:0]   ADDR_cnt_32, ADDR_cnt_32_d1;
    reg     [8:0]   ADDR_cnt_33, ADDR_cnt_33_d1;
//    reg     Trans_Done_0_flag_d3, Trans_Done_3_flag_d3 ;  //为了方便计算结束后write_enable的及时关闭
    reg     write_enable_30, write_enable_31, write_enable_32, write_enable_33;
    
    always@(posedge clk)begin
        cnt_30 <= cnt_20;
        cnt_31 <= cnt_21;
        cnt_32 <= cnt_22;
        cnt_33 <= cnt_23;
        ADDR_cnt_30 <= ADDR_cnt_20;
        ADDR_cnt_30_d1 <= ADDR_cnt_20_d1;
        
        ADDR_cnt_31 <= ADDR_cnt_21;
        ADDR_cnt_31_d1 <= ADDR_cnt_21_d1;
        
        ADDR_cnt_32 <= ADDR_cnt_22;
        ADDR_cnt_32_d1 <= ADDR_cnt_22_d1;
        
        ADDR_cnt_33 <= ADDR_cnt_23;
        ADDR_cnt_33_d1 <= ADDR_cnt_23_d1;
        
//        Trans_Done_0_flag_d3 <= Trans_Done_0_flag_d2;
//        Trans_Done_3_flag_d3 <= Trans_Done_3_flag_d2;
        
        write_enable_30 <= write_enable_20;
        write_enable_31 <= write_enable_21;
        write_enable_32 <= write_enable_22;
        write_enable_33 <= write_enable_23;
        
//        start_cnt_31 <= start_cnt_21;
//        start_cnt_32 <= start_cnt_22;
//        start_cnt_33 <= start_cnt_23;           
    end

    reg     [31:0]      OB_Data_30;
 
    reg     [19:0]  o31_temp_5;//o01产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o31_temp_5 <= 0;
        end else if(ADDR_cnt_30 == 0 && cnt_30 <=5 && write_enable_30==0)begin
            o31_temp_5[19 - ((cnt_30-1'b1)<<2) -: 4] <= o_31;
        end
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_30==56 && cnt_30<=3) begin
//            OB_Data_30[19:0] <= o31_temp_5;
//            OB_Data_30[31 - ((cnt_30-1'b1)<<2) -: 4] <= o_30;
//        end
//    end
        
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_30 <= 32'h0000;
        end else begin 
            if(cnt_30<=8 && ADDR_cnt_30 <= 55)begin
                OB_Data_30[31 - ((cnt_30-1'b1)<<2) -: 4] <= o_30;
            end else  if(ADDR_cnt_30==56 && cnt_30<=3) begin
                OB_Data_30[19:0] <= o31_temp_5;
                OB_Data_30[31 - ((cnt_30-1'b1)<<2) -: 4] <= o_30;
            end
        end
    end
    //为了一些细节的处理，导致一个简单想法的逻辑代码很冗余，待以后再修改简化
//o_01的第6个数据开始，8个8个地将o_11的输出存入RAM的57、58、59……地址
 
    reg     [7: 0]  o32_temp_2;//o02产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    reg     [31:0]  OB_Data_31;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o32_temp_2 <= 0;
        end else if(ADDR_cnt_30 == 0 && cnt_30 <= 2 && write_enable_30 == 0)begin
            o32_temp_2[7 - ((cnt_30-1'b1)<<2) -: 4] <= o_32;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_31 <= 32'h0000;
        end else begin
            if(cnt_31<=8 && ADDR_cnt_31 <= 111)begin
                OB_Data_31[31 - ((cnt_31-1'b1)<<2) -: 4] <= o_31;
            end else if(ADDR_cnt_31 == 112 && cnt_31 <= 6) begin
                OB_Data_31[7:0] <= o32_temp_2;
                OB_Data_31[31 - ((cnt_31-1'b1)<<2) -: 4] <= o_31;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_31 == 112 && cnt_31 <= 6) begin
//            OB_Data_31[7:0] <= o32_temp_2;
//            OB_Data_31[31 - ((cnt_31-1'b1)<<2) -: 4] <= o_31;     
//        end
//    end
 //o_02的第3个数据开始，以32bit存入ram的113、114、115……地址
    reg     [27: 0]  o33_temp_7;
    reg     [31:0]   OB_Data_32;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o33_temp_7 <= 0;
        end else if(ADDR_cnt_30 == 0 && cnt_30 <= 7 && write_enable_30==0)begin
            o33_temp_7[27 - ((cnt_30-1'b1)<<2) -: 4] <= o_33;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_32 <= 32'h0000;
        end else begin 
            if(cnt_32<=8 && ADDR_cnt_32 <= 168)begin
                OB_Data_32[31 - ((cnt_32-1'b1)<<2) -: 4] <= o_32;
            end else if(ADDR_cnt_32 == 169 && cnt_32 <= 1) begin
                OB_Data_32[27:0] <= o33_temp_7;
                OB_Data_32[31 - ((cnt_32-1'b1)<<2) -: 4] <= o_32;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_32 == 169 && cnt_32 <= 1) begin
//            OB_Data_32[27:0] <= o33_temp_7;
//            OB_Data_32[31 - ((cnt_32-1'b1)<<2) -: 4] <= o_32;     
//        end
//    end
//o_03的第8个数据开始，8个一组存入ram的地址170、171……
    reg     [31:0]  OB_Data_33;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_33 <= 32'h0000;
        end else begin
            if(cnt_33<=8 && ADDR_cnt_33 <= 224)begin
                OB_Data_33[31 - ((cnt_33-1'b1)<<2) -: 4] <= o_33;
            end else if(ADDR_cnt_33 == 225 && cnt_33 <= 2) begin
                OB_Data_33[23:0] <= 0;
                OB_Data_33[31 - ((cnt_33-1'b1)<<2) -: 4] <= o_33;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_33 == 225 && cnt_33 <= 2) begin
//            OB_Data_33[23:0] <= 0;
//            OB_Data_33[31 - ((cnt_33-1'b1)<<2) -: 4] <= o_33;     
//        end
//    end
    
 //根据条件确定SPRAM的输出与地址的组合逻辑  
    always@(*)begin
        if(!rst_n) begin
            OB_Data_3 = 0;
            write_enable_3 = 0;
        end
        else begin
            if(write_enable_30) begin
                OB_Data_3 = OB_Data_30;
                write_enable_3 = 1;
            end
            else if(write_enable_31) begin
                OB_Data_3 = OB_Data_31;
                write_enable_3 = 1;
            end
            else if(write_enable_32)begin
                OB_Data_3 = OB_Data_32;
                write_enable_3 = 1;
            end
            else if(write_enable_33) begin
                OB_Data_3 = OB_Data_33;
                write_enable_3 = 1;
            end
            else begin
                OB_Data_3 = 0;
                write_enable_3 = 0;
            end
        end
    end
    
    always@(*)begin
        if(!rst_n)begin
            ADDR_3 = 0;
        end
        else begin 
        if(write_enable_30) begin
            ADDR_3 = ADDR_cnt_30_d1;
        end 
        else if(write_enable_31)begin
            ADDR_3 = ADDR_cnt_31_d1;
        end
        else if(write_enable_32)begin
            ADDR_3 = ADDR_cnt_32_d1;
        end
        else if(write_enable_33)begin
            ADDR_3 = ADDR_cnt_33_d1;
        end
        else
            ADDR_3 = 0;
        end
    end   
//********************************************************输出通道4********************************************************
//o40的0~451个数据在rom4的地址0~55中存储，多出来的3个与o41产生的前5个合并为32bit存在rom4的地址56中
    reg     [3:0]   cnt_40, cnt_41, cnt_42, cnt_43;     
//    reg             start_cnt_41,  start_cnt_42, start_cnt_43;  //为1标志cnt_01开始计时
    
    reg     [5:0]   ADDR_cnt_40, ADDR_cnt_40_d1;
    reg     [6:0]   ADDR_cnt_41, ADDR_cnt_41_d1;
    reg     [7:0]   ADDR_cnt_42, ADDR_cnt_42_d1;
    reg     [8:0]   ADDR_cnt_43, ADDR_cnt_43_d1;
//    reg     Trans_Done_0_flag_d4, Trans_Done_3_flag_d4 ;  //为了方便计算结束后write_enable的及时关闭
    reg     write_enable_40, write_enable_41, write_enable_42, write_enable_43;
    
    always@(posedge clk)begin
        cnt_40 <= cnt_30;
        cnt_41 <= cnt_31;
        cnt_42 <= cnt_32;
        cnt_43 <= cnt_33;
        ADDR_cnt_40 <= ADDR_cnt_30;
        ADDR_cnt_40_d1 <= ADDR_cnt_30_d1;
        
        ADDR_cnt_41 <= ADDR_cnt_31;
        ADDR_cnt_41_d1 <= ADDR_cnt_31_d1;
        
        ADDR_cnt_42 <= ADDR_cnt_32;
        ADDR_cnt_42_d1 <= ADDR_cnt_32_d1;
        
        ADDR_cnt_43 <= ADDR_cnt_33;
        ADDR_cnt_43_d1 <= ADDR_cnt_33_d1;
        
//        Trans_Done_0_flag_d4 <= Trans_Done_0_flag_d3;
//        Trans_Done_3_flag_d4 <= Trans_Done_3_flag_d3;
        
        write_enable_40 <= write_enable_30;
        write_enable_41 <= write_enable_31;
        write_enable_42 <= write_enable_32;
        write_enable_43 <= write_enable_33;
        
//        start_cnt_41 <= start_cnt_31;
//        start_cnt_42 <= start_cnt_32;
//        start_cnt_43 <= start_cnt_33;           
    end

    reg     [31:0]      OB_Data_40;
 
    reg     [19:0]  o41_temp_5;//o01产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o41_temp_5 <= 0;
        end else if(ADDR_cnt_40 == 0 && cnt_40 <=5 && write_enable_40==0)begin
            o41_temp_5[19 - ((cnt_40-1'b1)<<2) -: 4] <= o_41;
        end
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_40==56 && cnt_40<=3) begin
//            OB_Data_40[19:0] <= o41_temp_5;
//            OB_Data_40[31 - ((cnt_40-1'b1)<<2) -: 4] <= o_40;
//        end
//    end
        
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_40 <= 32'h0000;
        end else begin 
            if(cnt_40<=8 && ADDR_cnt_40 <= 55)begin
                OB_Data_40[31 - ((cnt_40-1'b1)<<2) -: 4] <= o_40;
            end else if(ADDR_cnt_40==56 && cnt_40<=3) begin
                OB_Data_40[19:0] <= o41_temp_5;
                OB_Data_40[31 - ((cnt_40-1'b1)<<2) -: 4] <= o_40;
            end
        end
    end
    //为了一些细节的处理，导致一个简单想法的逻辑代码很冗余，待以后再修改简化
//o_01的第6个数据开始，8个8个地将o_11的输出存入RAM的57、58、59……地址
 
    reg     [7: 0]  o42_temp_2;//o02产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    reg     [31:0]  OB_Data_41;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o42_temp_2 <= 0;
        end else if(ADDR_cnt_40 == 0 && cnt_40 <= 2 && write_enable_40 == 0)begin
            o42_temp_2[7 - ((cnt_40-1'b1)<<2) -: 4] <= o_42;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_41 <= 32'h0000;
        end else begin 
        if(cnt_41<=8 && ADDR_cnt_41 <= 111)begin
            OB_Data_41[31 - ((cnt_41-1'b1)<<2) -: 4] <= o_41;
        end else if(ADDR_cnt_41 == 112 && cnt_41 <= 6) begin
            OB_Data_41[7:0] <= o42_temp_2;
            OB_Data_41[31 - ((cnt_41-1'b1)<<2) -: 4] <= o_41;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_41 == 112 && cnt_41 <= 6) begin
//            OB_Data_41[7:0] <= o42_temp_2;
//            OB_Data_41[31 - ((cnt_41-1'b1)<<2) -: 4] <= o_41;     
//        end
//    end
 //o_02的第3个数据开始，以32bit存入ram的113、114、115……地址
    reg     [27: 0]  o43_temp_7;
    reg     [31:0]   OB_Data_42;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o43_temp_7 <= 0;
        end else if(ADDR_cnt_40 == 0 && cnt_40 <= 7 && write_enable_40==0)begin
            o43_temp_7[27 - ((cnt_40-1'b1)<<2) -: 4] <= o_43;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_42 <= 32'h0000;
        end else begin 
            if(cnt_42<=8 && ADDR_cnt_42 <= 168)begin
                OB_Data_42[31 - ((cnt_42-1'b1)<<2) -: 4] <= o_42;
            end else if(ADDR_cnt_42 == 169 && cnt_42 <= 1) begin
                OB_Data_42[27:0] <= o43_temp_7;
                OB_Data_42[31 - ((cnt_42-1'b1)<<2) -: 4] <= o_42;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_42 == 169 && cnt_42 <= 1) begin
//            OB_Data_42[27:0] <= o43_temp_7;
//            OB_Data_42[31 - ((cnt_42-1'b1)<<2) -: 4] <= o_42;     
//        end
//    end
//o_03的第8个数据开始，8个一组存入ram的地址170、171……
    reg     [31:0]  OB_Data_43;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_43 <= 32'h0000;
        end else begin
        if(cnt_43<=8 && ADDR_cnt_43 <= 224)begin
            OB_Data_43[31 - ((cnt_43-1'b1)<<2) -: 4] <= o_43;
        end else if(ADDR_cnt_43 == 225 && cnt_43 <= 2) begin
            OB_Data_43[23:0] <= 0;
            OB_Data_43[31 - ((cnt_43-1'b1)<<2) -: 4] <= o_43;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_43 == 225 && cnt_43 <= 2) begin
//            OB_Data_43[23:0] <= 0;
//            OB_Data_43[31 - ((cnt_43-1'b1)<<2) -: 4] <= o_43;     
//        end
//    end
    
 //根据条件确定SPRAM的输出与地址的组合逻辑  
    always@(*)begin
        if(!rst_n) begin
            OB_Data_4 = 0;
            write_enable_4 = 0;
        end
        else begin
            if(write_enable_40) begin
                OB_Data_4 = OB_Data_40;
                write_enable_4 = 1;
            end
            else if(write_enable_41) begin
                OB_Data_4 = OB_Data_41;
                write_enable_4 = 1;
            end
            else if(write_enable_42)begin
                OB_Data_4 = OB_Data_42;
                write_enable_4 = 1;
            end
            else if(write_enable_43) begin
                OB_Data_4 = OB_Data_43;
                write_enable_4 = 1;
            end
            else begin
                OB_Data_4 = 0;
                write_enable_4 = 0;
            end
        end
    end
    
    always@(*)begin
        if(!rst_n)begin
            ADDR_4 = 0;
        end
        else begin 
        if(write_enable_40) begin
            ADDR_4 = ADDR_cnt_40_d1;
        end 
        else if(write_enable_41)begin
            ADDR_4 = ADDR_cnt_41_d1;
        end
        else if(write_enable_42)begin
            ADDR_4 = ADDR_cnt_42_d1;
        end
        else if(write_enable_43)begin
            ADDR_4 = ADDR_cnt_43_d1;
        end
        else
            ADDR_4 = 0;
        end
    end 
    
//********************************************************输出通道5********************************************************
//o50的0~451个数据在rom4的地址0~55中存储，多出来的3个与o51产生的前5个合并为32bit存在rom4的地址56中
    reg     [3:0]   cnt_50, cnt_51, cnt_52, cnt_53;     
//    reg             start_cnt_51,  start_cnt_52, start_cnt_53;  //为1标志cnt_01开始计时
    
    reg     [5:0]   ADDR_cnt_50, ADDR_cnt_50_d1;
    reg     [6:0]   ADDR_cnt_51, ADDR_cnt_51_d1;
    reg     [7:0]   ADDR_cnt_52, ADDR_cnt_52_d1;
    reg     [8:0]   ADDR_cnt_53, ADDR_cnt_53_d1;
//    reg     Trans_Done_0_flag_d5, Trans_Done_3_flag_d5 ;  //为了方便计算结束后write_enable的及时关闭
    reg     write_enable_50, write_enable_51, write_enable_52, write_enable_53;
    
    always@(posedge clk)begin
        cnt_50 <= cnt_40;
        cnt_51 <= cnt_41;
        cnt_52 <= cnt_42;
        cnt_53 <= cnt_43;
        ADDR_cnt_50 <= ADDR_cnt_40;
        ADDR_cnt_50_d1 <= ADDR_cnt_40_d1;
        
        ADDR_cnt_51 <= ADDR_cnt_41;
        ADDR_cnt_51_d1 <= ADDR_cnt_41_d1;
        
        ADDR_cnt_52 <= ADDR_cnt_42;
        ADDR_cnt_52_d1 <= ADDR_cnt_42_d1;
        
        ADDR_cnt_53 <= ADDR_cnt_43;
        ADDR_cnt_53_d1 <= ADDR_cnt_43_d1;
        
//        Trans_Done_0_flag_d5 <= Trans_Done_0_flag_d4;
//        Trans_Done_3_flag_d5 <= Trans_Done_3_flag_d4;
        
        write_enable_50 <= write_enable_40;
        write_enable_51 <= write_enable_41;
        write_enable_52 <= write_enable_42;
        write_enable_53 <= write_enable_43;
        
//        start_cnt_51 <= start_cnt_41;
//        start_cnt_52 <= start_cnt_42;
//        start_cnt_53 <= start_cnt_43;           
    end

    reg     [31:0]      OB_Data_50;
 
    reg     [19:0]      o51_temp_5;//o01产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o51_temp_5 <= 0;
        end else if(ADDR_cnt_50 == 0 && cnt_50 <=5 && write_enable_50==0)begin
            o51_temp_5[19 - ((cnt_50-1'b1)<<2) -: 4] <= o_51;
        end
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_50==56 && cnt_50<=3) begin
//            OB_Data_50[19:0] <= o51_temp_5;
//            OB_Data_50[31 - ((cnt_50-1'b1)<<2) -: 4] <= o_50;
//        end
//    end
        
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_50 <= 32'h0000;
        end else begin 
            if(cnt_50<=8 && ADDR_cnt_50 <= 55)begin
                OB_Data_50[31 - ((cnt_50-1'b1)<<2) -: 4] <= o_50;
            end else if(ADDR_cnt_50==56 && cnt_50<=3) begin
                OB_Data_50[19:0] <= o51_temp_5;
                OB_Data_50[31 - ((cnt_50-1'b1)<<2) -: 4] <= o_50;
            end
        end 
    end
    //为了一些细节的处理，导致一个简单想法的逻辑代码很冗余，待以后再修改简化
//o_01的第6个数据开始，8个8个地将o_11的输出存入RAM的57、58、59……地址
 
    reg     [7: 0]  o52_temp_2;//o02产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    reg     [31:0]  OB_Data_51;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o52_temp_2 <= 0;
        end else if(ADDR_cnt_50 == 0 && cnt_50 <= 2 && write_enable_50 == 0)begin
            o52_temp_2[7 - ((cnt_50-1'b1)<<2) -: 4] <= o_52;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_51 <= 32'h0000;
        end else begin 
            if(cnt_51<=8 && ADDR_cnt_51 <= 111)begin
                OB_Data_51[31 - ((cnt_51-1'b1)<<2) -: 4] <= o_51;
            end else if(ADDR_cnt_51 == 112 && cnt_51 <= 6) begin
                OB_Data_51[7:0] <= o52_temp_2;
                OB_Data_51[31 - ((cnt_51-1'b1)<<2) -: 4] <= o_51;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_51 == 112 && cnt_51 <= 6) begin
//            OB_Data_51[7:0] <= o52_temp_2;
//            OB_Data_51[31 - ((cnt_51-1'b1)<<2) -: 4] <= o_51;     
//        end
//    end
 //o_02的第3个数据开始，以32bit存入ram的113、114、115……地址
    reg     [27: 0]  o53_temp_7;
    reg     [31:0]   OB_Data_52;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o53_temp_7 <= 0;
        end else if(ADDR_cnt_50 == 0 && cnt_50 <= 7 && write_enable_50==0)begin
            o53_temp_7[27 - ((cnt_50-1'b1)<<2) -: 4] <= o_53;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_52 <= 32'h0000;
        end else begin 
            if(cnt_52<=8 && ADDR_cnt_52 <= 168)begin
                OB_Data_52[31 - ((cnt_52-1'b1)<<2) -: 4] <= o_52;
            end else if(ADDR_cnt_52 == 169 && cnt_52 <= 1) begin
                OB_Data_52[27:0] <= o53_temp_7;
                OB_Data_52[31 - ((cnt_52-1'b1)<<2) -: 4] <= o_52;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_52 == 169 && cnt_52 <= 1) begin
//            OB_Data_52[27:0] <= o53_temp_7;
//            OB_Data_52[31 - ((cnt_52-1'b1)<<2) -: 4] <= o_52;     
//        end
//    end
//o_03的第8个数据开始，8个一组存入ram的地址170、171……
    reg     [31:0]  OB_Data_53;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_53 <= 32'h0000;
        end else begin 
            if(cnt_53<=8 && ADDR_cnt_53 <= 224)begin
                OB_Data_53[31 - ((cnt_53-1'b1)<<2) -: 4] <= o_53;
            end else if(ADDR_cnt_53 == 225 && cnt_53 <= 2) begin
                OB_Data_53[23:0] <= 0;
                OB_Data_53[31 - ((cnt_53-1'b1)<<2) -: 4] <= o_53;     
            end 
        end
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_53 == 225 && cnt_53 <= 2) begin
//            OB_Data_53[23:0] <= 0;
//            OB_Data_53[31 - ((cnt_53-1'b1)<<2) -: 4] <= o_53;     
//        end
//    end
    
 //根据条件确定SPRAM的输出与地址的组合逻辑  
    always@(*)begin
        if(!rst_n) begin
            OB_Data_5 = 0;
            write_enable_5 = 0;
        end
        else begin
            if(write_enable_50) begin
                OB_Data_5 = OB_Data_50;
                write_enable_5 = 1;
            end
            else if(write_enable_51) begin
                OB_Data_5 = OB_Data_51;
                write_enable_5 = 1;
            end
            else if(write_enable_52)begin
                OB_Data_5 = OB_Data_52;
                write_enable_5 = 1;
            end
            else if(write_enable_53) begin
                OB_Data_5 = OB_Data_53;
                write_enable_5 = 1;
            end
            else begin
                OB_Data_5 = 0;
                write_enable_5 = 0;
            end
        end
    end
    
    always@(*)begin
        if(!rst_n)begin
            ADDR_5 = 0;
        end
        else begin 
        if(write_enable_50) begin
            ADDR_5 = ADDR_cnt_50_d1;
        end 
        else if(write_enable_51)begin
            ADDR_5 = ADDR_cnt_51_d1;
        end
        else if(write_enable_52)begin
            ADDR_5 = ADDR_cnt_52_d1;
        end
        else if(write_enable_53)begin
            ADDR_5 = ADDR_cnt_53_d1;
        end
        else
            ADDR_5 = 0;
        end
    end 
//********************************************************输出通道6********************************************************
//o60的0~451个数据在rom4的地址0~55中存储，多出来的3个与o61产生的前5个合并为32bit存在rom4的地址56中
    reg     [3:0]   cnt_60, cnt_61, cnt_62, cnt_63;     
//    reg             start_cnt_61,  start_cnt_62, start_cnt_63;  //为1标志cnt_01开始计时
    
    reg     [5:0]   ADDR_cnt_60, ADDR_cnt_60_d1;
    reg     [6:0]   ADDR_cnt_61, ADDR_cnt_61_d1;
    reg     [7:0]   ADDR_cnt_62, ADDR_cnt_62_d1;
    reg     [8:0]   ADDR_cnt_63, ADDR_cnt_63_d1;
//    reg     Trans_Done_0_flag_d6, Trans_Done_3_flag_d6 ;  //为了方便计算结束后write_enable的及时关闭
    reg     write_enable_60, write_enable_61, write_enable_62, write_enable_63;
    
    always@(posedge clk)begin
        cnt_60 <= cnt_50;
        cnt_61 <= cnt_51;
        cnt_62 <= cnt_52;
        cnt_63 <= cnt_53;
        ADDR_cnt_60 <= ADDR_cnt_50;
        ADDR_cnt_60_d1 <= ADDR_cnt_50_d1;
        
        ADDR_cnt_61 <= ADDR_cnt_51;
        ADDR_cnt_61_d1 <= ADDR_cnt_51_d1;
        
        ADDR_cnt_62 <= ADDR_cnt_52;
        ADDR_cnt_62_d1 <= ADDR_cnt_52_d1;
        
        ADDR_cnt_63 <= ADDR_cnt_53;
        ADDR_cnt_63_d1 <= ADDR_cnt_53_d1;
        
//        Trans_Done_0_flag_d6 <= Trans_Done_0_flag_d5;
//        Trans_Done_3_flag_d6 <= Trans_Done_3_flag_d5;
        
        write_enable_60 <= write_enable_50;
        write_enable_61 <= write_enable_51;
        write_enable_62 <= write_enable_52;
        write_enable_63 <= write_enable_53;
        
//        start_cnt_61 <= start_cnt_51;
//        start_cnt_62 <= start_cnt_52;
//        start_cnt_63 <= start_cnt_53;           
    end

    reg     [31:0]      OB_Data_60;
 
    reg     [19:0]      o61_temp_5;//o01产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o61_temp_5 <= 0;
        end else if(ADDR_cnt_60 == 0 && cnt_60 <=5 && write_enable_60==0)begin
            o61_temp_5[19 - ((cnt_60-1'b1)<<2) -: 4] <= o_61;
        end
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_60==56 && cnt_60<=3) begin
//            OB_Data_60[19:0] <= o61_temp_5;
//            OB_Data_60[31 - ((cnt_60-1'b1)<<2) -: 4] <= o_60;
//        end
//    end
        
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_60 <= 32'h0000;
        end else begin 
            if(cnt_60<=8 && ADDR_cnt_60 <= 55)begin
                OB_Data_60[31 - ((cnt_60-1'b1)<<2) -: 4] <= o_60;
            end else if(ADDR_cnt_60==56 && cnt_60<=3) begin
                OB_Data_60[19:0] <= o61_temp_5;
                OB_Data_60[31 - ((cnt_60-1'b1)<<2) -: 4] <= o_60;
            end
        end 
    end
    //为了一些细节的处理，导致一个简单想法的逻辑代码很冗余，待以后再修改简化
//o_01的第6个数据开始，8个8个地将o_11的输出存入RAM的57、58、59……地址
 
    reg     [7: 0]  o62_temp_2;//o02产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    reg     [31:0]  OB_Data_61;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o62_temp_2 <= 0;
        end else if(ADDR_cnt_60 == 0 && cnt_60 <= 2 && write_enable_60 == 0)begin
            o62_temp_2[7 - ((cnt_60-1'b1)<<2) -: 4] <= o_62;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_61 <= 32'h0000;
        end else begin 
            if(cnt_61<=8 && ADDR_cnt_61 <= 111)begin
                OB_Data_61[31 - ((cnt_61-1'b1)<<2) -: 4] <= o_61;
            end else if(ADDR_cnt_61 == 112 && cnt_61 <= 6) begin
                OB_Data_61[7:0] <= o62_temp_2;
                OB_Data_61[31 - ((cnt_61-1'b1)<<2) -: 4] <= o_61;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_61 == 112 && cnt_61 <= 6) begin
//            OB_Data_61[7:0] <= o62_temp_2;
//            OB_Data_61[31 - ((cnt_61-1'b1)<<2) -: 4] <= o_61;     
//        end
//    end
 //o_02的第3个数据开始，以32bit存入ram的113、114、115……地址
    reg     [27: 0]  o63_temp_7;
    reg     [31:0]   OB_Data_62;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o63_temp_7 <= 0;
        end else if(ADDR_cnt_60 == 0 && cnt_60 <= 7 && write_enable_60==0)begin
            o63_temp_7[27 - ((cnt_60-1'b1)<<2) -: 4] <= o_63;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_62 <= 32'h0000;
        end else begin 
            if(cnt_62<=8 && ADDR_cnt_62 <= 168)begin
                OB_Data_62[31 - ((cnt_62-1'b1)<<2) -: 4] <= o_62;
            end else if(ADDR_cnt_62 == 169 && cnt_62 <= 1) begin
                OB_Data_62[27:0] <= o63_temp_7;
                OB_Data_62[31 - ((cnt_62-1'b1)<<2) -: 4] <= o_62;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_62 == 169 && cnt_62 <= 1) begin
//            OB_Data_62[27:0] <= o63_temp_7;
//            OB_Data_62[31 - ((cnt_62-1'b1)<<2) -: 4] <= o_62;     
//        end
//    end
//o_03的第8个数据开始，8个一组存入ram的地址170、171……
    reg     [31:0]  OB_Data_63;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_63 <= 32'h0000;
        end else begin 
            if(cnt_63<=8 && ADDR_cnt_63 <= 224)begin
                OB_Data_63[31 - ((cnt_63-1'b1)<<2) -: 4] <= o_63;
            end else if(ADDR_cnt_63 == 225 && cnt_63 <= 2) begin
                OB_Data_63[23:0] <= 0;
                OB_Data_63[31 - ((cnt_63-1'b1)<<2) -: 4] <= o_63;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_63 == 225 && cnt_63 <= 2) begin
//            OB_Data_63[23:0] <= 0;
//            OB_Data_63[31 - ((cnt_63-1'b1)<<2) -: 4] <= o_63;     
//        end
//    end
    
 //根据条件确定SPRAM的输出与地址的组合逻辑  
    always@(*)begin
        if(!rst_n) begin
            OB_Data_6 = 0;
            write_enable_6 = 0;
        end
        else begin
            if(write_enable_60) begin
                OB_Data_6 = OB_Data_60;
                write_enable_6 = 1;
            end
            else if(write_enable_61) begin
                OB_Data_6 = OB_Data_61;
                write_enable_6 = 1;
            end
            else if(write_enable_62)begin
                OB_Data_6 = OB_Data_62;
                write_enable_6 = 1;
            end
            else if(write_enable_63) begin
                OB_Data_6 = OB_Data_63;
                write_enable_6 = 1;
            end
            else begin
                OB_Data_6 = 0;
                write_enable_6 = 0;
            end
        end
    end
    
    always@(*)begin
        if(!rst_n)begin
            ADDR_6 = 0;
        end
        else begin 
        if(write_enable_60) begin
            ADDR_6 = ADDR_cnt_60_d1;
        end 
        else if(write_enable_61)begin
            ADDR_6 = ADDR_cnt_61_d1;
        end
        else if(write_enable_62)begin
            ADDR_6 = ADDR_cnt_62_d1;
        end
        else if(write_enable_63)begin
            ADDR_6 = ADDR_cnt_63_d1;
        end
        else
            ADDR_6 = 0;
        end
    end  
//********************************************************输出通道7********************************************************
//o60的0~451个数据在rom4的地址0~55中存储，多出来的3个与o61产生的前5个合并为32bit存在rom4的地址56中
    reg     [3:0]   cnt_70, cnt_71, cnt_72, cnt_73;     
//    reg             start_cnt_71,  start_cnt_72, start_cnt_73;  //为1标志cnt_01开始计时
    
    reg     [5:0]   ADDR_cnt_70, ADDR_cnt_70_d1;
    reg     [6:0]   ADDR_cnt_71, ADDR_cnt_71_d1;
    reg     [7:0]   ADDR_cnt_72, ADDR_cnt_72_d1;
    reg     [8:0]   ADDR_cnt_73, ADDR_cnt_73_d1;
//    reg     Trans_Done_0_flag_d7, Trans_Done_3_flag_d7 ;  //为了方便计算结束后write_enable的及时关闭
    reg     write_enable_70, write_enable_71, write_enable_72, write_enable_73;
    
    always@(posedge clk)begin
        cnt_70 <= cnt_60;
        cnt_71 <= cnt_61;
        cnt_72 <= cnt_62;
        cnt_73 <= cnt_63;
        ADDR_cnt_70 <= ADDR_cnt_60;
        ADDR_cnt_70_d1 <= ADDR_cnt_60_d1;
        
        ADDR_cnt_71 <= ADDR_cnt_61;
        ADDR_cnt_71_d1 <= ADDR_cnt_61_d1;
        
        ADDR_cnt_72 <= ADDR_cnt_62;
        ADDR_cnt_72_d1 <= ADDR_cnt_62_d1;
        
        ADDR_cnt_73 <= ADDR_cnt_63;
        ADDR_cnt_73_d1 <= ADDR_cnt_63_d1;
        
//        Trans_Done_0_flag_d7 <= Trans_Done_0_flag_d6;
//        Trans_Done_3_flag_d7 <= Trans_Done_3_flag_d6;
        
        write_enable_70 <= write_enable_60;
        write_enable_71 <= write_enable_61;
        write_enable_72 <= write_enable_62;
        write_enable_73 <= write_enable_63;
        
//        start_cnt_71 <= start_cnt_61;
//        start_cnt_72 <= start_cnt_62;
//        start_cnt_73 <= start_cnt_63;           
    end

    reg     [31:0]      OB_Data_70;
 
    reg     [19:0]      o71_temp_5;//o01产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o71_temp_5 <= 0;
        end else if(ADDR_cnt_70 == 0 && cnt_70 <=5 && write_enable_70==0)begin
            o71_temp_5[19 - ((cnt_70-1'b1)<<2) -: 4] <= o_71;
        end
    end
    
   
        
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_70 <= 32'h0000;
        end else if(cnt_70<=8 && ADDR_cnt_70 <= 55)begin
            OB_Data_70[31 - ((cnt_70-1'b1)<<2) -: 4] <= o_70;
        end else if(ADDR_cnt_70==56 && cnt_70<=3) begin
            OB_Data_70[19:0] <= o71_temp_5;
            OB_Data_70[31 - ((cnt_70-1'b1)<<2) -: 4] <= o_70;
        end
    end
    //为了一些细节的处理，导致一个简单想法的逻辑代码很冗余，待以后再修改简化
//o_01的第6个数据开始，8个8个地将o_11的输出存入RAM的57、58、59……地址
 
    reg     [7: 0]  o72_temp_2;//o02产生的第451~455个数据，作为temp与o00的448、449、450合为8个4bit，即32bit
    reg     [31:0]  OB_Data_71;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o72_temp_2 <= 0;
        end else if(ADDR_cnt_70 == 0 && cnt_70 <= 2 && write_enable_70 == 0)begin
            o72_temp_2[7 - ((cnt_70-1'b1)<<2) -: 4] <= o_72;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_71 <= 32'h0000;
        end else begin
            if(cnt_71<=8 && ADDR_cnt_71 <= 111)begin
                OB_Data_71[31 - ((cnt_71-1'b1)<<2) -: 4] <= o_71;
            end else if(ADDR_cnt_71 == 112 && cnt_71 <= 6) begin
                OB_Data_71[7:0] <= o72_temp_2;
                OB_Data_71[31 - ((cnt_71-1'b1)<<2) -: 4] <= o_71;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_71 == 112 && cnt_71 <= 6) begin
//            OB_Data_71[7:0] <= o72_temp_2;
//            OB_Data_71[31 - ((cnt_71-1'b1)<<2) -: 4] <= o_71;     
//        end
//    end
 //o_02的第3个数据开始，以32bit存入ram的113、114、115……地址
    reg     [27: 0]  o73_temp_7;
    reg     [31:0]   OB_Data_72;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            o73_temp_7 <= 0;
        end else if(ADDR_cnt_70 == 0 && cnt_70 <= 7 && write_enable_70==0)begin
            o73_temp_7[27 - ((cnt_70-1'b1)<<2) -: 4] <= o_73;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_72 <= 32'h0000;
        end else begin 
            if(cnt_72<=8 && ADDR_cnt_72 <= 168)begin
                OB_Data_72[31 - ((cnt_72-1'b1)<<2) -: 4] <= o_72;
            end else if(ADDR_cnt_72 == 169 && cnt_72 <= 1) begin
                OB_Data_72[27:0] <= o73_temp_7;
                OB_Data_72[31 - ((cnt_72-1'b1)<<2) -: 4] <= o_72;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_72 == 169 && cnt_72 <= 1) begin
//            OB_Data_72[27:0] <= o73_temp_7;
//            OB_Data_72[31 - ((cnt_72-1'b1)<<2) -: 4] <= o_72;     
//        end
//    end
//o_03的第8个数据开始，8个一组存入ram的地址170、171……
    reg     [31:0]  OB_Data_73;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            OB_Data_73 <= 32'h0000;
        end else begin 
            if(cnt_73<=8 && ADDR_cnt_73 <= 224)begin
                OB_Data_73[31 - ((cnt_73-1'b1)<<2) -: 4] <= o_73;
            end else if(ADDR_cnt_73 == 225 && cnt_73 <= 2) begin
                OB_Data_73[23:0] <= 0;
                OB_Data_73[31 - ((cnt_73-1'b1)<<2) -: 4] <= o_73;     
            end
        end 
    end
    
//    always@(posedge clk)begin
//        if(ADDR_cnt_73 == 225 && cnt_73 <= 2) begin
//            OB_Data_73[23:0] <= 0;
//            OB_Data_73[31 - ((cnt_73-1'b1)<<2) -: 4] <= o_73;     
//        end
//    end   
 //根据条件确定SPRAM的输出与地址的组合逻辑  
    always@(*)begin
        if(!rst_n) begin
            OB_Data_7 = 0;
            write_enable_7 = 0;
        end
        else begin
            if(write_enable_70) begin
                OB_Data_7 = OB_Data_70;
                write_enable_7 = 1;
            end
            else if(write_enable_71) begin
                OB_Data_7 = OB_Data_71;
                write_enable_7 = 1;
            end
            else if(write_enable_72)begin
                OB_Data_7 = OB_Data_72;
                write_enable_7 = 1;
            end
            else if(write_enable_73) begin
                OB_Data_7 = OB_Data_73;
                write_enable_7 = 1;
            end
            else begin
                OB_Data_7 = 0;
                write_enable_7 = 0;
            end
        end
    end
    
    always@(*)begin
        if(!rst_n)begin
            ADDR_7 = 0;
        end
        else begin 
        if(write_enable_70) begin
            ADDR_7 = ADDR_cnt_70_d1;
        end 
        else if(write_enable_71)begin
            ADDR_7 = ADDR_cnt_71_d1;
        end
        else if(write_enable_72)begin
            ADDR_7 = ADDR_cnt_72_d1;
        end
        else if(write_enable_73)begin
            ADDR_7 = ADDR_cnt_73_d1;
        end
        else
            ADDR_7 = 0;
        end
    end   
    
    
       
endmodule
