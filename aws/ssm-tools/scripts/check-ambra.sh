#! /bin/bash
function checkDga() {
    if [[ -f "/etc/systemd/system/dga.service" ]]
    then
        dga_status=$(systemctl is-enabled dga)
        if [[ $dga_status == "enabled" ]]
        then
            echo -e "\e"
            echo -e "dga status"
            echo -e "\e"
            sudo systemctl status dga
        fi
    else
        echo "dga does not exist"
    fi
}

function checkGrid() {
    if [[ -f "/etc/systemd/system/grid.service" ]]
    then
        grid_status=$(systemctl is-enabled grid)
        if [[ $grid_status == "enabled" ]]
        then
            echo -e "\e"
            echo -e "grid status"
            sudo systemctl status grid
            echo -e "\e"
        fi
    else
        echo "grid does not exist"
    fi
}

function checkHaproxy() {
    if [[ -f /etc/systemd/system/multi-user.target.wants/haproxy.service ]]
    then
        haproxy_status=$(systemctl is-enabled haproxy)
        if [[ $haproxy_status == "enabled" ]]
        then
            echo -e "\e"
            echo -e "haproxy status"
            sudo systemctl status haproxy
            echo -e "\e"
        fi
    else
        echo "haproxy does not exist"
    fi
}

function checkOpenresty() {
    if [[ -f /etc/systemd/system/multi-user.target.wants/openresty.service ]]
    then
        openresty_status=$(systemctl is-enabled openresty)
        openresty_state=$(systemctl is-active openresty)
        if [[ $openresty_status == "enabled" ]]
        then
            echo -e "\e"
            echo -e "openresty status"
            sudo systemctl status openresty
            echo -e "\e"
        fi
    else
        echo "openresty does not exist"
    fi
}

function checkTranscoding() {
    if [[ -f /etc/systemd/system/transcoding* ]]
    then
        transcoding_status=$(systemctl is-enabled transcoding*)
        if [[ $transcoding_status == *"enabled"* ]]
        then
            echo -e "\e"
            echo -e "transcoding status"
            sudo systemctl status transcoding*
            echo -e "\e"
        fi
    else
        echo "transcoding services do not exist"
    fi
}

function checkV3sApache() {
    if [[ -f /etc/systemd/system/v3s-apache.service ]]
    then
        v3s-apache_status=$(systemctl is-enabled v3s-apache)
        if [[ $v3s-apache_status == "enabled" ]]
        then
            echo -e "\e"
            echo -e "v3s-apache status"
            sudo systemctl status v3s-apache
            echo -e "\e"
        fi
    else
        echo "v3s-apache does not exist"
    fi
}

function checkV3sCron() {
    if [[ -f /etc/systemd/system/v3s-cron.service ]]
    then
        v3s-cron_status=$(systemctl is-enabled v3s-cron)
        if [[ $v3s-cron_status == "enabled" ]]
        then
            echo -e "\e"
            echo -e "v3s-cron status"
            sudo systemctl status v3s-cron
            echo -e "\e"
        fi
    else
        echo "v3s-cron does not exist"
    fi
}

function checkV3sPostgres() {
    if [[ -f /etc/systemd/system/v3s-postgres.service ]]
    then
        v3s-postgres_status=$(systemctl is-enabled v3s-postgres)
        if [[ $v3s-postgres_status == "enabled" ]]
        then
            echo -e "\e"
            echo -e "v3s-postgres status"
            sudo systemctl status v3s-postgres
            echo -e "\e"
       fi
    else
        echo "v3s-postgres does not exist"
    fi
}

function checkV3sRedis() {
    if [[ -f /etc/systemd/system/v3s-redis.service ]]
    then
        v3s-redis_status=$(systemctl is-enabled v3s-redis)
        if [[ $v3s-redis_status == "enabled" ]]
        then
            echo -e "\e"
            echo -e "v3s-redis status"
            sudo systemctl status v3s-redis
            echo -e "\e"
        fi
    else
        echo "v3s-redis does not exist"
    fi
}

function checkWatchdog() {
    if [[ -f /etc/systemd/system/multi-user.target.wants/watchdog-services.service ]]
    then
        watchdog_status=$(systemctl is-enabled watchdog)
        if [[ $watchdog_status == "enabled" ]]
        then
            echo -e "\e"
            echo -e "watchdog status"
            sudo systemctl status watchdog-services
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
    checkDga
    checkGrid
    checkHaproxy
    checkOpenresty
    checkTranscoding
    checkV3sApache
    checkV3sCron
    checkV3sPostgres
    checkV3sRedis
    checkWatchdog
}

main