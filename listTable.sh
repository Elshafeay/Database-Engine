#!/bin/bash

shopt -s nocasematch

tput el1

if [[ $# == 2 ]] 
    then
    if [[ -z $currentDB ]]
		then
		printf "\t${RED}${bold}You need to connect to a database first!${normal}${NC}\n "
		exit
    else
	array=`ls DATA/$currentDB`
	   if [[ ! -z $array ]]
                then
                for i in $array
                do
                    printf "\t${BLUE}${bold}$i${normal}${NC}\n"
                done
            else
                printf "\t${RED}${bold}You don't have any existing Tables!${normal}${NC}\n"
	  fi
    fi
else
        printf "${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n "
fi
printf ">> "
