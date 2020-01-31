#!/bin/bash
shopt -s nocasematch

tput el1
if [[ $# < 3 ]] 
    then
    if [[ $1 =~ "list" || $2 =~ "database" ]]
        then
            array=`ls DATA`
            if [[ ! -z $array ]]
                then
                for i in $array
                do
                    printf "\t${BLUE}${bold}$i${normal}${NC}\n"
                done
            else
                printf "\t${RED}${bold}You don't have any existing database!${normal}${NC}\n"
            fi
            printf ">> "
    fi
    else
        printf "${RED}${bold}Wrong input!${NC}${normal}\n>> "
fi