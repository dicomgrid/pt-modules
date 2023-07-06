#! /bin/bash
set -e

function checkPacs() {
    if [[ -e $(ls /etc/rc.d/init.d/PACS) ]]
    then
        if [[ -e $(ls /etc/rc.d/init.d/corosync > /dev/null 2>&1) ]]
        then
            service corosync status
            echo -e "\e"
            echo -e "\e"
            echo -e "corosync status"
            sudo service corosync status | head -n 7

            service pacemaker status
            echo -e "\e"
            echo -e "\e"
            echo -e "pacemaker status"
            sudo service pacemaker status | head -n 7
        else
            echo "No clustering services to check, proceeding..."
        fi
            echo -e "\e"

        echo -e "\e"
        echo -e "\e"
        echo "Reporting Pre patching status"
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
    else
        echo "PACS services not found, exiting..."
    fi
}

function handleErr() {
    exitCode=$?
    lastCommand=${BASH_COMMAND}
    echo -e "stderr occurred!"
    echo -e "last command: $lastCommand"
    echo -e "exit code: $exitCode"
    exit $exitCode
}
trap handleErr ERR

function main() {
    export -f checkPacs
    su admin -c "bash -c checkPacs"
}
main
