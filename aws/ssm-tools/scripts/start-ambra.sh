#! /bin/bash
set -e

function startGrid() {
    #dga
    dga_status=$(systemctl is-enabled dga)
    dga_state=$(systemctl is-active dga)
    if [[$dga_status == "enabled" ]] && [[ $dga_state != "active" ]] 
    then
        sleep 5
        echo "dga not active, attempting to start..."
        sudo systemctl start dga
        dga_check1=$(systemctl is-active dga)
        if [[ $dga_check1 != "active" ]] 
            sleep 5
            echo "failed to start 1 time, attempting to start again..."
            sudo systemctl start dga
            echo -e "\e"
            echo -e "\e"
            echo -e "dga status"
            sudo systemctl status dga | head -n 7
        fi
    fi

    #grid
    grid_status=$(systemctl is-enabled grid)
    grid_state=$(systemctl is-active grid)
    if [[$grid_status == "enabled" ]] && [[ $grid_state != "active" ]] 
    then
        sleep 5
        echo "grid not active, attempting to start..."
        sudo systemctl start grid
        grid_check1=$(systemctl is-active grid)
        if [[ $grid_check1 != "active" ]] 
            sleep 5
            echo "failed to start 1 time, attempting to start again..."
            sudo systemctl start grid
            echo -e "\e"
            echo -e "\e"
            echo -e "grid status"
            sudo systemctl status grid | head -n 7
        fi
    fi
    
    #haproxy
    haproxy_status=$(systemctl is-enabled haproxy)
    haproxy_state=$(systemctl is-active haproxy)
    if [[$haproxy_status == "enabled" ]] && [[ $haproxy_state != "active" ]] 
    then
        sleep 5
        echo "haproxy not active, attempting to start..."
        sudo systemctl start haproxy
        haproxy_check1=$(systemctl is-active haproxy)
        if [[ $haproxy_check1 != "active" ]] 
            sleep 5
            echo "failed to start 1 time, attempting to start again..."
            sudo systemctl start haproxy
            echo -e "\e"
            echo -e "\e"
            echo -e "haproxy status"
            sudo systemctl status haproxy | head -n 7
        fi
    fi

    #openresty
    openresty_status=$(systemctl is-enabled openresty)
    openresty_state=$(systemctl is-active openresty)
    if [[$openresty_status == "enabled" ]] && [[ $openresty_state != "active" ]] 
    then
        sleep 5
        echo "openresty not active, attempting to start..."
        sudo systemctl start openresty
        openresty_check1=$(systemctl is-active openresty)
        if [[ $openresty_check1 != "active" ]] 
            sleep 5
            echo "failed to start 1 time, attempting to start again..."
            sudo systemctl start openresty
            echo -e "\e"
            echo -e "\e"
            echo -e "openresty status"
            sudo systemctl status openresty | head -n 7
        fi
    fi

    #transcoding*
    transcoding_status=$(systemctl is-enabled transcoding*)
    transcoding_state=$(systemctl is-active transcoding*)
    if [[$transcoding_status == *"enabled"* ]] && [[ $transcoding_state != *"active"* ]] 
    then
        sleep 5
        echo "transcoding not active, attempting to start..."
        sudo systemctl start transcoding*
        transcoding_check1=$(systemctl is-active transcoding*)
        if [[ $transcoding_check1 != *"active"* ]] 
            sleep 5
            echo "failed to start 1 time, attempting to start again..."
            sudo systemctl start transcoding*
            echo -e "\e"
            echo -e "\e"
            echo -e "transcoding status"
            sudo systemctl status transcoding* | head -n 7
        fi
    fi

    #v3s-apache
    v3s-apache_status=$(systemctl is-enabled v3s-apache)
    v3s-apache_state=$(systemctl is-active v3s-apache)
    if [[$v3s-apache_status == "enabled" ]] && [[ $v3s-apache_state != "active" ]] 
    then
        sleep 5
        echo "v3s-apache not active, attempting to start..."
        sudo systemctl start v3s-apache
        v3s-apache_check1=$(systemctl is-active v3s-apache)
        if [[ $v3s-apache_check1 != "active" ]] 
            sleep 5
            echo "failed to start 1 time, attempting to start again..."
            sudo systemctl start v3s-apache
            echo -e "\e"
            echo -e "\e"
            echo -e "v3s-apache status"
            sudo systemctl status v3s-apache | head -n 7
        fi
    fi

    #v3s-cron
    v3s-cron_status=$(systemctl is-enabled v3s-cron)
    v3s-cron_state=$(systemctl is-active v3s-cron)
    if [[$v3s-cron_status == "enabled" ]] && [[ $v3s-cron_state != "active" ]] 
    then
        sleep 5
        echo "v3s-cron not active, attempting to start..."
        sudo systemctl start v3s-cron
        v3s-cron_check1=$(systemctl is-active v3s-cron)
        if [[ $v3s-cron_check1 != "active" ]] 
            sleep 5
            echo "failed to start 1 time, attempting to start again..."
            sudo systemctl start v3s-cron
            echo -e "\e"
            echo -e "\e"
            echo -e "v3s-cron status"
            sudo systemctl status v3s-cron | head -n 7
        fi
    fi

    #v3s-postgres
    v3s-postgres_status=$(systemctl is-enabled v3s-postgres)
    v3s-postgres_state=$(systemctl is-active v3s-postgres)
    if [[$v3s-postgres_status == "enabled" ]] && [[ $v3s-postgres_state != "active" ]] 
    then
        sleep 5
        echo "v3s-postgres not active, attempting to start..."
        sudo systemctl start v3s-postgres
        v3s-postgres_check1=$(systemctl is-active v3s-postgres)
        if [[ $v3s-postgres_check1 != "active" ]] 
            sleep 5
            echo "failed to start 1 time, attempting to start again..."
            sudo systemctl start v3s-postgres
            echo -e "\e"
            echo -e "\e"
            echo -e "v3s-postgres status"
            sudo systemctl status v3s-postgres | head -n 7
        fi
    fi

    #v3s-redis
    v3s-redis_status=$(systemctl is-enabled v3s-redis)
    v3s-redis_state=$(systemctl is-active v3s-redis)
    if [[$v3s-redis_status == "enabled" ]] && [[ $v3s-redis_state != "active" ]] 
    then
        sleep 5
        echo "v3s-redis not active, attempting to start..."
        sudo systemctl start v3s-redis
        v3s-redis_check1=$(systemctl is-active v3s-redis)
        if [[ $v3s-redis_check1 != "active" ]] 
            sleep 5
            echo "failed to start 1 time, attempting to start again..."
            sudo systemctl start v3s-redis
            echo -e "\e"
            echo -e "\e"
            echo -e "v3s-redis status"
            sudo systemctl status v3s-redis | head -n 7
        fi
    fi

    #watchdog-services
    watchdog_status=$(systemctl is-enabled watchdog)
    watchdog_state=$(systemctl is-active watchdog)
    if [[$watchdog_status == "enabled" ]] && [[ $watchdog_state != "active" ]] 
    then
        sleep 5
        echo "watchdog not active, attempting to start..."
        sudo systemctl start watchdog
        watchdog_check1=$(systemctl is-active watchdog)
        if [[ $watchdog_check1 != "active" ]] 
            sleep 5
            echo "failed to start 1 time, attempting to start again..."
            sudo systemctl start watchdog
            echo -e "\e"
            echo -e "\e"
            echo -e "watchdog status"
            sudo systemctl status watchdog | head -n 7
        fi
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

startGrid
