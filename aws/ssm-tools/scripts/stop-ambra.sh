#! /bin/bash
set -e

function stopGrid() {
    #dga
    dga_status=$(systemctl is-enabled dga)
    dga_state=$(systemctl is-active dga)
    if [[$dga_status == "enabled" ]] && [[ $dga_state != "active" ]]
    then
        echo "Attempting to stop dga..."
        sudo systemctl stop dga
        echo -e "\e"
        echo -e "\e"
        echo -e "dga status"
        sudo systemctl status dga | head -n 7
    fi

    #grid
    grid_status=$(systemctl is-enabled grid)
    grid_state=$(systemctl is-active grid)
    if [[$grid_status == "enabled" ]] && [[ $grid_state != "active" ]] 
    then
        echo "Attempting to stop grid..."
        sudo systemctl stop grid
        echo -e "\e"
        echo -e "\e"
        echo -e "grid status"
        sudo systemctl status grid | head -n 7
    fi
    
    #haproxy
    haproxy_status=$(systemctl is-enabled haproxy)
    haproxy_state=$(systemctl is-active haproxy)
    if [[$haproxy_status == "enabled" ]] && [[ $haproxy_state != "active" ]] 
    then
        echo "Attempting to stop haproxy..."
        sudo systemctl stop haproxy
        echo -e "\e"
        echo -e "\e"
        echo -e "haproxy status"
        sudo systemctl status haproxy | head -n 7
    fi

    #openresty
    openresty_status=$(systemctl is-enabled openresty)
    openresty_state=$(systemctl is-active openresty)
    if [[$openresty_status == "enabled" ]] && [[ $openresty_state != "active" ]] 
    then
        echo "Attempting to stop openresty..."
        sudo systemctl stop openresty
        echo -e "\e"
        echo -e "\e"
        echo -e "openresty status"
        sudo systemctl status openresty | head -n 7
    fi

    #transcoding*
    transcoding_status=$(systemctl is-enabled transcoding*)
    transcoding_state=$(systemctl is-active transcoding*)
    if [[$transcoding_status == *"enabled"* ]] && [[ $transcoding_state != *"active"* ]] 
    then
        echo "Attempting to stop transcoding services..."
        sudo systemctl stop transcoding*
        echo -e "\e"
        echo -e "\e"
        echo -e "transcoding status"
        sudo systemctl status transcoding* | head -n 7
    fi

    #v3s-apache
    v3s-apache_status=$(systemctl is-enabled v3s-apache)
    v3s-apache_state=$(systemctl is-active v3s-apache)
    if [[$v3s-apache_status == "enabled" ]] && [[ $v3s-apache_state != "active" ]] 
    then
            echo "Attempting to stop v3s-apache services..."
            sudo systemctl stop v3s-apache
            echo -e "\e"
            echo -e "\e"
            echo -e "v3s-apache status"
            sudo systemctl status v3s-apache | head -n 7
    fi

    #v3s-cron
    v3s-cron_status=$(systemctl is-enabled v3s-cron)
    v3s-cron_state=$(systemctl is-active v3s-cron)
    if [[$v3s-cron_status == "enabled" ]] && [[ $v3s-cron_state != "active" ]] 
    then
            echo "Attempting to stop v3s-cron services..."
            sudo systemctl stop v3s-cron
            echo -e "\e"
            echo -e "\e"
            echo -e "v3s-cron status"
            sudo systemctl status v3s-cron | head -n 7
    fi

    #v3s-postgres
    v3s-postgres_status=$(systemctl is-enabled v3s-postgres)
    v3s-postgres_state=$(systemctl is-active v3s-postgres)
    if [[$v3s-postgres_status == "enabled" ]] && [[ $v3s-postgres_state != "active" ]] 
    then
            echo "Attempting to stop v3s-postgres services..."
            sudo systemctl stop v3s-postgres
            echo -e "\e"
            echo -e "\e"
            echo -e "v3s-postgres status"
            sudo systemctl status v3s-postgres | head -n 7
    fi

    #v3s-redis
    v3s-redis_status=$(systemctl is-enabled v3s-redis)
    v3s-redis_state=$(systemctl is-active v3s-redis)
    if [[$v3s-redis_status == "enabled" ]] && [[ $v3s-redis_state != "active" ]] 
    then
            echo "Attempting to stop v3s-redis services..."
            sudo systemctl stop v3s-redis
            echo -e "\e"
            echo -e "\e"
            echo -e "v3s-redis status"
            sudo systemctl status v3s-redis | head -n 7
    fi

    #watchdog-services
    watchdog_status=$(systemctl is-enabled watchdog)
    watchdog_state=$(systemctl is-active watchdog)
    if [[$watchdog_status == "enabled" ]] && [[ $watchdog_state != "active" ]] 
    then
            echo "Attempting to stop watchdog services..."
            sudo systemctl stop watchdog-services
            echo -e "\e"
            echo -e "\e"
            echo -e "watchdog status"
            sudo systemctl status watchdog-services | head -n 7
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

stopGrid
