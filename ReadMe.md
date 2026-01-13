# Policy Editor

![Policy Editor Banner](https://img.shields.io/badge/Chrome%20OS-Policy%20Editor-blue)

A Chrome OS user policy editor with extension force-installer capabilities. Based on [Pollen](https://github.com/mercuryworkshop/pollen) by MercuryWorkshop.

## ⚠️ Important

**You must have Developer Mode enabled for this to work!**

This script modifies **user policies only** and cannot modify device-level policies.

## 🚀 Features

- **Force-installs extensions** (GoGuardian, Snap&Read, CoWriter, etc.)
- **Disables restrictive policies** (URL blocking, extension blocking, etc.)
- **Enables useful features** (Incognito, Developer Tools, Guest Mode, etc.)
- **Automatic RootFS check** and optional disable
- **30+ policy modifications** for maximum freedom

## 📦 Installation

### Temporary (Lost on Reboot)
```bash
curl -Ls https://raw.githubusercontent.com/GamerRyker/Policy-Editor/refs/heads/main/PolicyEditor.sh | sudo bash
```

### Permanent (Requires RootFS Disabled)

1. Disable RootFS verification:
```bash
sudo /usr/share/vboot/bin/make_dev_ssd.sh --remove_rootfs_verification --partitions 2
sudo reboot
```

2. After reboot, run the script:
```bash
curl -Ls https://raw.githubusercontent.com/GamerRyker/Policy-Editor/refs/heads/main/PolicyEditor.sh | sudo bash
```

## 🎯 What It Does

### Extensions Force-Installed:
- GoGuardian
- GoGuardian License
- Snap&Read
- CoWriter
- Read&Write

### Policies Modified:
- ✅ URL blocking: DISABLED
- ✅ Incognito mode: ENABLED
- ✅ Developer tools: ENABLED
- ✅ Browser history deletion: ENABLED
- ✅ Guest mode: ENABLED
- ✅ Extension blocking: DISABLED
- ✅ Safe browsing: DISABLED
- ✅ Password manager: ENABLED
- ✅ Printing: ENABLED
- ✅ Download restrictions: NONE
- ✅ Screen lock on idle: DISABLED
- ✅ Power management: DISABLED
- And 20+ more...

## 📋 Usage

1. Open VT-2 terminal: Press `Ctrl + Alt + F2` (or `Ctrl + Alt + →`)
2. Login as root
3. Run the installation command above
4. Follow the prompts
5. Wait for Chrome UI to restart
6. Check `chrome://policy` to verify changes

## ⚙️ Requirements

- Chrome OS in Developer Mode
- Root/sudo access (VT-2 shell)
- Internet connection (for curl installation)

## 🛠️ Customization

Edit the script to add/remove extensions or modify policies:
```bash
# Add more extensions to this array:
EXTENSIONS=(
  "your_extension_id;https://clients2.google.com/service/update2/crx"
)
```

## ⚠️ Disclaimer

This tool is for educational purposes. Use responsibly and only on devices you own or have permission to modify. Bypassing school/organization restrictions may violate policies.

## 📜 License

MIT License

## 🙏 Credits

- Based on [Pollen](https://github.com/mercuryworkshop/pollen) by MercuryWorkshop
- Extension force-install concept from various Chrome OS exploits

## 📞 Support

If you encounter issues:
1. Check `chrome://policy` to see if policies applied
2. Try running `sudo restart ui` manually
3. Verify Developer Mode is enabled
4. Open an issue on GitHub

---

**Made with ❤️ for Chrome OS freedom**
```

**NOTE: WE ARE NOT RESPONSIBLE FOR ANY DAMAGES OR ISSUES THIS MAY CAUSE TO YOUR CHROMEBOOK. USE AT YOUR OWN DISCRETION
**
