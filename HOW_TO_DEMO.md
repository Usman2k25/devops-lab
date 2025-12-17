# 🎓 How to Demo CI/CD to Your Teacher

## 📋 Before the Demo - One-Time Setup

Make sure you've added all 5 GitHub secrets (you only do this once):
- Go to: https://github.com/Usman2k25/devops-lab/settings/secrets/actions
- Add all 5 secrets (DOCKER_USERNAME, DOCKER_PASSWORD, EC2_HOST, EC2_USERNAME, EC2_SSH_KEY)

---

## 🎬 Demo Steps (Show Your Teacher)

### Step 1: Show the Current Website
Open browser and visit: **http://44.192.66.105:5000**

Show your teacher: "This is the current version running on AWS EC2"

---

### Step 2: Make a Small Change

Open the project folder:
```bash
cd /Users/usman/Downloads/Parhai/DevOps/Labs/LAB\ 08/lab
```

Open `app.py` in VS Code and make a TINY change. For example:

**Find this line (around line 33):**
```python
<h1>🚀 Welcome to DevOps Lab!</h1>
```

**Change it to:**
```python
<h1>🚀 Welcome to DevOps Lab - LIVE DEMO!</h1>
```

**Or find this line (around line 37):**
```python
<div class="version">Version 1.3 - Live on AWS EC2 🌐</div>
```

**Change it to:**
```python
<div class="version">Version 2.0 - Updated Live! 🌐</div>
```

Save the file (Cmd+S or Ctrl+S)

---

### Step 3: Commit and Push the Change

In terminal, run these 3 commands:

```bash
git add app.py
git commit -m "Demo: Update version to 2.0"
git push origin main
```

Tell your teacher: "I just pushed the code change to GitHub"

---

### Step 4: Show the Pipeline Running

Open this in browser: **https://github.com/Usman2k25/devops-lab/actions**

You'll see a new workflow running! Show your teacher:
- Click on the latest workflow (top one)
- Show the two jobs:
  - ✅ Build and Push Docker Image (building...)
  - ✅ Deploy to AWS EC2 (will run after build completes)

Tell your teacher: "The CI/CD pipeline is automatically building and deploying my change"

---

### Step 5: Wait for Pipeline to Complete

Wait about 2-3 minutes. You'll see:
- ✅ Build and Push Docker Image - completed (green checkmark)
- ✅ Deploy to AWS EC2 - completed (green checkmark)

Tell your teacher: "The pipeline has finished deploying"

---

### Step 6: Show the Updated Website

Refresh the browser: **http://44.192.66.105:5000**

Press Ctrl+Shift+R (or Cmd+Shift+R on Mac) to hard refresh

Show your teacher: "The website has automatically updated with my change!"

Point out the text you changed (like "LIVE DEMO!" or "Version 2.0")

---

## 🎯 What You're Demonstrating

✅ **Version Control**: Changes tracked in Git  
✅ **Automation**: No manual deployment needed  
✅ **CI/CD Pipeline**: Automatic build and deploy  
✅ **Cloud Hosting**: Running on AWS EC2  
✅ **Containerization**: Docker builds and runs the app  
✅ **DevOps Workflow**: Complete professional deployment pipeline

---

## 💡 Quick Demo Script (What to Say)

1. **"Here's my live website on AWS"** → Show http://44.192.66.105:5000
2. **"I'll make a small change to the code"** → Edit app.py
3. **"I push it to GitHub"** → Run git commands
4. **"The pipeline automatically triggers"** → Show GitHub Actions
5. **"In 2-3 minutes, it builds and deploys"** → Wait for green checkmarks
6. **"And the website updates automatically!"** → Refresh and show changes

---

## 🔄 If You Want to Demo Again

Just make another small change:
- Change "Version 2.0" to "Version 2.1"
- Or change colors, text, emojis - anything!
- Then repeat Steps 3-6

Every push to GitHub automatically deploys! 🚀

---

## ⚠️ Important Notes

- **Current EC2 IP**: `44.192.66.105` (use this URL)
- **Pipeline takes**: 2-3 minutes to complete
- **Hard refresh**: Use Ctrl+Shift+R to see changes (clears browser cache)
- **GitHub Actions**: https://github.com/Usman2k25/devops-lab/actions

---

## 🎓 Teacher Will Be Impressed By

1. You don't manually connect to servers
2. Everything is automated
3. Professional DevOps workflow
4. Infrastructure as Code (Terraform)
5. Containerization (Docker)
6. Full CI/CD pipeline working

Good luck with your demo! 🌟
