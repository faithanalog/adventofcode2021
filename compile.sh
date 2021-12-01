#!/bin/bash

echo "----------------------------------"
echo "   Doors CS Assembler/Compiler"
echo "          Version 2.0L"
echo "     Written by Kerm Martian"
echo "     http://www.Cemetech.net"
echo "----------------------------------"
echo "----- Assembling $1 for the TI-83/84 Plus..."

mkdir exec &> /dev/null
mkdir list &> /dev/null

echo "#define TI83P" >tasm/zztemp.asm
echo ".binarymode TI8X" >>tasm/zztemp.asm

output=$1
output=${output%%.*}.8xp;
if [ -e source/$1.asm ]
then
	cat source/$1.asm >>tasm/zztemp.asm
elif [ -e source/$1.z80 ]
then
	cat source/$1.z80 >>tasm/zztemp.asm
elif [ -e source/$1 ]
then
	cat source/$1 >>tasm/zztemp.asm
else
	echo "source/$1.asm, source/$1.z80, and source/$1 could be found."
	exit 1
fi
if [ -z `which mono` ];
then
	echo "----- Mono is not installed! Install the mono-runtime package."
	exit 1
fi
rm -f "exec/$1.bin"
mono tasm/Brass.exe "tasm/zztemp.asm" "exec/$output" -l "list/$1.list.html"
if [ -f "exec/$output" ];
then
	echo ----- $1 for the TI-83/84 Plus Assembled and Compiled.
	echo TI-83 Plus version is $1.8xp
else
	echo "----- There were errors."
fi
rm -f tasm/zztemp.asm
