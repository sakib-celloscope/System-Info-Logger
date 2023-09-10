#!/bin/sh

#System Info Logger
#System Info Logger is a shell script that automates the process of gathering essential system information, including RAM usage, available storage, and OS details. It logs this data into a file and sends it via email, providing daily insights into your system's health and status.

#Printing the Script Name
echo -e "Script Name: ${0}\n"

#RAM: Displays information of RAM
RAM(){
    TOTAL_RAM=`free -mt | grep "Total" | awk '{print $2}'`
    FREE_RAM_SPACE=`free -mt | grep "Total" | awk '{print $4}'`
    USED_RAM_SPACE=`free -mt | grep "Total" | awk '{print $3}'`


    echo "Total Ram Size: ${TOTAL_RAM} MB"
    echo "Total Free Space: ${FREE_RAM_SPACE} MB"
    echo -e "Total Used Space: ${USED_RAM_SPACE} MB\n"
}

#STORAGE: Displays information of Storage
STORAGE(){
    TOTAL_STORAGE_SPACE=`df -mT | grep "ext4" | awk '{print $3}'`
    AVAILABLE_STORAGE_SPACE=`df -mT | grep "ext4" | awk '{print $5}'`
    USED_STORAGE_SPACE=`df -mT | grep "ext4" | awk '{print $4}'`

    echo "Total Storage Size: ${TOTAL_STORAGE_SPACE} MB"
    echo "Total Available Storage: ${AVAILABLE_STORAGE_SPACE} MB"
    echo -e "Total Used Storage: ${USED_STORAGE_SPACE} MB\n"
}

#Calling Functions To Display Informations
RAM
STORAGE

