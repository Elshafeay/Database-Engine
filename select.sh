#!/bin/bash

shopt -s nocasematch
tput el1

if [[ $# == 4 ]]
    then
    if [[ $3 =~ ^(from)$ && ! -z $4 ]]
    then
        array=($(cut -d: -f1 DATA/$currentDB/$4.metadata))
        if [[ $2 =~ ^(all)$ ]]
        then
            printf "\n*==============================$4==============================*\n"
            awk 'BEGIN {FS=":"} {if(NR>0) printf "|\t"$1"\t\t"} END{printf "\n"}' "DATA/$currentDB/$4.metadata"
            awk 'BEGIN {FS=":";OFS="\t\t|\t";ORS="\n"} {$1=$1; printf "|\t"; printf substr($0,1,length($0))"\n"}' "DATA/$currentDB/$4"
            printf "\n*==============================$4==============================*\n"

        fi
    else
        printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
    fi
else
    printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
fi
