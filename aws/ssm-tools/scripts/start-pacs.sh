#! /bin/bash
set -e

function startPacs() {
    if [[ -e $(ls /etc/rc.d/init.d/PACS) ]]
    then
        echo "Attempting to start sybase..."
        /opt/intelerad/bin/padmin sudo /etc/init.d/sybase -v start > /dev/null 2>&1
        echo "Attempting to start postgres-intelerad..."
        /opt/intelerad/bin/padmin sudo /etc/init.d/postgres-intelerad start > /dev/null 2>&1
        echo "Attempting to start apache2..."
        /opt/intelerad/bin/padmin sudo /etc/init.d/apache2 start > /dev/null 2>&1
        echo "Attempting to start Tomcat..."
        /opt/intelerad/bin/padmin controlTomcat -t start > /dev/null 2>&1
        echo "Attempting to start IntelePACS services..."
        /opt/intelerad/bin/padmin PACS start > /dev/null 2>&1
        
        echo -e "\e"
        echo -e "\e"
        echo "Reporting Post service start status"
        echo -e "\e"
        echo -e "\e"
        echo -e "sybase status"
        sudo service sybase status
        echo -e "\e"
        echo -e "\e"
        echo -e "postgres-intelerad status"
        sudo service postgres-intelerad status | head -n 7
        echo -e "\e"
        echo -e "\e"
        echo -e "apache2 status"
        sudo service apache2 status | head -n 7
        echo -e "\e"
        echo -e "\e"
        echo -e "Tomcat status"
        /opt/intelerad/bin/padmin controlTomcat -t list
        echo -e "\e"
        echo -e "\e"
        echo -e "PACS status"
        /opt/intelerad/bin/padmin PACS status
        echo -e "\e"
        echo -e "\e"
        if [[ -e $(ls /etc/rc.d/init.d/corosync > /dev/null 2>&1) ]]
        then
            echo "Attempting to start corosync..."
            sudo systemctl start corosync > /dev/null 2>&1
            echo -e "\e"
            echo -e "\e"
            echo -e "corosync status"
            sudo service corosync status | head -n 7
            
            echo "Attempting to start pacemaker..."
            sudo systemctl start pacemaker > /dev/null 2>&1
            echo -e "\e"
            echo -e "\e"
            echo -e "pacemaker status"
            sudo service pacemaker status | head -n 7
        else
            echo "No clustering services to start, proceeding..."
        fi
        echo "start service tasks completed."
    else
        echo "PACS services not found, exiting..."
    fi
}

function handleErr() {
    exitCode=$?
    lastCommand=${BASH_COMMAND}
    echo "stderr occurred!"
    echo "last command: $lastCommand"
    echo -e "exit code: $exitCode"
    exit $exitCode
}
trap handleErr ERR

function main() {
    export -f startPacs
    su admin -c "bash -c startPacs"
}
main