#! /usr/bin/bash

echo "compiling"

g++ negotiation_tool.cpp -o negotiation_tool.exe

echo "done, waiting for keypress"

read keypress

echo "random data example"

./negotiation_tool.exe < input_negotiation_tool.csv > output_negotiation_tool.json

echo "woodscapes employment example"

./negotiation_tool.exe < input_woodscapes_employment.txt > output_woodscapes_employment.json

echo "cabinet ministers example"

./negotiation_tool.exe < input_cabinet_ministers.txt > output_cabinet_ministers.json

echo "done, waiting for keypress"

read keypress
