#!/bin/bash
cd ~/Halide
sed -i '1i\#define _CODEGEN_HETEROCL_GENERATE_' /curr/jiajieli/Halide/src/Lower.cpp # add '#define _CODEGEN_HETEROCL_GENERATE_' to the file 'Lower.cpp'
export LLVM_CONFIG=~/llvm8.0/build/bin/llvm-config
make bin/libHalide.so -j50
cd ~/new/stencil_chain
export HL_DEBUG_CODEGEN=0
g++ stencil_chain.cpp -g -std=c++11 -I /curr/jiajieli/Halide/include -I /curr/jiajieli/Halide/tools -L /curr/jiajieli/Halide/bin -lHalide `libpng-config --cflags --ldflags` -ljpeg -lpthread -ldl -o stencil_chain
LD_LIBRARY_PATH=/curr/jiajieli/Halide/bin /curr/jiajieli/new/stencil_chain/stencil_chain
sed -i '/#define _CODEGEN_HETEROCL_GENERATE_/d' /curr/jiajieli/Halide/src/Lower.cpp # delete '#define _CODEGEN_HETEROCL_GENERATE' in the file 'Lower.cpp'
cd ~/Halide
export LLVM_CONFIG=~/llvm8.0/build/bin/llvm-config
make bin/libHalide.so -j50