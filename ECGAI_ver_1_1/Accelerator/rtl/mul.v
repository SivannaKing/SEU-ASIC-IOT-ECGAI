/*
@AUTHOR     Huangjunguang;
@EMAIL      huangjunguang@seu.edu.cn
@TIME&LOG   2020-05-21 - create - Huangjunguang
            Initial Commit
            2021-09-11 - modify - wzx
            Add en annotations
@MODULE     mul
@SUBMODULE  
@FUNC       8bits multiplier
*/
module mul (
    input  [ 7:0] a,
    input  [ 7:0] b,
    output [15:0] data_out
);

    assign data_out = {a[7] ^ b[7], 1'b0, a[6:0] * b[6:0]};
endmodule
