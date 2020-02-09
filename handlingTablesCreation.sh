#!/bin/bash

shopt -s nocasematch
shopt -s extglob

printf "\t${YELLOW}${bold}Enter your columns in the format ([column-name] [column-type], ...)\n\tand for more details type 'help'${NC}${normal}\n"
while read -p ">> " -e input
do

#### if he wanted to cancel that table and get back to main menu ####
    if [[ $input =~ ^(cancel)$ ]]
        then
        printf "\n"
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

#### making sure he wrote the columns in parentheses ####
    if [[ ! ${input:0:1} == "(" || ! ${input: -1} == ")" ]]
    then
        printf "\t${RED}${bold}Bad Format! for more details type 'help'${NC}${normal}\n"
        continue
    fi

    input=${input:1:-1}

#### making sure the parentheses isn't empty ####
    if [[ -z $input ]]
    then
        printf "\t${RED}${bold}Bad Format! for more details type 'help'${NC}${normal}\n"
        continue
    fi
    
#### making an array containgin all columns ####    
    IFS=',' read -ra arrayOfCol <<< "$input"
    IFS=' '

#### checking the syntax, the format and the regex of columns #### 
    array=()
    for i in "${arrayOfCol[@]}"; do
        temparr=($i)
        if [[ ${#temparr[@]} > 2 || ! ${temparr[1]} =~ ^(int|string)$  ]]
            then
            printf "\t${RED}${bold}Bad Format! for more details type 'help'${NC}${normal}\n"
            continue 2
        fi

        if [[ ${temparr[0]:0:1} == [[:alpha:]] ]]
            then
                case ${temparr[0]} in 
                    !(+([[:alnum:]])))
                    printf "\t${RED}${bold}Columns names can't have special characters! for more details type 'help'${NC}${normal}\n"
                    continue 2
                    ;;
                esac
            else
            printf "\t${RED}${bold}Columns name must start with character! for more details type 'help'${NC}${normal}\n"
            continue 2
        fi
        array[${#array[@]}]=${temparr[0],,}  ## turned it into lowercase so that the dublicates check can work well
    done

#### to check if there are dublicates in columns names ####
    uniqueNum=$(printf '%s\n' "${array[@]}"|awk '!($0 in seen){seen[$0];c++} END {print c}')
    if [[ $uniqueNum != ${#array[@]} ]]
    then
        printf "\t${RED}${bold}You have dublicate columns! for more details type 'help'${NC}${normal}\n"
        continue
    fi

#### creating the table and its metadata ####
    touch DATA/$currentDB/$1;
    touch DATA/$currentDB/$1.metadata;
    for i in "${arrayOfCol[@]}"; do
        temparr=($i)
        echo "${temparr[0]}:${temparr[1]}," >> DATA/$currentDB/$1.metadata; 
    done
    printf "\t${YELLOW}${bold}Created Successfully!${normal}${NC}\n"
    break
done