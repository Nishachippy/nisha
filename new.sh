#!/bin/bash
usage=$(uptime | cut -d "," -f4 | sed -e "s/\.//g")
threshold=100
echo usage=$usage
while [ 1 ]
do
if [ $usage -gt $threshold ]
then
echo PID  %CPU  COMMAND
echo $(ps -eo pid -eo pcpu -eo cmd | sort -k 2 rn | head -n 1)
echo usage greater than threshold
echo "kill the above process y or n"
read opt
if [ $opt = "y" ]
then
sudo kill -9 $(ps -eo pid -eo pcpu | grep -v %cpu | sort -k 2 rn | head -n 1 | cut -d "" -f2)                
fi
fi
sleep 60
done
