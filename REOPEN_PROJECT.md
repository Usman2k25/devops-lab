# 🔄 How to Reopen and Run This Project

## When You Close VS Code and Want to Start Again

### Step 1: Open the Project Folder
```bash
cd /Users/usman/Downloads/Parhai/DevOps/Labs/LAB\ 08/lab
code .
```

Or just open VS Code and:
- File → Open Folder → Select the `lab` folder

---

## ✅ Everything is Already Running!

Your application is **LIVE 24/7** on AWS EC2. You don't need to restart anything!

- **Website URL**: http://44.192.66.105:5000
- **EC2 Instance**: Running continuously
- **Docker Container**: Auto-restarts if server reboots

Just open the URL in your browser - it's already working! 🚀

---

## 🎯 What You Can Do After Reopening

### Option 1: Check if Everything is Still Running
```bash
# Check EC2 status
cd terraform
terraform output

# Test the website
curl http://44.192.66.105:5000
```

### Option 2: Make Changes and Demo CI/CD
```bash
# 1. Make a change in app.py (change version number, text, etc.)

# 2. Commit and push
git add app.py
git commit -m "Update version"
git push origin main

# 3. Watch pipeline run
# Open: https://github.com/Usman2k25/devops-lab/actions

# 4. Wait 2-3 minutes, then check website
# Open: http://44.192.66.105:5000
```

---

## 🔍 Quick Status Checks

### Check if EC2 is running:
```bash
cd terraform
terraform output
```

### Check if Docker container is running on EC2:
```bash
ssh -i ~/.ssh/usman-deploy-key-new.pem ec2-user@44.192.66.105 "sudo docker ps"
```

### View application logs:
```bash
ssh -i ~/.ssh/usman-deploy-key-new.pem ec2-user@44.192.66.105 "sudo docker logs flask-app"
```

---

## 📋 Important Information to Remember

### Your Credentials:
- **Docker Hub**: usman966 / Usman@2005
- **GitHub Repo**: https://github.com/Usman2k25/devops-lab
- **EC2 IP**: 44.192.66.105
- **SSH Key**: ~/.ssh/usman-deploy-key-new.pem

### URLs to Remember:
- **Live App**: http://44.192.66.105:5000
- **GitHub Actions**: https://github.com/Usman2k25/devops-lab/actions
- **Docker Hub Repo**: https://hub.docker.com/r/usman966/devops-lab

---

## 🎬 For Your Demo to Teacher

1. **Open the website**: http://44.192.66.105:5000
2. **Make a small change** in `app.py`
3. **Push to GitHub**:
   ```bash
   git add app.py
   git commit -m "Demo change"
   git push origin main
   ```
4. **Show the pipeline**: https://github.com/Usman2k25/devops-lab/actions
5. **Wait 2-3 minutes** for deployment
6. **Refresh website** to see changes

---

## ⚠️ If Something is Stopped

### If EC2 was stopped:
```bash
cd terraform
terraform apply -auto-approve
```

This will restart everything automatically!

---

## 💡 Pro Tips

- The EC2 instance runs 24/7 - you don't need to start it
- The Docker container auto-restarts if the server reboots
- Your code is safely stored in GitHub
- The infrastructure is defined in Terraform (can be recreated anytime)
- All GitHub secrets are already configured

**Bottom line**: Just open VS Code and your app is already live! 🎉
