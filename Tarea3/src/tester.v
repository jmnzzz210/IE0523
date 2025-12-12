module tester(/*AUTOARG*/
   // Outputs
   clk, rst
   );

    output reg clk, rst;

    initial begin
        rst = 0;
        clk = 0;
        #10 rst =1;

        #505 rst = 0;
        #10 rst = 1;

        #575 $finish;
    end

    always begin
        #5 clk = !clk;
    end

endmodule
