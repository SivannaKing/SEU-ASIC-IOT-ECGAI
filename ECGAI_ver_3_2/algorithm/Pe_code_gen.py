if __name__ == "__main__":
    for i in range(1, 16):
        # code = f"""PE_Row_B3   PE_R{i}_B3(   .clk(clk), .rst_n(row_{i}_en), .new_weight_val(new_weight_val[{i}]),
        #                     .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3),
        #                     .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
        #                     .w_8(w_8), .w_9(w_9), .w_10(w_10), .w_11(w_11),
        #                     .w_12(w_12), .w_13(w_13), .w_14(w_14), .w_15(w_15),
        #                     .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                     .Slide_data_2(in_data_to_next_pe_{i}_2), .Slide_data_3(in_data_to_next_pe_{i}_3),
        #                     .Slide_data_4(in_data_to_next_pe_{i}_4), .Slide_data_5(in_data_to_next_pe_{i}_5),
        #                     .Slide_data_6(in_data_to_next_pe_{i}_6), .Slide_data_7(in_data_to_next_pe_{i}_7),
        #                     .Slide_data_8(in_data_to_next_pe_{i}_8), .Slide_data_9(in_data_to_next_pe_{i}_9),
        #                     .Slide_data_10(in_data_to_next_pe_{i}_10), .Slide_data_11(in_data_to_next_pe_{i}_11),
        #                     .Slide_data_12(in_data_to_next_pe_{i}_12), .Slide_data_13(in_data_to_next_pe_{i}_13),
        #                     .Slide_data_14(in_data_to_next_pe_{i}_14), .Slide_data_15(in_data_to_next_pe_{i}_15),
        #                     .result(o_{i}),
        #                     .in_data_to_next_pe_0(in_data_to_next_pe_{i + 1}_0), .in_data_to_next_pe_1(in_data_to_next_pe_{i + 1}_1),
        #                     .in_data_to_next_pe_2(in_data_to_next_pe_{i + 1}_2), .in_data_to_next_pe_3(in_data_to_next_pe_{i + 1}_3),
        #                     .in_data_to_next_pe_4(in_data_to_next_pe_{i + 1}_4), .in_data_to_next_pe_5(in_data_to_next_pe_{i + 1}_5),
        #                     .in_data_to_next_pe_6(in_data_to_next_pe_{i + 1}_6), .in_data_to_next_pe_7(in_data_to_next_pe_{i + 1}_7),
        #                     .in_data_to_next_pe_8(in_data_to_next_pe_{i + 1}_8), .in_data_to_next_pe_9(in_data_to_next_pe_{i + 1}_9),
        #                     .in_data_to_next_pe_10(in_data_to_next_pe_{i + 1}_10), .in_data_to_next_pe_11(in_data_to_next_pe_{i + 1}_11),
        #                     .in_data_to_next_pe_12(in_data_to_next_pe_{i + 1}_12), .in_data_to_next_pe_13(in_data_to_next_pe_{i + 1}_13),
        #                     .in_data_to_next_pe_14(in_data_to_next_pe_{i + 1}_14), .in_data_to_next_pe_15(in_data_to_next_pe_{i + 1}_15),
        #                     .next_row_en(row_{i + 1}_en)
        #                     );"""
        # code = f'Dout_{i} <= {{Dout_{i}[30:0], Bin_{i}}};' #Dout_1 <= {Dout_1[30:0], Bin_1};

        # code = f"4{i}:  file = $fopen(FILENAME_{i}, ""w"");"
        # code = f"""parameter FILENAME_{i} = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block4_Input_Binary/B4_In_Channel_{i}.txt";"""
        # code = f'.Slide_data_{i}(Slide_data_{i}), '
        # code = f"""
        # in_data_to_next_pe_{i}_0, in_data_to_next_pe_{i}_1, in_data_to_next_pe_{i}_2, in_data_to_next_pe_{i}_3,
        # in_data_to_next_pe_{i}_4, in_data_to_next_pe_{i}_5, in_data_to_next_pe_{i}_6, in_data_to_next_pe_{i}_7,
        # in_data_to_next_pe_{i}_8, in_data_to_next_pe_{i}_9, in_data_to_next_pe_{i}_10, in_data_to_next_pe_{i}_11,
        # in_data_to_next_pe_{i}_12, in_data_to_next_pe_{i}_13, in_data_to_next_pe_{i}_14, in_data_to_next_pe_{i}_15,
        # in_data_to_next_pe_{i}_16, in_data_to_next_pe_{i}_17, in_data_to_next_pe_{i}_18, in_data_to_next_pe_{i}_19,
        # in_data_to_next_pe_{i}_20, in_data_to_next_pe_{i}_21, in_data_to_next_pe_{i}_22, in_data_to_next_pe_{i}_23,
        # in_data_to_next_pe_{i}_24, in_data_to_next_pe_{i}_25, in_data_to_next_pe_{i}_26, in_data_to_next_pe_{i}_27,
        # in_data_to_next_pe_{i}_28, in_data_to_next_pe_{i}_29, in_data_to_next_pe_{i}_30, in_data_to_next_pe_{i}_31,
        #
        # """
        # code = f""".w_{i}(w_{i}), """
        # code = f"""
        # PE_Row_B5   PE_R{i}_B5(   .clk(clk), .rst_n(row_{i}_en), .new_weight_val(new_weight_val[{i}]),
        #                 .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3),
        #                 .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
        #                 .w_8(w_8), .w_9(w_9), .w_10(w_10), .w_11(w_11),
        #                 .w_12(w_12), .w_13(w_13), .w_14(w_14), .w_15(w_15),
        #                 .w_16(w_16), .w_17(w_17), .w_18(w_18), .w_19(w_19),
        #                 .w_20(w_20), .w_21(w_21), .w_22(w_22), .w_23(w_23),
        #                 .w_24(w_24), .w_25(w_25), .w_26(w_26), .w_27(w_27),
        #                 .w_28(w_28), .w_29(w_29), .w_30(w_30), .w_31(w_31),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_2(in_data_to_next_pe_{i}_2), .Slide_data_3(in_data_to_next_pe_{i}_3),
        #                 .Slide_data_4(in_data_to_next_pe_{i}_4), .Slide_data_5(in_data_to_next_pe_{i}_5),
        #                 .Slide_data_6(in_data_to_next_pe_{i}_6), .Slide_data_7(in_data_to_next_pe_{i}_7),
        #                 .Slide_data_8(in_data_to_next_pe_{i}_8), .Slide_data_9(in_data_to_next_pe_{i}_9),
        #                 .Slide_data_10(in_data_to_next_pe_{i}_10), .Slide_data_11(in_data_to_next_pe_{i}_11),
        #                 .Slide_data_12(in_data_to_next_pe_{i}_12), .Slide_data_13(in_data_to_next_pe_{i}_13),
        #                 .Slide_data_14(in_data_to_next_pe_{i}_14), .Slide_data_15(in_data_to_next_pe_{i}_15),
        #                 .Slide_data_16(in_data_to_next_pe_{i}_16), .Slide_data_17(in_data_to_next_pe_{i}_17),
        #                 .Slide_data_18(in_data_to_next_pe_{i}_18), .Slide_data_19(in_data_to_next_pe_{i}_19),
        #                 .Slide_data_20(in_data_to_next_pe_{i}_20), .Slide_data_21(in_data_to_next_pe_{i}_21),
        #                 .Slide_data_22(in_data_to_next_pe_{i}_22), .Slide_data_23(in_data_to_next_pe_{i}_23),
        #                 .Slide_data_24(in_data_to_next_pe_{i}_24), .Slide_data_25(in_data_to_next_pe_{i}_25),
        #                 .Slide_data_26(in_data_to_next_pe_{i}_26), .Slide_data_27(in_data_to_next_pe_{i}_27),
        #                 .Slide_data_28(in_data_to_next_pe_{i}_28), .Slide_data_29(in_data_to_next_pe_{i}_29),
        #                 .Slide_data_30(in_data_to_next_pe_{i}_30), .Slide_data_31(in_data_to_next_pe_{i}_31),
        #                 .Slide_data_32(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .Slide_data_0(in_data_to_next_pe_{i}_0), .Slide_data_1(in_data_to_next_pe_{i}_1),
        #                 .result(o_{i}),
        #                 .in_data_to_next_pe_0(in_data_to_next_pe_{i+1}_0), .in_data_to_next_pe_1(in_data_to_next_pe_{i+1}_1),
        #                 .in_data_to_next_pe_2(in_data_to_next_pe_{i+1}_2), .in_data_to_next_pe_3(in_data_to_next_pe_{i+1}_3),
        #                 .in_data_to_next_pe_4(in_data_to_next_pe_{i+1}_4), .in_data_to_next_pe_5(in_data_to_next_pe_{i+1}_5),
        #                 .in_data_to_next_pe_6(in_data_to_next_pe_{i+1}_6), .in_data_to_next_pe_7(in_data_to_next_pe_{i+1}_7),
        #                 .in_data_to_next_pe_8(in_data_to_next_pe_{i+1}_8), .in_data_to_next_pe_9(in_data_to_next_pe_{i+1}_9),
        #                 .in_data_to_next_pe_10(in_data_to_next_pe_{i+1}_10), .in_data_to_next_pe_11(in_data_to_next_pe_{i+1}_11),
        #                 .in_data_to_next_pe_12(in_data_to_next_pe_{i+1}_12), .in_data_to_next_pe_13(in_data_to_next_pe_{i+1}_13),
        #                 .in_data_to_next_pe_14(in_data_to_next_pe_{i+1}_14), .in_data_to_next_pe_15(in_data_to_next_pe_{i+1}_15),
        #                 .in_data_to_next_pe_16(in_data_to_next_pe_{i+1}_16), .in_data_to_next_pe_17(in_data_to_next_pe_{i+1}_17),
        #                 .in_data_to_next_pe_18(in_data_to_next_pe_{i+1}_18), .in_data_to_next_pe_19(in_data_to_next_pe_{i+1}_19),
        #                 .in_data_to_next_pe_20(in_data_to_next_pe_{i+1}_20), .in_data_to_next_pe_21(in_data_to_next_pe_{i+1}_21),
        #                 .in_data_to_next_pe_22(in_data_to_next_pe_{i+1}_22), .in_data_to_next_pe_23(in_data_to_next_pe_{i+1}_23),
        #                 .in_data_to_next_pe_24(in_data_to_next_pe_{i+1}_24), .in_data_to_next_pe_25(in_data_to_next_pe_{i+1}_25),
        #                 .in_data_to_next_pe_26(in_data_to_next_pe_{i+1}_26), .in_data_to_next_pe_27(in_data_to_next_pe_{i+1}_27),
        #                 .in_data_to_next_pe_28(in_data_to_next_pe_{i+1}_28), .in_data_to_next_pe_29(in_data_to_next_pe_{i+1}_29),
        #                 .in_data_to_next_pe_30(in_data_to_next_pe_{i+1}_30), .in_data_to_next_pe_31(in_data_to_next_pe_{i+1}_31),
        #                 .next_row_en(row_{i+1}_en)
        # );
        #
        # """

        # code = f"""
        # pe PE_{i}(  .clk(clk),
        #     .rst_n(rst_n),
        #     .input_data(Slide_data_{i}),
        #     .weight_data(w_{i}),
        #     .out(o_{i}),
        #     .new_weight_val(new_weight_val),
        #     .in_data_to_next_pe(in_data_to_next_pe_{i}),
        #     .next_pe_en()
        #     );
        # """


        # code = f"""
        # in_data_to_next_pe_{i}_0, in_data_to_next_pe_{i}_1, in_data_to_next_pe_{i}_2, in_data_to_next_pe_{i}_3,
        # in_data_to_next_pe_{i}_4, in_data_to_next_pe_{i}_5, in_data_to_next_pe_{i}_6, in_data_to_next_pe_{i}_7,
        # in_data_to_next_pe_{i}_8, in_data_to_next_pe_{i}_9, in_data_to_next_pe_{i}_10, in_data_to_next_pe_{i}_11,
        # in_data_to_next_pe_{i}_12, in_data_to_next_pe_{i}_13, in_data_to_next_pe_{i}_14, in_data_to_next_pe_{i}_15,
        # in_data_to_next_pe_{i}_16, in_data_to_next_pe_{i}_17, in_data_to_next_pe_{i}_18, in_data_to_next_pe_{i}_19,
        # in_data_to_next_pe_{i}_20, in_data_to_next_pe_{i}_21, in_data_to_next_pe_{i}_22, in_data_to_next_pe_{i}_23,
        # in_data_to_next_pe_{i}_24, in_data_to_next_pe_{i}_25, in_data_to_next_pe_{i}_26, in_data_to_next_pe_{i}_27,
        # in_data_to_next_pe_{i}_28, in_data_to_next_pe_{i}_29, in_data_to_next_pe_{i}_30, in_data_to_next_pe_{i}_31,
        # in_data_to_next_pe_{i}_32, in_data_to_next_pe_{i}_33, in_data_to_next_pe_{i}_34, in_data_to_next_pe_{i}_35,
        # in_data_to_next_pe_{i}_36, in_data_to_next_pe_{i}_37, in_data_to_next_pe_{i}_38, in_data_to_next_pe_{i}_39,
        # in_data_to_next_pe_{i}_40, in_data_to_next_pe_{i}_41, in_data_to_next_pe_{i}_42, in_data_to_next_pe_{i}_43,
        # in_data_to_next_pe_{i}_44, in_data_to_next_pe_{i}_45, in_data_to_next_pe_{i}_46, in_data_to_next_pe_{i}_47,
        # in_data_to_next_pe_{i}_48, in_data_to_next_pe_{i}_49, in_data_to_next_pe_{i}_50, in_data_to_next_pe_{i}_51,
        # in_data_to_next_pe_{i}_52, in_data_to_next_pe_{i}_53, in_data_to_next_pe_{i}_54, in_data_to_next_pe_{i}_55,
        # in_data_to_next_pe_{i}_56, in_data_to_next_pe_{i}_57, in_data_to_next_pe_{i}_58, in_data_to_next_pe_{i}_59,
        # in_data_to_next_pe_{i}_60, in_data_to_next_pe_{i}_61, in_data_to_next_pe_{i}_62, in_data_to_next_pe_{i}_63,
        # """

        # code = f'.Bin_{i}(Bin_{i}), '
        # code = f"""
        # //*******************************************RAM{i}***************************************
        # reg         Bin_{i}_Val;
        # always@(posedge clk)begin
        #     ADDR_{i} <= ADDR_{i-1};
        #     WEA_{i} <= WEA_{i-1};
        #     Bin_{i}_Val <= Bin_{i-1}_Val;
        # end
        # always@(posedge clk or negedge rst_n)begin
        #     if(!rst_n)begin
        #         Dout_{i} <= 0;
        #     end
        #     else begin
        #         if(Bin_{i}_Val) begin
        #             Dout_{i} <= {{Dout_{i}[30:0], Bin_{i}}};
        #         end
        #     end
        # end
        # """

        # code = f'SPRAM   #(.ADDR_WIDTH(2), .DATA_WIDTH(32),.DATA_DEPTH(2)) Input_Buffer6_{i}( .clk(clk),  .rst_n(rst_n), .DINA(DIN_{i}), .ADDRA(ADDR_{i}), .WEA(WEA_{i}), .DOUTA(DOUTA_{i}), .M(6{i}), .ENA(ENA_{i}) );'
        # code = f'w_{i} <= 0; '
        # code = f'parameter FILENAME_{i} = "/home/mrpp/my_work/PyTorch_Learn/BNN_Learn/My_bnn_exp/My_Net_For_FPGA/Compare/Block6_Input_Binary/B6_In_Channel_{i}_Verilog.txt";'
        # code = f'6{i}:  file = $fopen(FILENAME_{i}, "w");'
        # code = f'Temp6_and_five_one_{i}, '
        # code = f"""in_data_to_next_pe_0_{i}, """
        # code = f'.in_data_to_next_pe_{i}(in_data_to_next_pe_1_{i}), '
        # code = f'.w_{i}(w_{i}), '
        # code = f'.in_data_to_next_pe_0(in_data_to_next_pe_{i}_0), '
#         code = f"""
#         PE_Row_B6   PE_R{i}_B6(   .clk(clk), .rst_n(rst_n), .new_weight_val(new_weight_val[{i}]),
#                         .w_0(w_0), .w_1(w_1), .w_2(w_2), .w_3(w_3),
#                         .w_4(w_4), .w_5(w_5), .w_6(w_6), .w_7(w_7),
#                         .w_8(w_8), .w_9(w_9), .w_10(w_10), .w_11(w_11),
#                         .w_12(w_12), .w_13(w_13), .w_14(w_14), .w_15(w_15),
#                         .w_16(w_16), .w_17(w_17), .w_18(w_18), .w_19(w_19),
#                         .w_20(w_20), .w_21(w_21), .w_22(w_22), .w_23(w_23),
#                         .w_24(w_24), .w_25(w_25), .w_26(w_26), .w_27(w_27),
#                         .w_28(w_28), .w_29(w_29), .w_30(w_30), .w_31(w_31),
#                         .w_32(w_32), .w_33(w_33), .w_34(w_34), .w_35(w_35),
#                         .w_36(w_36), .w_37(w_37), .w_38(w_38), .w_39(w_39),
#                         .w_40(w_40), .w_41(w_41), .w_42(w_42), .w_43(w_43),
#                         .w_44(w_44), .w_45(w_45), .w_46(w_46), .w_47(w_47),
#                         .w_48(w_48), .w_49(w_49), .w_50(w_50), .w_51(w_51),
#                         .w_52(w_52), .w_53(w_53), .w_54(w_54), .w_55(w_55),
#                         .w_56(w_56), .w_57(w_57), .w_58(w_58), .w_59(w_59),
#                         .w_60(w_60), .w_61(w_61), .w_62(w_62), .w_63(w_63),
#                         .Slide_data_0(in_data_to_next_pe_{i}_0),.Slide_data_1(in_data_to_next_pe_{i}_1),
#                         .Slide_data_2(in_data_to_next_pe_{i}_2),.Slide_data_3(in_data_to_next_pe_{i}_3),
#                         .Slide_data_4(in_data_to_next_pe_{i}_4),.Slide_data_5(in_data_to_next_pe_{i}_5),
#                         .Slide_data_6(in_data_to_next_pe_{i}_6),.Slide_data_7(in_data_to_next_pe_{i}_7),
#                         .Slide_data_8(in_data_to_next_pe_{i}_8),.Slide_data_9(in_data_to_next_pe_{i}_9),
#                         .Slide_data_10(in_data_to_next_pe_{i}_10),.Slide_data_11(in_data_to_next_pe_{i}_11),
#                         .Slide_data_12(in_data_to_next_pe_{i}_12),.Slide_data_13(in_data_to_next_pe_{i}_13),
#                         .Slide_data_14(in_data_to_next_pe_{i}_14),.Slide_data_15(in_data_to_next_pe_{i}_15),
#                         .Slide_data_16(in_data_to_next_pe_{i}_16),.Slide_data_17(in_data_to_next_pe_{i}_17),
#                         .Slide_data_18(in_data_to_next_pe_{i}_18),.Slide_data_19(in_data_to_next_pe_{i}_19),
#                         .Slide_data_20(in_data_to_next_pe_{i}_20),.Slide_data_21(in_data_to_next_pe_{i}_21),
#                         .Slide_data_22(in_data_to_next_pe_{i}_22),.Slide_data_23(in_data_to_next_pe_{i}_23),
#                         .Slide_data_24(in_data_to_next_pe_{i}_24),.Slide_data_25(in_data_to_next_pe_{i}_25),
#                         .Slide_data_26(in_data_to_next_pe_{i}_26),.Slide_data_27(in_data_to_next_pe_{i}_27),
#                         .Slide_data_28(in_data_to_next_pe_{i}_28),.Slide_data_29(in_data_to_next_pe_{i}_29),
#                         .Slide_data_30(in_data_to_next_pe_{i}_30),.Slide_data_31(in_data_to_next_pe_{i}_31),
#                         .Slide_data_32(in_data_to_next_pe_{i}_32),.Slide_data_33(in_data_to_next_pe_{i}_33),
#                         .Slide_data_34(in_data_to_next_pe_{i}_34),.Slide_data_35(in_data_to_next_pe_{i}_35),
#                         .Slide_data_36(in_data_to_next_pe_{i}_36),.Slide_data_37(in_data_to_next_pe_{i}_37),
#                         .Slide_data_38(in_data_to_next_pe_{i}_38),.Slide_data_39(in_data_to_next_pe_{i}_39),
#                         .Slide_data_40(in_data_to_next_pe_{i}_40),.Slide_data_41(in_data_to_next_pe_{i}_41),
#                         .Slide_data_42(in_data_to_next_pe_{i}_42),.Slide_data_43(in_data_to_next_pe_{i}_43),
#                         .Slide_data_44(in_data_to_next_pe_{i}_44),.Slide_data_45(in_data_to_next_pe_{i}_45),
#                         .Slide_data_46(in_data_to_next_pe_{i}_46),.Slide_data_47(in_data_to_next_pe_{i}_47),
#                         .Slide_data_48(in_data_to_next_pe_{i}_48),.Slide_data_49(in_data_to_next_pe_{i}_49),
#                         .Slide_data_50(in_data_to_next_pe_{i}_50),.Slide_data_51(in_data_to_next_pe_{i}_51),
#                         .Slide_data_52(in_data_to_next_pe_{i}_52),.Slide_data_53(in_data_to_next_pe_{i}_53),
#                         .Slide_data_54(in_data_to_next_pe_{i}_54),.Slide_data_55(in_data_to_next_pe_{i}_55),
#                         .Slide_data_56(in_data_to_next_pe_{i}_56),.Slide_data_57(in_data_to_next_pe_{i}_57),
#                         .Slide_data_58(in_data_to_next_pe_{i}_58),.Slide_data_59(in_data_to_next_pe_{i}_59),
#                         .Slide_data_60(in_data_to_next_pe_{i}_60),.Slide_data_61(in_data_to_next_pe_{i}_61),
#                         .Slide_data_62(in_data_to_next_pe_{i}_62),.Slide_data_63(in_data_to_next_pe_{i}_63),
#                         .result(o_{i}),
#                         .in_data_to_next_pe_0(in_data_to_next_pe_{i+1}_0), .in_data_to_next_pe_1(in_data_to_next_pe_{i+1}_1),
#                         .in_data_to_next_pe_2(in_data_to_next_pe_{i+1}_2), .in_data_to_next_pe_3(in_data_to_next_pe_{i+1}_3),
#                         .in_data_to_next_pe_4(in_data_to_next_pe_{i+1}_4), .in_data_to_next_pe_5(in_data_to_next_pe_{i+1}_5),
#                         .in_data_to_next_pe_6(in_data_to_next_pe_{i+1}_6), .in_data_to_next_pe_7(in_data_to_next_pe_{i+1}_7),
#                         .in_data_to_next_pe_8(in_data_to_next_pe_{i+1}_8), .in_data_to_next_pe_9(in_data_to_next_pe_{i+1}_9),
#                         .in_data_to_next_pe_10(in_data_to_next_pe_{i+1}_10), .in_data_to_next_pe_11(in_data_to_next_pe_{i+1}_11),
#                         .in_data_to_next_pe_12(in_data_to_next_pe_{i+1}_12), .in_data_to_next_pe_13(in_data_to_next_pe_{i+1}_13),
#                         .in_data_to_next_pe_14(in_data_to_next_pe_{i+1}_14), .in_data_to_next_pe_15(in_data_to_next_pe_{i+1}_15),
#                         .in_data_to_next_pe_16(in_data_to_next_pe_{i+1}_16), .in_data_to_next_pe_17(in_data_to_next_pe_{i+1}_17),
#                         .in_data_to_next_pe_18(in_data_to_next_pe_{i+1}_18), .in_data_to_next_pe_19(in_data_to_next_pe_{i+1}_19),
#                         .in_data_to_next_pe_20(in_data_to_next_pe_{i+1}_20), .in_data_to_next_pe_21(in_data_to_next_pe_{i+1}_21),
#                         .in_data_to_next_pe_22(in_data_to_next_pe_{i+1}_22), .in_data_to_next_pe_23(in_data_to_next_pe_{i+1}_23),
#                         .in_data_to_next_pe_24(in_data_to_next_pe_{i+1}_24), .in_data_to_next_pe_25(in_data_to_next_pe_{i+1}_25),
#                         .in_data_to_next_pe_26(in_data_to_next_pe_{i+1}_26), .in_data_to_next_pe_27(in_data_to_next_pe_{i+1}_27),
#                         .in_data_to_next_pe_28(in_data_to_next_pe_{i+1}_28), .in_data_to_next_pe_29(in_data_to_next_pe_{i+1}_29),
#                         .in_data_to_next_pe_30(in_data_to_next_pe_{i+1}_30), .in_data_to_next_pe_31(in_data_to_next_pe_{i+1}_31),
#                         .in_data_to_next_pe_32(in_data_to_next_pe_{i+1}_32), .in_data_to_next_pe_33(in_data_to_next_pe_{i+1}_33),
#                         .in_data_to_next_pe_34(in_data_to_next_pe_{i+1}_34), .in_data_to_next_pe_35(in_data_to_next_pe_{i+1}_35),
#                         .in_data_to_next_pe_36(in_data_to_next_pe_{i+1}_36), .in_data_to_next_pe_37(in_data_to_next_pe_{i+1}_37),
#                         .in_data_to_next_pe_38(in_data_to_next_pe_{i+1}_38), .in_data_to_next_pe_39(in_data_to_next_pe_{i+1}_39),
#                         .in_data_to_next_pe_40(in_data_to_next_pe_{i+1}_40), .in_data_to_next_pe_41(in_data_to_next_pe_{i+1}_41),
#                         .in_data_to_next_pe_42(in_data_to_next_pe_{i+1}_42), .in_data_to_next_pe_43(in_data_to_next_pe_{i+1}_43),
#                         .in_data_to_next_pe_44(in_data_to_next_pe_{i+1}_44), .in_data_to_next_pe_45(in_data_to_next_pe_{i+1}_45),
#                         .in_data_to_next_pe_46(in_data_to_next_pe_{i+1}_46), .in_data_to_next_pe_47(in_data_to_next_pe_{i+1}_47),
#                         .in_data_to_next_pe_48(in_data_to_next_pe_{i+1}_48), .in_data_to_next_pe_49(in_data_to_next_pe_{i+1}_49),
#                         .in_data_to_next_pe_50(in_data_to_next_pe_{i+1}_50), .in_data_to_next_pe_51(in_data_to_next_pe_{i+1}_51),
#                         .in_data_to_next_pe_52(in_data_to_next_pe_{i+1}_52), .in_data_to_next_pe_53(in_data_to_next_pe_{i+1}_53),
#                         .in_data_to_next_pe_54(in_data_to_next_pe_{i+1}_54), .in_data_to_next_pe_55(in_data_to_next_pe_{i+1}_55),
#                         .in_data_to_next_pe_56(in_data_to_next_pe_{i+1}_56), .in_data_to_next_pe_57(in_data_to_next_pe_{i+1}_57),
#                         .in_data_to_next_pe_58(in_data_to_next_pe_{i+1}_58), .in_data_to_next_pe_59(in_data_to_next_pe_{i+1}_59),
#                         .in_data_to_next_pe_60(in_data_to_next_pe_{i+1}_60), .in_data_to_next_pe_61(in_data_to_next_pe_{i+1}_61),
#                         .in_data_to_next_pe_62(in_data_to_next_pe_{i+1}_62), .in_data_to_next_pe_63(in_data_to_next_pe_{i+1}_63),
#                         .next_row_en(row_{i+1}_en)
# );
#         """
#         code = f"o_{i}, "

        # code = f"""
        # if(Max_out_Val_d{i})begin
        #         case(max_{i}[9])
        #             0:  channel_ge{i}_sum <= channel_ge{i}_sum + max_{i};
        #             1:  channel_le{i}_sum <= channel_le{i}_sum + max_{i};
        #         endcase
        # end
        # """
        code = f'Input_Buffer3_IP Input_Buffer3{i} (.clka(clk), .ena(ENA_{i}), .wea(WEA_{i}), .addra(ADDR_{i}), .dina(DIN_{i}), .douta(DOUTA_{i}));'
        print(code)
        # print(code, end="")