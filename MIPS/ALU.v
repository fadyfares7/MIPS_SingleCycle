
/* The ALU module will be described behaviorally in the following code.
   The ALU unit takes two 32-bit operands and performs an operation on them depending  
   on the ALU_OP input which is a 4-bit signal
*/	

module ALU(operand1, operand2, ALU_OP,unsigned_op, shamt, result, zero_signal);

	input [31:0] operand1;
	input [31:0] operand2;
	input [3:0] ALU_OP;
	input unsigned_op;
	input [4:0] shamt;

	output [31:0] result;
	output zero_signal;

	reg [31:0] result;
	reg zero_signal;
 
/* The following always block will be executed when one 
of the input parameters of the module change */

always @ (operand1 or operand2 or ALU_OP or unsigned_op or shamt)
	begin
	   #2
	   case (ALU_OP)
		4'b1111:   result = 32'bx; // if ALU is not used
		4'b0000:   result = operand1 & operand2;
		4'b0001:   result = operand1 | operand2; 
		4'b0010:   result = $signed(operand1) + $signed(operand2);
		4'b0110:   result = $signed(operand1) - $signed(operand2);
		4'b0111: 
			if (unsigned_op == 1'b0)
			  if (($signed(operand1)-$signed(operand2))<0) result=  32'b1;
			  else   result = 32'b0;//slt & slti
			else if (unsigned_op == 1'b1)
			    result = (operand1<operand2) ? 32'b1 : 32'b0;//sltiu
		4'b1001:   result = (operand1<operand2) ? 32'b1 : 32'b0;//sltu
		4'b0100:   result = ~(operand1 | operand2); // nor
		4'b0101:   result = operand2 << shamt; //sll
		4'b1000:   result = operand2 >> shamt; //srl
		4'b0011:   result = $signed(operand1) * $signed(operand2);
	   endcase
			
		// The next two statements detect the zero result to set the zero_signal
		if (result == 32'b0) zero_signal = 1'b1;
		else zero_signal = 1'b0;
	end
endmodule

