#!/bin/bash

# A script for checking Linux CLI NOIA node data, status and statistics 
# Version 190923-1

# Fetch log messages to temporary files
tac /var/log/syslog |grep -m 1 "changed bandwidth" > tnn.log
tac /var/log/syslog |grep -m 1 "Received statistics" > tno.log

# Define variables
logDate=`cat tnn.log |cut -c 1-15`
logDay=`cat tnn.log |cut -c 1-15 |cut -f 2 -d " " | sed 's/^0*//'`
logHour=`cat tnn.log |cut -c 1-15 |cut -f 3 -d " " |cut -f 1 -d ":" | sed 's/^0*//'`
logMinute=`cat tnn.log |cut -c 1-15 |cut -f 3 -d " " |cut -f 2 -d ":" | sed 's/^0*//'`
curDay=`date '+%d' | sed 's/^0*//'`
curHour=`date '+%H' | sed 's/^0*//'`
curMinute=`date '+%M' | sed 's/^0*//'`
nodeName=`cat tnn.log |cut -f 4 -d " "`
nodeIp=`cat tnn.log |cut -f 6 -d "=" |cut -f 1 -d ","`
airDrop=`grep airdropAddress .noia-node/node.settings |cut -f 2 -d "="`
storeDir=`grep dir= .noia-node/node.settings |cut -f 2 -d "="`
storeSize=`grep size= .noia-node/node.settings |cut -f 2 -d "="`
ispName=` cat tnn.log |cut -f 9 -d "=" |cut -f 1 -d ","`
cityName=` cat tnn.log |cut -f 18 -d "=" |cut -f 1 -d ","`
countryName=` cat tnn.log |cut -f 19 -d "=" |cut -f 1 -d ","`
testHost=`cat tnn.log |cut -f 15 -d "=" |cut -f 1 -d "," |cut -f 1 -d ":"`
upTime=`cat /var/log/syslog |grep -c "changed bandwidth"`
downLoad=`cat tnn.log |cut -f 2 -d "=" |cut -f 1 -d "," |cut -f 1 -d "."`
upLoad=`cat tnn.log |cut -f 3 -d "=" |cut -f 1 -d "," |cut -f 1 -d "."`
pingTime=`cat tnn.log |cut -f 24 -d "=" |cut -f 1 -d "," |cut -f 1 -d "."`
upTotal=`cat tno.log |cut -f 3 -d "," |cut -f 4 -d " "`
upDays=$(( $upTotal / 24 ))
upHours=$(($upTotal % 24 ))
downBytes=`cat tno.log |cut -f 2 -d "=" |cut -f 1 -d ","`
upBytes=`cat tno.log |cut -f 3 -d "=" |cut -f 1 -d ","`
downGbytes=$(( $downBytes / 1073741824 ))
upGbytes=$(( $upBytes / 1073741824 ))
downMbytes=$(( $downBytes / 1048567 ))
upMbytes=$(( $upBytes / 1048567 ))
downKbytes=$(( $downBytes / 1024 ))
upKbytes=$(( $upBytes / 1024 ))
storeGbytes=$(( $storeSize / 1073741824 ))
storeMbytes=$(( $storeSize / 1048567 ))
storeKbytes=$(( $storeSize / 1024 ))

# Define color names
noColor='\033[0m'
green='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
blue='\033[0;34m'

# Calculate log age
upDiff=$(($curHour-$upTime))
curHourMin=$(( $curHour * 60 ))
curHourMin=$(( $curHourMin + $curMinute ))
logHourMin=$(( $logHour * 60 ))
logHourMin=$(( $logHourMin + $logMinute ))
logAge=$(( $curHourMin - $logHourMin ))

# Define value based colors
uptimeColor=$yellow
if [ "$upDiff" -ge "3" ]; then
  uptimeColor=$red
fi
if [ "$upDiff" -le "1" ]; then
  uptimeColor=$green
fi

if [ "$logAge" -le "0" ]; then
logAge=$(($logAge + 60))
fi
if [ "$storeSize" -ge "1073741824" ]; then
  storeColor=$green
else
  storeColor=$red
fi
if [ "$logAge" -le "60" ]; then
  dateColor=$green
else
  dateColor=$red
fi
downColor=$yellow
if [ "$downLoad" -ge "70" ]; then
  downColor=$green
fi
if [ "$downLoad" -le "20" ]; then
  downColor=$red
fi
upColor=$yellow
if [ "$upLoad" -ge "70" ]; then
  upColor=$green
fi
if [ "$upLoad" -le "20" ]; then
  upColor=$red
fi

pingColor=$yellow
if [ "$pingTime" -ge "70" ]; then
  pingColor=$red
fi
if [ "$pingTime" -le "30" ]; then
  pingColor=$green
fi

downLoaded=$downGbytes
downUnit="GB"
if [ "$downGbytes" = "0" ]; then
  downLoaded=$downMbytes
  downUnit="MB"
fi
if [ "$downMbytes" = "0" ]; then
  downLoaded=$downKbytes
  downUnit="kB"
fi
if [ "$downKbytes" = "0" ]; then
  downLoaded=$downBytes
  downUnit="bytes"
fi
upLoaded=$upGbytes
upUnit="GB"
if [ "$upGbytes" = "0" ]; then
  upLoaded=$upMbytes
  upUnit="MB"
fi
if [ "$upMbytes" = "0" ]; then
  upLoaded=$upKbytes
  downUnit="kB"
fi
if [ "$upKbytes" = "0" ]; then
  upLoaded=$upBytes
  upUnit="bytes"
fi
storage=$storeGbytes
storeUnit="GB"
if [ "$storeGbytes" = "0" ]; then
  storage=$storeMbytes
  storeUnit="MB"
fi
if [ "$storeMbytes" = "0" ]; then
  storage=$storeKbytes
  downUnit="kB"
fi
if [ "$storeKbytes" = "0" ]; then
  storage=$storeBytes
  storeUnit="bytes"
fi

# Print results
clear
echo

# If node verified OK, print fetched data, else print exception messages
if [ "$logAge" != "" ]; then
  headColor=$blue
  printf "${headColor}-------------------------------------------------------------------\n"
  printf "${headColor}NOIA node data, status and statistics"
  echo ' - '$logDate
  printf "${headColor}-------------------------------------------------------------------${noColor}\n"
  echo
  printf '%-25s' 'Node name'
  echo $nodeName
  printf '%-25s' 'External IP address'
  echo $nodeIp
  printf '%-25s' 'Beneficiary address'
  echo $airDrop
  printf '%-25s' 'System location'
  echo $cityName', '$countryName
  printf '%-25s' 'Storage directory'
  echo $storeDir
  printf '%-25s' 'Storage size'
  printf "${storeColor}$storage"
  printf "${storeColor} $storeUnit${noColor}\n"
  printf '%-25s' 'Uptime today'
  printf "${uptimeColor}$upTime"
  printf "${uptimeColor} hours${noColor}\n"
  printf '%-25s' 'Status checked OK'
  printf "${dateColor}$logAge"
  printf "${dateColor} min ago${noColor}\n"
  printf '%-25s' 'Test server address'
  echo $testHost
  printf '%-25s' 'Measured download speed'
  printf "${downColor}$downLoad"
  printf "${downColor} Mb/s${noColor}\n"
  printf '%-25s' 'Measured upload speed'
  printf "${upColor}$upLoad"
  printf "${upColor} Mb/s${noColor}\n"
  printf '%-25s' 'Network ping time'
  printf "${pingColor}$pingTime"
  printf "${pingColor} ms${noColor}\n"
  printf '%-25s' 'Cumulative uptime'
  echo $upDays' days '$upHours' hours'
  printf '%-25s' 'Total downloaded'
  echo $downLoaded' '$downUnit
  printf '%-25s' 'Total uploaded'
  echo $upLoaded' '$upUnit
  echo
  echo '(Legend: Green: OK/Good, Yellow: Acceptable, Red: Not OK/Poor)'
  echo
else
  echo
  echo "The node is down or not verified yet. (Can take up to 1 h)"
  echo
  portChk=`timeout 1s telnet $nodeIp 8048 |grep Connected |cut -f 1 -d " "`
  if [ "$portChk" = "Connected" ]; then
    echo "Port 8048 tested OK"
  else
    clear
    echo
    echo "The node is down for TCP port 8048 being blocked!"
  fi
  echo
fi

# Remove the temporary files
rm tn?.log
