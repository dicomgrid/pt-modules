#! /bin/bash
set -e

function checkGrid() {
    #dga
    echo -e "\e"
    echo -e "\e"
    echo -e "dga status"
    sudo systemctl status dga
  
    #grid
    echo -e "\e"
    echo -e "\e"
    echo -e "grid status"
    sudo systemctl status grid
    
    #haproxy
    echo -e "\e"
    echo -e "\e"
    echo -e "haproxy status"
    sudo systemctl status haproxy

    #openresty
    echo -e "\e"
    echo -e "\e"
    echo -e "openresty status"
    sudo systemctl status openresty
    
    #transcoding*
    echo -e "\e"
    echo -e "\e"
    echo -e "transcoding status"
    sudo systemctl status transcoding*
    
    #v3s-apache
    echo -e "\e"
    echo -e "\e"
    echo -e "v3s-apache status"
    sudo systemctl status v3s-apache
    
    #v3s-cron
    echo -e "\e"
    echo -e "\e"
    echo -e "v3s-cron status"
    sudo systemctl status v3s-cron

    #v3s-postgres
    echo -e "\e"
    echo -e "\e"
    echo -e "v3s-postgres status"
    sudo systemctl status v3s-postgres

    #v3s-redis
    echo -e "\e"
    echo -e "\e"
    echo -e "v3s-redis status"
    sudo systemctl status v3s-redis

    #watchdog-services
    echo -e "\e"
    echo -e "\e"
    echo -e "watchdog status"
    sudo systemctl status watchdog-services
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

checkGrid
