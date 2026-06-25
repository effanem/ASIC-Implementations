/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : V-2023.12-SP4
// Date      : Sun Jan 18 23:37:21 2026
/////////////////////////////////////////////////////////////


module pri_enc8 ( clk, rst, req, code, valid );
  input [7:0] req;
  output [2:0] code;
  input clk, rst;
  output valid;
  wire   N50, N51, N52, N53, n1, n2, n3, n4, n5, n6, n7, n8;

  SAEDLVT14_FDP_V2_0P5 \code_reg[2]  ( .D(N52), .CK(clk), .Q(code[2]) );
  SAEDLVT14_FDP_V2_0P5 \code_reg[1]  ( .D(N51), .CK(clk), .Q(code[1]) );
  SAEDLVT14_FDP_V2_0P5 \code_reg[0]  ( .D(N50), .CK(clk), .Q(code[0]) );
  SAEDLVT14_FDP_V2_0P5 valid_reg ( .D(N53), .CK(clk), .Q(valid) );
  SAEDLVT14_INV_1 U15 ( .A(n4), .X(n1) );
  SAEDLVT14_OR4_1 U16 ( .A1(req[5]), .A2(req[4]), .A3(req[7]), .A4(req[6]), 
        .X(n4) );
  SAEDLVT14_AOI21_0P5 U17 ( .A1(n1), .A2(req[3]), .B(req[7]), .X(n7) );
  SAEDLVT14_AOI21_0P5 U18 ( .A1(n8), .A2(n7), .B(rst), .X(N50) );
  SAEDLVT14_OA32_U_0P5 U19 ( .A1(req[2]), .A2(n4), .A3(n3), .B1(req[6]), .B2(
        n2), .X(n8) );
  SAEDLVT14_INV_1 U20 ( .A(req[5]), .X(n2) );
  SAEDLVT14_INV_1 U21 ( .A(req[1]), .X(n3) );
  SAEDLVT14_AOI21_0P5 U22 ( .A1(n6), .A2(n7), .B(rst), .X(N51) );
  SAEDLVT14_AOI21_0P5 U23 ( .A1(req[2]), .A2(n1), .B(req[6]), .X(n6) );
  SAEDLVT14_OA21B_1 U24 ( .A1(n4), .A2(n5), .B(rst), .X(N53) );
  SAEDLVT14_OR4_1 U25 ( .A1(req[1]), .A2(req[0]), .A3(req[3]), .A4(req[2]), 
        .X(n5) );
  SAEDLVT14_NR2_MM_1 U26 ( .A1(rst), .A2(n1), .X(N52) );
endmodule

