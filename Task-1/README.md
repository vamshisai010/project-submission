# Task 1: Server Setup and SSH Key-Based Authentication

## Objective

Provision a Linux server and configure secure SSH connectivity using SSH key-based authentication to enable passwordless login.

---

## Environment

* Client Machine: WSL Ubuntu
* Cloud Platform: AWS EC2
* Operating System: Ubuntu
* Authentication Method: SSH Key-Based Authentication
* AWS Imported Key Pair Name: **sai**

---

## Step 1: Generate SSH Key Pair in WSL Ubuntu

An RSA key pair was generated locally on the WSL Ubuntu machine.

### Command

```bash
ssh-keygen -t rsa -b 4096 -C "saivamshi-devops-task"
```

### Generated Files

```text
~/.ssh/id_rsa
~/.ssh/id_rsa.pub
```

### Purpose

Generate a secure public-private key pair for SSH authentication.

---

## Step 2: Import Public Key into AWS

The contents of the public key file were displayed using:

```bash
cat ~/.ssh/id_rsa.pub
```

The public key was copied and imported into AWS EC2 as a key pair named **sai**.

### Purpose

Allow AWS EC2 instances to trust the locally generated SSH key pair.

---

## Step 3: Launch EC2 Instance

An Ubuntu EC2 instance was launched using the imported key pair **sai**.

### Configuration

* Operating System: Ubuntu
* Key Pair: sai
* Security Group:

  * SSH (22)
  * HTTP (80)
  * Custom TCP (8000)

---

## Step 4: Connect to EC2 Instance

The EC2 instance was accessed directly from WSL Ubuntu.

### Command

```bash
ssh ubuntu@3.110.120.12
```

### Purpose

Establish secure remote access using the locally generated private key.

---

## Verification

Successful login without password:

```bash
ssh ubuntu@3.110.120.12
```

Connection established successfully without requiring a password.

---

## Authentication Workflow

```text
WSL Ubuntu
│
├── id_rsa (Private Key)
├── id_rsa.pub (Public Key)
│
▼
AWS EC2 Key Pair (Imported)
Name: sai
│
▼
Ubuntu EC2 Instance
│
▼
SSH Authentication
│
▼
Secure Passwordless Login
```

---

## Outcome

* Generated an RSA key pair in WSL Ubuntu.
* Imported the public key into AWS as a key pair named **sai**.
* Launched an Ubuntu EC2 instance using the imported key pair.
* Established secure SSH connectivity.
* Verified successful passwordless authentication.

## Task Status

✅ Completed

