/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module alu_4 (
    input [15:0] a,
    input [15:0] b,
    input [5:0] alufn,
    output reg [15:0] f,
    output reg [2:0] error,
    output reg overflow
  );
  
  
  
  wire [16-1:0] M_addMod_sum;
  wire [3-1:0] M_addMod_error;
  wire [1-1:0] M_addMod_z;
  wire [1-1:0] M_addMod_v;
  wire [1-1:0] M_addMod_n;
  reg [16-1:0] M_addMod_a;
  reg [16-1:0] M_addMod_b;
  reg [6-1:0] M_addMod_alufn;
  add_8 addMod (
    .a(M_addMod_a),
    .b(M_addMod_b),
    .alufn(M_addMod_alufn),
    .sum(M_addMod_sum),
    .error(M_addMod_error),
    .z(M_addMod_z),
    .v(M_addMod_v),
    .n(M_addMod_n)
  );
  
  wire [16-1:0] M_booleMod_o;
  wire [3-1:0] M_booleMod_error;
  reg [16-1:0] M_booleMod_a;
  reg [16-1:0] M_booleMod_b;
  reg [6-1:0] M_booleMod_alufn;
  boole_9 booleMod (
    .a(M_booleMod_a),
    .b(M_booleMod_b),
    .alufn(M_booleMod_alufn),
    .o(M_booleMod_o),
    .error(M_booleMod_error)
  );
  
  wire [16-1:0] M_shiftMod_o;
  wire [3-1:0] M_shiftMod_error;
  reg [16-1:0] M_shiftMod_a;
  reg [16-1:0] M_shiftMod_b;
  reg [6-1:0] M_shiftMod_alufn;
  shift_10 shiftMod (
    .a(M_shiftMod_a),
    .b(M_shiftMod_b),
    .alufn(M_shiftMod_alufn),
    .o(M_shiftMod_o),
    .error(M_shiftMod_error)
  );
  
  wire [1-1:0] M_cmpMod_o;
  wire [3-1:0] M_cmpMod_error;
  reg [6-1:0] M_cmpMod_alufn;
  reg [1-1:0] M_cmpMod_z;
  reg [1-1:0] M_cmpMod_v;
  reg [1-1:0] M_cmpMod_n;
  cmp_11 cmpMod (
    .alufn(M_cmpMod_alufn),
    .z(M_cmpMod_z),
    .v(M_cmpMod_v),
    .n(M_cmpMod_n),
    .o(M_cmpMod_o),
    .error(M_cmpMod_error)
  );
  
  wire [16-1:0] M_muldivMod_o;
  wire [3-1:0] M_muldivMod_error;
  wire [1-1:0] M_muldivMod_overflow;
  reg [16-1:0] M_muldivMod_a;
  reg [16-1:0] M_muldivMod_b;
  reg [6-1:0] M_muldivMod_alufn;
  muldiv_12 muldivMod (
    .a(M_muldivMod_a),
    .b(M_muldivMod_b),
    .alufn(M_muldivMod_alufn),
    .o(M_muldivMod_o),
    .error(M_muldivMod_error),
    .overflow(M_muldivMod_overflow)
  );
  
  always @* begin
    M_addMod_a = a;
    M_addMod_b = b;
    M_addMod_alufn = alufn;
    M_booleMod_a = a;
    M_booleMod_b = b;
    M_booleMod_alufn = alufn;
    M_shiftMod_a = a;
    M_shiftMod_b = b;
    M_shiftMod_alufn = alufn;
    M_cmpMod_z = M_addMod_z;
    M_cmpMod_v = M_addMod_v;
    M_cmpMod_n = M_addMod_n;
    M_cmpMod_alufn = alufn;
    M_muldivMod_a = a;
    M_muldivMod_b = b;
    M_muldivMod_alufn = alufn;
    f = 1'h0;
    error = 1'h0;
    overflow = 1'h0;
    
    case (alufn[4+1-:2])
      2'h0: begin
        if (alufn[1+0-:1] == 1'h0) begin
          f = M_addMod_sum;
          overflow = M_addMod_v;
          error = M_addMod_error;
        end else begin
          if (alufn[1+0-:1] == 1'h1) begin
            f = M_muldivMod_o;
            overflow = M_muldivMod_overflow;
            error = M_muldivMod_error;
          end
        end
      end
      2'h1: begin
        f = M_booleMod_o;
        error = M_booleMod_error;
      end
      2'h2: begin
        f = M_shiftMod_o;
        error = M_shiftMod_error;
      end
      2'h3: begin
        f = M_cmpMod_o;
        error = M_cmpMod_error;
      end
    endcase
  end
endmodule
