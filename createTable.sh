#!/bin/bash

shopt -s nocasematch
shopt -s extglob

tput el1
if [[ ! -z $3 && -z $4 ]]
    then
        if [[ -z $currentDB ]]
        then
            printf "\t${RED}${bold}You need to connect to a database first!${normal}${NC}\n>> "
            exit
        fi
        if [[ ${3:0:1} == [[:alpha:]] ]]
            then
            case $3 in
                +([[:alnum:]]))
                    if [[ -f DATA/$currentDB/$3 ]] 
                    then
                        printf "${RED}${bold}There is already a table with the same name!${normal}${NC}\n>> "
                    else
                        ./handlingTablesCreation.sh $3
                    fi
                ;;
                *)  printf "${RED}${bold}Table name can't have special characters!${normal}${NC}\n>> "
                ;;
            esac
        else
            printf "${RED}${bold}Table name must start with a character!${normal}${NC}\n>> "
        fi
else
    printf "${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n>> "
fi