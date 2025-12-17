# 🚀 Complete Setup Instructions for DevOps Lab CI/CD

## ✅ What's Already Done

1. ✅ Flask application created with modern UI
2. ✅ Dockerfile configured
3. ✅ GitHub repository connected: https://github.com/Usman2k25/devops-lab
4. ✅ Terraform infrastructure deployed on AWS
5. ✅ EC2 instance running at: **100.48.56.146**
6. ✅ CI/CD pipeline configured in GitHub Actions
7. ✅ Multiple commits created to demonstrate pipeline activity

## 🔴 What You Need to Do NOW

### Step 1: Add GitHub Secrets (CRITICAL!)

The CI/CD pipeline won't fully work until you add these secrets. Here's how:

1. **Go to GitHub Repository Settings:**
   - Visit: https://github.com/Usman2k25/devops-lab/settings/secrets/actions
   
2. **Click "New repository secret" and add each of these:**

#### Secret 1: DOCKER_USERNAME
```
usman966
```

#### Secret 2: DOCKER_PASSWORD
```
Usman@2005
```

#### Secret 3: EC2_HOST
```
100.48.56.146
```

#### Secret 4: EC2_USERNAME
```
ec2-user
```

#### Secret 5: EC2_SSH_KEY (This is the tricky one!)

You need to paste your **ENTIRE** private SSH key. Follow these steps:
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

**Option A: If you have the key on your computer**
```bash
cat ~/.ssh/usman-deploy-key.pem
```

**Option B: If you don't have the key**
You'll need to create a new key pair and update your EC2 instance. Here's how:

1. **Download your existing key from wherever you saved it originally** (you would have downloaded it when creating the EC2 key pair in AWS)

2. **If you can't find it**, you need to create a NEW EC2 instance with a NEW key pair:
   ```bash
   cd terraform
   # First, download the new key from AWS console and save it
   # Then update terraform and apply
   terraform apply
   ```

**The SSH key should look like this:**
```
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA... (many lines of text)
... (more lines)
-----END RSA PRIVATE KEY-----
```

Copy **EVERYTHING** including the BEGIN and END lines and paste it into the `EC2_SSH_KEY` secret.

---

### Step 2: Get Your SSH Key (If You Don't Have It)

If you can't find your SSH key, here's what to do:

1. **Check if you have it locally:**
   ```bash
   ls -la ~/.ssh/
   # Look for files like: usman-deploy-key.pem or similar
   ```

2. **If not found, you have two options:**

   **Option A: Create NEW key pair in AWS and update EC2**
   1. Go to AWS Console → EC2 → Key Pairs
   2. Create new key pair named "usman-deploy-key-2"
   3. Download the .pem file
   4. Save it to `~/.ssh/usman-deploy-key-2.pem`
   5. Update Terraform:
      ```bash
      cd terraform
      # Edit variables.tf to use new key name
      terraform apply
      ```

   **Option B: Access EC2 through AWS Console (temporary)**
   1. Go to AWS Console → EC2 → Instances
   2. Select your instance
   3. Click "Connect" → "Session Manager" (if enabled)
   4. Manually deploy the Docker container

---

### Step 3: Verify Everything Works

After adding ALL 5 secrets to GitHub:

1. **Make a small change to test the pipeline:**
   ```bash
   cd /Users/usman/Downloads/Parhai/DevOps/Labs/LAB\ 08/lab
   
   # Edit app.py and change the version number
   # Then commit and push:
   git add app.py
   git commit -m "Test automatic deployment"
   git push origin main
   ```

2. **Watch the pipeline run:**
   - Go to: https://github.com/Usman2k25/devops-lab/actions
   - You should see TWO jobs running:
     - ✅ Build and Push Docker Image
     - ✅ Deploy to AWS EC2

3. **Wait 2-3 minutes, then check your website:**
   - Visit: http://100.48.56.146:5000
   - You should see your updated version!

---

## 📊 Current Status

### ✅ Working Right Now:
- EC2 instance is running
- Website is accessible at: http://100.48.56.146:5000
- Docker container is running on EC2
- GitHub Actions pipeline builds and pushes Docker images

### ⚠️ Needs Your Action:
- Add the 5 GitHub secrets (especially EC2_SSH_KEY)
- Once secrets are added, the deployment job will work automatically

### 📈 What You'll See After Setup:
1. Every time you push to GitHub, you'll see workflow runs
2. Build job: Builds Docker image and pushes to Docker Hub
3. Deploy job: Connects to EC2 and deploys new version
4. Your website updates automatically!

---

## 🎯 Expected Pipeline Workflow

```
Code Push to GitHub (main branch)
    ↓
GitHub Actions Triggered
    ↓
Job 1: Build and Push Docker Image
    - Checkout code
    - Login to Docker Hub
    - Build Docker image
    - Push to usman966/devops-lab:latest
    ↓
Job 2: Deploy to AWS EC2 (needs secrets!)
    - SSH into EC2
    - Stop old container
    - Pull new image
    - Start new container
    ↓
Website Updated! 🎉
```

---

## 🔍 Troubleshooting

### Pipeline shows "Success" but Deploy job is skipped?
- You haven't added the EC2 secrets yet (EC2_HOST, EC2_USERNAME, EC2_SSH_KEY)

### Deploy job fails with "Permission denied"?
- Your EC2_SSH_KEY is incorrect or doesn't match the key pair on the EC2 instance

### Website not loading at 100.48.56.146:5000?
- EC2 instance might have restarted and gotten new IP
- Run: `cd terraform && terraform output` to get current IP
- Update EC2_HOST secret with new IP

### Docker Hub login fails?
- Check DOCKER_USERNAME and DOCKER_PASSWORD are correct
- Password is: Usman@2005

---

## 📞 Next Steps

1. **IMMEDIATELY**: Add the 5 GitHub secrets
2. **TEST**: Make a code change and push
3. **VERIFY**: Check the Actions tab for pipeline runs
4. **CONFIRM**: Visit http://100.48.56.146:5000 to see changes

---

## 🎓 What This Demonstrates

This project shows:
- ✅ Containerization with Docker
- ✅ Infrastructure as Code with Terraform
- ✅ CI/CD automation with GitHub Actions
- ✅ Cloud deployment on AWS EC2
- ✅ Automated testing and deployment
- ✅ Version control with Git

You now have a complete DevOps pipeline! 🚀
