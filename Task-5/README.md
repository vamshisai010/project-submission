# Task 5: Firewall Configuration Using UFW

## Objective

Configure the Uncomplicated Firewall (UFW) to secure the server by:

* Allowing SSH access only from a specific IP address.
* Allowing HTTP traffic.
* Allowing application traffic on port 8000.

---

## Environment

* Server: AWS EC2 Ubuntu
* Firewall Tool: UFW (Uncomplicated Firewall)
* Application Port: 8000
* HTTP Port: 80
* SSH Port: 22
* Allowed SSH Source IP: `103.143.168.150`

---

## Step 1: Verify UFW Installation

### Command

```bash
sudo ufw status
```

### Output

```text
Status: inactive
```

### Verify Installation

```bash
sudo apt install ufw -y
sudo systemctl enable ufw
```

### Purpose

Ensure UFW is installed and available on the server.

---

## Step 2: Reset Existing Rules

### Command

```bash
sudo ufw --force reset
```

### Purpose

Remove previous firewall configurations and start with a clean configuration.

---

## Step 3: Allow SSH Access From a Specific IP

### Command

```bash
sudo ufw allow from 103.143.168.150 to any port 22 proto tcp
```

### Purpose

Restrict SSH access to a specific IP address and prevent unauthorized remote access.

### Verify Rule

```bash
sudo ufw status numbered
```

---

## Step 5: Allow Application Traffic on Port 8000

### Command

```bash
sudo ufw allow 8000/tcp
```

### Purpose

Allow external users to access the Dockerized web application running on port 8000.

---

## Step 6: Enable Firewall

### Command

```bash
sudo ufw enable
```

### Output

```text
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
```

### Purpose

Activate the firewall and enable it to start automatically during boot.

---

## Step 7: Verify Firewall Rules

### Command

```bash
sudo ufw status
```

### Output

```text
ubuntu@ip-172-31-0-220:~$ sudo ufw status
Status: active

To                         Action      From
--                         ------      ----
8000/tcp                   ALLOW       Anywhere
22/tcp                     ALLOW       103.143.168.150
8000/tcp (v6)              ALLOW       Anywhere (v6)
```

---

## Detailed Verification

### Command

```bash
sudo ufw status verbose
```

### Output

```text
ubuntu@ip-172-31-0-220:~$ sudo ufw status verbose
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), deny (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
8000/tcp                   ALLOW IN    Anywhere
22/tcp                     ALLOW IN    103.143.168.150
8000/tcp (v6)              ALLOW IN    Anywhere (v6)
```

---

## Firewall Architecture

```text
                 Internet
                     │
         ┌───────────┴───────────┐
         │                       │
         ▼                       ▼
 SSH Port 22               Ports 8000
 Allowed from              Allowed from
 103.143.168.150                Anywhere
         │                       │
         └───────────┬───────────┘
                     ▼
                AWS EC2 Server
```

---

## Verification Commands

### Check Firewall Status

```bash
sudo ufw status
```

### View Detailed Rules

```bash
sudo ufw status verbose
```

### View Numbered Rules

```bash
sudo ufw status numbered
```

---

## Outcome

* Successfully configured UFW firewall.
* Restricted SSH access to a specific IP address.
* Allowed HTTP traffic on port 80.
* Allowed Docker application traffic on port 8000.
* Enabled firewall protection.
* Verified all firewall rules and access control.

## Task Status

✅ Completed

