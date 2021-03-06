#!/bin/bash

shopt -s nocasematch

RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' #No Color
bold=$(tput bold)
normal=$(tput sgr0)
currentDB=""

printf "${YELLOW}${bold}Hi There, take a look at our documentation by typing 'help'\n${normal}${NC}"

if [ ! -d "DATA" ]
    then
    mkdir DATA
fi


function connect2DB {
    tput el1
    if [[ $2 =~ ^(to)$ && ! -z $3 ]]
        then
            if [[ ! -d DATA/$3 || ! -z $4 ]]
            then
                printf "\t${RED}${bold}There is NO database with that name!${normal}${NC}\n"
            else
                if [[ ! -z $currentDB ]]
                then
                    if [[ $currentDB =~ $3 ]]
                    then
                        printf "\t${RED}${bold}You're already connected to $3!${normal}${NC}\n"
                    else
                        printf "\t${YELLOW}${bold}Switched to $3!${normal}${NC}\n"
                    fi
                else
                    printf "\t${YELLOW}${bold}You're now connected to $3!${normal}${NC}\n"
                fi
                currentDB=$3
            fi
    else
        printf "\t${RED}${bold}Bad syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
    fi
}

function disconnect {
    tput el1
    if [[ -z $2 ]]
        then
            if [[ -z $currentDB ]]
            then
                printf "\t${RED}${bold}You're not connected to any databases!${normal}${NC}\n"
            else
                printf "\t${YELLOW}${bold}Disconnected successfully from $currentDB!${normal}${NC}\n"
                currentDB=""
            fi
    else
        printf "\t${RED}${bold}Bad syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
    fi
}

function showDB {
    tput el1
    if [[ -z $currentDB ]]
    then
        printf "\t${RED}${bold}You're not connected to any databases!${normal}${NC}\n"
    else
        printf "\t${YELLOW}${bold}You're connected to $currentDB!${normal}${NC}\n"
    fi
}

function dropDatabases {
    
    tput el1
    if [[ ! -z "$currentDB" ]]
        then
            disconnect
            tput el1
    fi	
        if [[ -z "$(ls -A DATA)" ]] 
        then
            printf "\t${RED}${bold}There is NO databases to delete!${normal}${NC}\n"	
        else 
        rm -r DATA/*
            if [[ $? -eq 0 ]]
                then
                    printf "\t${YELLOW}${bold}Deleted Successfully!${normal}${NC}\n"  
        fi
    fi

} 

function dropDB {
    tput el1
    if [[ $2 =~ ^(database)$ && ! -z $3 ]]
        then
            if [[ ! -d DATA/$3 ]] 
                then
                printf "\t${RED}${bold}There is NO database with that name!${normal}${NC}\n"
            else
                if [[ $currentDB == $3 ]]
                then
                    disconnect
                    tput el1
                fi
                rm -r DATA/$3
                if [[ $? -eq 0 ]]
                then
                    printf "\t${YELLOW}${bold}Deleted Successfully!${normal}${NC}\n"
                fi
            fi
    else
        printf "\t\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
    fi
}



export bold NC normal BLUE RED YELLOW currentDB

while  read -p ">> " -e input
do
    array=($input)
    if [[ ${array[0]} =~ ^(create)$ && ${array[1]} =~ ^(database)$ ]]
    then
        ./scripts/createDB.sh "${array[@]}"

    elif [[ ${array[0]} =~ ^(list)$ && ${array[1]} =~ ^(databases)$ ]]
    then 
        ./scripts/listDBs.sh "${array[@]}"
    
    elif [[ ${array[0]} =~ ^(list)$ && ${array[1]} =~ ^(tables)$ ]]
    then 
        ./scripts/listTable.sh "${array[@]}"

    elif [[ ${array[0]} =~ ^(drop)$ && ${array[1]} =~ ^(database)$ ]]
    then 
        dropDB "${array[@]}"

    elif [[ ${array[0]} =~ ^(drop)$ && ${array[1]} =~ ^(table)$ ]]
    then
	    ./scripts/dropTable.sh "${array[@]}"

    elif [[ ${array[0]} =~ ^(select)$ ]]
    then 
        ./scripts/select.sh "${array[@]}"

    elif [[ ${array[0]} =~ ^(disconnect)$ ]]
        then
        disconnect "${array[@]}"

    elif [[ ${array[0]} =~ ^(connect)$ ]]
    then
        connect2DB "${array[@]}"
    
    elif [[ ${array[0]} =~ ^(db)$ && -z ${array[1]} ]]
    then
        showDB
    
    elif [[ ${array[0]} =~ ^(create)$ && ${array[1]} =~ ^(table)$ ]]
    then
        ./scripts/createTable.sh "${array[@]}"
    	
    elif [[ ${array[0]} =~ ^(insert)$ && ${array[1]} =~ ^(into)$ ]]
    then
		./scripts/insert.sh "${array[@]}"

    elif [[ ${array[0]} =~ ^(delete)$ && ${array[1]} =~ ^(from)$ ]]
    then
		./scripts/deleteFrom.sh "${array[@]}"

		elif [[ ${array[0]} =~ ^(drop)$ && ${array[1]} =~ ^(all)$ && ${array[2]} =~ ^(databases)$ ]]
    then
        dropDatabases

		elif [[ ${array[0]} =~ ^(drop)$ && ${array[1]} =~ ^(all)$ && ${array[2]} =~ ^(tables)$ ]]
    then
        ./scripts/dropTables.sh "${array[@]}"

    elif [[ ${array[0]} =~ ^(update)$ ]]
    then
        ./scripts/update.sh "${array[@]}"

    elif [[ ${array[0]} =~ ^(help)$ ]]
    then
        ./scripts/help.sh

    elif [[ ${array[0]} =~ ^(exit)$ ]]
    then
        break 2
        
    # for Enter button
    elif [[ -z $input ]]
    then
        continue

    else
        tput el1
        printf "\t${RED}${bold}Bad Syntax! For more details check the documentation by typing 'help'${NC}${normal}\n"
    fi
done


##for erasing unwanted line at the closing
tput cuu1

printf "\n${YELLOW}hope to see you soon!${NC}\n"
