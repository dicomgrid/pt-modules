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

export SKIP="--exclude=pacemaker* --exclude=corosync*"
export DISABLED_PLUGINS="--disableplugin=rhnplugin"
if [[ ! -z $(cat /etc/os-release | grep ID= | grep rocky) ]]
then
    echo "Rocky Instance Found..."
    export REPOS="--disablerepo=* --enablerepo=epel --enablerepo=appstream --enablerepo=baseos --enablerepo=extras"
    sudo yum ${DISABLED_PLUGINS} ${REPOS} ${SKIP} update -y --nobest || true
    sudo package-cleanup --cleandupes || true
fi

if [[ ! -z $(cat /etc/os-release | grep ID= | grep centos) ]]
then
    echo "CentOS Instance Found..."
    export REPOS="--disablerepo=* --enablerepo=epel --enablerepo=base --enablerepo=updates"
    sudo yum ${DISABLED_PLUGINS} update ca-certificates -y
    sudo yum ${DISABLED_PLUGINS} install yum-utils -y
    sudo yum ${DISABLED_PLUGINS} ${REPOS} ${SKIP} update -y
    sudo yum-complete-transaction ${DISABLED_PLUGINS} --cleanup-only
fi

export REBOOT=$(needs-restarting -r | grep required)
if [[ $REBOOT ]]
then
    echo "Rebooting now..."
    export -f stopPacs
    su admin -c "bash -c stopPacs"
    exit 194
else
    echo "Exiting..."
    exit 0
fi
