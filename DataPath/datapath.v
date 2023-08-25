`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2023 17:55:41
// Design Name: 
// Module Name: datapath
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


module datapath(
    
    output [6:0] opcode,
    output [14:12] funct3, 
    output [31:25] funct7, 
    
    output [31:0] Result,
    output zero,overload,
    input rst,clk, reg_wr,sel_A,sel_B,
    input [1:0] wb_sel,
    input [2:0] immsrc,
    input [3:0] alu_op,
    input [2:0] br_type, readcontrol, writecontrol
   
    );
    
    wire [31:0] PC, PCNext, PCPlus4, immext, srcA, rd1, rd2, srcB, rdata, aluresult, instr;
	wire [24:20] rs2;
	wire [19:15] rs1;
	wire [11:7] rd;
    wire [31:7] imm;
    wire br_taken;
    
    mux  pcnext(.y(PCNext),.d0(PCPlus4),.d1(aluresult),.s(br_taken));
    pc   pc_instruction(.pc(PC),.clk(clk),.rst(rst),.pc_next(PCNext));
    adder pc_plus4(.y(PCPlus4),.a(PC),.b(32'd4));
    instruction_memory instruction(.instr(instr),.pc(PC));
    instruction_fetch instr_fetch(.opcode(opcode),.rd(rd),.funct3(funct3),.rs1(rs1),.rs2(rs2),.funct7(funct7),.imm(imm),.instr(instr));
    sign_extend extension(.immext(immext),.instr(instr[31:7]),.immsrc(immsrc));
    register_file register(.rd1(rd1),.rd2(rd2),.clk(clk), .we3(reg_wr), .rst(rst), .a1(rs1),.a2(rs2),.a3(rd), .wd3(Result));
    branch_determining_unit branch(.branch_taken(br_taken),.branch_type(br_type),.a(rd1),.b(rd2));
    mux srcA_(.y(srcA),.d0(PC),.d1(rd1),.s(sel_A));
	mux srcB_(.y(srcB),.d0(rd2),.d1(immext),.s(sel_B));
	alu aalu(.a(srcA),.b(srcB),.alu_sel(alu_op), .alu_result(aluresult),.zero(zero),.overload(overload));
	data_memory data_mem(.read_data(rdata),.clk(clk),.rst(rst),.readcontrol(readcontrol),.writecontrol(writecontrol),.address(aluresult),.writedata(rd2));
	mux_pc result(.y(Result),.d0(PCPlus4),.d1(aluresult),.d2(rdata),.s(wb_sel));
    
endmodule
