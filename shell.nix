{ pkgs ? import <nixpkgs> {} }:

with pkgs.lib;

let
  texPaths = [
    "."
    ./.
    ./weekly_report
    ./ece_day
    ./tutorials
    "$TEXINPUTS"
  ];

in pkgs.mkShell {
  buildInputs = with pkgs; [
    verilog   # Icarus Verilog compiler
    svlint    # SystemVerilog Linter
    svls      # SystemVerilog Language Server
    verilator # (System)Verilog Simulator/Compiler

    # ChipYard Dependencies
    bison
    flex
    gnum4 expect
    gmp mpfr libmpc zlib
    vim git jdk
    texinfo gengetopt
    expat libusb ncurses cmake
    perl perlPackages.ExtUtilsMakeMaker
    # Deps for poky
    python36 patch diffstat texinfo subversion chrpath git wget
    # Deps for qemu
    gtk3
    # Deps for firemarshall
    python36 python36Packages.pip
    rsync libguestfs texinfo expat ctags
    # Install dtc
    dtc

    # keep this line if you use bash
    bashInteractive
  ];

  shellHook = ''
    export TEXINPUTS=${concatStringsSep ":" texPaths}
  '';
}
