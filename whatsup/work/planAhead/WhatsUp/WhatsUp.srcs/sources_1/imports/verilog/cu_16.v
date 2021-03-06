/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module cu_16 (
    input clk,
    input rst,
    input pressed,
    input rise,
    input sc_hold,
    input [15:0] alu_output,
    input easy_mode,
    input [15:0] current_counter,
    input [15:0] player_score,
    output reg [5:0] alufn,
    output reg [1:0] ra1sel,
    output reg [3:0] ra2sel,
    output reg werf,
    output reg [2:0] wasel,
    output reg restart,
    output reg increment_old_counter,
    output reg update_hs,
    output reg [3:0] mainSeg3_char,
    output reg [3:0] mainSeg2_char,
    output reg [3:0] mainSeg1_char,
    output reg [3:0] mainSeg0_char
  );
  
  
  
  
  localparam IDLE_game_state = 5'd0;
  localparam STARTONE_game_state = 5'd1;
  localparam STARTTWO_game_state = 5'd2;
  localparam STARTTHREE_game_state = 5'd3;
  localparam GO_game_state = 5'd4;
  localparam CHECKEND_game_state = 5'd5;
  localparam MOD5A_game_state = 5'd6;
  localparam MOD5B_game_state = 5'd7;
  localparam MOD7A_game_state = 5'd8;
  localparam MOD7B_game_state = 5'd9;
  localparam MOD10_5A_game_state = 5'd10;
  localparam MOD10_5B_game_state = 5'd11;
  localparam MOD10_7A_game_state = 5'd12;
  localparam MOD10_7B_game_state = 5'd13;
  localparam SHLDPRESS_game_state = 5'd14;
  localparam SHLDNOTPRESS_game_state = 5'd15;
  localparam ADDSCORE_game_state = 5'd16;
  localparam CHECKSTREAK_game_state = 5'd17;
  localparam ADDSTREAK_game_state = 5'd18;
  localparam MINUSSTREAK_game_state = 5'd19;
  localparam WAIT_game_state = 5'd20;
  localparam CHECKHIGHSCORE_game_state = 5'd21;
  localparam NOHIGHSCHORE_game_state = 5'd22;
  localparam UPDATEHS_game_state = 5'd23;
  
  reg [4:0] M_game_state_d, M_game_state_q = IDLE_game_state;
  
  
  localparam IDLE_counter_state = 2'd0;
  localparam ONE_counter_state = 2'd1;
  localparam TEN_counter_state = 2'd2;
  localparam HUNDRED_counter_state = 2'd3;
  
  reg [1:0] M_counter_state_d, M_counter_state_q = IDLE_counter_state;
  
  reg [15:0] quotient;
  
  reg [15:0] quotientPS10;
  
  reg [15:0] temp1;
  
  reg [15:0] tempPS10;
  
  reg [3:0] M_oneMain_d, M_oneMain_q = 1'h0;
  reg [3:0] M_tenMain_d, M_tenMain_q = 1'h0;
  reg [3:0] M_hundredMain_d, M_hundredMain_q = 1'h0;
  
  always @* begin
    M_game_state_d = M_game_state_q;
    M_counter_state_d = M_counter_state_q;
    M_oneMain_d = M_oneMain_q;
    M_hundredMain_d = M_hundredMain_q;
    M_tenMain_d = M_tenMain_q;
    
    alufn = 1'h0;
    ra1sel = 1'h0;
    ra2sel = 1'h0;
    werf = 1'h0;
    wasel = 1'h0;
    restart = 1'h0;
    increment_old_counter = 1'h0;
    update_hs = 1'h0;
    mainSeg3_char = 4'hf;
    mainSeg2_char = 4'hf;
    mainSeg1_char = 4'hf;
    mainSeg0_char = 4'hf;
    mainSeg0_char = M_oneMain_q;
    mainSeg1_char = M_tenMain_q;
    mainSeg2_char = M_hundredMain_q;
    mainSeg3_char = 4'hf;
    if (rst) begin
      M_game_state_d = IDLE_game_state;
      M_counter_state_d = IDLE_counter_state;
    end else begin
      
      case (M_counter_state_q)
        ONE_counter_state: begin
          quotient = current_counter / 4'ha;
          M_oneMain_d = current_counter - (4'ha * quotient);
          M_counter_state_d = TEN_counter_state;
        end
        TEN_counter_state: begin
          temp1 = current_counter / 4'ha;
          quotient = temp1 / 4'ha;
          M_tenMain_d = temp1 - (4'ha * quotient);
          M_counter_state_d = HUNDRED_counter_state;
        end
        HUNDRED_counter_state: begin
          temp1 = current_counter / 7'h64;
          quotient = temp1 / 4'ha;
          M_hundredMain_d = temp1 - (4'ha * quotient);
          M_counter_state_d = ONE_counter_state;
        end
      endcase
      
      case (M_game_state_q)
        IDLE_game_state: begin
          if (pressed) begin
            M_game_state_d = STARTTHREE_game_state;
            update_hs = 1'h0;
          end
        end
        STARTTHREE_game_state: begin
          mainSeg3_char = 4'hf;
          mainSeg2_char = 4'hf;
          mainSeg1_char = 2'h3;
          mainSeg0_char = 4'hf;
          if (rise) begin
            M_game_state_d = STARTTWO_game_state;
          end
        end
        STARTTWO_game_state: begin
          mainSeg3_char = 4'hf;
          mainSeg2_char = 4'hf;
          mainSeg1_char = 2'h2;
          mainSeg0_char = 4'hf;
          if (rise) begin
            M_game_state_d = STARTONE_game_state;
          end
        end
        STARTONE_game_state: begin
          mainSeg3_char = 4'hf;
          mainSeg2_char = 4'hf;
          mainSeg1_char = 1'h1;
          mainSeg0_char = 4'hf;
          if (rise) begin
            M_game_state_d = GO_game_state;
          end
        end
        GO_game_state: begin
          mainSeg3_char = 4'hf;
          mainSeg2_char = 4'h6;
          mainSeg1_char = 4'h0;
          mainSeg0_char = 4'hf;
          if (rise) begin
            M_game_state_d = CHECKEND_game_state;
            restart = 1'h1;
            increment_old_counter = 1'h0;
            M_counter_state_d = ONE_counter_state;
          end
        end
        CHECKEND_game_state: begin
          restart = 1'h0;
          alufn = 6'h37;
          ra1sel = 2'h1;
          ra2sel = 4'h3;
          werf = 1'h0;
          if (alu_output == 16'h0000 && sc_hold) begin
            M_game_state_d = CHECKHIGHSCORE_game_state;
          end else begin
            if (alu_output == 16'h0001 && sc_hold) begin
              M_game_state_d = MOD5A_game_state;
            end
          end
        end
        MOD5A_game_state: begin
          alufn = 6'h04;
          ra1sel = 2'h1;
          ra2sel = 4'h6;
          werf = 1'h1;
          wasel = 4'h2;
          if (sc_hold) begin
            M_game_state_d = MOD5B_game_state;
          end
        end
        MOD5B_game_state: begin
          alufn = 6'h33;
          ra1sel = 2'h2;
          ra2sel = 4'h4;
          werf = 1'h0;
          if (alu_output == 16'h0000 && sc_hold) begin
            M_game_state_d = MOD7A_game_state;
          end else begin
            if (alu_output == 16'h0001 && sc_hold) begin
              M_game_state_d = SHLDPRESS_game_state;
            end
          end
        end
        MOD7A_game_state: begin
          alufn = 6'h04;
          ra1sel = 2'h1;
          ra2sel = 4'h7;
          werf = 1'h1;
          wasel = 4'h2;
          if (sc_hold) begin
            M_game_state_d = MOD7B_game_state;
          end
        end
        MOD7B_game_state: begin
          alufn = 6'h33;
          ra1sel = 2'h2;
          ra2sel = 4'h4;
          werf = 1'h0;
          if (alu_output == 16'h0000 && sc_hold) begin
            M_game_state_d = MOD10_5A_game_state;
          end else begin
            if (alu_output == 16'h0001 && sc_hold) begin
              M_game_state_d = SHLDPRESS_game_state;
            end
          end
        end
        MOD10_5A_game_state: begin
          alufn = 6'h04;
          ra1sel = 2'h1;
          ra2sel = 4'h8;
          werf = 1'h1;
          wasel = 4'h2;
          if (sc_hold) begin
            M_game_state_d = MOD10_5B_game_state;
          end
        end
        MOD10_5B_game_state: begin
          alufn = 6'h33;
          ra1sel = 2'h2;
          ra2sel = 4'h6;
          werf = 1'h0;
          if (alu_output == 16'h0000 && sc_hold) begin
            M_game_state_d = MOD10_7A_game_state;
          end else begin
            if (alu_output == 16'h0001 && sc_hold) begin
              M_game_state_d = SHLDPRESS_game_state;
            end
          end
        end
        MOD10_7A_game_state: begin
          alufn = 6'h04;
          ra1sel = 2'h1;
          ra2sel = 4'h8;
          werf = 1'h1;
          wasel = 4'h2;
          if (sc_hold) begin
            M_game_state_d = MOD10_7B_game_state;
          end
        end
        MOD10_7B_game_state: begin
          alufn = 6'h33;
          ra1sel = 2'h2;
          ra2sel = 4'h7;
          werf = 1'h0;
          if (alu_output == 16'h0000 && sc_hold) begin
            M_game_state_d = SHLDNOTPRESS_game_state;
          end else begin
            if (alu_output == 16'h0001 && sc_hold) begin
              M_game_state_d = SHLDPRESS_game_state;
            end
          end
        end
        SHLDPRESS_game_state: begin
          if (pressed) begin
            M_game_state_d = ADDSCORE_game_state;
          end
          alufn = 6'h37;
          ra1sel = 2'h1;
          ra2sel = 4'h1;
          werf = 1'h0;
          if (alu_output == 16'h0000 && sc_hold) begin
            M_game_state_d = MINUSSTREAK_game_state;
          end
        end
        SHLDNOTPRESS_game_state: begin
          if (pressed) begin
            M_game_state_d = MINUSSTREAK_game_state;
          end
          alufn = 6'h37;
          ra1sel = 2'h1;
          ra2sel = 4'h1;
          werf = 1'h0;
          if (alu_output == 16'h0000 && sc_hold) begin
            increment_old_counter = 1'h1;
            M_game_state_d = CHECKEND_game_state;
          end
        end
        ADDSCORE_game_state: begin
          alufn = 6'h00;
          ra1sel = 2'h0;
          ra2sel = 4'h0;
          werf = 1'h1;
          wasel = 4'h0;
          M_game_state_d = CHECKSTREAK_game_state;
        end
        CHECKSTREAK_game_state: begin
          alufn = 6'h35;
          ra1sel = 2'h3;
          if (easy_mode) begin
            ra2sel = 4'h6;
          end else begin
            ra2sel = 4'h7;
          end
          werf = 1'h0;
          if (alu_output == 16'h0000 && sc_hold) begin
            M_game_state_d = WAIT_game_state;
          end else begin
            if (alu_output == 16'h0001 && sc_hold) begin
              M_game_state_d = ADDSTREAK_game_state;
            end
          end
        end
        ADDSTREAK_game_state: begin
          alufn = 6'h00;
          ra1sel = 2'h3;
          ra2sel = 4'h5;
          werf = 1'h1;
          wasel = 4'h3;
          M_game_state_d = WAIT_game_state;
        end
        MINUSSTREAK_game_state: begin
          alufn = 6'h1c;
          ra2sel = 4'h5;
          werf = 1'h1;
          wasel = 4'h3;
          M_game_state_d = WAIT_game_state;
        end
        WAIT_game_state: begin
          alufn = 6'h37;
          ra1sel = 2'h1;
          ra2sel = 4'h1;
          werf = 1'h0;
          if (alu_output == 16'h0000 && sc_hold) begin
            increment_old_counter = 1'h1;
            M_game_state_d = CHECKEND_game_state;
          end
        end
        CHECKHIGHSCORE_game_state: begin
          mainSeg2_char = 4'hd;
          mainSeg1_char = 4'hb;
          mainSeg0_char = 4'he;
          alufn = 6'h37;
          ra1sel = 2'h0;
          ra2sel = 4'h2;
          werf = 1'h0;
          if (alu_output == 16'h0001) begin
            if (rise) begin
              M_game_state_d = NOHIGHSCHORE_game_state;
            end else begin
              mainSeg2_char = 4'hb;
              mainSeg1_char = 4'ha;
              mainSeg0_char = 4'hc;
            end
          end
          if (alu_output == 16'h0000) begin
            if (rise) begin
              M_counter_state_d = IDLE_counter_state;
              M_game_state_d = UPDATEHS_game_state;
            end else begin
              mainSeg2_char = 4'hc;
              mainSeg1_char = 4'ha;
              mainSeg0_char = 4'hc;
            end
          end
        end
        NOHIGHSCHORE_game_state: begin
          quotient = player_score / 4'ha;
          M_oneMain_d = player_score - (4'ha * quotient);
          tempPS10 = player_score / 4'ha;
          quotientPS10 = tempPS10 / 4'ha;
          M_tenMain_d = tempPS10 - (4'ha * quotientPS10);
          M_hundredMain_d = 4'hf;
        end
        UPDATEHS_game_state: begin
          update_hs = 1'h1;
          quotient = player_score / 4'ha;
          M_oneMain_d = player_score - (4'ha * quotient);
          tempPS10 = player_score / 4'ha;
          quotientPS10 = tempPS10 / 4'ha;
          M_tenMain_d = tempPS10 - (4'ha * quotientPS10);
          M_hundredMain_d = 4'hf;
        end
      endcase
    end
  end
  
  always @(posedge clk) begin
    M_game_state_q <= M_game_state_d;
  end
  
  
  always @(posedge clk) begin
    M_counter_state_q <= M_counter_state_d;
  end
  
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_oneMain_q <= 1'h0;
      M_tenMain_q <= 1'h0;
      M_hundredMain_q <= 1'h0;
    end else begin
      M_oneMain_q <= M_oneMain_d;
      M_tenMain_q <= M_tenMain_d;
      M_hundredMain_q <= M_hundredMain_d;
    end
  end
  
endmodule
