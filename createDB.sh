#!/bin/bash

shopt -s nocasematch
shopt -s extglob

tput el1
if [[ ! -z $3 ]]
    then
        if [[ ! -z $4 ]]
            then
            printf "\t${RED}${bold}Database name can't have special characters!${NC}${normal}\n"
            exit
        fi
        if [[ ${3:0:1} == [[:alpha:]] ]]
            then
            case $3 in
                +([[:alnum:]]))
                    if [[ -d DATA/$3 ]] 
                    then
                        printf "\t${RED}${bold}There is already a database with the same name!${normal}${NC}\n"
                    else
                        mkdir DATA/$3;
                        if [[ $? -eq 0 ]]
                        then
                            printf "\t${YELLOW}${bold}Created Successfully!${normal}${NC}\n"
                        fi
                    fi
                ;;
                *)  printf "\t${RED}${bold}Database name can't have special characters!${normal}${NC}\n"
                ;;
            esac
        else
            printf "\t${RED}${bold}Database name must start with a character!${normal}${NC}\n"
        fi
else
    printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
fi