# Task 2: Docker Installation and Application Deployment

## Objective

Install Docker on the Linux server, containerize a custom HTML page, and expose the application on port 8000.

---

## Environment

* Server: AWS EC2 Ubuntu
* Container Runtime: Docker
* Base Image: `nginx:alpine`
* Image Name: `index`
* Container Name: `index`
* Application Port: `8000`

---

## Step 1: Install Docker

### Update Package Repository

```bash
sudo apt update
```

### Install Docker

```bash
sudo apt install docker.io -y
```

### Start and Enable Docker Service

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

### Verify Installation

```bash
docker --version
```

---

## Step 2: Create Application File

A custom `index.html` page was created to serve as the web application.

### Verify File

```bash
ls
```

Output:

```text
Dockerfile
index.html
```

---

## Step 3: Create Dockerfile

### Dockerfile

```dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

RUN sed -i 's/listen       80;/listen       8000;/g' /etc/nginx/conf.d/default.conf

EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"]
```

### Purpose

* Use lightweight Nginx Alpine image.
* Copy custom HTML page into Nginx web root.
* Configure Nginx to listen on port 8000.
* Start Nginx in foreground mode.

---

## Step 4: Build Docker Image

### Command

```bash
docker build -t index .
```

### Verify Image

```bash
docker images
```

Example Output:

```text
REPOSITORY   TAG       IMAGE ID
index        latest    xxxxxxxxx
```

---

## Step 5: Run Container

### Command

```bash
docker run -d --name index -p 8000:8000 index
```

### Verify Running Container

```bash
docker ps
```

Example Output:

```text
CONTAINER ID   IMAGE   PORTS
xxxxxxxxxxxx   index   0.0.0.0:8000->8000/tcp
```

---

## Step 6: Verify Application

### Test Locally

```bash
curl localhost:8000
```

### Browser Access

```text
http://<EC2-PUBLIC-IP>:8000
```

The application was successfully accessible through the browser.
[O
---

## Files Used

### Dockerfile

```dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

RUN sed -i 's/listen       80;/listen       8000;/g' /etc/nginx/conf.d/default.conf

EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"]
```

### index.html

Custom HTML page hosted inside the container.

---

## Container Architecture

```text
AWS EC2 Ubuntu
       │
       ▼
Docker Engine
       │
       ▼
Image: index
(Base Image: nginx:alpine)
       │
       ▼
Container: index
       │
       ▼
Port 8000
       │
       ▼
Browser Access
```

---

## Outcome

* Successfully installed Docker.
* Created a custom Dockerfile.
* Built a Docker image named `index`.
* Deployed a container named `index`.
* Hosted a custom HTML page.
* Exposed the application on port 8000.
* Verified successful browser access.

## Task Status

✅ Completed

