`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 16:35:58
// Design Name: 
// Module Name: top_rv32i
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


module top_rv32i(
    input clk,
    input reset,
    output [31:0] proc_out,
    input [31:0] instruction_data
    );
    
wire [31:0] inst_wire;   // PC to Datapath & Instruction Memory
wire [31:0] wire_inst;   // Datapath to PC
wire [3:0]  op_wire;     // ALU_Control to ALU
wire [6:0]  opcode_wire; // Instruction Decoder to Control Unit & ImmGen & Datapath
wire [4:0]  rs1a_wire;    // Instruction Decoder to RS1 Address  
wire [4:0]  rs2a_wire;    // Instruction Decoder to RS2 Address
wire [4:0]  rda_wire;     // Instruction Decoder to RD  Address
wire [2:0]  funct3_wire; // Instruction Decoder to funct3 
wire [6:0]  funct7_wire; // Instruction Decoder to funct7
wire [24:0] imm_wire;    // Instruction Decoder to ImmGen
wire [31:0] instmem_wire;// Instruction Memory to Intruction Decoder
wire [31:0] rs1_wire;         // Register File to Datapath
wire [31:0] rs2_wire;         // Register File to Datapath & Memory
wire [31:0] write_reg_wire; // Datapath to Register File
wire [31:0] dataout_wire;   // Memory to Datapath
wire [31:0] immediate_wire; // ImmGen to Datapath

wire ALU_Src_wire;       // Control Unit to Datapath 
wire ALU_Src2_wire;      // Control Unit to Datapath 
wire RegWrite_wire;      // Control Unit to Register File     
wire MemWrite_wire;      // Control Unit to Memory    
wire [1:0]MemtoReg_wire; // Control Unit to Datapath   
wire [1:0]ALU_Op_wire;   // Control Unit to ALU_Control
wire MemRead_wire;       // Control Unit to Memory
wire Branch_wire;        // Control Unit to Datapath      
wire Jump_wire;          // Control Unit to Datapath 

wire [31:0] Operand1_wire; // Datapath to ALU
wire [31:0] Operand2_wire; // Datapath to ALU 
wire Zero_wire;            // ALU to Datapath
wire [31:0] Sum_wire;      // ALU to Datapath & Memory 


pc program_counter(
    .clk(clk),
    .reset(reset),
    .new_inst(wire_inst),
    .current_inst(inst_wire)
);  

register_file registers(
    .clk(clk),
    .reset(reset),
    .RegWrite(RegWrite_wire),
    .rs1_addr(rs1a_wire),
    .rs2_addr(rs2a_wire),
    .rd_addr(rda_wire),
    .write_reg(write_reg_wire),
    .rs1(rs1_wire),
    .rs2(rs2_wire)
); 

immgen immediate(
    .instr_31_7(imm_wire),
    .opcode(opcode_wire),
    .immediate(immediate_wire)
); 

alu_control alu_decoder(
    .funct3(funct3_wire),
    .funct7(funct7_wire),
    .ALU_Op(ALU_Op_wire),
    .op(op_wire)
);

control_unit control(
    .Opcode(opcode_wire),
    .ALU_Op(ALU_Op_wire),
    .ALU_Src(ALU_Src_wire),
    .ALU_Src2(ALU_Src2_wire),
    .RegWrite(RegWrite_wire),
    .MemWrite(MemWrite_wire),
    .MemtoReg(MemtoReg_wire),
    .MemRead(MemRead_wire),
    .Branch(Branch_wire),
    .Jump(Jump_wire)
);

inst_decoder decoder(
    .next_inst(instmem_wire),
    .opcode(opcode_wire),
    .rs1_addr(rs1a_wire),
    .rs2_addr(rs2a_wire),
    .rd_addr(rda_wire),
    .funct3(funct3_wire),
    .funct7(funct7_wire),
    .instr_31_7(imm_wire)
);

inst_mem instmemory(
    .clk(clk),
    .inst_addr(inst_wire),
    .write_data(instruction_data), 
    .next_inst(instmem_wire)     
);

memory mem(
    .clk(clk),
    .MemWrite(MemWrite_wire),
    .address(Sum_wire),
    .data_in(rs2_wire),
    .data_out(dataout_wire),
    .MemRead(MemRead_wire)
);

main_alu alu(
    .operand_1(Operand1_wire),
    .operand_2(Operand2_wire),
    .op(op_wire),
    .sum(Sum_wire),
    .zero(Zero_wire)    
);

datapath bus(
    .Branch(Branch_wire),
    .Zero(Zero_wire),
    .ALU_Src(ALU_Src_wire),
    .ALU_Src2(ALU_Src2_wire),
    .Jump(Jump_wire),
    .MemtoReg(MemtoReg_wire),
    .current_inst(inst_wire),
    .rs1(rs1_wire),
    .rs2(rs2_wire),
    .immediate(immediate_wire),
    .data_out(dataout_wire),
    .sum(Sum_wire),
    .opcode(opcode_wire),
    .new_inst(wire_inst),
    .write_reg(write_reg_wire),
    .operand_1(Operand1_wire),
    .operand_2(Operand2_wire)    
);

assign proc_out = Sum_wire;
endmodule
