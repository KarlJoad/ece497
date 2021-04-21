#!/usr/bin/env bash

set -ex

# Dependencies for building verilator from source
sudo apt install autoconf automake

# install verilator
git clone http://git.veripool.org/git/verilator
cd verilator
git checkout v4.034
autoconf && ./configure && make -j$(nproc) && sudo make install
