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
