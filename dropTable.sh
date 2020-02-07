#!/bin/bash

shopt -s nocasematch

tput el1

if [[ $# == 3 ]]
then
if [[ ! -z $3 ]]
	then 
	if [[ -z $currentDB ]]
		then
		printf "\t${RED}${bold}You need to connect to a database first!${normal}${NC}\n "
		exit
	else
		if [[ ! -f DATA/$currentDB/$3 ]]
			then
			printf "${RED}${bold}There is no table has this name!${normal}${NC}\n"
		else
		rm -rf "DATA/$currentDB/$3"
		rm -rf "DATA/$currentDB/$3.metadata"
		if [[ $? -eq 0 ]]
           		then
                	printf "\t${YELLOW}${bold} $3 table deleted Successfully!${normal}${NC}\n"
		fi
      		fi
	fi
	
printf ">> "
else
    printf "${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n>> "
fi
else
    printf "${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n>> "
fi
