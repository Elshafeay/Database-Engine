#!/bin/bash

shopt -s nocasematch

tput el1
if [[ $2=~"database" && ! -z $3 ]]
    then
        if [[ -d DATA/$3 ]] 
            then
            printf "${RED}${bold}There is already a database with the same name!${normal}${NC}\n"
        else
            mkdir DATA/$3
            if [[ $? -eq 0 ]]
            then
                printf "\t${YELLOW}${bold}Created Successfully!${normal}${NC}\n"
            fi
        fi
    printf ">> "
else
    printf "${RED}${bold}Wrong input!${NC}${normal}\n>> "
fi