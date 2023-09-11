#!/bin/sh

#System Info Logger
#System Info Logger is a shell script that automates the process of gathering essential system information, including RAM usage, available storage, and OS details. It logs this data into a file and sends it via email, providing daily insights into your system's health and status.

#Check Current Directory
CURRENT_DIRECTORY=`pwd`

#Checking Date in YYYY-MM-DD Format
CURRENT_DATE=`date +%F`

#Checking Current Time
CURRENT_TIME=`date +%T`

LOG_FILE="Log-${CURRENT_DATE}"

echo "LOG FILE: ${LOG_FILE}"

echo -e "Script Executed at ${CURRENT_TIME}\n"


#Printing the Script Name
echo -e "${0} Executed at ${CURRENT_TIME}\n" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log

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

#OS: Displays information of OS and it's version
OS(){
    OS_NAME=`hostnamectl | grep "Operating System" | cut -d" " -f 3`
    OS_VERSION=`hostnamectl | grep "Operating System" | cut -d" " -f 4`

    echo "OS Name: ${OS_NAME}"
    echo -e "OS Version: ${OS_VERSION}\n"
}

#IP_ADDRESS: Displays IP address
IP_ADDRESS(){
    IP=`hostname -I`

    echo -e "IP Address: ${IP}\n"
}


#Wrapper Function to call other functions To Display Informations
DISPLAY(){
    RAM >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
    STORAGE >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
    OS >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
    IP_ADDRESS >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
}

DISPLAY

SEND_MAIL(){
    echo "Here is the system info log file which is generated at ${CURRENT_TIME}. Thank you." | mail -s "System Info Log Update" -A "$LOG_FILE.log" abdullahnazmussakib@gmail.com
}

SEND_MAIL 

echo "==========================================" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log