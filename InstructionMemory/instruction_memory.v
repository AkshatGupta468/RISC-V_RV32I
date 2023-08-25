`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Akash Kumar
// 
// Create Date: 15.08.2023 10:13:36
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(
    output reg [31:0] instr,
    input [31:0] pc
    );
    
    reg [31:0] instr_mem [23:0];
    
    initial
    $readmemh("instruction.mem", instr_mem);
    
    always@(pc)
    begin
        instr <= instr_mem[pc>>2];
    end
    
endmodule
