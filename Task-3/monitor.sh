#!/bin/bash

CONTAINER_NAME="index"
LOG_FILE="/opt/container-monitor/logs/container_usage.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

CPU_USAGE=$(docker stats "$CONTAINER_NAME" --no-stream --format "{{.CPUPerc}}")
MEM_USAGE=$(docker stats "$CONTAINER_NAME" --no-stream --format "{{.MemUsage}}")

echo "$TIMESTAMP | Container: $CONTAINER_NAME | CPU: $CPU_USAGE | Memory: $MEM_USAGE" >> "$LOG_FILE"
