#a bash script used for gdb debug(inside vim)
#!/bin/bash
rm -rf GDB_DataStru
gcc -g DataStru.c -o GDB_DataStru
breakpoint=(69)
display=(
"pi->pow"
"pj->pow"
"key->pow"
"head0->pow"
"tail0->pow"
"head1->pow"
"head1->next->pow"
"head1->next->next->pow"
"head1->next->next->next->pow"
"tail1->pow"
"tail1->prior->pow"
"tail1->prior->prior->pow"
"tail1->prior->prior->prior->pow"
)
line=(
2 1 3 3 4 5 0 0 
3 3 2 5 3 4 0 0
)
afterProI=(n)
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
(echo -e "$command" && cat)|gdb GDB_DataStru
rm -f input
