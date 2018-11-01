#a bash script used for gdb debug(inside vim)
#!/bin/bash
breakpoint=()
display=(
)
line=(
)
afterProI=(r)
filename=""

rm -rf "GDB_$filename"
gcc -g "$filename.c" -o "GDB_$filename"

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
command=$command"run < input\n"

j=0
while [ $j -lt ${#display[@]} ];do
	command=$command"display ${display[$j]}\n"
	((j++))
done

for i in ${afterProI[@]};do
	command=$command"$afterProI\n"
done

#echo "$command"
#echo -e "$command" > command
(echo -e "$command" && cat)|gdb "GDB_$filename"
rm -f input
