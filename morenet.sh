 #host name, essid, frequency of wlan/wlp3s0, bitrate, tx-power, signal level, 

 host=$(hostname)
 essid=$(iwconfig wlp3s0 | awk '/ESSID:/ {print $4}' | cut -f2 -d ':' | tr -d '"')
 frequency=$(iwconfig wlp3s0 | awk '/Frequency:/ {print $2 " " $3}' | cut -f2 -d ':')
 bitrate=$(iwconfig wlp3s0 | awk '/Rate=/ {print $2 " " $3}' | cut -f2 -d '=')
 txpower=$(iwconfig wlp3s0 | awk '/Tx-Power=/ {print $4 " " $5}' | cut -f2 -d '=')
 linkquality=$(iwconfig wlp3s0 | awk '/Link Quality/ {print $1 " " $2}' | cut -f2 -d '=')
 signal_level=$(iwconfig wlp3s0 | awk '/Signal level/ {print $3 " " $4 " " $5}' | cut -f2 -d '=')
 retries=$(iwconfig wlp3s0 | awk '/Tx excessive/ {print $1 " " $2 " " $3}' | cut -f2 -d ':')
 MAC=$(iwconfig wlp3s0 | awk '/Access Point/ {print $4 " " $5 " " $6}' | cut -f3 -d ' ')
 
 
 #sort in descending orders
 (echo ESSID: $essid
 echo Hostname:  $host
 echo Frequency:  $frequency
 echo Bit Rate:  $bitrate
 echo Tx-Power:  $txpower
 echo Link Quality:  $linkquality
 echo Signal Level:  $signal_level
 echo Tx Excessive Retries:  $retries
 echo MAC Address: $MAC) | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2-
 
#Hostname: billxiong24-Lenovo-Z580
#Tx Excessive Retries: 1
#Signal Level: -39 dBm
#Frequency: 2.437 GHz
#Link Quality: 70/70
#Bit Rate: 117 Mb/s
#Tx-Power: 15 dBm
#ESSID: alix
