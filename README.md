# DevOps Internship Assignment

## Overview

This repository contains the implementation of the DevOps Internship assignment. The project demonstrates secure server access, Dockerized application deployment, automated container monitoring, Linux access control, and firewall configuration.

---

## Environment

* Cloud Platform: AWS EC2
* Operating System: Ubuntu
* Client Machine: WSL Ubuntu
* Container Runtime: Docker
* Web Server: Nginx Alpine
* Monitoring: Shell Script + Cron
* Firewall: UFW
* Authentication: SSH Key-Based Authentication

---

# Repository Structure

```text
Project-Submission/
│
├── Task-1/
│   └── README.md
│
├── Task-2/
│   ├── Dockerfile
│   ├── index.html
│   └── README.md
│
├── Task-3/
│   ├── monitor.sh
│   └── README.md
│
├── Task-4/
│   └── README.md
│
├── Task-5/
│   └── README.md
│
└── README.md
```

---

# Task Summary

## Task 1: Server Setup and SSH Key-Based Authentication

* Generated an RSA key pair in WSL Ubuntu.
* Imported the public key into AWS EC2 Key Pairs as **sai**.
* Launched an Ubuntu EC2 instance using the imported key pair.
* Configured secure SSH access.
* Verified passwordless authentication.

---

## Task 2: Docker Installation and Application Deployment

* Installed Docker on Ubuntu EC2.
* Created a custom `index.html`.
* Created a Dockerfile using `nginx:alpine`.
* Built Docker image named `index`.
* Deployed container named `index`.
* Exposed the application on port `8000`.

---

## Task 3: Container Monitoring and Automated Logging

* Created monitoring directory.
* Developed `monitor.sh`.
* Collected CPU and memory usage using Docker statistics.
* Stored logs in:

```text
/opt/container-monitor/logs/container_usage.log
```

* Automated monitoring using Cron.

---

## Task 4: Secure Monitoring Logs Using a Dedicated User

* Created a dedicated user `monitoruser`.
* Assigned ownership of `/opt/container-monitor`.
* Restricted access to unauthorized users.
* Verified Linux file permissions.

---

## Task 5: Firewall Configuration

Configured UFW firewall rules:

| Port | Service     | Access      |
| ---- | ----------- | ----------- |
| 22   | SSH         | Specific IP |
| 8000 | Application | Anywhere    |

Enabled and verified firewall rules.

---

# Technologies Used

* AWS EC2
* Ubuntu Linux
* SSH
* Docker
* Nginx Alpine
* Shell Scripting
* Cron Jobs
* Linux User Management
* File Permissions
* UFW Firewall
* GitHub

---

# Architecture

```text
WSL Ubuntu
     │
     ▼
AWS EC2 Ubuntu
     │
 ┌───┴─────────────────────┐
 │                         │
 ▼                         ▼
SSH Authentication     Docker Engine
                            │
                            ▼
                    Container (index)
                            │
                            ▼
                    Application Port 8000
                            │
                            ▼
                   monitor.sh + Cron
                            │
                            ▼
             /opt/container-monitor/logs
                            │
                            ▼
                      monitoruser
                            │
                            ▼
                      UFW Firewall
```

---

# Demonstration Video

A demonstration video covering all tasks has been uploaded to Google Drive.

### Video Covers

* SSH Key-Based Authentication
* Docker Deployment
* Container Monitoring
* Linux User Permissions
* Firewall Configuration

### Video Link

```text
https://drive.google.com/file/d/1r6P_4Alrt6oT17-h-v9mIiEpoNzb1O4h/view?usp=sharing
```

---

# Screenshots

# Screenshots

## SSH-keygen on WSL ubuntu

![SSH Key](screenshots/ssh-keygen.png)

## Ec2 instance configuration

![Ec2-instance](screenshots/ec2-instance.png)

## Docker Build image and Running container

![Docker Build and Containers Running](screenshots/docker-container.png)

## Application successfully deployed

![Monitoring Script](screenshots/app-deployed.png)

## CRONJOB Script

![User Permissions](screenshots/cronjob-script.png)

---

# Final Outcome

Successfully implemented:

* Secure SSH key-based authentication.
* Dockerized web application deployment.
* Automated container monitoring with Cron.
* Secure access control using Linux permissions.
* Firewall configuration using UFW.

---

# Author

**Gande Saivamshi**

AWS DevSecOps Enthusiast

