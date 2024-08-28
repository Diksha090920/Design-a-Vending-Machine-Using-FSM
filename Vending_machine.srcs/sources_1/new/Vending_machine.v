`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2024 11:17:07
// Design Name: 
// Module Name: Vending_machine
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


module Vending_machine(clk,rst, in,sel, out , change );
input clk, rst, sel;
input [1:0] in; //01 =5rs , 10=10rs 
output reg out;
output reg [1:0] change;

parameter s0= 2'b00;
parameter s1= 2'b01;
parameter s2= 2'b10;

reg [1:0] c_state , n_state;

always @ (posedge clk) 
begin 
  if (rst ==1)
  begin 
    c_state=0;
    n_state=0;
    change =2'b00;
  end
  else 
    c_state=n_state;
    case(c_state)
    
    s0: if (in==0)
    begin 
       n_state =s0;
       out=0;
       change =2'b00;
    end
     else if (in ==2'b01)
     begin 
       if (sel==0)
       begin
      n_state=s1;
      out=0;
      change =2'b00;
      end 
      else if (sel==1)
             begin
            n_state=s1;
            out=0;
            change =2'b00;
            end 
     end
     else if (in ==2'b10)
     begin 
     if (sel==0)
      begin
     n_state=s2;
     out =1;
     change =2'b00; 
     end
    else if (sel==1)
           begin
          n_state=s2;
          out =0;
          change =2'b00; 
          end
     end
     
     s1:if(in==0)
     begin 
        n_state=s0;
        out =0;
        change =2'b01;
        
     end
     else if (in ==2'b01)
     begin 
       if (sel==0)  // if cola is selected , out put cola   
          begin        // with zero change (10 rs)
       n_state=s2;
       out=1;
       change =2'b00;
          end
        if (sel==1)  // if cola is selected , out put cola   
             begin        // with zero change (10 rs)
             n_state=s2;
             out=0;
             change =2'b00;
             end
        end
        else if (in ==2'b10)
          begin
            if (sel==0) 
            begin 
           n_state=s0;
           out =1;
           change =2'b01;
           end
           else if (sel==1)
           begin 
            n_state=s0;
            out =1;
            change =2'b00;
           end
          end
       
     s2: // State 2: 10rs   
                          if (in == 0)  
                          begin
                              n_state = s0;
                              out = 0;
                              change = 2'b10; 
                          end
                          else if (in == 2'b01)  
                          begin
                              if (sel == 1)  // Pepsi selected
                              begin
                                  n_state = s0;
                                  out = 1;   // Dispense Pepsi
                                  change = 2'b00;
                              end
                              else // Cola selected
                              begin
                                  n_state = s0;
                                  out = 1;   // Dispense Cola
                                  change = 2'b00; // No change needed
                              end
                          end 
                          else if (in == 2'b10)  
                          begin
                              if (sel == 1)  // Pepsi selected
                              begin
                                  n_state = s0;
                                  out = 1;   // Dispense Pepsi
                                  change = 2'b01; // Return 5rs as change
                              end
                              else // Cola selected
                              begin
                                  n_state = s0;
                                  out = 1;   // Dispense Cola
                                  change = 2'b00; // No change needed
                              end
                          end   
         
        
    endcase
end

endmodule
