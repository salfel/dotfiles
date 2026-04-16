#! /usr/bin/env bash

ln -sf build/compile_commands.json .
mkdir -p build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON 
cmake --build .
