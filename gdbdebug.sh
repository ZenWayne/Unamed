#a bash script used for gdb debug(inside vim)
#!/bin/bash
filename="oj1164"
run=0
breakpoint=(52)
#variables need to watch
display=(
"vara"
"varb"
)                              
# program input 
line=(
"programinput"
)

afterProI=(
"set pagination off"
)

afterProI=(r)

rm -rf "GDB_$filename"
g++ -g "$filename.cpp" -o "GDB_$filename"

command="\n"
for i in ${breakpoint[@]};do
	command=$command"b $i\n"
done

i=0
programinput=""
while [ $i -lt ${#line[@]} ];do
	programinput=$programinput"${line[$i]}\n"
	((i++))
done
echo -e $programinput > input
command=$command"run < input\n\n"

i=0
while [ $i -lt ${#display[@]} ];do
	command=$command"display ${display[$i]}\n"
	((i++))
done

i=0
while [ $i -lt ${#afterProI[@]} ];do
	command=$command"${afterProI[$i]}\n"
	((i++))
done

if [ $run -eq 1 ]; then
    rm -f "./run_$filename"
    gcc "$filename.c" -o "run_$filename"
    "./run_$filename" < input
    #rm -f input "./run_$filename"
else
    echo "$command"
    rm -rf "GDB_$filename"
    gcc -g "$filename.c" -o "GDB_$filename"
    (echo -e "$command" && cat)|gdb "GDB_$filename"
    rm -rf "GDB_$filename"
fi
