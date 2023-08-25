`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2023 11:46:54
// Design Name: 
// Module Name: sign_extend
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


module sign_extend(
    input [31:7] instr,
    input [2:0] immsrc,
    output reg [31:0] immext
    );
    
     always@(*) begin
        case(immsrc)
            3'b000:     immext = {{20{instr[31]}}, instr[31:20]};// I-type
            3'b001:     immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};// S-type (stores)
            3'b010:     immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};// B-type (branches)
            3'b011:     immext = {instr[31:12], 12'b0};// U-type                
            3'b100:     immext = {{12{instr[31]}}, instr[19:12],  instr[20], instr[30:21], 1'b0};// J-type       
            default:    immext = 32'b0; // undefined
        endcase
    end
    
endmodule
