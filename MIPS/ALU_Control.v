module ALU_Control(ALUControlInput,jump_reg,ControlOp,Function);

input [5:0]Function;
input [2:0]ControlOp;		// input control op
output[3:0]ALUControlInput;	// output to the ALU unit
output jump_reg;

wire [5:0]Function;
wire [2:0]ControlOp;

reg [3:0]ALUControlInput;
reg jump_reg;

always @ (ControlOp or Function)
begin
  case (ControlOp)
    3'b010: // R-type instructions
	case (Function)
		6'b100000: // add
			begin
			ALUControlInput=4'b0010;
			jump_reg=1'b0;
			end
		6'b100010: // subtract
			begin
			ALUControlInput=4'b0110;
			jump_reg=1'b0;
			end
		6'b011000: // multiply
			begin
			ALUControlInput=4'b0011;
			jump_reg=1'b0;
			end
		6'b100100: // and
			begin
			ALUControlInput=4'b0000;
			jump_reg=1'b0;
			end
		6'b100101: // or
			begin
			ALUControlInput=4'b0001;
			jump_reg=1'b0;
			end
		6'b100111: // nor
			begin
			ALUControlInput=4'b0100;
			jump_reg=1'b0;
			end
		6'b000000: // sll
			begin
			ALUControlInput=4'b0101;
			jump_reg=1'b0;
			end
		6'b000010: // srl
			begin
			ALUControlInput=4'b1000;
			jump_reg=1'b0;
			end
		6'b101010: // slt
			begin
			ALUControlInput=4'b0111;
			jump_reg=1'b0;
			end
		6'b101001: // sltu
			begin
			ALUControlInput=4'b1001;
			jump_reg=1'b0;
			end
		6'b001000:
			begin
			ALUControlInput=4'b1111;
			jump_reg=1'b1;
			end
		default: // ALU is not used
			begin
			ALUControlInput=4'b1111;
			jump_reg=1'b0;
			end
	endcase

   3'b000: // add in case not R type
	begin
	ALUControlInput=4'b0010;
	jump_reg=1'b0;
	end
   3'b001: // subtract in case of not R type
	begin
	ALUControlInput=4'b0110;
	jump_reg=1'b0;
	end
   3'b011: // and in case of not R type 
	begin
	ALUControlInput=4'b0000;
	jump_reg=1'b0;
	end
   3'b100: // or in case of not R type
	begin
	ALUControlInput=4'b0001;
	jump_reg=1'b0;
	end
   3'b101: //slt in case of not R type
	begin
	ALUControlInput=4'b0111;
	jump_reg=1'b0;
	end
   default: // ALU is not used
	begin
	ALUControlInput=4'b1111;
	jump_reg=1'b0;
	end
   endcase
  end //end of begin
endmodule

