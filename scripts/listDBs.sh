#!/bin/bash
shopt -s nocasematch

tput el1
if [[ $# == 2 ]] 
    then
    if [[ $2 =~ ^(databases)$ ]]
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
    else
        printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
    fi

else
    printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
fi