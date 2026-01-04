`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga640x480 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga640x480(
	input wire dclk,			//pixel clock: 25MHz
	input wire clr,			//asynchronous reset
	input wire [9:0] bird_coord,
	input wire [8:0] pipe_pos,
	input wire [7:0]pipe_array0,
	input wire [7:0]pipe_array1,
	input wire [3:0] current_score,
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [1:0] blue	//blue vga output
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;
//variables for gamestate and qlearning
wire [15:0] game_state;
wire jump_signal;
reg is_collide;
//instantiate gamestate
GameStateCalculator state_calculator (
        .birdY(bird_coord),
        .pipe1_X(pipe_pos),   // Assuming pipe1_X is represented by pipe_pos
        .pipe1_Y(pipe_array0),// And pipe1_Y by pipe_array0
        .pipe2_X(pipe_pos),   // Similar assumption for pipe2
        .pipe2_Y(pipe_array1),
        .state(game_state)
);
// Instantiate QLearningController
    QLearningController q_learning (
        .clk(dclk),
        .reset(clr),
        .state(game_state),
        .is_collide(is_collide),
        .jump(jump_signal)
);

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

// Collision detection logic
    always @(posedge dclk) begin
        is_collide <= (vc > (480 - bird_coord) - 20 && vc < (480 - bird_coord) + 20 &&
                       hc > hbp + 100 && hc < hbp + 140 &&
                       ((hc < hfp - pipe_pos + 50 && hc > hfp - pipe_pos) &&
                       (vc < pipe_array1 + 75 || (vc > pipe_array1 + 215 && vc < 500)) ||
                       ((hc < hfp - 345 - pipe_pos + 50 && hc > hfp - 345 - pipe_pos) &&
                       (vc < pipe_array0 + 75 || (vc > pipe_array0 + 215 && vc < 500)))));
    end

// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =

reg a;
initial a = 0;
reg b;
initial b = 0;
reg c;
initial c = 0;
reg d;
initial d = 0;
reg e;
initial e = 0;
reg f;
initial f = 0;
reg g;
initial g = 0;
reg h;
initial h = 0;
reg i;
initial i = 0;
reg j;
initial j = 0;
reg k;
initial k = 0;
reg l;
initial l = 0;
reg m;
initial m = 0;
reg n;
initial n = 0;
reg o;
initial o = 0;

always @ (*)
begin
case(current_score)
0:
begin
	a = 0;
	b = 0;
	c = 0;
	d = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	j = 0;
	k = 0;
	l = 0;
	m = 0;
	n = 0;
	o = 0;
end
1:
begin
	a = 1;
end
2: 
begin
	a = 1;
	b = 1;
end
3: 
begin
	a = 1;
	b = 1;
	c = 1;
end
4: 
begin
	a = 1;
	b = 1;
	c = 1;
	d = 1;
end
5:
begin
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
end
6: 
begin
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
	f = 1;
end
7:
begin
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
	f = 1;
	g = 1;
end
8:
begin
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
	f = 1;
	g = 1;
	h = 1;
end
9: 
begin
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
	f = 1;
	g = 1;
	h = 1;
	i = 1;
end
10:
begin 
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
	f = 1;
	g = 1;
	h = 1;
	i = 1;
	j = 1;
end
11:
begin 
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
	f = 1;
	g = 1;
	h = 1;
	i = 1;
	j = 1;
	k = 1;
end
12:
begin
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
	f = 1;
	g = 1;
	h = 1;
	i = 1;
	j = 1;
	k = 1;
	l = 1;
end
13:
begin
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
	f = 1;
	g = 1;
	h = 1;
	i = 1;
	j = 1;
	k = 1;
	l = 1;
	m = 1;
end
14:
begin 
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
	f = 1;
	g = 1;
	h = 1;
	i = 1;
	j = 1;
	k = 1;
	l = 1;
	m = 1;
	n = 1;
end
15:
begin 
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	e = 1;
	f = 1;
	g = 1;
	h = 1;
	i = 1;
	j = 1;
	k = 1;
	l = 1;
	m = 1;
	n = 1;
	o = 1;
end
endcase
end
	



always @(*)
begin

	// first check if we're within vertical active video range
	if (vc >= vbp && vc < vfp)
	begin
		// now display different colors every 80 pixels
		// while we're within the active horizontal range
		// -----------------
		if(hc > (hbp+20) && hc < (hbp+25)&& a && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+30) && hc < (hbp+35) && b && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+40) && hc < (hbp+45) && c && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+50) && hc < (hbp+55) && d && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+60) && hc < (hbp+65) && e && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+70) && hc < (hbp+75) && f && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+80) && hc < (hbp+85) && g && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+90) && hc < (hbp+95) && h && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+100) && hc < (hbp+105) && i && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+110) && hc < (hbp+115) && j && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+120) && hc < (hbp+125) && k && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+130) && hc < (hbp+135) && l && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+140) && hc < (hbp+145) && m && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+150) && hc < (hbp+155) && n && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+160) && hc < (hbp+165) && o && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else if(vc > (480-bird_coord)-20 && vc < (480-bird_coord)+20 && hc > hbp+100 && hc < hbp+140)
			begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
		//pipes
		else if ((hc < hfp-pipe_pos+50 && hc > hfp-pipe_pos) && (vc < pipe_array1+75 || vc > pipe_array1+215 && vc < 500))
		begin
			red = 3'b111;
			green = 3'b000;
			blue = 2'b00;
		end		
		else if ((hc < hfp-345-pipe_pos+50 && hc > hfp-345-pipe_pos) && (vc < pipe_array0+75 || vc > pipe_array0+215 && vc < 500))
		begin
			red = 3'b111;
			green = 3'b000;
			blue = 2'b00;
		end		
		//grass -- not marijuana
		else if (vc >= 500)
		begin
			red = 3'b000;
			green = 3'b111;
			blue = 2'b00;
		end
		// display cyan bar
		else if (hc >= (hbp) && hc < (hbp+640))
		begin
			red = 3'b000;
			green = 3'b111;
			blue = 2'b11;
		end
		// we're outside active horizontal range so display black
		else
		begin
			red = 0;
			green = 0;
			blue = 0;
		end
	end
	// we're outside active vertical range so display black
	else
	begin
		red = 0;
		green = 0;
		blue = 0;
	end
end

endmodule

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   [Your Creation Date]
// Design Name:   pipes
// Module Name:   [Your Module Name]_tb
// Project Name:  [Your Project Name]
// Target Device:  
// Tool versions:  
// Description: 
//  Testbench for the pipes module.
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pipes_tb;

    // Inputs
    reg clk;
    reg enable;
    reg pos;

    // Outputs
    wire [2:0] pipe_array [3:0];

    // Instantiate the Unit Under Test (UUT)
    pipes uut (
        .clk(clk), 
        .enable(enable), 
        .pos(pos), 
        .pipe_array(pipe_array)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        enable = 0;
        pos = 0;

        // Wait for global reset
        #100;
        enable = 1;

        // Test Scenario: Enable pipe generation
        #20;
        pos = 1;
        #10;
        pos = 0;

        // More test scenarios can be added here
        // ...

    end

    // Clock generation
    always #5 clk = ~clk;
      
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:49:36 03/19/2013 
// Design Name: 
// Module Name:    clockdiv 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clockdiv(
	input wire clk,		//master clock: 50MHz
	input wire clr,		//asynchronous reset
	output wire dclk,		//pixel clock: 25MHz
	output wire segclk,	//7-segment clock: 381.47Hz
	output wire bird_clk
	);

// 17-bit counter variable
reg [16:0] q;

// Clock divider --
// Each bit in q is a clock signal that is
// only a fraction of the master clock.
always @(posedge clk or posedge clr)
begin
	// reset condition
	if (clr == 1)
		q <= 0;
	// increment counter by one
	else
		q <= q + 1;
end

// 50Mhz ÷ 2^17 = 381.47Hz
assign segclk = q[16];

// 50Mhz ÷ 2^1 = 25MHz
assign dclk = q[1];

assign bird_clk = q[16];

endmodule

module bird(
    input clk,
    input rst,
    input enable,
    input jump, // This signal comes from the QLearningController
    input [1:0] state,
    output reg signed [10:0] y_coord,
    output reg [1:0] BirdAnimation // Additional output for bird animation state
);

    reg signed [10:0] vel;
    reg [8:0] clock_div;

    // Initialization
    initial begin
        y_coord = 'd300;
        vel = 'd0;
        clock_div = 0;
    end

    // Clock divider for controlling the update rate
    always @ (posedge clk) begin
        clock_div <= clock_div + 1;
    end

    // Velocity and position update logic
    always @ (posedge clock_div[4]) begin
        if(enable && state == 2) begin
            if(jump && vel < 5) begin
                vel <= vel + 'd10; // Jump action triggered by QLearningController
                BirdAnimation <= 1; // Flapping
            end else if (vel > -5) begin
                vel <= vel - 1;
                BirdAnimation <= 2; // Falling
            end
        end else if (!state[1]) begin
            vel <= 0;
            BirdAnimation <= 0; // Idle or other state
        end
    end

    // Y-coordinate update logic
    always @ (posedge clock_div[4]) begin
        if(enable && state == 2) begin
            if(y_coord <= 0)
                y_coord <= 0;
            else if(y_coord + vel <= 0)
                y_coord <= 0;
            else if((y_coord + vel) > 0 && (y_coord + vel) < 485)
                y_coord <= y_coord + vel;
        end else if (state == 0)
            y_coord <= 0;
        else if (state == 1)
            y_coord <= 300;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:28:28 05/11/2016 
// Design Name: 
// Module Name:    RNG 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RNG( clk, out
    );
	 
	 input clk;
	 output reg [7:0] out;
	 
	 reg [20:0] rand;
	 initial rand = ~(20'b0);
	 reg [20:0] rand_next;
	 wire feedback;
	 
	 assign feedback = rand[20] ^ rand[17];
	 
	 always @ (posedge clk)
	 begin
		rand <= rand_next;
		out = rand[7:0];
	 end
	 
	 always @ *
	 begin
		rand_next = {rand[19:0], feedback};
	 end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:56 03/19/2013 
// Design Name: 
// Module Name:    segdisplay 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module segdisplay(
	input wire [3:0] score,
	input wire segclk,		//7-segment clock
	input wire clr,			//asynchronous reset
	output reg [6:0] seg,	//7-segment display LEDs
	output reg [3:0] an		//7-segment display anode enable
	);

// constants for displaying letters on display
reg [6:0] segments;

// Finite State Machine (FSM) states
parameter left = 2'b00;
parameter midleft = 2'b01;
parameter midright = 2'b10;
parameter right = 2'b11;

// state register
reg [1:0] state;

// FSM which cycles though every digit of the display every 2.62ms.
// This should be fast enough to trick our eyes into seeing that
// all four digits are on display at the same time.
	always @ (*)
			case(score)
				4'd0: segments = 7'b1000000;
				4'd1: segments = 7'b1111001;
				4'd2: segments = 7'b0100100;
				4'd3: segments = 7'b0110000;
				4'd4: segments = 7'b0011001;
				4'd5: segments = 7'b0010010;
				4'd6: segments = 7'b0000010;
				4'd7: segments = 7'b1111000;
				4'd8: segments = 7'b0000000;
				4'd9: segments = 7'b0010000;
				4'd10: segments = 7'b0001000;
				4'd11: segments = 7'b0000011;
				4'd12: segments = 7'b1000110;
				4'd13: segments = 7'b0100001;
				4'd14: segments = 7'b0000110;
				4'd15: segments = 7'b0001110;
				default: segments = 7'b1111111;
			endcase
			
always @(posedge segclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		seg <= 7'b1111111;
		an <= 7'b1111;
		state <= left;
	end
	// display the character for the current position
	// and then move to the next state
	else

	begin
		case(state)
			left:
			begin
				seg <= 7'b1000000;
				an <= 4'b0111;
				state <= midleft;
			end
			midleft:
			begin
				seg <= 7'b1000000;
				an <= 4'b1011;
				state <= midright;
			end
			midright:
			begin
				seg <= 7'b1000000;
				an <= 4'b1101;
				state <= right;
			end
			right:
			begin
				seg <= segments;
				an <= 4'b1110;
				state <= left;
			end
		endcase
	end
end

endmodule

`timescale 1ns / 1ps

module GameStateCalculator(
    input [9:0] birdY,            // Bird's Y-coordinate
    input [8:0] pipe1_X, pipe1_Y, // First pipe's X and Y coordinates
    input [8:0] pipe2_X, pipe2_Y, // Second pipe's X and Y coordinates
    output reg [15:0] state       // State representation
);

    // Temporary variables to calculate distances
    reg [9:0] vert_dist_to_pipe;  // Vertical distance to next pipe
    reg [9:0] horiz_dist_to_pipe; // Horizontal distance to next pipe

    always @(*) begin
        // Determine which pipe is the next pipe
        if (pipe1_X < birdY && pipe1_X < pipe2_X || pipe2_X >= birdY) begin
            // Pipe 1 is the next pipe
            vert_dist_to_pipe = pipe1_Y - birdY;
            horiz_dist_to_pipe = pipe1_X; // Assuming horizontal position is fixed
        end else begin
            // Pipe 2 is the next pipe
            vert_dist_to_pipe = pipe2_Y - birdY;
            horiz_dist_to_pipe = pipe2_X; // Assuming horizontal position is fixed
        end

        // Combine these distances into a single state variable
        // Adjust the bit widths as needed based on your game's specifics
        state = {vert_dist_to_pipe[9:5], horiz_dist_to_pipe[8:4]};
    end

endmodule

`timescale 1ns / 1ps

module QLearningController(
    input clk,
    input reset,
    input [15:0] state,       // State input from GameStateCalculator
    input is_collide,         // Signal indicating if the bird collided
    output reg jump           // Output to control bird's jump
);

    // Parameters for the Q-learning algorithm
    parameter ALPHA = 10;     // Learning rate
    parameter GAMMA = 10;     // Discount factor
    parameter REWARD_POS = 50; // Reward for positive outcome
    parameter REWARD_NEG = -100; // Penalty for collision

    // Define the Q-table size based on your state and action space
    reg [15:0] Q_table [1023:0][1:0]; // Example size

    // State, action, and reward variables
    reg [15:0] current_state, next_state;
    reg current_action, next_action;
    reg [15:0] current_reward;

    // Initialize the Q-table
    integer i, j;
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            for (j = 0; j < 2; j = j + 1) begin
                Q_table[i][j] = 0; // Initialize with zero or a small value
            end
        end
    end

    // Update logic for the Q-table
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset logic
            jump <= 0;
            current_state <= 0;
            current_action <= 0;
            current_reward <= 0;
        end else begin
            // Update Q-table
            if (is_collide) begin
                current_reward = REWARD_NEG; // Negative reward on collision
            end else begin
                current_reward = REWARD_POS; // Positive reward otherwise
            end

            // Q-table update formula
            Q_table[current_state][current_action] <= 
                Q_table[current_state][current_action] + 
                ALPHA * (current_reward + GAMMA * Q_table[next_state][next_action] - Q_table[current_state][current_action]);

            // Decision logic for next action
            if (Q_table[state][1] > Q_table[state][0]) begin
                jump <= 1;  // Jump action
            end else begin
                jump <= 0;  // Don't jump action
            end

            // Update current state and action
            current_state <= state;
            current_action <= jump;
        end
    end

Endmodule

