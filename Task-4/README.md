# Task 4: Secure Monitoring Logs Using a Dedicated User

## Objective

Create a dedicated user for monitoring operations and secure the monitoring directory by assigning ownership and restricting access to unauthorized users.

---

## Environment

* Server: AWS EC2 Ubuntu
* Monitoring User: `monitoruser`
* Test User: `testuser`
* Monitoring Directory: `/opt/container-monitor`

---

## Step 1: Create a Dedicated User

### Command

```bash
sudo useradd -m monitoruser
```

### Set Password

```bash
sudo passwd monitoruser
```

### Verify User

```bash
id monitoruser
```

Output

```text
root@ip-172-31-0-50:~# sudo useradd -m monitoruser
root@ip-172-31-0-50:~# sudo passwd monitoruser
New password:
Retype new password:
passwd: password updated successfully
root@ip-172-31-0-50:~# id monitoruser
uid=1001(monitoruser) gid=1001(monitoruser) groups=1001(monitoruser)
root@ip-172-31-0-50:~#
```

### Purpose

Create a dedicated user responsible for managing monitoring operations.

---

## Step 2: Assign Ownership to Monitoring Directory

### Command

```bash
sudo chown -R monitoruser:monitoruser /opt/container-monitor
```

### Verify Ownership

```bash
ls -ld /opt/container-monitor
```

Output

```text
root@ip-172-31-0-50:~# sudo chown -R monitoruser:monitoruser /opt/container-monitor
root@ip-172-31-0-50:~# ls -ld /opt/container-monitor
drwxr-xr-x 3 monitoruser monitoruser 4096 Jun 19 11:22 /opt/container-monitor
root@ip-172-31-0-50:~#
```

### Purpose

Transfer ownership of the monitoring directory and its contents to the dedicated monitoring user.

---

## Step 3: Restrict Access and Secure Files

### Commands

```bash
sudo chmod 700 /opt/container-monitor
sudo chmod 700 /opt/container-monitor/logs
sudo chmod 600 /opt/container-monitor/logs/container_usage.log
sudo chmod 700 /opt/container-monitor/logs/monitor.sh
```

### Verify Permissions

```bash
ls -lR /opt/container-monitor
```

Output

```text
root@ip-172-31-0-50:~# ls -lR /opt/container-monitor

/opt/container-monitor:
total 4
drwx------ 2 monitoruser monitoruser 4096 Jun 19 11:26 logs

/opt/container-monitor/logs:
total 8
-rw------- 1 monitoruser monitoruser 1804 Jun 19 11:51 container_usage.log
-rwx------ 1 monitoruser monitoruser  448 Jun 19 11:24 monitor.sh

root@ip-172-31-0-50:~#
```

### Purpose

* Grant full access only to `monitoruser`.
* Prevent other users from reading logs or executing scripts.
* Secure monitoring data and scripts.

---

## Step 4: Verify Authorized Access

### Switch to Monitoring User

```bash
su - monitoruser
```

### Access Monitoring Directory

```bash
$ cd /opt/container-monitor/logs
$ ls
container_usage.log  monitor.sh

$ cat container_usage.log
2026-06-19 11:26:41 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
2026-06-19 11:26:55 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
2026-06-19 11:32:01 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
2026-06-19 11:33:01 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
2026-06-19 11:34:01 | Container: index | CPU: 0.00% | Memory: 3.371MiB / 908.7MiB
...
```

### Result

Successfully accessed the monitoring directory and log files.

---

## Step 5: Verify Access Restriction

### Create Test User

```bash
$ sudo useradd -m testuser

root@ip-172-31-0-50:~$ sudo passwd testuser
New password:
Retype new password:
passwd: password updated successfully
```

### Switch User

```bash
root@ip-172-31-0-50:~$ su - testuser
Password:
$
```

### Attempt Access

```bash
cd /opt/container-monitor
```

### Output

```text
-bash: cd: /opt/container-monitor: Permission denied

also ubuntu user can't access

ubuntu@ip-172-31-0-50:~$ cd /opt/container-monitor
-bash: cd: /opt/container-monitor: Permission denied
```

### Purpose

Verify that unauthorized users cannot access the monitoring directory.

---

## Ownership Verification

### Command

```bash
ls -lR /opt/container-monitor
```

Output

```text
/opt/container-monitor:
drwx------ monitoruser monitoruser

logs/

/opt/container-monitor/logs:
-rw------- monitoruser monitoruser container_usage.log
-rwx------ monitoruser monitoruser monitor.sh
```

---

## Access Control Architecture

```text
                 Root User
                     │
                     ▼
             /opt/container-monitor
                     │
         ┌───────────┴───────────┐
         │                       │
         ▼                       ▼
   monitoruser              Other Users
 (Owner - Full Access)     (Permission Denied)
```

---

## Verification Commands

### Verify User

```bash
id monitoruser
```

### Verify Ownership

```bash
ls -ld /opt/container-monitor
```

### Verify Permissions

```bash
ls -lR /opt/container-monitor
```

### Verify Access Restriction

```bash
su - testuser

cd /opt/container-monitor
```

---

## Outcome

* Created a dedicated monitoring user.
* Assigned ownership of `/opt/container-monitor` to `monitoruser`.
* Granted full access to the monitoring user.
* Restricted access for all other users.
* Secured monitoring directories, scripts, and log files using Linux permissions.
* Verified access control successfully.

## Task Status

✅ Completed
