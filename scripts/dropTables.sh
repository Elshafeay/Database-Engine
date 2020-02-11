#!/bin/bash

shopt -s nocasematch

tput el1

if [[ $# == 3 ]]
then
	if [[ -z $currentDB ]]
		then
			printf "\t${RED}${bold}You need to connect to a database first!${normal}${NC}\n"
			exit
		else
	if [[ "$(ls -A DATA/$currentDB)" ]]
		then
		rm -r DATA/$currentDB/*
			if [[ $? -eq 0 ]]
		        	then
		            	printf "\t${YELLOW}${bold}Deleted Successfully!${normal}${NC}\n"
		        fi
	else
		printf "\t${RED}${bold}There is NO tables to delete!${normal}${NC}\n"	
	fi
	fi
else
			printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n "
fi
