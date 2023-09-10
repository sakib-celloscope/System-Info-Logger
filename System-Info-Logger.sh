#!/bin/sh

#System Info Logger
#System Info Logger is a shell script that automates the process of gathering essential system information, including RAM usage, available storage, and OS details. It logs this data into a file and sends it via email, providing daily insights into your system's health and status.

#Check Current Directory
CURRENT_DIRECTORY=`pwd`

#Checking Date in YYYY-MM-DD Format
CURRENT_DATE=`date +%F`

#Checking Current Time
CURRENT_TIME=`date +%T`

echo -e "Script Executed at ${CURRENT_TIME}\n"


#Printing the Script Name
echo -e "${0} Executed at ${CURRENT_TIME}\n" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log

#RAM: Displays information of RAM
RAM(){
    TOTAL_RAM=`free -mt | grep "Total" | awk '{print $2}'`
    FREE_RAM_SPACE=`free -mt | grep "Total" | awk '{print $4}'`
    USED_RAM_SPACE=`free -mt | grep "Total" | awk '{print $3}'`


    echo "Total Ram Size: ${TOTAL_RAM} MB" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
    echo "Total Free Space: ${FREE_RAM_SPACE} MB" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
    echo -e "Total Used Space: ${USED_RAM_SPACE} MB\n" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
}

#STORAGE: Displays information of Storage
STORAGE(){
    TOTAL_STORAGE_SPACE=`df -mT | grep "ext4" | awk '{print $3}'`
    AVAILABLE_STORAGE_SPACE=`df -mT | grep "ext4" | awk '{print $5}'`
    USED_STORAGE_SPACE=`df -mT | grep "ext4" | awk '{print $4}'`

    echo "Total Storage Size: ${TOTAL_STORAGE_SPACE} MB" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
    echo "Total Available Storage: ${AVAILABLE_STORAGE_SPACE} MB" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
    echo -e "Total Used Storage: ${USED_STORAGE_SPACE} MB\n" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
}

#OS: Displays information of OS and it's version
OS(){
    OS_NAME=`hostnamectl | grep "Operating System" | cut -d" " -f 3`
    OS_VERSION=`hostnamectl | grep "Operating System" | cut -d" " -f 4`

    echo "OS Name: ${OS_NAME}" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
    echo -e "OS Version: ${OS_VERSION}\n" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
}

#IP_ADDRESS: Displays IP address
IP_ADDRESS(){
    IP=`hostname -I`

    echo -e "IP Address: ${IP}\n" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
}


#Wrapper Function to call other functions To Display Informations
DISPLAY(){
    RAM
    STORAGE
    OS
    IP_ADDRESS
}

DISPLAY

echo "==========================================" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log