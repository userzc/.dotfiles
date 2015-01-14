#!/bin/zsh

if [[ $# == 0 ]]; then
    infile="examples.desktop"
else
    infile=$1
fi

TRAPINT() {
    echo "\nExiting from keyboard"
    echo "Last completely executed line: " $(( i - 1 ))
    [ -f last_executed_line.lock ] && rm last_executed_line.lock
    echo ${i} >> last_executed_line.lock
    echo ${infile} >> last_executed_line.lock
    exit
}

last_line=1
if [[ -f last_executed_line.lock ]];
then
    exec 4< last_executed_line.lock
    read <& 4 last_line
    read <& 4 input_file
else
    echo "Starting from the beginning"
fi

exec 3< $infile

for (( i=1; i < last_line; i++ )) do
    read <& 3 myline
done

until [ $done ]
do
    read <& 3 myline
    if [ $? != 0 ]; then
        done=1
        continue
    fi
    echo "line ${i}:" $myline "|*- endl -*|"
    sleep 0.1
    (( i++ ))
done
