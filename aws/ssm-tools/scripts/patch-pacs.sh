#! /bin/bash
set -e

export SKIP="--exclude=pacemaker* --exclude=corosync*"
export DISABLED_PLUGINS="--disableplugin=rhnplugin"
if [[ ! -z $(cat /etc/os-release | grep ID= | grep rocky) ]]
then
    echo "Rocky Instance Found..."
    export REPOS="--disablerepo=* --enablerepo=epel --enablerepo=appstream --enablerepo=baseos --enablerepo=extras"
    if [[ -f /etc/yum/pluginconf.d/rhnplugin.conf ]]
    then
        echo "Has rhnplugin."
        sudo yum ${DISABLED_PLUGINS} ${REPOS} ${SKIP} update -y --nobest || true
        sudo package-cleanup --cleandupes || true
    else
        sudo yum ${REPOS} ${SKIP} update -y --nobest || true
        sudo package-cleanup --cleandupes || true
    fi
fi

if [[ ! -z $(cat /etc/os-release | grep ID= | grep centos) ]]
then
    echo "CentOS Instance Found..."
    export REPOS="--disablerepo=* --enablerepo=epel --enablerepo=base --enablerepo=updates"
    if [[ -f /etc/yum/pluginconf.d/rhnplugin.conf ]]
    then
        echo "Has rhnplugin."
        sudo yum ${DISABLED_PLUGINS} update ca-certificates -y
        sudo yum ${DISABLED_PLUGINS} install yum-utils -y
        sudo yum ${DISABLED_PLUGINS} ${REPOS} ${SKIP} update -y
        sudo yum-complete-transaction ${DISABLED_PLUGINS} --cleanup-only
    else
        sudo yum update ca-certificates -y
        sudo yum install yum-utils -y
        sudo yum ${REPOS} ${SKIP} update -y
        sudo yum-complete-transaction --cleanup-only
    fi
fi

export REBOOT=$(needs-restarting -r | grep required)
if [[ $REBOOT ]]
then
    echo "Rebooting now..."
    exit 194
else
    echo "Exiting..."
    exit 0
fi
