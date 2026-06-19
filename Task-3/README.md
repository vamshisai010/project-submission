# Task 3: Container Monitoring and Automated Logging

## Objective

Monitor Docker container resource usage by capturing CPU and memory consumption with timestamps and automate the process using a cron job. Store all logs in a dedicated monitoring directory.

---

## Environment

* Server: AWS EC2 Ubuntu
* Container Runtime: Docker
* Container Name: `index`
* Monitoring Directory: `/opt/container-monitor/logs`
* Log File: `container_usage.log`
* Scheduler: Cron

---

## Step 1: Create Monitoring Directory

### Commands

```bash
sudo mkdir -p /opt/container-monitor/logs
cd /opt/container-monitor/logs
```

### Purpose

Create a dedicated directory to store monitoring scripts and log files.

---

## Step 2: Create Monitoring Script

### File

```text
monitor.sh
```

### Script

```bash
#!/bin/bash

CONTAINER_NAME="index"
LOG_FILE="/opt/container-monitor/logs/container_usage.log"
DOCKER="/usr/bin/docker"
DATE="/usr/bin/date"

TIMESTAMP=$($DATE '+%Y-%m-%d %H:%M:%S')

CPU_USAGE=$($DOCKER stats "$CONTAINER_NAME" --no-stream --format "{{.CPUPerc}}")
MEM_USAGE=$($DOCKER stats "$CONTAINER_NAME" --no-stream --format "{{.MemUsage}}")

echo "$TIMESTAMP | Container: $CONTAINER_NAME | CPU: $CPU_USAGE | Memory: $MEM_USAGE" >> "$LOG_FILE"
```

### Purpose

The script performs the following tasks:

* Collects CPU utilization of the container.
* Collects memory utilization of the container.
* Generates timestamps.
* Appends the information to a log file.

---

## Step 3: Grant Execute Permission

### Command

```bash
chmod +x /opt/container-monitor/logs/monitor.sh
```

### Purpose

Allow the script to be executed.

---

## Step 4: Test Script Manually

### Command

```bash
/opt/container-monitor/logs/monitor.sh
```

### Verify Logs

```bash
cat /opt/container-monitor/logs/container_usage.log
```

Example Output

```text
2026-06-19 06:42:16 | Container: index | CPU: 0.00% | Memory: 3.32MiB / 908.7MiB
2026-06-19 06:50:56 | Container: index | CPU: 0.00% | Memory: 3.57MiB / 908.7MiB
```

---

## Step 5: Configure Cron Job

### Edit Crontab

```bash
crontab -e
```

### Add Entry

```cron
* * * * * /opt/container-monitor/logs/monitor.sh
```

### Verify Cron Job

```bash
crontab -l
```

Output

```text
* * * * * /opt/container-monitor/logs/monitor.sh
```

### Purpose

Execute the monitoring script automatically every minute.

---

## Step 6: Verify Automatic Logging

### Command

```bash
tail -f /opt/container-monitor/logs/container_usage.log
```

Example Output

```text
2026-06-19 06:58:01 | Container: index | CPU: 0.00% | Memory: 3.57MiB / 908.7MiB
2026-06-19 06:59:01 | Container: index | CPU: 0.00% | Memory: 3.57MiB / 908.7MiB
2026-06-19 07:00:01 | Container: index | CPU: 0.00% | Memory: 3.57MiB / 908.7MiB
```

---

## Files Used

### monitor.sh

Monitoring script responsible for collecting container statistics.

### container_usage.log

Stores timestamped CPU and memory utilization data.

---

## Monitoring Architecture

```text
Docker Container (index)
          │
          ▼
monitor.sh
          │
          ▼
docker stats --no-stream
          │
          ▼
container_usage.log
          │
          ▼
Cron Scheduler
(runs every minute)
```

---

## Outcome

* Created a monitoring directory.
* Developed a shell script to capture container CPU and memory usage.
* Added timestamps for each log entry.
* Stored logs in `/opt/container-monitor/logs`.
* Automated monitoring using a cron job.
* Verified automatic log generation every minute.

## Task Status

✅ Completed

