module Adder(In1,In2,Out);
input[31:0] In1,In2;
output[31:0] Out;
reg[31:0] Out;
always @(In1 or In2)
#2 Out = In1 + In2;
endmodule




