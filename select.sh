#!/bin/bash

shopt -s nocasematch
tput el1

if [[ $# == 4 ]] 
    then
if [[ ! -z $2 && $3 =~ ^(from)$ && $4 =~ ^(dfile)$ ]]
	then

	
case $2 in
"all")
awk -F: 'BEGIN{printf "\n+-------+---------------------+---------------+---------+\n"; printf "|  ID   |        Name         |    Position   |  Salary |\n"; sline="+-------+---------------------+---------------+---------+"; print sline}{printf("| %5d | %19s | %13s | %7d |\n", $1,$2,$3,$4);}END{print sline}' ./DATA/nnnn/dfile
;;
*)
printf "${RED}${bold}The items that you want to display is not clear!${NC}${normal}\n"
;;
esac
else	
printf "${RED}${bold}Wrong input!${NC}${normal}\n"
fi
else
printf "${RED}${bold}Please enter the full syntax!${NC}${normal}\n"
fi
printf ">> "
