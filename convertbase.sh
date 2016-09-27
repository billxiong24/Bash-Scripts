#!/bin/bash
#This program uses the command "bc" to convert bases
#ibase is the input base
#obase is the output base

#$1 is input number, $2 is base to convert to
#$1 must be in binary, hex, or dec. $2 can be any base. 


function is_number(){
    #the =~ expression evaluates right side as a regular expression
    #test if valid number(A-F is for hexidecimal)
    if [[ $1 =~ ^[0-9A-F]+$ ]]; then
        echo 0
    else
        echo 1
    fi
}
#use this function to check the base of $1 (bin, hex, or dec)
function find_base(){
    if [[ $1 =~ ^[0-1]+$ ]]; then
        echo 2
    elif [[ $1 =~ ^[0-9]+$ ]]; then
        echo 10
    elif [[ $1 =~ ^[0-9A-F]+$ ]]; then
        echo 16
    else
        exit 1
    fi
}
#Error checking
[[ "$#" -lt 1 ]] && { echo "Not enough arguments. Exiting..."; exit 1; }
for i in "$@"; do
    if [ $(is_number $i) -eq 1 ]; then
        echo "Invalid input. Exiting..."
        exit 1
    fi
done

num="$1"
inbase=$(find_base $num)

#default output base is 10.
outbase=
if [ "$#" -ge 2 ]; then
    outbase="$2";
else
    outbase=10
fi

num=$(echo $num | tr '[a-f]' '[A-F]')
#use bc command to convert the number to the appropriate base
echo "obase=$outbase; ibase=$inbase; $num" | bc
