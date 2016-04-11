module Shift_left_2(In,Out);
input[31:0] In;
output[31:0] Out;
assign Out={ In,2'b0};
endmodule


