# DevOps Lab Project

Simple Flask application deployed using Docker, GitHub Actions CI/CD, and Terraform on AWS EC2.

## Project Structure
- `app.py` - Flask application
- `Dockerfile` - Container configuration
- `.github/workflows/ci-cd.yml` - CI/CD pipeline
- `terraform/` - Infrastructure as Code

## Deployment Steps

### 1. Push to GitHub
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/Usman2k25/devops-lab.git
git push -u origin main
```

### 2. Set up GitHub Secrets
Add these secrets in GitHub repository settings:
- `DOCKER_USERNAME`: usman966
- `DOCKER_PASSWORD`: Your Docker Hub password

### 3. Deploy Infrastructure
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 4. Access Application
After deployment, access your app at: `http://<EC2_PUBLIC_IP>:5000`

## Tech Stack
- Flask (Python web framework)
- Docker (Containerization)
- GitHub Actions (CI/CD)
- Terraform (Infrastructure as Code)
- AWS EC2 (Hosting)
