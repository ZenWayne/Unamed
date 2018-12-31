#a bash script used for gdb debug(inside vim)
#!/bin/bash
breakpoint=(396)
display=(
"i"
"j"
"visitedNum[i]"
"visitedNum[i]"
"visitedNumIndex"
"visitedNum[0]"
"visitedNum[1]"
"visitedNum[2]"
"Seqlist[i]->weight"
"Seqlist[index]->weight"
"Seqlist[0]->weight"
"Seqlist[1]->weight"
"Seqlist[2]->weight"
"Seqlist[3]->weight"
"Seqlist[4]->weight"
"index"
#"i->weight"
#"j->weight"
#"head->weight"
#"key->weight"
#"p->next->weight"
#"p->next->next->weight"
#"p->next->next->next->weight"
#"p->next->next->next->next->weight"
#"p->next->next->next->next->next->weight"
#"p->next->next->next->next->next->next->weight"
#"p->next->next->next->next->next->next->next->weight"
#"p->next->next->next->next->next>next->next->next->weight"
#"p->next->next->next->next->next->next>next>next->next->next->weight"
#"p->next->next->next->next->next->next>next>next->next->next->next->weight"
)                              
line=(
)
afterProI=(r)
filename="E03"

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
