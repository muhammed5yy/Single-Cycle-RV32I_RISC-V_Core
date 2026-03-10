`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2025 12:00:58
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    
    input [6:0] Opcode,
    
    output reg [1:0]ALU_Op,
    output reg ALU_Src,
    output reg ALU_Src2,
    output reg RegWrite,
    output reg MemWrite,
    output reg [1:0]MemtoReg,
    output reg MemRead,
    output reg Branch,
    output reg Jump
);
    

always@(*) begin
ALU_Op = 2'b0;
ALU_Src = 0;
RegWrite = 0;
MemWrite = 0;
MemtoReg = 0;  
MemRead = 0;   
Branch = 0;    
Jump = 0;
ALU_Src2 = 0;
//LOAD, STORE, AUIPC, JAL, JALR ---> ALU_Op = 2'b00.
//R Type Instructions -------> ALU_Op = 2'b11.
//I Type Instructions -------> ALU_Op = 2'b10.
//Branch Instructions -------------> ALU_Op = 2'b01.

//ALU_Src2 ---> 1 for AUIPC and JAL, 0 for other instructions.

//MemtoReg ---> 00: ALU Result
//MemtoReg ---> 01: Memory out
//MemtoReg ---> 10: PC+4
//MemtoReg ---> 11: ImmGen out
    case(Opcode)
        7'b0000011: begin //LOAD
        ALU_Op = 2'b00;
        ALU_Src = 1;
        RegWrite = 1;
        MemWrite = 0;
        MemtoReg = 2'b01;  
        MemRead = 1;   
        Branch = 0;    
        Jump = 0;
        ALU_Src2 = 0;
        end
        
        7'b0010011: begin //I-Type
        ALU_Op = 2'b10;
        ALU_Src = 1;
        RegWrite = 1;
        MemWrite = 0;
        MemtoReg = 2'b00;  
        MemRead = 0;   
        Branch = 0;    
        Jump = 0;
        ALU_Src2 = 0;
        end
        
        7'b0010111: begin //AUIPC
        ALU_Op = 2'b00;
        ALU_Src = 1'b1;
        RegWrite = 1;
        MemWrite = 0;
        MemtoReg = 2'b00;  
        MemRead = 0;   
        Branch = 0;    
        Jump = 0;
        ALU_Src2 = 1;
        end
        
        7'b0100011: begin  //STORE
        ALU_Op = 2'b00;
        ALU_Src = 1;
        RegWrite = 0;
        MemWrite = 1;
        MemtoReg = 2'b00;  
        MemRead = 0;   
        Branch = 0;    
        Jump = 0;
        ALU_Src2 = 0;
        end
        
        7'b0110011: begin  //R-Type
        ALU_Op = 2'b11;
        ALU_Src = 0;
        RegWrite = 1;
        MemWrite = 0;
        MemtoReg = 2'b00;  
        MemRead = 0;   
        Branch = 0;    
        Jump = 0;
        ALU_Src2 = 0;
        end
        
        7'b0110111: begin //LUI
        ALU_Op = 2'b00;
        ALU_Src = 1'bx;
        RegWrite = 1;
        MemWrite = 0;
        MemtoReg = 2'b11;  
        MemRead = 0;   
        Branch = 0;    
        Jump = 0;
        ALU_Src2 = 0;
        end
        
        7'b1100011: begin //Branch
        ALU_Op = 2'b01;
        ALU_Src = 0;
        RegWrite = 0;
        MemWrite = 0;
        MemtoReg = 2'b00;  
        MemRead = 0;   
        Branch = 1;    
        Jump = 0;
        ALU_Src2 = 0;
        end
        
        7'b1100111: begin //JALR(REGISTER)
        ALU_Op = 2'b00;
        ALU_Src = 1;
        RegWrite = 1;
        MemWrite = 0;
        MemtoReg = 2'b10;  
        MemRead = 0;   
        Branch = 0;    
        Jump = 1;
        ALU_Src2 = 0;
        end
        
        7'b1101111: begin //JAL
        ALU_Op = 2'b00;
        ALU_Src = 1'b1;
        RegWrite = 1;
        MemWrite = 0;
        MemtoReg = 2'b10;  
        MemRead = 0;   
        Branch = 0;    
        Jump = 1;
        ALU_Src2 = 1;
        end
        
        default: begin
        ALU_Op = 2'b0;
        ALU_Src = 0;
        RegWrite = 0;
        MemWrite = 0;
        MemtoReg = 2'b00;  
        MemRead = 0;   
        Branch = 0;    
        Jump = 0;
        end
        endcase
        

end       
endmodule 
