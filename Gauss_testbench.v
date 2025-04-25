`define clk_period 20

module Gauss_testbench();

reg clk;
reg reset;
reg enable;

reg [7:0] In1;
reg [7:0] In2;
reg [7:0] In3;

wire done;
wire [7:0] gaussian;

Gaussian_Filter gausstest(
	.clk(clk),
	.reset(reset),
    .enable(enable),
    .In1(In1),
    .In2(In2),
    .In3(In3),
    .done(done),
    .gaussian(gaussian)
);

initial clk = 1'b1;
always #(`clk_period/2) clk = ~clk;

initial begin
    reset = 1'b0;
    enable = 1'b0;
    In1 = 8'd0;
    In2 = 8'd0;
    In3 = 8'd0;

    #(`clk_period);
    reset = 1'b1;

    #(`clk_period);
    enable = 1'b1;
    In1 = 8'd1;
    In2 = 8'd2;
    In3 = 8'd3;

    #(`clk_period);
    enable = 1'b0;
    In1 = 8'd4;
    In2 = 8'd5;
    In3 = 8'd6;

    #(`clk_period);
    In1 = 8'd7;
    In2 = 8'd8;
    In3 = 8'd9;

    #(`clk_period * 5);
    $stop;
end

endmodule












