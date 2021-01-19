{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    verilog   # Icarus Verilog compiler
    svlint    # SystemVerilog Linter
    svls      # SystemVerilog Language Server
    verilator # (System)Verilog Simulator/Compiler

    # keep this line if you use bash
    pkgs.bashInteractive
  ];
}
