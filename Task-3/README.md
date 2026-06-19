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
sudo -i
sudo mkdir -p /opt/container-monitor/logs
cd /opt/container-monitor/logs
```

### Purpose

Create a dedicated directory to store monitoring scripts and log files.

---

## Step 2: Create Monitoring Script

### File

```text
nano monitor.sh or vi monitor.sh
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
/opt/container-monitor/logs/monitor.sh or ./monitor.sh
```

### Verify Logs

```bash
cat /opt/container-monitor/logs/container_usage.log
```

Example Output

```text
root@ip-172-31-0-50:/opt/container-monitor/logs# /opt/container-monitor/logs/monitor.sh
root@ip-172-31-0-50:/opt/container-monitor/logs# cat /opt/container-monitor/logs/container_usage.log
2026-06-19 11:26:41 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
2026-06-19 11:26:55 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
```

---

## Step 5: Configure Cron Job

### Edit Crontab

```bash
root@ip-172-31-0-50:/opt/container-monitor/logs# crontab -e
no crontab for root - using an empty one
Select an editor.  To change later, run select-editor again.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.basic
  3. /usr/bin/vim.tiny
  4. /bin/ed

Choose 1-4 [1]: 1
crontab: installing new crontab
root@ip-172-31-0-50:/opt/container-monitor/logs#
```

### Add Entry

```cron
ADD this path in crontab editor at the end

* * * * * /opt/container-monitor/logs/monitor.sh
```

### Verify Cron Job

```bash
crontab -l
```

Output

```text
root@ip-172-31-0-50:/opt/container-monitor/logs# crontab -l
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
* * * * * /opt/container-monitor/logs/monitor.sh
root@ip-172-31-0-50:/opt/container-monitor/logs#

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
root@ip-172-31-0-50:/opt/container-monitor/logs# tail -f /opt/container-monitor/logs/container_usage.log
2026-06-19 11:26:41 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
2026-06-19 11:26:55 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
2026-06-19 11:32:01 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
2026-06-19 11:33:01 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
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

