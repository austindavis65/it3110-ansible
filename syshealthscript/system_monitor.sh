#!/bin/bash

# basic config 

LOG_FILE="/var/log/system_monitor.log"
ALERT_EMAIL="austin.davis@utahtech.edu"

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90
HOST=$(hostname)

DATE=$(date '+%Y-%m-%d %H:%M:%S')

# basic functions

log_message() {
    echo "[$DATE] $1" >> $LOG_FILE
}

send_alert() {
    echo "$1" | mail -s "System Alert" $ALERT_EMAIL
}

#system log start message

log_message "System Monitor Test Start on $HOST"

# cpu check

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d "." -f1)

log_message "CPU Usage: $CPU_USAGE%"

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    ALERT="WARNING: CPU usage is high at $CPU_USAGE%"
    log_message "$ALERT"
    send_alert "$ALERT"
fi

# memory check

MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d "." -f1)

log_message "Memory Usage: $MEM_USAGE%"

if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
    ALERT="WARNING: Memory usage is high at $MEM_USAGE%"
    log_message "$ALERT"
    send_alert "$ALERT"
fi

# disk usage check 

DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

log_message "Disk Usage: $DISK_USAGE%"

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    ALERT="WARNING: Disk usage is high at $DISK_USAGE%"
    log_message "$ALERT"
    send_alert "$ALERT"
fi

# check of a vital service 

SERVICE="isc-dhcp-server"

if systemctl is-active --quiet $SERVICE; then
    log_message "Service $SERVICE is running"
else
    ALERT="CRITICAL: Service $SERVICE is NOT running"
    log_message "$ALERT"
    send_alert "$ALERT"
fi

# log message end of check 

log_message "System check complete"
echo "Check completed at $DATE"
