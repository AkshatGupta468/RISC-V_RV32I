`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2023 12:15:34
// Design Name: 
// Module Name: alu
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


module alu(
    input [31:0] a,b,
    input [3:0] alu_sel,
    output reg [31:0] alu_result,
    output reg zero, overload
    );
    
    
    always @(*)begin
    case(alu_sel)
    4'b0000: begin
     alu_result = a + b;        //add
      if ((a[31] == b[31]) && (alu_result[31] != b[31])) overload = 1;
                else overload = 0;
      end
    4'b0001: begin
     alu_result = a - b;        //sub
      if ((a[31] != b[31]) && (alu_result[31] == b[31])) overload = 1;
                else overload = 0;
      end
    4'b0010: alu_result = a ^ b;        //xor
    4'b0011: alu_result = a | b;        //or
    4'b0100: alu_result = a & b;        //and
    4'b0101: alu_result = a << b[4:0];  //logical shift left
    4'b0110: alu_result = a >> b[4:0];  //logical shift right
    4'b0111: alu_result = a >>> b[4:0]; //arithmetic shift right
    4'b1000: alu_result = a < b ? 32'd1 : 32'd0;  //set less than unsigned
    4'b1001: alu_result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;  //set less than signed
    4'b1010: alu_result = b;            //lui instruction
    default: alu_result = 0;
    endcase
    
    if(alu_result == 0)
        zero = 1;
        else
        zero = 0;
    
    end
endmodule
