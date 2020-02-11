#!/bin/bash

shopt -s nocasematch
tput el1

display_center(){
    columns="$(tput cols)"
    line="'*======================================$1======================================*'"
    printf "\n"
    printf "%*s\n" $(( (${#line} + columns) / 2)) $line
    printf "\n"
}

if [[ $# == 4 ]]
    then
    if [[ $3 =~ ^(from)$ && ! -z $4 ]]
    then
        array=($(cut -d: -f1 DATA/$currentDB/$4.metadata))
        if [[ $2 =~ ^(all)$ ]]
        then
            printf "\n"
            display_center $4
            awk 'BEGIN {FS=":"} {if(NR>0) printf "|\t"$1"\t\t"} END{printf "\n\n"}' "DATA/$currentDB/$4.metadata"
            awk 'BEGIN {FS=":";OFS="\t\t|\t";ORS="\n"} {$1=$1; printf "|\t"; printf substr($0,1,length($0))"\n"}' "DATA/$currentDB/$4"
            display_center $4
        fi
    else
        printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
    fi
else
    printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
fi
