#!/bin/bash

#FORMATTED NETWORK INFORMATION FOR WLAN

localip=$(ifconfig wlp3s0 | awk '/inet/ {print $2}' | head -1)
bcast=$(ifconfig wlp3s0 | awk '/Bcast:/ {print $3}')
mask=$(ifconfig wlp3s0 | awk '/[Mm]ask:/ {print $4}')
coll=$(ifconfig wlp3s0 | awk '/collisions/ {print $1}')

ipaddr=$(echo $localip | cut -f2 -d ':')
bcast=$(echo $bcast | cut -f2 -d ':')
mask=$(echo $mask | cut -f2 -d ':')
coll=$(echo $coll | cut -f2 -d ':')

echo "Local IP Addr: $ipaddr"
echo "Bcast Addr: $bcast"
echo "Mask: $mask"

#RX Packets and RX Bytes
ifconfig wlp3s0 | awk '/RX/ {print $1 " " $2}'

#TX Packets
ifconfig wlp3s0 | awk '/TX/ {print $1 " " $2}' | head -1

#TX Bytes- data doesn't line up incely, so need 2 commands
ifconfig wlp3s0 | awk '/TX/ {print $5 " " $6}' | tail -1

echo "Collisions: $coll"


