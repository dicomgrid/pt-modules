#! /bin/bash
function stopDga() {
    if [[ -f "/etc/systemd/system/dga.service" ]]
    then
        dga_status=$(systemctl is-enabled dga)
        dga_state=$(systemctl is-active dga)
        if [[ $dga_status == "enabled" ]] && [[ $dga_state == "active" ]]
        then
            echo "Attempting to stop dga..."
            sudo systemctl stop dga
        fi
        echo -e "\e"
        echo -e "dga status"
        sudo systemctl status dga
        echo -e "\e"
    else
        echo "dga does not exist"
    fi
}

function stopGrid() {
    if [[ -f "/etc/systemd/system/grid.service" ]]
    then
        grid_status=$(systemctl is-enabled grid)
        grid_state=$(systemctl is-active grid)
        if [[ $grid_status == "enabled" ]] && [[ $grid_state == "active" ]] 
        then
            echo "Attempting to stop grid..."
            sudo systemctl stop grid
        fi
        echo -e "\e"
        echo -e "grid status"
        sudo systemctl status grid
        echo -e "\e"
    else
        echo "grid does not exist"
    fi   
}
    
function stopHaproxy() {
    if [[ -f /etc/systemd/system/multi-user.target.wants/haproxy.service ]]
    then
        haproxy_status=$(systemctl is-enabled haproxy)
        haproxy_state=$(systemctl is-active haproxy)
        if [[ $haproxy_status == "enabled" ]] && [[ $haproxy_state == "active" ]] 
        then
            echo "Attempting to stop haproxy..."
            sudo systemctl stop haproxy
        fi
        echo -e "\e"
        echo -e "haproxy status"
        sudo systemctl status haproxy
        echo -e "\e"
    else
        echo "haproxy does not exist"
    fi 
}

function stopOpenresty() {
    if [[ -f /etc/systemd/system/multi-user.target.wants/openresty.service ]]
    then
        openresty_status=$(systemctl is-enabled openresty)
        openresty_state=$(systemctl is-active openresty)
        if [[ $openresty_status == "enabled" ]] && [[ $openresty_state == "active" ]] 
        then
            echo "Attempting to stop openresty..."
            sudo systemctl stop openresty
        fi
        echo -e "\e"
        echo -e "openresty status"
        sudo systemctl status openresty
        echo -e "\e"
    else
        echo "openresty does not exist"
    fi 
}


function stopTranscoding() {
    if [[ -f /etc/systemd/system/transcoding* ]]
    then
        transcoding_status=$(systemctl is-enabled transcoding*)
        transcoding_state=$(systemctl is-active transcoding*)
        if [[ $transcoding_status == *"enabled"* ]] && [[ $transcoding_state == *"active"* ]] 
        then
            echo "Attempting to stop transcoding services..."
            sudo systemctl stop transcoding*
            fi
        echo -e "\e"
        echo -e "transcoding status"
        sudo systemctl status transcoding*
        echo -e "\e"
    else
        echo "transcoding does not exist"
    fi 
}

function stopV3sApache() {
    if [[ -f /etc/systemd/system/v3s-apache.service ]]
    then
        v3s-apache_status=$(systemctl is-enabled v3s-apache)
        v3s-apache_state=$(systemctl is-active v3s-apache)
        if [[ $v3s-apache_status == "enabled" ]] && [[ $v3s-apache_state == "active" ]] 
        then
            echo "Attempting to stop v3s-apache services..."
            sudo systemctl stop v3s-apache
        fi
        echo -e "\e"
        echo -e "v3s-apache status"
        sudo systemctl status v3s-apache
        echo -e "\e"
    else
        echo "v3s-apache does not exist"
    fi 
}

function stopV3sCron() { 
    if [[ -f /etc/systemd/system/v3s-cron.service ]]
    then
        v3s-cron_status=$(systemctl is-enabled v3s-cron)
        v3s-cron_state=$(systemctl is-active v3s-cron)
        if [[ $v3s-cron_status == "enabled" ]] && [[ $v3s-cron_state == "active" ]] 
        then
            echo "Attempting to stop v3s-cron services..."
            sudo systemctl stop v3s-cron
            sudo -u v3s -i ctl cron_stop #drain manually started processes
            sleep 600 #to allow ingestion to drain
        fi
        echo -e "\e"
        echo -e "v3s-cron status"
        sudo systemctl status v3s-cron
        echo -e "\e"
    else
        echo "v3s-cron does not exist"
    fi
}

function stopV3sPostgres() {
    if [[ -f /etc/systemd/system/v3s-postgres.service ]]
    then
        v3s-postgres_status=$(systemctl is-enabled v3s-postgres)
        v3s-postgres_state=$(systemctl is-active v3s-postgres)
        if [[ $v3s-postgres_status == "enabled" ]] && [[ $v3s-postgres_state == "active" ]] 
        then
            echo "Attempting to stop v3s-postgres services..."
            sudo systemctl stop v3s-postgres
            fi
        echo -e "\e"
        echo -e "v3s-postgres status"
        sudo systemctl status v3s-postgres
        echo -e "\e"
    else
        echo "v3s-postgres does not exist"
    fi
}

function stopV3sRedis() {
    if [[ -f /etc/systemd/system/v3s-redis.service ]]
    then
        v3s-redis_status=$(systemctl is-enabled v3s-redis)
        v3s-redis_state=$(systemctl is-active v3s-redis)
        if [[ $v3s-redis_status == "enabled" ]] && [[ $v3s-redis_state == "active" ]] 
        then
            echo "Attempting to stop v3s-redis services..."
            sudo systemctl stop v3s-redis
        fi
            echo -e "\e"
            echo -e "v3s-redis status"
            sudo systemctl status v3s-redis
            echo -e "\e"
    else
        echo "v3s-redis does not exist"
    fi
}

function stopWatchdog() {
    if [[ -f /etc/systemd/system/multi-user.target.wants/watchdog-services.service ]]
    then
        watchdog_status=$(systemctl is-enabled watchdog)
        watchdog_state=$(systemctl is-active watchdog)
        if [[ $watchdog_status == "enabled" ]] && [[ $watchdog_state == "active" ]] 
        then
            echo "Attempting to stop watchdog services..."
            sudo systemctl stop watchdog-services
        fi
            echo -e "\e"
            echo -e "watchdog status"
            sudo systemctl status watchdog
            echo -e "\e"
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

export REPOS="--disablerepo=* --enablerepo=base --enablerepo=epel --enablerepo=base --enablerepo=updates"
sudo yum ${REPOS} update -y
sudo yum-complete-transaction --cleanup-only
export REBOOT=$(needs-restarting -r | grep required)
if [[ $REBOOT ]]
then
        echo "Stopping grid services and Rebooting now..."
        export -f stopV3sCron
        stopV3sCron
        export -f stopDga
        stopDga
        export -f stopGrid
        stopGrid
        export -f stopHaproxy
        stopHaproxy
        export -f stopOpenresty
        stopOpenresty
        export -f stopTranscoding
        stopTranscoding
        export -f stopV3sApache
        stopV3sApache
        export -f stopV3sRedis
        stopV3sRedis
        export -f stopWatchdog
        stopWatchdog
        export -f stopV3sPostgres
        stopV3sPostgres
        exit 194
else
        echo "Exiting..."
        exit 0
fi