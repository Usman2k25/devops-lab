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
Add these secrets in GitHub repository settings (Settings → Secrets and variables → Actions → New repository secret):

**Docker Hub Credentials:**
- `DOCKER_USERNAME`: `usman966`
- `DOCKER_PASSWORD`: `******`

**AWS EC2 SSH Access:**
- `EC2_HOST`: `100.48.56.146` (Current EC2 public IP)
- `EC2_USERNAME`: `ec2-user` (Default for Amazon Linux)
- `EC2_SSH_KEY`: Your private SSH key content (usman-deploy-key.pem)

To get your SSH key content:
```bash
cat ~/.ssh/usman-deploy-key.pem
```
Copy the entire output including `-----BEGIN RSA PRIVATE KEY-----` and `-----END RSA PRIVATE KEY-----`

### 3. Deploy Infrastructure
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 4. Access Application
Application URL: **http://100.48.56.146:5000**

## CI/CD Pipeline
The pipeline automatically:
1. **Build & Push**: Builds Docker image and pushes to Docker Hub
2. **Deploy to EC2**: SSHs into EC2, pulls latest image, and restarts container

Every push to `main` branch triggers the full pipeline!

## Tech Stack
- Flask (Python web framework)
- Docker (Containerization)
- GitHub Actions (CI/CD)
- Terraform (Infrastructure as Code)
- AWS EC2 (Hosting)
