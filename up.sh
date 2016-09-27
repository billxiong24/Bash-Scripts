#!/bin/bash
#remember to run with source command
[[ "$#" -eq 0 ]] && { echo "Enter a number."; exit 1; }
num="$1"
digitcheck='^[0-9]+$'
[[ ! $num =~ $digitcheck ]] && { echo "Number not valid."; exit 1; }
path="$PWD"
for i in $(seq 1 $num); do
path=$path/..
done
cd $path


 
