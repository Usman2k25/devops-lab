# GitHub Secrets Setup Guide

## Required Secrets for CI/CD Pipeline

You need to add the following secrets to your GitHub repository to enable automatic deployment to EC2.

### How to Add Secrets:
1. Go to your repository: https://github.com/Usman2k25/devops-lab
2. Click **Settings** tab
3. In the left sidebar, click **Secrets and variables** → **Actions**
4. Click **New repository secret** button
5. Add each secret below

---

## Secrets to Add:

### 1. Docker Hub Credentials

**Secret Name:** `DOCKER_USERNAME`  
**Value:** 
```
usman966
```

**Secret Name:** `DOCKER_PASSWORD`  
**Value:** 
```
Usman@2005
```

---

### 2. EC2 Connection Details

**Secret Name:** `EC2_HOST`  
**Value:** 
```
100.48.56.146
```

**Secret Name:** `EC2_USERNAME`  
**Value:** 
```
ec2-user
```

---

### 3. EC2 SSH Private Key

**Secret Name:** `EC2_SSH_KEY`  
**Value:** You need to get your private SSH key content

#### How to get your SSH key:

**Option 1: If you have the key file locally**
```bash
cat ~/.ssh/usman-deploy-key.pem
```

**Option 2: Download from AWS Console**
1. Unfortunately, AWS doesn't allow re-downloading private keys
2. You should have saved it when creating the key pair

**Option 3: Create a new key pair (if you don't have it)**

Run this command in your terminal:
```bash
# Check if EC2 instance is accessible
ssh -i ~/.ssh/usman-deploy-key.pem ec2-user@100.48.56.146
```

If this works, then run:
```bash
cat ~/.ssh/usman-deploy-key.pem
```

Copy the ENTIRE output including:
```
-----BEGIN RSA PRIVATE KEY-----
... (all the lines in between)
-----END RSA PRIVATE KEY-----
```

Paste this entire content (including the BEGIN and END lines) into the `EC2_SSH_KEY` secret.

---

## Verifying Secrets

After adding all secrets, you should have 5 secrets total:
- ✅ DOCKER_USERNAME
- ✅ DOCKER_PASSWORD
- ✅ EC2_HOST
- ✅ EC2_USERNAME
- ✅ EC2_SSH_KEY

Once all secrets are added, every push to the `main` branch will:
1. Build your Docker image
2. Push it to Docker Hub
3. Deploy it to your EC2 instance automatically

## Testing the Pipeline

After adding secrets, make a small change to `app.py` and push:
```bash
# Make a change in app.py
git add app.py
git commit -m "Test CI/CD pipeline"
git push origin main
```

Then watch the Actions tab: https://github.com/Usman2k25/devops-lab/actions
