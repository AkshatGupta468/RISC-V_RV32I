`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2023 14:09:59
// Design Name: 
// Module Name: instruction_fetch
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


module instruction_fetch(
		output [6:0] opcode, 
		output [11:7] rd, 
		output [14:12] funct3,
		output [19:15] rs1,
		output [24:20] rs2,
		output [31:25] funct7,
		output [31:7] imm,
		input [31:0] instr);
		
	assign opcode = instr[6:0];
	assign rd = instr[11:7];
	assign funct3 = instr[14:12];
	assign rs1 = instr[19:15];
	assign rs2 = instr[24:20];
	assign funct7 = instr[31:25];
	assign imm = instr[31:7];
	
endmodule
