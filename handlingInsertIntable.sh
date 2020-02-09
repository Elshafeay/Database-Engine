#!/bin/bash

shopt -s nocasematch
shopt -s extglob

col=`cut -d: -f1 DATA/$currentDB/$1.metadata`
printf "\t${YELLOW}${bold}Enter your columns in the format [($col), ...]\n\tand for more details type 'help'${NC}${normal}\n"

while read -p ">> " -e input
do

    if [[ $input =~ ^(cancel)$ ]]
        then
        break
    elif [[ $input =~ ^(help)$ ]]
        then
        tput el1
        printf "\n"
        cat tablesHelp
        continue
    elif [[ -z $input ]]
        then
        continue
    fi

    if [[ ! ${input:0:1} == "(" || ! ${input: -1} == ")" ]]
    then
        printf "${RED}${bold}Bad Format! for more details type 'help'${NC}${normal}\n
 	"
        continue
    fi

    input=${input:1:-1}

    if [[ -z $input ]]
    then
        printf "${RED}${bold}Bad Format! for more details type 'help'${NC}${normal}\n"
        continue
    fi

IFS=' ' read -ra arrayOfData <<< "$input"

for i in "${arrayOfData[@]}";
do
        temparr=($i)
	echo "${temparr}," >> DATA/$currentDB/$1; 
done 
printf "\t${YELLOW}${bold}Inserted Successfully!${normal}${NC}\n"
    break
done
