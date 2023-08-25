`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2023 12:50:58
// Design Name: 
// Module Name: branch_determining_unit
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


module branch_determining_unit(
    input [31:0] a,b,
    input [2:0] branch_type,
    output reg branch_taken
    );
    
    always@(*)begin
    case(branch_type)
    3'b000: branch_taken <= (a==b);         //beq
    3'b001: branch_taken <= (a!=b);         //bne
    3'b010: branch_taken <= 0;              //no jump
    3'b011: branch_taken <= 1;              //jal and jalr instruction
    3'b100: branch_taken <= ($signed(a) < $signed(b));         //blt
    3'b101: branch_taken <= ($signed(a) >= $signed(b));        //bge
    3'b110: branch_taken <= (a < b);         //bltu
    3'b111: branch_taken <= (a >= b);        //bgeu
    default: branch_taken <= 0;
    endcase
    end
    
endmodule
