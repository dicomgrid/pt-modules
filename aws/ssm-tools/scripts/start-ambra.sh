#! /bin/bash
set -e

function startGrid() {
    #dga
    if [[ -e $(ls /etc/systemd/system/dga.service) ]] 
    then
            echo "Attempting to start grid..."
            sudo systemctl enable dga
            sudo systemctl start dga
            echo -e "\e"
            echo -e "\e"
            echo -e "dga status"
            sudo systemctl status dga | head -n 7
    fi

    #grid
    if [[ -e $(ls /etc/systemd/system/grid.service) ]] 
    then
            echo "Attempting to start grid..."
            sudo systemctl enable grid
            sudo systemctl start grid
            echo -e "\e"
            echo -e "\e"
            echo -e "grid status"
            sudo systemctl status grid | head -n 7
    fi
    
    #haproxy
    if [[ -e $(ls /etc/systemd/system/multi-user.target.wants/haproxy.service) ]] 
    then
            echo "Attempting to start haproxy..."
            sudo systemctl enable haproxy
            sudo systemctl start haproxy
            echo -e "\e"
            echo -e "\e"
            echo -e "haproxy status"
            sudo systemctl status haproxy | head -n 7
    fi

    #openresty
    if [[ -e $(ls /etc/systemd/system/multi-user.target.wants/openresty.service) ]] 
    then
            echo "Attempting to start openresty..."
            sudo systemctl start openresty
            echo -e "\e"
            echo -e "\e"
            echo -e "openresty status"
            sudo systemctl status openresty
    fi

    #redis
    if [[ -e $(ls /etc/systemd/system/v3s-redis.service) ]] 
    then
            echo "Attempting to start v3s-redis..."
            sudo systemctl start v3s-redis
            echo -e "\e"
            echo -e "\e"
            echo -e "v3s-redis status"
            sudo systemctl status v3s-redis
    fi

    #transcoding
    if [[ -e $(ls /etc/systemd/system/transcoding*) ]] 
    then
            echo "Attempting to start transcoding services..."
            sudo systemctl start transcoding*
            echo -e "\e"
            echo -e "\e"
            echo -e "transcoding status"
            sudo systemctl status transcoding*
    fi

    #v3s
    if [[ -e $(ls /home/v3s/bin/ctl) ]] 
    then
            echo "Attempting to start grid services..."
            su v3s -c "bash -c /home/v3s/bin/ctl start_all"
            echo -e "\e"
            echo -e "\e"
            echo -e "ctl status"
            su v3s -c "bash -c /home/v3s/bin/ctl status"
    fi

    #watchdog-services
    if [[ -e $(ls /etc/systemd/system/multi-user.target.wants/watchdog-services.service) ]] 
    then
            echo "Attempting to start watchdog services..."
            sudo systemctl start watchdog-services
            echo -e "\e"
            echo -e "\e"
            echo -e "watchdog status"
            sudo systemctl status watchdog-services
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
