#! /bin/bash
set -e

function stopPacs() {
    if [[ -e $(ls /etc/rc.d/init.d/PACS) ]] 
    then
        if [[ -e $(ls /etc/rc.d/init.d/corosync > /dev/null 2>&1) ]]
        then
            echo "Attempting to stop corosync..."
            sudo systemctl stop corosync > /dev/null 2>&1
            echo -e "\e"
            echo -e "\e"
            echo -e "corosync status"
            sudo service corosync status | head -n 7

            echo "Attempting to stop pacemaker..."
            sudo systemctl stop pacemaker > /dev/null 2>&1
            echo -e "\e"
            echo -e "\e"
            echo -e "pacemaker status"
            sudo service pacemaker status | head -n 7
        else
            echo "No clustering services to stop, proceeding..."
        fi
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
        
        echo -e "\e"
        echo -e "\e"
        echo "Reporting Post service stop status"
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
        echo "stop service tasks completed."
    else
        echo "PACS services not found, exiting..."
    fi
}

function main() {
    su admin -c "bash -c stopPacs"
}

export -f stopPacs
export REPOS="--disablerepo=* --enablerepo=centos7-x86_64 --enablerepo=epel --enablerepo=base --enablerepo=updates"
export SKIP="--exclude=pacemaker* --exclude=corosync*"
sudo yum --disableplugin=rhnplugin  update ca-certificates -y
sudo yum install yum-utils -y
sudo yum ${REPOS} ${SKIP} update -y
sudo yum-complete-transaction --cleanup-only
export REBOOT=$(needs-restarting -r | grep required)
if [[ $REBOOT ]]
then
        echo "Rebooting now..."
        main
        exit 194
else
        echo "Exiting..."
        exit 0
fi
