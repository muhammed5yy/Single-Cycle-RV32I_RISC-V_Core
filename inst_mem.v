module inst_mem(
input clk,
input [31:0]inst_addr,
input [31:0]write_data,

output reg [31:0] next_inst
    );
        
   (* rom_style = "block" *) reg [31:0] inst_memory [1023:0];
    
    initial begin
        $readmemh("instr_program.mem", inst_memory); 
    end
    
    always@(*) begin
        next_inst = inst_memory[inst_addr[11:2]];
        end
        
     always@(posedge clk) begin        
        inst_memory[inst_addr[11:2]] <= write_data;       
        end
          
    
endmodule
