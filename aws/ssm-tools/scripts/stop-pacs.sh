#! /bin/bash
set -e

function stopPacs() {
    if [ -e $(ls /etc/rc.d/init.d/PACS) ]; 
    then
        sudo su - admin
        if [ -e $(ls /etc/rc.d/init.d/corosync) ];
        then
            echo "Attempting to stop corosync..."
            sudo systemctl stop corosync > /dev/null 2>&1
            sudo service corosync status
            echo "Attempting to stop pacemaker..."
            sudo systemctl stop pacemaker > /dev/null 2>&1
            sudo systemctl status pacemaker
        ;
        else
            echo "No clustering services to stop, proceeding..."
        ;
        
        echo "Attempting to stop IntelePACS services..."
        /opt/intelerad/bin/padmin PACS stop > /dev/null 2>&1
        echo "Attempting to stop Tomcat..."
        /opt/intelerad/bin/padmin controlTomcat -t stop > /dev/null 2>&1
        echo "Attempting to stop apache2..."
        /opt/intelerad/bin/padmin sudo /etc/init.d/apache2 stop > /dev/null 2>&1
        echo "Attempting to stop postgres-intelerad service..."
        /opt/intelerad/bin/padmin sudo /etc/init.d/postgres-intelerad stop > /dev/null 2>&1
        echo "Attempting to stop Sybase service..."
        /opt/intelerad/bin/padmin sudo /etc/init.d/sybase -v stop > /dev/null 2>&1
        
        exit 0
        ;
    else
        echo "PACS services not found, exiting..."
        exit 0
    ;
    fi
}

stopPacs || exit 1