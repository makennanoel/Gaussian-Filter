// Type: 2D Gaussian Blur (approximated)
// Kernel: 3x4
// Spatial Domain (Not Frequency Domain)
// Fixed-Point logic using shifts for division
// Use Case: Image Smoothening

module Gaussian_Filter (
	input clk,
	input reset,
    input enable,
    input [7:0] In1,
    input [7:0] In2,
    input [7:0] In3,

    output reg done,
    output reg [7:0] gaussian
);

reg signed [7:0] row1 [2:0];
reg signed [7:0] row2 [2:0];
reg signed [7:0] row3 [2:0];

reg signed [15:0] row1_comp;
reg signed [15:0] row2_comp;
reg signed [15:0] row3_comp;

reg signed [7:0] gs_sum;

reg signed [3:0] counter; 
reg signed inputs_enabled;


always @(posedge clk or negedge reset) 
begin
    if (!reset)
        begin
            row1[0]<= 8'd0;
            row1[1]<= 8'd0;
            row1[2]<= 8'd0;
        end
    else
        begin
            row1[0]<= In1;
            row1[1]<= row1[0];
            row1[2]<= row1[1];
        end
end

always @(posedge clk or negedge reset)
begin
    if (!reset)
        begin
            row2[0]<= 8'd0;
            row2[1]<= 8'd0;
            row2[2]<= 8'd0;
        end
    else
        begin
            row2[0]<= In2;
            row2[1]<= row2[0];
            row2[2]<= row2[1];
        end
end

always @(posedge clk or negedge reset)
begin
    if (!reset)
        begin
            row3[0]<= 8'd0;
            row3[1]<= 8'd0;
            row3[2]<= 8'd0;
        end
    else
        begin
            row3[0]<= In3;
            row3[1]<= row3[0];
            row3[2]<= row3[1];
        end
end

always @(posedge clk or negedge reset)
begin
    if (!reset)
        begin
            row1_comp = 8'd0;
            row2_comp = 8'd0;
            row3_comp = 8'd0;
        end
    else
        begin
            row1_comp = row1[0]*(1) + row1[1]*(2) + row1[2]*(1);
            row2_comp = row2[0]*(2) + row2[1]*(3) + row2[2]*(1);
            row3_comp = row3[0]*(1) + row3[1]*(2) + row3[2]*(1);
        end
end

always @(posedge clk or negedge reset)
begin
    if (!reset)
    begin
        gs_sum = 8'd0;
    end
    else
    begin
        gs_sum = (row1_comp + row2_comp + row3_comp);
    end
end

//Set output
always @(posedge clk or negedge reset)
begin
    if (!reset)
    begin
        counter = 4'd0;
        inputs_enabled = 1'd0;
        done = 1'd0;
    end
    else
    begin 
        case (inputs_enabled)
            1'd0:
					begin
						 done <= 1'd0;
						 if (enable) 
						 begin
							inputs_enabled <= 1'd1;
							counter <= counter + 4'd1;
						 end
					 end
            1'd1:
                if (counter == 4'd5)
                begin
                    inputs_enabled <= 1'd0;
                    counter <= 4'd0;
                    done <= 1'd1;
                end
                else
                begin
                    counter <= counter + 4'd1;
                end
            default:
				begin
                counter <= 4'd0;
                inputs_enabled <= 1'd0;
                done <= 1'd0;
				end
        endcase
    end
end

//Set Output
always @(posedge clk or negedge reset)
begin
    if (!reset)
    begin
        gaussian = 8'd0;
    end
    else
    begin
        gaussian = gs_sum >> 4;
    end
end

endmodule