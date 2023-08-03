#! /bin/bash
function startDga() {
    if [[ -f "/etc/systemd/system/dga.service" ]]
    then
        dga_status=$(systemctl is-enabled dga)
        dga_state=$(systemctl is-active dga)
        if [[ $dga_status == "enabled" ]] && [[ $dga_state != "active" ]] 
        then
            sleep 5
            echo "dga enabled, but not active. attempting to start..."
            sudo systemctl start dga
            dga_check1=$(systemctl is-active dga)
            if [[ $dga_check1 != "active" ]]
            then
                sleep 5
                echo "failed to start 1 time, attempting to start again..."
                sudo systemctl start dga
            fi
        fi
        echo -e "\e"
        echo -e "dga status"
        sudo systemctl status dga
        echo -e "\e"

    else
        echo "dga does not exist"
    fi
}

function startGrid() {
    if [[ -f "/etc/systemd/system/grid.service" ]]
    then
        grid_status=$(systemctl is-enabled grid)
        grid_state=$(systemctl is-active grid)
        if [[ $grid_status == "enabled" ]] && [[ $grid_state != "active" ]] 
        then
            sleep 5
            echo "grid enabled, but not active. attempting to start..."
            sudo systemctl start grid
            grid_check1=$(systemctl is-active grid)
            if [[ $grid_check1 != "active" ]]
            then
                sleep 5
                echo "failed to start 1 time, attempting to start again..."
                sudo systemctl start grid
            fi
        echo -e "\e"
        echo -e "grid status"
        sudo systemctl status grid
        echo -e "\e"
        fi
    else
        echo "grid does not exist"
    fi   
}

function startHaproxy() {
    if [[ -f /etc/systemd/system/multi-user.target.wants/haproxy.service ]]
    then
        haproxy_status=$(systemctl is-enabled haproxy)
        haproxy_state=$(systemctl is-active haproxy)
        if [[ $haproxy_status == "enabled" ]] && [[ $haproxy_state != "active" ]] 
        then
            sleep 5
            echo "haproxy enabled, but not active. attempting to start..."
            sudo systemctl start haproxy
            haproxy_check1=$(systemctl is-active haproxy)
            if [[ $haproxy_check1 != "active" ]]
            then
                sleep 5
                echo "failed to start 1 time, attempting to start again..."
                sudo systemctl start haproxy
            fi
        echo -e "\e"
        echo -e "haproxy status"
        sudo systemctl status haproxy
        echo -e "\e"
        fi
    else
        echo "haproxy does not exist"
    fi 
}

function startOpenresty() {
    if [[ -f /etc/systemd/system/multi-user.target.wants/openresty.service ]]
    then
        openresty_status=$(systemctl is-enabled openresty)
        openresty_state=$(systemctl is-active openresty)
        if [[ $openresty_status == "enabled" ]] && [[ $openresty_state != "active" ]] 
        then
            sleep 5
            echo "openresty enabled, but not active. attempting to start..."
            sudo systemctl start openresty
            openresty_check1=$(systemctl is-active openresty)
            if [[ $openresty_check1 != "active" ]]
            then
                sleep 5
                echo "failed to start 1 time, attempting to start again..."
                sudo systemctl start openresty
            fi
        echo -e "\e"
        echo -e "openresty status"
        sudo systemctl status openresty
        echo -e "\e"
        fi
    else
        echo "openresty does not exist"
    fi 
}

function startTranscoding() {
    if [[ -f /etc/systemd/system/transcoding* ]]
    then
        transcoding_status=$(systemctl is-enabled transcoding*)
        transcoding_state=$(systemctl is-active transcoding*)
        if [[ $transcoding_status == *"enabled"* ]] && [[ $transcoding_state != *"active"* ]] 
        then
            sleep 5
            echo "transcoding enabled, but not active. attempting to start..."
            sudo systemctl start transcoding*
            transcoding_check1=$(systemctl is-active transcoding*)
            if [[ $transcoding_check1 != *"active"* ]]
            then
                sleep 5
                echo "failed to start 1 time, attempting to start again..."
                sudo systemctl start transcoding*
            fi
        echo -e "\e"
        echo -e "transcoding status"
        sudo systemctl status transcoding*
        echo -e "\e"
        fi
    else
        echo "transcoding does not exist"
    fi 
}

function startV3sApache() {
    if [[ -f /etc/systemd/system/v3s-apache.service ]]
    then
        v3s-apache_status=$(systemctl is-enabled v3s-apache)
        v3s-apache_state=$(systemctl is-active v3s-apache)
        if [[ $v3s-apache_status == "enabled" ]] && [[ $v3s-apache_state != "active" ]] 
        then
            sleep 5
            echo "v3s-apache enabled, but not active. attempting to start..."
            sudo systemctl start v3s-apache
            v3s-apache_check1=$(systemctl is-active v3s-apache)
            if [[ $v3s-apache_check1 != "active" ]]
            then
                sleep 5
                echo "failed to start 1 time, attempting to start again..."
                sudo systemctl start v3s-apache
            fi
        echo -e "\e"
        echo -e "v3s-apache status"
        sudo systemctl status v3s-apache
        echo -e "\e"
        fi
    else
        echo "v3s-apache does not exist"
    fi 
}

function startV3sCron() {
    if [[ -f /etc/systemd/system/v3s-cron.service ]]
    then
        v3s-cron_status=$(systemctl is-enabled v3s-cron)
        v3s-cron_state=$(systemctl is-active v3s-cron)
        if [[ $v3s-cron_status == "enabled" ]] && [[ $v3s-cron_state != "active" ]] 
        then
            sleep 5
            echo "v3s-cron enabled, but not active. attempting to start..."
            sudo systemctl start v3s-cron
            v3s-cron_check1=$(systemctl is-active v3s-cron)
            if [[ $v3s-cron_check1 != "active" ]]
            then
                sleep 5
                echo "failed to start 1 time, attempting to start again..."
                sudo systemctl start v3s-cron
            fi
        echo -e "\e"
        echo -e "v3s-cron status"
        sudo systemctl status v3s-cron
        echo -e "\e"
        fi
    else
        echo "v3s-cron does not exist"
    fi
}

function startV3sPostgres() {
    if [[ -f /etc/systemd/system/v3s-postgres.service ]]
    then
        v3s-postgres_status=$(systemctl is-enabled v3s-postgres)
        v3s-postgres_state=$(systemctl is-active v3s-postgres)
        if [[ $v3s-postgres_status == "enabled" ]] && [[ $v3s-postgres_state != "active" ]] 
        then
            sleep 5
            echo "v3s-postgres enabled, but not active. attempting to start..."
            sudo systemctl start v3s-postgres
            v3s-postgres_check1=$(systemctl is-active v3s-postgres)
            if [[ $v3s-postgres_check1 != "active" ]]
            then
                sleep 5
                echo "failed to start 1 time, attempting to start again..."
                sudo systemctl start v3s-postgres
            fi
        echo -e "\e"
        echo -e "v3s-postgres status"
        sudo systemctl status v3s-postgres
        echo -e "\e"
        fi
    else
        echo "v3s-postgres does not exist"
    fi
}

function startV3sRedis() {
    if [[ -f /etc/systemd/system/v3s-redis.service ]]
    then
        v3s-redis_status=$(systemctl is-enabled v3s-redis)
        v3s-redis_state=$(systemctl is-active v3s-redis)
        if [[ $v3s-redis_status == "enabled" ]] && [[ $v3s-redis_state != "active" ]] 
        then
            sleep 5
            echo "v3s-redis enabled, but not active. attempting to start..."
            sudo systemctl start v3s-redis
            v3s-redis_check1=$(systemctl is-active v3s-redis)
            if [[ $v3s-redis_check1 != "active" ]]
            then
                sleep 5
                echo "failed to start 1 time, attempting to start again..."
                sudo systemctl start v3s-redis
            fi
        echo -e "\e"
        echo -e "v3s-redis status"
        sudo systemctl status v3s-redis
        echo -e "\e"
        fi
    else
        echo "v3s-redis does not exist"
    fi
}

function startWatchdog() {
    if [[ -f /etc/systemd/system/multi-user.target.wants/watchdog-services.service ]]
    then
        watchdog_status=$(systemctl is-enabled watchdog)
        watchdog_state=$(systemctl is-active watchdog)
        if [[ $watchdog_status == "enabled" ]] && [[ $watchdog_state != "active" ]] 
        then
            sleep 5
            echo "watchdog enabled, but not active. attempting to start..."
            sudo systemctl start watchdog
            watchdog_check1=$(systemctl is-active watchdog)
            if [[ $watchdog_check1 != "active" ]]
            then
                sleep 5
                echo "failed to start 1 time, attempting to start again..."
                sudo systemctl start watchdog
            fi
        echo -e "\e"
        echo -e "watchdog status"
        sudo systemctl status watchdog
        echo -e "\e"
        fi
    else
        echo "watchdog does not exist"
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
    startV3sPostgres
    startWatchdog
    startV3sRedis
    startTranscoding
    startV3sApache
    startOpenresty
    startHaproxy
    startGrid
    startDga
    startV3sCron
}
main