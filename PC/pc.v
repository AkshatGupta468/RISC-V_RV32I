`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2023 13:04:49
// Design Name: 
// Module Name: pc
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


module pc(
    output reg [31:0] pc, 
    input clk, rst, 
    input [31:0] pc_next
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 0;
        end
        else begin
            pc <= pc_next;
        end
    end
endmodule
