#!/bin/bash

# ============================
# CONFIG
# ============================

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90
HOST=$(hostname)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# ============================
# CPU USAGE
# ============================

CPU_IDLE=$(top -bn1 | awk '/Cpu\(s\)/ {print $8}' | cut -d. -f1)
CPU_USAGE=$((100 - CPU_IDLE))

[ "$CPU_USAGE" -lt 0 ] && CPU_USAGE=0

CPU_STATUS="OK"
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
  CPU_STATUS="WARNING"
fi

# ============================
# MEMORY USAGE
# ============================

MEM_USAGE=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')

MEM_STATUS="OK"
if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
  MEM_STATUS="WARNING"
fi

# ============================
# DISK USAGE
# ============================

DISK_USAGE=$(df / | awk 'END {gsub("%","",$5); print $5}')

DISK_STATUS="OK"
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
  DISK_STATUS="WARNING"
fi

# ============================
# SERVICE CHECK
# ============================

SERVICE="apache2"

if systemctl is-active --quiet "$SERVICE"; then
  SERVICE_STATUS="running"
else
  SERVICE_STATUS="stopped"
fi

# ============================
# OUTPUT (ANSIBLE CONSUMPTION)
# ============================

cat <<EOF 
Host: $HOST
Timestamp: $DATE

CPU: $CPU_USAGE% ($CPU_STATUS)
Memory: $MEM_USAGE% ($MEM_STATUS)
Disk: $DISK_USAGE% ($DISK_STATUS)

Service: $SERVICE ($SERVICE_STATUS)

EOF
