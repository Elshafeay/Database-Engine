#!/bin/bash

shopt -s nocasematch
tput el1

if [[ $# -eq 7 ]]
then
    if [[ $4 =~ ^(where)$ && $5 =~ ^(rn)$ && $6 == '=' ]]
    then
        if [[ -f DATA/$currentDB/$3 ]] 
            then
            sed -i "${7}d" DATA/$currentDB/$3
            printf "\t${YELLOW}${bold}Deleted Successfully!${normal}${NC}\n"
        else
            printf "\t${RED}${bold}There is no table with that name!${normal}${NC}\n"
            exit
        fi
    else
        printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
    fi
else
    printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
fi