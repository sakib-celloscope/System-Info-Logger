#!/bin/sh

#System Info Logger
#System Info Logger is a shell script that automates the process of gathering essential system information, including RAM usage, available storage, and OS details. It logs this data into a file and sends it via email, providing daily insights into your system's health and status.

#Check Current Directory
CURRENT_DIRECTORY=`pwd`

#Checking Date in YYYY-MM-DD Format
CURRENT_DATE=`date +%F`

#Checking Current Time
CURRENT_TIME=`date +%T.%3N`

LOG_FILE="Log-${CURRENT_DATE}"

echo "LOG FILE: ${LOG_FILE}"

echo -e "Script Executed at ${CURRENT_TIME}\n"


#Printing the Script Name
echo -e "${0} Executed at ${CURRENT_TIME}\n" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log

#Printing in Tabular Format
PRINT_TABLE_ROW(){
    printf "%-25s : %-25s : %s\n" "$1" "$2" "$3"
}

KB_TO_GB(){
    IN_GB=`expr $1 / 1000000`
    return $IN_GB
}

#RAM: Displays information of RAM
RAM(){
    #TOTAL_RAM=`free -t | grep "Total" | awk '{print $1/1024/1024/1024 " GB"}'`
    RAM_IN_KB=`free | awk '/Mem/ {print $2}'`
    FREE_RAM_KB=`free | awk '/Mem/ {print $4}'`
    USED_RAM_KB=`free | awk '/Mem/ {print $3}'`
    
    KB_TO_GB "${RAM_IN_KB}"
    TOTAL_RAM=$?

    KB_TO_GB "${FREE_RAM_KB}"
    FREE_RAM_SPACE=$?

    KB_TO_GB "${USED_RAM_KB}"
    USED_RAM_SPACE=$?

    PRINT_TABLE_ROW "${CURRENT_DATE} ${CURRENT_TIME}" "Total RAM" "${TOTAL_RAM}GB"
    PRINT_TABLE_ROW "${CURRENT_DATE} ${CURRENT_TIME}" "Total Free Space" "${FREE_RAM_SPACE}GB"
    PRINT_TABLE_ROW "${CURRENT_DATE} ${CURRENT_TIME}" "Total Used Space" "${USED_RAM_SPACE}GB"
    PRINT_TABLE_ROW "-----------" "-----------" "-----------"
}

#STORAGE: Displays information of Storage
STORAGE(){
    TOTAL_STORAGE_SPACE_IN_KB=`df -T | awk '/ext4/ {print $3}'`
    AVAILABLE_STORAGE_SPACE_IN_KB=`df -T | awk '/ext4/ {print $5}'`
    USED_STORAGE_SPACE_IN_KB=`df -T | awk '/ext4/ {print $4}'`

    KB_TO_GB "${TOTAL_STORAGE_SPACE_IN_KB}"
    TOTAL_STORAGE_SPACE=$?

    KB_TO_GB "${AVAILABLE_STORAGE_SPACE_IN_KB}"
    AVAILABLE_STORAGE_SPACE=$?

    KB_TO_GB "${USED_STORAGE_SPACE_IN_KB}"
    USED_STORAGE_SPACE=$?


    PRINT_TABLE_ROW "${CURRENT_DATE} ${CURRENT_TIME}" "Total Storage Size" "${TOTAL_STORAGE_SPACE}GB"
    PRINT_TABLE_ROW "${CURRENT_DATE} ${CURRENT_TIME}" "Total Available Storage" "${AVAILABLE_STORAGE_SPACE}GB"
    PRINT_TABLE_ROW "${CURRENT_DATE} ${CURRENT_TIME}" "Total Used Storage" "${USED_STORAGE_SPACE}GB"
    PRINT_TABLE_ROW "-----------" "-----------" "-----------"
}

#OS: Displays information of OS and it's version
OS(){
    OS_NAME=`hostnamectl | grep "Operating System" | cut -d" " -f 3`
    OS_VERSION=`hostnamectl | grep "Operating System" | cut -d" " -f 4`

    PRINT_TABLE_ROW "${CURRENT_DATE} ${CURRENT_TIME}" "OS Name" "${OS_NAME}"
    PRINT_TABLE_ROW "${CURRENT_DATE} ${CURRENT_TIME}" "OS Version" "${OS_VERSION}"
    PRINT_TABLE_ROW "-----------" "-----------" "-----------"
}

#IP_ADDRESS: Displays IP address
IP_ADDRESS(){
    IP=`hostname -I`

    #echo -e "IP Address: ${IP}\n"

    PRINT_TABLE_ROW "${CURRENT_DATE} ${CURRENT_TIME}" "IP Address" "${IP}"
}


#Wrapper Function to call other functions To Display Informations
DISPLAY(){
    PRINT_TABLE_ROW "TIMESTAMP" "SYSTEM INFO" "VOLUME" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
    PRINT_TABLE_ROW "-----------" "-----------" "-----------" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log
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

echo "=====================================================================" >> ${CURRENT_DIRECTORY}/Log-${CURRENT_DATE}.log