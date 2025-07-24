module ctranif1(b, d, g, s);  // NMOS
    supply1 vdd;
    supply0 vss;

    input b, g;
  
    inout d, s;

    tranif1 n1(d, s, g);
endmodule

module ctranif0(b, s, g, d);  // PMOS
    supply1 vdd;
    supply0 vss;
  
    input b, g;
  
    inout s, d;

    tranif0 p1(s, d, g);

endmodule
