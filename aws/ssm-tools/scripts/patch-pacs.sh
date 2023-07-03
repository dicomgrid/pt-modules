#! /bin/bash
export REPOS="--disablerepo=* --enablerepo=centos7-x86_64 --enablerepo=epel --enablerepo=base --enablerepo=updates"
export SKIP="--exclude=pacemaker* --exclude=corosync*"
sudo yum --disableplugin=rhnplugin  update ca-certificates -y
sudo yum ${REPOS} ${SKIP} update -y

needs-restarting -r
if [ $? -eq 1 ]
then
        exit 194
else
        exit 0
fi