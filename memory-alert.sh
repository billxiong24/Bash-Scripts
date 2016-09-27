#!/bin/bash

#### This script alerts when low on RAM, and subsequently low on swap memory.
#sends warning email with info in attachment. 
#Units are in MB
ALERT_RAM=500
ALERT_SWAP=1000
RAM_MESSAGE="You are low on RAM. See attachment for details."
SWAP_MESSAGE="Low swap memory. Check for memory leaks. See attachment for details."

while [ true ]; do
    free_RAM=$(free -m | awk 'NR==2 {print $4}')
    free_swap=$(free -m | awk 'NR==3 {printf $4}')
    
    if [ $free_RAM -lt $ALERT_RAM ]; then
        free -m > mem.txt
        echo $RAM_MESSAGE | mutt -s "LOW RAM" -a mem.txt -- billx0477@gmail.com   
    fi

    #hopefully this never happens
    if [ $free_swap -lt $ALERT_SWAP ]; then
        free -m > mem.txt
        echo $SWAP_MESSAGE | mutt -s "LOW SWAP MEMORY" -a mem.txt -- billx0477@gmail.com
    fi

    sleep 30s
done