#!/bin/bash

shopt -s nocasematch

tput el1
if [[ $2 =~ ^(database)$ && ! -z $3 ]]
    then
        if [[ ! -d DATA/$3 ]] 
            then
            printf "${RED}${bold}There is NO database with that name!${normal}${NC}\n"
        else
            rm -r DATA/$3
            if [[ $? -eq 0 ]]
            then
                printf "\t${YELLOW}${bold}Deleted Successfully!${normal}${NC}\n"
            fi
        fi
    printf ">> "
else
    printf "${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n>> "
fi