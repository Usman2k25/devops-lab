# DevOps Lab 08 - Complete CI/CD Pipeline Documentation

## 📋 Project Overview

This project demonstrates a complete DevOps workflow with automated CI/CD pipeline deployment. A Flask web application is containerized using Docker, stored in Docker Hub, deployed on AWS EC2 using Terraform, and automatically updated through GitHub Actions whenever code changes are pushed.

---

## 🎯 Project Task

Build and deploy a Flask web application with:
- Containerization using Docker
- Infrastructure as Code using Terraform
- Automated CI/CD pipeline using GitHub Actions
- Cloud deployment on AWS EC2
- Automatic deployment on code changes

---

## 📁 Project Structure

```
lab/
├── app.py                              # Flask web application
├── Dockerfile                          # Docker container configuration
├── requirements.txt                    # Python dependencies
├── README.md                           # Project documentation
├── .github/workflows/ci-cd.yml         # GitHub Actions CI/CD pipeline
└── terraform/
    ├── main.tf                         # AWS infrastructure definition
    ├── variables.tf                    # Terraform variables
    └── terraform.tfstate               # Infrastructure state
```

---

## 🔧 Technologies Used

- **Flask**: Python web framework
- **Docker**: Container platform
- **GitHub Actions**: CI/CD automation
- **Terraform**: Infrastructure as Code
- **AWS EC2**: Cloud hosting
- **Docker Hub**: Container registry

---

## 💻 Application Code

### app.py
```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return '''
    <html>
        <head>
            <title>DevOps Lab - Usman</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                }
                .container {
                    text-align: center;
                    background: rgba(255, 255, 255, 0.1);
                    padding: 50px;
                    border-radius: 20px;
                    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
                }
                h1 {
                    font-size: 3em;
                    margin-bottom: 20px;
                }
                p {
                    font-size: 1.5em;
                }
                .badge {
                    background: #4CAF50;
                    padding: 10px 20px;
                    border-radius: 25px;
                    margin-top: 20px;
                    display: inline-block;
                }
                .version {
                    margin-top: 20px;
                    font-size: 0.9em;
                    opacity: 0.8;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>🚀 Welcome to DevOps Lab!</h1>
                <p>Created by Usman - Full Stack DevOps Engineer</p>
                <p style="font-size: 1.2em; margin-top: 10px;">🔄 Automated CI/CD with GitHub Actions</p>
                <div class="badge">✅ Pipeline Active & Running</div>
                <div class="version">Version 1.3 - Live on AWS EC2 🌐</div>
            </div>
        </body>
    </html>
    '''

@app.route('/health')
def health():
    return {'status': 'healthy'}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

### requirements.txt
```
Flask==3.0.0
Werkzeug==3.0.1
```

### Dockerfile
```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]
```

---

## 🏗️ Infrastructure Code

### terraform/variables.tf
```hcl
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance (Amazon Linux 2)"
  type        = string
  default     = "ami-0453ec754f44f9a4a"
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
  default     = "usman-deploy-key-new"
}
```

### terraform/main.tf
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Security Group
resource "aws_security_group" "flask_app_sg" {
  name        = "flask-app-security-group"
  description = "Security group for Flask application"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Flask App"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "flask-app-sg"
  }
}

# EC2 Instance
resource "aws_instance" "flask_app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  security_groups = [aws_security_group.flask_app_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              
              # Pull and run the Docker container
              sudo docker pull usman966/devops-lab:latest
              sudo docker run -d -p 5000:5000 --name flask-app --restart unless-stopped usman966/devops-lab:latest
              EOF

  tags = {
    Name = "Flask-App-Server"
  }
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.flask_app.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.flask_app.public_dns
}

output "application_url" {
  description = "URL to access the Flask application"
  value       = "http://${aws_instance.flask_app.public_ip}:5000"
}
```

---

## 🔄 CI/CD Pipeline

### .github/workflows/ci-cd.yml
```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-push:
    name: Build and Push Docker Image
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
    
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v2
    
    - name: Log in to Docker Hub
      uses: docker/login-action@v2
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}
    
    - name: Build and push Docker image
      uses: docker/build-push-action@v4
      with:
        context: .
        push: true
        tags: |
          usman966/devops-lab:latest
          usman966/devops-lab:${{ github.sha }}
    
    - name: Image digest
      run: echo "Image pushed successfully with tag ${{ github.sha }}"

  deploy-to-ec2:
    name: Deploy to AWS EC2
    needs: build-and-push
    runs-on: ubuntu-latest
    
    steps:
    - name: Deploy to EC2
      uses: appleboy/ssh-action@v1.0.0
      with:
        host: ${{ secrets.EC2_HOST }}
        username: ${{ secrets.EC2_USERNAME }}
        key: ${{ secrets.EC2_SSH_KEY }}
        script: |
          # Stop and remove old container
          sudo docker stop flask-app || true
          sudo docker rm flask-app || true
          
          # Pull latest image
          sudo docker pull usman966/devops-lab:latest
          
          # Run new container
          sudo docker run -d -p 5000:5000 --name flask-app --restart unless-stopped usman966/devops-lab:latest
          
          # Clean up old images
          sudo docker image prune -f
    
    - name: Verify deployment
      run: echo "Application deployed successfully to EC2"
```

---

## 🚀 Setup and Deployment Commands

### 1. Initialize Git Repository
```bash
cd /Users/usman/Downloads/Parhai/DevOps/Labs/LAB\ 08/lab
git init
git add .
git commit -m "Initial commit: Flask app with Docker and Terraform"
git branch -M main
git remote add origin https://github.com/Usman2k25/devops-lab.git
git push -u origin main
```

### 2. Create AWS EC2 Key Pair
```bash
aws ec2 create-key-pair --key-name usman-deploy-key-new --query 'KeyMaterial' --output text --region us-east-1 > ~/.ssh/usman-deploy-key-new.pem
chmod 400 ~/.ssh/usman-deploy-key-new.pem
```

### 3. Deploy Infrastructure with Terraform
```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

### 4. Get EC2 Public IP
```bash
terraform output instance_public_ip
```

**Output**: `44.192.66.105`

---

## 🔐 GitHub Secrets Configuration

Navigate to: `https://github.com/Usman2k25/devops-lab/settings/secrets/actions`

Add the following repository secrets:

### Secret 1: DOCKER_USERNAME
```
usman966
```

### Secret 2: DOCKER_PASSWORD
```
Usman@2005
```

### Secret 3: EC2_HOST
```
44.192.66.105
```

### Secret 4: EC2_USERNAME
```
ec2-user
```

### Secret 5: EC2_SSH_KEY
Get the SSH key content:
```bash
cat ~/.ssh/usman-deploy-key-new.pem
```

Copy the entire output including BEGIN and END markers:
```
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAyDFp60Q1+F3DvxmetRQC65WR3fbkrEYaFXgkHLxYqQNvsOKS
mFIuP872cjFGy3PbD/dhVjkCQBrnhv9Suvu/VaYJkTPDgr8ksK4PHl2YXGUzcoRI
RC0E/BSZ6Ll8E1UWA840qrwxNVSzMtGWfNG5W+JgWVFd25VICDHpzm9dvc0H46jl
xTNvY3ChdV3ErrpXuTVRA40wuVzqdrrTdRsBoJaZUm13fJ2Kx1pyV2pOgpc16arb
ByHPTpzs5OfDmxrCAWYeN/qKAihpI9ku1fCX2FrW4t4cTSrxN0RfzaQcPiFgATyn
zuMxSCFd/8wCmt1nBAxfrRY0fQEA6jCfb1l0ZwIDAQABAoIBAGYv+v4Rom72Bc5N
WJrb7SWuAnhH57AcVIIzAlP8vFEBpQiojuXbxSnjDh96EcYWjHKY9wGZNhHc6eQZ
/nPdv2wLxgRtZNYfla3uG1+HrRc0vU8uQOk0BcBbD7kgvTntC8DDiFTCnWe4pYRC
QcvTDgfeBQpyozNL/ynXuJ4ccMBJuieqsBl27O+h4YvtyYK1kgAft4BzuMfOy+3T
BAZrOd9ORNMSYqqHee6WopBmbLRZqrpqN0D09qovW7gixkjRsGdMIdCB23c91XIm
3X6CCqwEQT1AGSA1rAVBsSa7rv+lzeAqFnVFm0+2LOFCUpKwjzQ2hR3ztYMV3ic/
nZLyJqECgYEA46QakgiqqYl65L5lSdNf1zUk+MMRDEAViK/p4EqI2wS4xFlQmiam
WU7I8GMJ9VBLEGlTAdWHAQe8GPxG8gyY6yYeD+U5N1cRvShNhdg13bhGQe9ME1Wb
hQy2/YQI5WwRDObLWyyvBf3w7UdbfoFDIA6hzizAdbQUo4lmBs8GcZcCgYEA4SHx
H33SVWK2RAc2ZKU6AQMFfRj3L4kF+Fu6J3XYzettxG7x3AFCOQYFYYu+UhbIpRVq
Ma26H3A9boY0jCLUI/if87fa76bJGbw55URpZQVnfMP9+owc1ud65mPNWwWqkKE9
/AD61u0IAeqL9ZJT8ZDbRbMMsNAbKnEliFRpzbECgYAe8fb+tRjmFR9UqyE/yPE1
Yy8UdggCP0/uFePYLqmuBFVNs8qGOgzRBSnBq+T1qSWbJIY5MJq6pB+I0fqe+uFq
zfK2PHXrtPVfXnQzZrHj4yIB4pLX6gJLMvBJREKlVWx38YPhcBCW4u92ggXJC69h
UzvhuCmtln5bwNjSwh/hHwKBgDikmo8q0AXNrUAWdHgEHkDs6q+b3W1nU0o2gfK1
stO0fUykAVQyOOAyBJ6TU1JCCz+F0M8o/6AzVDF/sK7lgGyAfHYMdxg+5XAFLKfj
e4UARBZfFYK5R/RGD2TyDVPubAixmO/Tq0jyIEajJY2mwFoR8SlrMDE4Wu1lxGS1
oF0xAoGBAJrHjWl1pWdYgqkVkL7jDWQoaJ/DWHewDqLW9ZKVd5kt7m/6cB/FugOL
7cyrvcc0IQ0Jk7mOV1wG6ya/IowaoosJgbuxZubhjep6RIJY6CdhQkh7E3MCw3Ax
kyUXipHwqnT6hcONWHDEiItz5IfK2Dl4p6Rhu0LcNsEBDXWM87C4
-----END RSA PRIVATE KEY-----
```

---

## 📊 Deployment Details

### Docker Hub Repository
- **Username**: `usman966`
- **Repository**: `devops-lab`
- **Image Tags**: `latest`, commit SHA tags

### AWS Resources
- **Region**: `us-east-1`
- **Instance Type**: `t3.micro`
- **AMI**: `ami-0453ec754f44f9a4a` (Amazon Linux 2)
- **Security Group**: Ports 22 (SSH) and 5000 (Flask) open
- **Key Pair**: `usman-deploy-key-new`

### Application Access
- **URL**: `http://44.192.66.105:5000`
- **Health Endpoint**: `http://44.192.66.105:5000/health`

### GitHub Repository
- **URL**: `https://github.com/Usman2k25/devops-lab`
- **Actions**: `https://github.com/Usman2k25/devops-lab/actions`

---

## 🎬 How to Demonstrate CI/CD

### Step 1: Show Current Application
Open browser and visit: `http://44.192.66.105:5000`

### Step 2: Make Code Change
Edit `app.py` and modify any text:
```python
# Change this line:
<div class="version">Version 1.3 - Live on AWS EC2 🌐</div>

# To this:
<div class="version">Version 2.0 - Live Demo! 🌐</div>
```

### Step 3: Commit and Push
```bash
git add app.py
git commit -m "Demo: Update to version 2.0"
git push origin main
```

### Step 4: Monitor Pipeline
Open: `https://github.com/Usman2k25/devops-lab/actions`

Watch the two jobs execute:
1. ✅ Build and Push Docker Image
2. ✅ Deploy to AWS EC2

### Step 5: Verify Deployment
Wait 2-3 minutes for pipeline completion, then refresh: `http://44.192.66.105:5000`

Press `Ctrl+Shift+R` (hard refresh) to see updated version.

---

## 🔄 CI/CD Pipeline Workflow

```
Developer pushes code to GitHub
           ↓
GitHub Actions triggered automatically
           ↓
Job 1: Build and Push Docker Image
  - Checkout code from repository
  - Login to Docker Hub
  - Build Docker image
  - Push to Docker Hub with tags
           ↓
Job 2: Deploy to AWS EC2
  - SSH into EC2 instance
  - Stop old container
  - Pull latest Docker image
  - Start new container
  - Clean up old images
           ↓
Application automatically updated on EC2
```

---

## 📝 Git Commit History

```
de45180 - Add project summary and status overview
1c4f7fa - Add complete setup instructions for GitHub secrets
45685f9 - Version 1.3: Enhanced welcome message and AWS branding
155be50 - Update to version 1.2 with deployment info
3fceca7 - Add CI/CD automation message to homepage
02acb42 - Enhanced Flask app with modern UI and styling
b9eb859 - Initial commit: Flask app with Docker and Terraform
```

---

## 🛠️ Useful Commands

### Check Infrastructure Status
```bash
cd terraform
terraform output
```

### View Application Logs on EC2
```bash
ssh -i ~/.ssh/usman-deploy-key-new.pem ec2-user@44.192.66.105
sudo docker logs flask-app
```

### Test Application Locally
```bash
docker build -t devops-lab .
docker run -p 5000:5000 devops-lab
```

### Destroy Infrastructure
```bash
cd terraform
terraform destroy -auto-approve
```

---

## ✅ Project Achievements

- ✅ Automated CI/CD pipeline with GitHub Actions
- ✅ Containerized application using Docker
- ✅ Infrastructure as Code with Terraform
- ✅ Cloud deployment on AWS EC2
- ✅ Automatic deployment on code changes
- ✅ Version control with Git
- ✅ Professional DevOps workflow

---

## 📞 Project Information

**Student**: Usman  
**Project**: DevOps Lab 08 - CI/CD Pipeline  
**Date**: December 9, 2025  
**Repository**: https://github.com/Usman2k25/devops-lab  
**Live URL**: http://44.192.66.105:5000
