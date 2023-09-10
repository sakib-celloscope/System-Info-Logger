#!/bin/sh

#System Info Logger
#System Info Logger is a shell script that automates the process of gathering essential system information, including RAM usage, available storage, and OS details. It logs this data into a file and sends it via email, providing daily insights into your system's health and status.

#Printing the Script Name
echo "Script Name: ${0}"

#Specification variables
TOTAL_RAM=`free -mt | grep "Total" | awk '{print $2}'`
FREE_RAM_SPACE=`free -mt | grep "Total" | awk '{print $4}'`
USED_RAM_SPACE=`free -mt | grep "Total" | awk '{print $3}'`


echo "Total Ram Size: ${TOTAL_RAM} MB"
echo "Total Free Space: ${FREE_RAM_SPACE} MB"
echo "Total Used Space: ${USED_RAM_SPACE} MB"


