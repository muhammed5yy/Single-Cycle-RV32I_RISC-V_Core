`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.02.2026 12:26:03
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
    input Branch, Zero, ALU_Src,ALU_Src2, Jump,
    input [1:0] MemtoReg,
    input [31:0]current_inst,
    input [31:0]rs2,
    input [31:0]rs1,
    input [31:0]immediate,
    input [31:0]data_out,
    input [31:0]sum,
    input [6:0]opcode,
    
    output [31:0]new_inst,
    output [31:0]write_reg,
    output [31:0]operand_2,
    output [31:0]operand_1
    
    );

wire [31:0] inst1;     
wire [31:0] inst0;
wire [31:0] inst3;
wire [31:0] secn_mux;
wire        inst4;
    
assign inst0 = current_inst + 32'd4; // PC + 4

assign inst1   = $signed(current_inst) + immediate; //Branch 
assign inst4 = Branch & Zero; //Branch

wire [31:0] jalr_target = {sum[31:1], 1'b0};

assign inst3 = inst4 ? inst1 : inst0;
wire [31:0] jump_target = (opcode == 7'b1100111) ? jalr_target : sum;
assign secn_mux = Jump ? jump_target : inst3;
assign new_inst = secn_mux;


assign operand_2 = ALU_Src  ? immediate : rs2;
assign operand_1 = ALU_Src2 ? current_inst : rs1;

assign write_reg = (MemtoReg == 2'b00) ? sum :         // ALU Sonucu
                   (MemtoReg == 2'b01) ? data_out :    // Bellekten okunan
                   (MemtoReg == 2'b10) ? inst0 :   // Dönüş adresi (JAL/JALR)
                   (MemtoReg == 2'b11) ? immediate :     // Doğrudan sayı (LUI)
                                         32'b0;


 
endmodule
