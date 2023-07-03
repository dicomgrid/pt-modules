#! /bin/bash
set -e

function startPacs() {
    if [ -e $(ls /etc/rc.d/init.d/PACS) ]; 
    then
        sudo su - admin

        echo "Attempting to start sybase..."
        /opt/intelerad/bin/padmin sudo /etc/init.d/sybase -v start > /dev/null 2>&1
        echo "Attempting to start postgres-intelerad..."
        /opt/intelerad/bin/padmin sudo /etc/init.d/postgres-intelerad start > /dev/null 2>&1
        echo "Attempting to start apache2..."
        /opt/intelerad/bin/padmin sudo /etc/init.d/apache2 start > /dev/null 2>&1
        echo "Attempting to start Tomcat..."
        /opt/intelerad/bin/padmin controlTomcat -t start > /dev/null 2>&1
        echo "Attempting to start IntelePACS services..."
        /opt/intelerad/bin/padmin PACS start
        
        echo "Reporting Post start status"
        sudo service pacemaker status
        sudo service sybase status
        sudo service postgres-intelerad status
        sudo service apache2 status
        /opt/intelerad/bin/padmin controlTomcat -t list
        /opt/intelerad/bin/padmin PACS status

        if [ -e $(ls /etc/rc.d/init.d/corosync) ];
        then
            echo "Attempting to start corosync..."
            sudo systemctl start corosync > /dev/null 2>&1
            sudo service corosync status
            echo "Attempting to start pacemaker..."
            sudo systemctl start pacemaker > /dev/null 2>&1
            sudo systemctl status pacemaker
        ;
        else
            echo "No clustering services to start, proceeding..."
        ;
        exit 0
    ;
    else 
        echo "PACS services not found, exiting..."
        exit 0
    ; 
    fi
}

startPacs || exit 1


