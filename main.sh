#!/bin/bash

shopt -s nocasematch

RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' #No Color
bold=$(tput bold)
normal=$(tput sgr0)
bind -x '"\C-l": clear; printf ">> "' #so we can use ctrl+L to clear the screen
tput cuu1
tput ed

printf "${YELLOW}${bold}Hi There, take a look at our documentation by typing 'help'\n${normal}${NC}"

if [ ! -d "DATA" ]
    then
    mkdir DATA
fi

printf ">> ";
export bold NC normal BLUE RED YELLOW

while read -e input
do
    array=($input)
    printf ">> ";
    
    if [[ $array[0] =~ "create" ]]
    then
        ./createDB.sh "${array[@]}"

    elif [[ $array[0] =~ "list" ]]
    then 
        ./listDBs.sh "${array[@]}"

    elif [[ $array[0] =~ "drop" ]]
    then 
        ./dropDB.sh "${array[@]}"

    elif [[ $array[0] =~ "connect" ]]
    then 
        # ./connect2DB.sh

    elif [[ $array[0] =~ "help" ]]
    then
        ./help.sh
    
    elif [[ $array[0] =~ "exit" ]]
    then
        break 2
        
    # for Enter button
    elif [[ -z $input ]]
    then
        continue

    else
        tput el1
        printf "${RED}${bold}Wrong input!${NC}${normal}\n>> "        
    fi
done


##for erasing unwanted line at the closing
tput cuu1

printf "\n${YELLOW}hope to see you soon!${NC}\n"
