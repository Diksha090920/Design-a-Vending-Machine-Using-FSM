`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2024 11:47:56
// Design Name: 
// Module Name: tb_vending_machine
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



module tb_vending_machine;

    // Inputs
    reg clk;
    reg rst;
    reg [1:0] in;
    reg sel; 

    // Outputs
    wire out;
    wire [1:0] change;

    // Instantiate the Unit Under Test (UUT)
    Vending_machine uut (
        .clk(clk), 
        .rst(rst), 
        .in(in), 
        .sel(sel), 
        .out(out), 
        .change(change)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10 time units period clock

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        in = 2'b00;
        sel = 0;

        // Reset the machine
        rst = 1;
        #10;
        rst = 0;

        // Test 1: Select Cola (cost 10) and insert 10
        sel = 0; // Cola selected
        #10;
        in = 2'b10;  // Insert 10 rupees
        #20;
        in = 2'b00;  // No more input
        #10;
        $display("Test 1 - Cola: out = %b, change = %b", out, change);

        // Test 2: Select Pepsi (cost 15) and insert 10 then 5
        rst = 1;
        #10;
        rst = 0;
        sel = 1; // Pepsi selected
        #10;
        in = 2'b10;  // Insert 10 rupees
        #20;
        in = 2'b01;  // Insert 5 rupees
        #20;
        in = 2'b00;  // No more input
        #10;
        $display("Test 2 - Pepsi: out = %b, change = %b", out, change);

        // Test 3: Select Pepsi and insert 20 (10 + 10)
        rst = 1;
        #10;
        rst = 0;
        sel = 1; // Pepsi selected
        #10;
        in = 2'b10;  // Insert 10 rupees
        #20;
        in = 2'b10;  // Insert another 10 rupees
        #20;
        in = 2'b00;  // No more input
        #10;
        $display("Test 3 - Pepsi with extra: out = %b, change = %b", out, change);

        // Test 4: Select Cola and insert 15 (10 + 5)
        rst = 1;
        #10;
        rst = 0;
        sel = 0; // Cola selected
        #10;
        in = 2'b10;  // Insert 10 rupees
        #20;
        in = 2'b01;  // Insert 5 rupees
        #20;
        in = 2'b00;  // No more input
        #10;
        $display("Test 4 - Cola with extra: out = %b, change = %b", out, change);

        // Test 5: Select Cola and insert 5 (insufficient amount)
        rst = 1;
        #10;
        rst = 0;
        sel = 0; // Cola selected
        #10;
        in = 2'b01;  // Insert 5 rupees
        #20;
        in = 2'b00;  // No more input
        #10;
        $display("Test 5 - Cola with insufficient funds: out = %b, change = %b", out, change);

        $finish;
    end
endmodule
