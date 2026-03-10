`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 21:12:21
// Design Name: 
// Module Name: inst_decoder
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


module inst_decoder(
    input [31:0]  next_inst,
    output [6:0]  opcode,
    output [4:0]  rs1_addr,
    output [4:0]  rs2_addr,
    output [4:0]  rd_addr,
    output [2:0]  funct3,
    output [6:0]  funct7,
    output [24:0] instr_31_7
    );

assign opcode = next_inst[6:0];
assign rs1_addr = next_inst[19:15];    
assign rs2_addr = next_inst[24:20];
assign rd_addr = next_inst[11:7];
assign funct3 = next_inst[14:12];
assign funct7 = next_inst[31:25];
assign instr_31_7 = next_inst[31:7];

    
endmodule
