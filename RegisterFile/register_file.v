`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2023 10:48:25
// Design Name: 
// Module Name: register_file
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


module register_file(
    output reg [31:0] rd1, rd2,
    input clk, we3, rst,
    input [4:0] a1, a2, a3,
    input [31:0] wd3 
    );
    
    reg [31:0] reg_file [31:0];
    
    integer i;
    
    always @(posedge clk or posedge rst) begin
            if(rst) begin
                    for(i=0;i<32;i=i+1) begin
                            reg_file[i] <= 'd0;
                        end
                end
            else if(!rst && we3 && (a3!=0)) //writing wd3 to a3 only if a3 is not zero as reg 0 is hardwired to 0
                reg_file[a3] <= wd3;
           
        end
        
    always@(*) begin
        rd1 <= reg_file[a1];
        rd2 <= reg_file[a2];      
    end
    
endmodule
