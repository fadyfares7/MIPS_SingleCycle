
module Shift_left_16(In,Out);
input[31:0] In;
output[31:0] Out;
assign Out={ In,16'b0};
endmodule
