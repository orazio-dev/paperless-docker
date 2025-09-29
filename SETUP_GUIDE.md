# 📱 Paperless Mobile Sync Setup Guide

Complete instructions for setting up Paperless-ngx on your PC and syncing with your Android mobile device.

## 🎯 What You'll Get

- **PC Server**: Paperless running on your computer
- **Mobile Sync**: Access documents from your Android phone
- **Camera Upload**: Take photos directly in the mobile app
- **Offline Access**: Download documents for offline viewing
- **Automatic Sync**: Documents sync between devices automatically

---

## 📋 Prerequisites

### PC Requirements
- **Operating System**: Windows, macOS, or Linux
- **Docker**: Docker Desktop installed ([Download here](https://www.docker.com/products/docker-desktop/))
- **RAM**: At least 2GB available
- **Storage**: 1GB+ free space
- **Network**: PC and Android device on same Wi-Fi network

### Android Requirements
- **Android**: Version 7.0+ (API level 24+)
- **Storage**: 100MB+ free space
- **Network**: Connected to same Wi-Fi as PC

---

## 🖥️ PC Setup (Step 1)

### 1. Install Docker Desktop

**Windows:**
1. Download Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop/)
2. Run the installer and follow the setup wizard
3. Restart your computer when prompted

**macOS:**
1. Download Docker Desktop for Mac
2. Drag Docker.app to Applications folder
3. Launch Docker Desktop from Applications

**Linux:**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker
```

### 2. Download Paperless Setup

**Option A: Git Clone (Recommended)**
```bash
git clone https://github.com/orazio-dev/paperless-docker.git
cd paperless-docker
```

**Option B: Download ZIP**
1. Go to [GitHub Repository](https://github.com/orazio-dev/paperless-docker)
2. Click "Code" → "Download ZIP"
3. Extract the ZIP file
4. Open terminal/command prompt in the extracted folder

### 3. Configure Paperless

**Find Your PC's IP Address:**

**Windows:**
```cmd
ipconfig
```
Look for "IPv4 Address" under your Wi-Fi adapter.

**macOS/Linux:**
```bash
hostname -I
```

**Example IP**: `192.168.1.100`

### 4. Update Configuration

**Edit the `.env` file:**
```bash
# Windows
notepad .env

# macOS/Linux
nano .env
```

**Update these lines:**
```env
PAPERLESS_URL=http://YOUR_PC_IP:8000
PAPERLESS_ADMIN_USER=admin
PAPERLESS_ADMIN_PASSWORD=your_secure_password_here
PAPERLESS_ADMIN_MAIL=your_email@example.com
```

**Replace:**
- `YOUR_PC_IP` with your actual IP address
- `your_secure_password_here` with a strong password
- `your_email@example.com` with your email

### 5. Start Paperless

```bash
# Start the services
docker compose up -d

# Check if running
docker compose ps
```

**Expected output:**
```
NAME                           STATUS
paperless-docker-broker-1      Up
paperless-docker-db-1          Up  
paperless-docker-webserver-1   Up (healthy)
```

### 6. Test PC Setup

1. **Open browser** and go to: `http://YOUR_PC_IP:8000`
2. **Login** with:
   - Username: `admin`
   - Password: `your_secure_password_here`
3. **Verify** you can see the Paperless interface

---

## 📱 Android Setup (Step 2)

### 1. Install Paperless Mobile App

**Option A: Google Play Store**
1. Open Google Play Store
2. Search for "Paperless"
3. Install the official Paperless app

**Option B: F-Droid (Open Source)**
1. Install F-Droid from [f-droid.org](https://f-droid.org/)
2. Search for "Paperless"
3. Install the app

### 2. Configure Mobile App

1. **Open** the Paperless mobile app
2. **Tap** "Add Server" or "+"
3. **Enter server details:**
   - **Server URL**: `http://YOUR_PC_IP:8000`
   - **Username**: `admin`
   - **Password**: `your_secure_password_here`
4. **Tap** "Test Connection"
5. **Tap** "Save" if connection successful

### 3. Test Mobile Sync

1. **Upload a document** on your PC via web interface
2. **Check** if it appears in the mobile app
3. **Take a photo** in the mobile app
4. **Check** if it appears on your PC

---

## 🔧 Troubleshooting

### Common Issues

**1. Can't connect from mobile app**
- ✅ **Check**: PC and Android on same Wi-Fi network
- ✅ **Check**: PC firewall allows port 8000
- ✅ **Check**: IP address is correct
- ✅ **Try**: Restart Docker services

**2. Login fails**
- ✅ **Check**: Username is `admin` (not custom)
- ✅ **Check**: Password matches `.env` file
- ✅ **Try**: Reset password (see below)

**3. Documents not syncing**
- ✅ **Check**: Internet connection
- ✅ **Check**: Paperless services running
- ✅ **Try**: Refresh mobile app

### Reset Admin Password

**Method 1: Update .env file**
```bash
# Edit .env file
nano .env

# Change this line:
PAPERLESS_ADMIN_PASSWORD=your_new_password

# Restart services
docker compose restart webserver
```

**Method 2: Command line**
```bash
docker compose exec webserver python3 manage.py changepassword admin
```

### Check Service Status

```bash
# View logs
docker compose logs webserver

# Check status
docker compose ps

# Restart if needed
docker compose restart webserver
```

---

## 🚀 Advanced Features

### Camera Upload
1. **Open** Paperless mobile app
2. **Tap** camera icon
3. **Take photo** of document
4. **Add tags** and metadata
5. **Upload** - automatically syncs to PC

### Offline Access
1. **Open** document in mobile app
2. **Tap** download icon
3. **View** documents without internet
4. **Sync** when back online

### Email Integration
1. **Go to** PC web interface
2. **Admin** → **Mail Accounts**
3. **Configure** email settings
4. **Send** documents to email address
5. **Auto-process** into Paperless

### File Sync Options

**Option 1: FolderSync App**
1. Install FolderSync from Play Store
2. Set up sync between Android folder and PC's `consume/` folder
3. Documents added to folder automatically process

**Option 2: Cloud Storage**
1. Set up Google Drive/Dropbox sync
2. Configure Paperless to watch cloud folder
3. Documents in cloud folder auto-process

---

## 🔒 Security Best Practices

### Password Security
- ✅ **Use strong passwords** (12+ characters)
- ✅ **Include** uppercase, lowercase, numbers, symbols
- ✅ **Avoid** common passwords
- ✅ **Change** default password immediately

### Network Security
- ✅ **Use secure Wi-Fi** (WPA2/WPA3)
- ✅ **Avoid public networks** for initial setup
- ✅ **Consider VPN** for remote access
- ✅ **Enable HTTPS** for production use

### Data Backup
```bash
# Create backup
docker compose exec webserver document_exporter /usr/src/paperless/export/

# Backup files will be in ./export/ folder
```

---

## 📞 Getting Help

### Documentation
- **Official Docs**: [paperless-ngx.readthedocs.io](https://paperless-ngx.readthedocs.io/)
- **GitHub Issues**: [github.com/paperless-ngx/paperless-ngx/issues](https://github.com/paperless-ngx/paperless-ngx/issues)

### Community Support
- **Discussions**: [GitHub Discussions](https://github.com/paperless-ngx/paperless-ngx/discussions)
- **Reddit**: r/selfhosted
- **Discord**: Paperless community servers

### Common Commands

```bash
# Start services
docker compose up -d

# Stop services  
docker compose down

# View logs
docker compose logs -f webserver

# Update to latest version
docker compose pull
docker compose up -d

# Backup documents
docker compose exec webserver document_exporter /usr/src/paperless/export/

# Reset admin password
docker compose exec webserver python3 manage.py changepassword admin
```

---

## 🎉 Success!

Once setup is complete, you'll have:

- ✅ **Paperless running** on your PC
- ✅ **Mobile app connected** and syncing
- ✅ **Camera upload** working
- ✅ **Offline access** available
- ✅ **Automatic sync** between devices

**Your documents are now accessible everywhere!** 📱💻

---

## 📝 Quick Reference

| Service | URL | Credentials |
|---------|-----|-------------|
| **PC Web Interface** | `http://YOUR_PC_IP:8000` | `admin` / `your_password` |
| **Mobile App** | Same server URL | Same credentials |
| **API Endpoint** | `http://YOUR_PC_IP:8000/api/` | Same credentials |

**Remember**: Replace `YOUR_PC_IP` with your actual computer's IP address!
