`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2023 14:16:02
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    output reg [31:0] read_data,
    input clk,rst, 
    input [2:0] readcontrol, writecontrol, 
    input [31:0] address, 
    input [31:0] writedata
    );
    
    
    reg [31:0] data_mem_file [255:0];
    reg [31:0] store_intermediate;
    
    integer i;
    always @(posedge clk or posedge rst) begin //write at WD3 if WE3
        if(rst)
        begin
            for(i=0;i<=255;i=i+1)begin    //set everything to 0
                data_mem_file[i]<=32'd0;
            end
            store_intermediate <= 0;
        end
        else 
        begin
            case(writecontrol) 
                3'b000:begin
                    store_intermediate = {24'h000000, writedata[7:0]} ;
                    data_mem_file[address] = store_intermediate;
                 end            
                3'b001:begin
                    store_intermediate = {16'h0000,writedata[15:0]};
                    data_mem_file[address] = store_intermediate;
                 end
                3'b010: data_mem_file[address] <= writedata;//Store Word
                default: begin
                    for(i=0;i<32;i=i+1)begin    //retain current value
                        data_mem_file[i] <= data_mem_file[i];
                    end 
                end 
            endcase
        end
    end
    
     always @(*) begin
        case (readcontrol)
            3'b000:begin
                read_data <= {{24{data_mem_file[address][31]}},data_mem_file[address][7:0]};//read Byte                       
            end
            3'b001:begin
                read_data <= {{16{data_mem_file[address][31]}},data_mem_file[address][15:0]};//read Byte
            end
            3'b010: read_data <=  data_mem_file[address]; //read word
            3'b100:begin
               read_data <= {{24{1'b0}},data_mem_file[address][7:0]};
            end
            3'b101:begin
                read_data <= {{16{1'b0}},data_mem_file[address][15:0]};  
            end
            default: begin
            read_data <= 0;
            end
        endcase
    end
endmodule
