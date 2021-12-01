@echo off
cls
echo ---------------------------------------------------------
echo               Doors CS Assembler/Compiler    
echo                       Version 2.0          
echo      Written by Christopher "Kerm Martian" Mitchell      
echo                 http://www.Cemetech.net      
echo ---------------------------------------------------------
echo ----- Assembling %1 for the TI-83/84 Plus...
echo #define TI83P >tasm\zztemp.asm
echo .binarymode TI8X >>tasm\zztemp.asm
set output=%~n1.8xp
set varname=%~n1
call :UpCase varname
echo .variablename %varname% >>tasm\zztemp.asm
if exist source\%1.asm (
	type source\%1.asm >>tasm\zztemp.asm
) else (
	if exist source\%1.z80 (
		type source\%1.z80 >>tasm\zztemp.asm
	) else (
		if exist source\%1 (
			type source\%1 >>tasm\zztemp.asm
		) else (
			echo ----- '%1', '%1.asm', and '%1.z80' not found!
			goto ERRORS
		)
	)
)
cd tasm
brass zztemp.asm ..\exec\%output% -l ..\list\%1.list.html
if errorlevel 1 goto ERRORS
cd..
rem cd exec
rem ..\tasm\binpac8x.py %1.bin
color 02
echo ----- %1 for the TI-83/84 Plus Assembled and Compiled.
color 07
echo TI-83 Plus version is %output%
goto DONE
:ERRORS
color 04
echo ----- There were errors.
color 07
rem cd..
:DONE
del tasm\zztemp.asm >nul
rem del %1.bin >nul
rem cd..
GOTO:EOF

:UpCase
:: Subroutine to convert a variable VALUE to all UPPER CASE.
:: The argument for this subroutine is the variable NAME.
FOR %%i IN ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") DO CALL SET "%1=%%%1:%%~i%%"
GOTO:EOF