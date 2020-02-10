#!/bin/bash

shopt -s nocasematch
tput el1

if [[ $# == 3 ]] 
then
    if [[ ! -z $3 ]]
    then
        if [[ -z $currentDB ]]
        then
            printf "\t${RED}${bold}You need to connect to a database first!${normal}${NC}\n"
            exit
        fi
        if [[ -f DATA/$currentDB/$3 ]] 
            then
            ./handlingInsertIntable.sh $3
        else
            printf "\t${RED}${bold}There is NO table with that name!${normal}${NC}\n"
        fi
    fi
else
    printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
fi