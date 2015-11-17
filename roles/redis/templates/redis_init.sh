#!/bin/sh
#
# Simple Redis init.d script conceived to work on Linux systems
# as it does use of the /proc filesystem.

# REDISPORT=6379
REDISSOCKET={{ socket_file }}
EXEC={{ install_dir }}/bin/redis-server
CLIEXEC={{ install_dir }}/bin/redis-cli

# PIDFILE=/var/run/redis_${REDISPORT}.pid
PIDFILE={{ pid_file }}
# CONF="/etc/redis/${REDISPORT}.conf"
CONF="/etc/redis.conf"

case "$1" in
    start)
        if [ -f $PIDFILE ]
        then
                echo "$PIDFILE exists, process is already running or crashed"
        else
                echo "Starting Redis server..."
                $EXEC $CONF
        fi
        ;;
    stop)
        if [ ! -f $PIDFILE ]
        then
                echo "$PIDFILE does not exist, process is not running"
        else
                PID=$(cat $PIDFILE)
                echo "Stopping ..."
                # $CLIEXEC -p $REDISPORT shutdown
                $CLIEXEC -s $REDISSOCKET shutdown
                while [ -x /proc/${PID} ]
                do
                    echo "Waiting for Redis to shutdown ..."
                    sleep 1
                done
                echo "Redis stopped"
        fi
        ;;
    *)
        echo "Please use start or stop as first argument"
        ;;
esac
