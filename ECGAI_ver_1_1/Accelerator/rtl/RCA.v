/*
@AUTHOR     wzx;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2020-05-21 - create - Huangjunguang
            Initial Commit
            2021-09-11 - modify - wzx
            Add en annotations
@MODULE     RCA
@SUBMODULE  
@FUNC       Convert the true code into complement code and sum two 16bits nums,
            and then convert the result into the true code.
*/
module RCA (
    input  [15:0] A,
    input  [15:0] B,
    output [15:0] out
);
    wire [15:0] x, y, sum;
    // Convert to complement (h8000->h0000)
    assign x = (A[15] == 0) ? A : (A[14:0] == 15'b0) ? 16'h0 : {1'b1, ~A[14:0] + 1'b1};
    assign y = (B[15] == 0) ? B : (B[14:0] == 15'b0) ? 16'h0 : {1'b1, ~B[14:0] + 1'b1};

    assign sum = x + y;

    // 2 neg / 2 pos may overflow
    assign out = (x[15] & y[15]) ? {1'b1, ~sum[14:0] + 1'b1} :  // 2 neg
        (~x[15] & ~y[15]) ? {1'b0, sum[14:0]} :  // 2 pos  
        (sum[15] == 1) ? {1'b1, ~sum[14:0] + 1'b1} :  // 1 neg 1 pos sum neg
        {1'b0, sum[14:0]};  // 1 neg 1 pos sum pos
endmodule
