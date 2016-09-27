#!/bin/bash

#generates prime numbers from 2 until argument specified
[[ "$#" -lt 1 || "$#" -gt 2 ]] && { echo "Wrong number of arguments."; exit; }
lim=$1

function is_prime(){
    nums=( $(factor "$1" | cut -f2 -d ":") )

    if [ ${#nums[@]} -eq 1 ]; then #this means there is only 1 prime factor, so prime
        echo 0
    else
        echo 1
    fi 

}
function print(){ #if user does not pass in a file, print numbers to console
    for i in $(seq 3 $lim); do
        if [ $(is_prime $i) -eq 0 ]; then
            echo $i;
        fi
    done
}
function write(){ #if user passes in a file, write the numbers to that file
    for i in $(seq 3 $lim); do
        if [ $(is_prime $i) -eq 0 ]; then
            echo $i >> $1
        fi
    done
}

if [ "$#" -eq 2 ]; then
    write "$2"
else
    print
fi