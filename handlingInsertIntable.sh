#!/bin/bash

shopt -s nocasematch
shopt -s extglob

cols=` awk 'BEGIN {FS=":"} {if(NR>0) printf $1","}' "DATA/$currentDB/$1.metadata" `
types=` awk 'BEGIN {FS=":"} {if(NR>0) printf $2}' "DATA/$currentDB/$1.metadata" `
IFS=',' read -ra arrayOfCols <<< "$cols"
IFS=',' read -ra arrayOfTypes <<< "$types"
IFS=' '

printf "\t${YELLOW}${bold}Enter your data in the format [("
for (( i=0; i<${#arrayOfCols[@]}; i++ ))
do  
    printf "${arrayOfCols[i]}<${arrayOfTypes[i]}>"
    if [[ $i < $((${#arrayOfCols[@]}-1)) ]]
    then
        printf ":"
    fi
done
printf "), ...]\n\tand for more details type 'help'${NC}${normal}\n"


while read -p "(Insertion Mode)>> " -e input
do

#### if he wanted to cancel that table and get back to main menu ####
    if [[ $input =~ ^(cancel)$ ]]
        then
        break
    elif [[ $input =~ ^(help)$ ]]
        then
        tput el1
        printf "\n"
        cat insertionHelp
        continue
    elif [[ -z $input ]]
        then
        continue
    fi

#### making sure he wrote the columns in [] ####
    if [[ ! ${input:0:1} == "[" || ! ${input: -1} == "]" ]]
    then
        printf "\t${RED}${bold}Bad Format! for more details type 'help'${NC}${normal}\n"
        continue
    fi

    input=${input:1:-1}
    if [[ -z $input ]]
    then
        printf "\t${RED}${bold}Bad Format! for more details type 'help'${NC}${normal}\n"
        continue
    fi

    IFS=',' read -ra arrayOfData <<< "$input"
    arrayOfData=(${arrayOfData[@]})
#### validating the whole data ####
    for row in "${arrayOfData[@]}"
    do
        if [[ ! ${row:0:1} == "(" || ! ${row: -1} == ")" ]]
        then
            printf "\t${RED}${bold}Bad Format! for more details type 'help'${NC}${normal}\n"
            continue 2
        fi
        row=${row:1:-1}
        if [[ -z $row ]]
        then
            printf "\t${RED}${bold}Bad Format! for more details type 'help'${NC}${normal}\n"
            continue 2
        fi

#### validating every row of insertion #### 

        for (( i=0; i<${#arrayOfCols[@]}; i++ ))
        do  
            IFS=':' read -ra temparr <<< "$row"
            if [[ ${#temparr[@]} != ${#arrayOfCols[@]} ]]
                then
                printf "\t${RED}${bold}Bad Format! for more details type 'help'${NC}${normal}\n"
                continue 3
            fi
            for (( i=0; i<${#arrayOfCols[@]}; i++ ))
            do
                if [[ ${arrayOfTypes[i]} == "int" ]]
                then
                    case ${temparr[i]} in 
                        !(+([[:digit:]])))
                        printf "\t${RED}${bold}You can't enter characters into an integer field! for more details type 'help'${NC}${normal}\n"
                        continue 5
                        ;;
                    esac
                else
                    case ${temparr[i]} in 
                        !(+([[:alnum:]])))
                        printf "\t${RED}${bold}Strings can't have special characters for now! for more details type 'help'${NC}${normal}\n"
                        continue 5
                        ;;
                    esac
                fi
            done
        done
        IFS=' '
    done


#### inserting the whole data ####
    for row in ${arrayOfData[@]}
    do
        row=${row:1:-1}
        string=""
        IFS=':' read -ra temparr <<< "$row"
        for i in ${temparr[@]}
        do
            if [[ $i == ${temparr[$((${#temparr[@]}-1))]} ]]
            then
                string+="$i"
            else
                string+="$i:"
            fi
        done
        IFS=' '
        echo $string >> DATA/$currentDB/$1;
    done
    printf "\t${YELLOW}${bold}Inserted Successfully!${normal}${NC}\n"
    break
done