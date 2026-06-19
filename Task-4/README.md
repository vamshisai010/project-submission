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

Example Output

```text
uid=1001(monitoruser) gid=1001(monitoruser) groups=1001(monitoruser)
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

Example Output

```text
drwxr-xr-x 3 monitoruser monitoruser 4096 Jun 19 07:00 /opt/container-monitor
```

### Purpose

Transfer ownership of the monitoring directory and its contents to the dedicated monitoring user.

---

## Step 3: Restrict Access

### Command

```bash
sudo chmod 700 /opt/container-monitor
```

### Verify Permissions

```bash
ls -ld /opt/container-monitor
```

Example Output

```text
drwx------ 3 monitoruser monitoruser 4096 Jun 19 07:00 /opt/container-monitor
```

### Purpose

Grant full access only to `monitoruser` and deny access to other users.

---

## Step 4: Verify Authorized Access

### Switch to Monitoring User

```bash
su - monitoruser
```

### Access Monitoring Directory

```bash
cd /opt/container-monitor

ls

cd logs

cat container_usage.log
```

### Result

Successfully accessed the monitoring directory and log files.

---

## Step 5: Verify Access Restriction

### Create Test User

```bash
sudo useradd -m testuser

sudo passwd testuser
```

### Switch User

```bash
su - testuser
```

### Attempt Access

```bash
cd /opt/container-monitor
```

### Output

```text
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

Example Output

```text
/opt/container-monitor:
drwx------ monitoruser monitoruser

logs/

/opt/container-monitor/logs:
container_usage.log
monitor.sh
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
* Verified access control successfully.

## Task Status

✅ Completed

