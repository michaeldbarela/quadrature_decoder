`timescale 1ns / 1ps

module quadrature_encoder_tb;

//////////////////////////////////////////
//         Signal Declarations
//////////////////////////////////////////
    logic           clk, reset;
    logic[1:0]      enc;
    logic[3:0]      count;
    int             errorCount;
    
//////////////////////////////////////////
//         Device Under Test
//////////////////////////////////////////     
    quadrature_encoder dut1( 
        .clk( clk ),
        .reset( reset ),
        .enc( enc ),
        .count( count ) );
                   
//////////////////////////////////////////
//      Self Checking Test Bench
//////////////////////////////////////////                               
    //Creates a 100MHz, 10ns period    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0; reset = 1; errorCount = 0; 
        enc = 0;
        #10; reset = 0;
        #20; reset = 1;
        #10; enc[0] = 1;
        #10; enc[1] = 1;
        #20; enc[0] = 0;
        #10; enc[1] = 0;
        // if(errorCount == 0)
        //     $display("NO ERRORS FOUND IN AISO RESET MODULE.");
        // else
        //     $display("ERRORS FOUND IN AISO RESET MODULE. NUMBER OF ERRORS = %d", errorCount);
        // #10; $stop;
    end
   
endmodule

