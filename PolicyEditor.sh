#!/bin/bash

#################################################################################
# Custom Policy Editor with Extension Force Installer
# Based on Pollen by MercuryWorkshop
# https://github.com/mercuryworkshop/pollen
#################################################################################

# Check if running as root
if [ $(id -u) -ne 0 ]; then
    echo "ERROR: This script must be run as root!"
    echo "Please run with: sudo bash $0"
    exit 1
fi

echo "=========================================="
echo "  Custom Policy Editor & Extension Installer"
echo "=========================================="
echo ""

# Check if RootFS verification is disabled
echo "[*] Checking RootFS status..."
if mount | grep -q "ro,seclabel,nosuid,nodev,noexec"; then
    echo "[!] WARNING: RootFS verification is still enabled!"
    echo "[!] Changes will be temporary and lost on reboot."
    echo ""
    read -p "Do you want to disable RootFS verification now? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        echo "[*] Disabling RootFS verification..."
        /usr/share/vboot/bin/make_dev_ssd.sh --remove_rootfs_verification --partitions 2
        echo "[*] RootFS verification disabled. Please reboot and run this script again."
        exit 0
    else
        echo "[*] Continuing with temporary changes..."
    fi
fi

# Make filesystem writable
echo "[*] Making filesystem writable..."
mount -o remount,rw /

# Create policy directory if it doesn't exist
echo "[*] Creating policy directory..."
mkdir -p /etc/opt/chrome/policies/managed

# Force-installed extensions
EXTENSIONS=(
  "haldlgldplgnggkjaafhelgiaglafanh;https://clients2.google.com/service/update2/crx"  # GoGuardian
  "jjfeehgdeghiknkilcildnjofkcndjcm;https://clients2.google.com/service/update2/crx"  # GoGuardian License
  "mloajfnmjckfjbeeofcdaecbelnblden;https://clients2.google.com/service/update2/crx"  # Snap&Read
  "ifajfiofeifbbhbionejdliodenmecna;https://clients2.google.com/service/update2/crx"  # CoWriter
  "inoeonmfapjbbkmdafoankkfajkcphgd;https://clients2.google.com/service/update2/crx"  # That other extension
)

# Build extension JSON array
echo "[*] Building extension force-install list..."
EXT_JSON="["
for i in "${!EXTENSIONS[@]}"; do
  if [ $i -gt 0 ]; then
    EXT_JSON+=","
  fi
  EXT_JSON+="\"${EXTENSIONS[$i]}\""
done
EXT_JSON+="]"

# Create the comprehensive policy JSON
echo "[*] Creating policy configuration..."
cat > /etc/opt/chrome/policies/managed/custom_policy.json << EOF
{
  "ExtensionInstallForcelist": $EXT_JSON,
  "URLBlocklist": [],
  "URLAllowlist": ["*"],
  "IncognitoModeAvailability": 1,
  "DeveloperToolsAvailability": 1,
  "AllowDeletingBrowserHistory": true,
  "BrowserGuestModeEnabled": true,
  "DeviceGuestModeEnabled": true,
  "ExtensionInstallBlocklist": [],
  "SafeBrowsingEnabled": false,
  "SafeBrowsingProtectionLevel": 0,
  "PasswordManagerEnabled": true,
  "AutofillAddressEnabled": true,
  "AutofillCreditCardEnabled": true,
  "PrintingEnabled": true,
  "DownloadRestrictions": 0,
  "AllowDinosaurEasterEgg": true,
  "ChromeOsLockOnIdleSuspend": false,
  "ScreenBrightnessPercent": 100,
  "UserAvatarCustomizationSelectorsEnabled": true,
  "BookmarkBarEnabled": true,
  "EditBookmarksEnabled": true,
  "ShowHomeButton": true,
  "HomepageIsNewTabPage": true,
  "RestoreOnStartup": 1,
  "AllowFileSelectionDialogs": true,
  "PromptForDownloadLocation": false,
  "AlternateErrorPagesEnabled": true,
  "SearchSuggestEnabled": true,
  "NetworkPredictionOptions": 1,
  "WPADQuickCheckEnabled": false,
  "QuicAllowed": true,
  "BrowserAddPersonEnabled": true,
  "ForceBrowserSignin": false,
  "BrowserSignin": 2,
  "UserDataDir": "",
  "FullscreenAllowed": true,
  "AudioCaptureAllowed": true,
  "VideoCaptureAllowed": true,
  "AudioCaptureAllowedUrls": ["*"],
  "VideoCaptureAllowedUrls": ["*"],
  "ScreenCaptureAllowed": true,
  "AllowScreenLock": true,
  "PowerManagementIdleSettings": {
    "AC": {
      "Delays": {
        "ScreenDim": 0,
        "ScreenOff": 0,
        "IdleWarning": 0,
        "Idle": 0
      },
      "IdleAction": "DoNothing"
    },
    "Battery": {
      "Delays": {
        "ScreenDim": 0,
        "ScreenOff": 0,
        "IdleWarning": 0,
        "Idle": 0
      },
      "IdleAction": "DoNothing"
    }
  },
  "RelaunchNotification": 1,
  "RelaunchNotificationPeriod": 604800000,
  "SystemFeaturesDisableList": [],
  "SystemFeaturesDisableMode": 0,
  "AttestationEnabledForUser": false,
  "CloudPrintSubmitEnabled": false,
  "DisableSafeBrowsingProceedAnyway": false,
  "SpellcheckEnabled": true,
  "SpellcheckLanguage": [],
  "AlwaysOpenPdfExternally": false,
  "ClearBrowsingDataOnExitList": [],
  "DefaultSearchProviderEnabled": true,
  "SyncDisabled": false,
  "SigninAllowed": true,
  "BrowserLabsEnabled": true
}
EOF

echo ""
echo "[✓] Policy configuration complete!"
echo ""
echo "=========================================="
echo "  Configuration Summary"
echo "=========================================="
echo ""
echo "Extensions Force-Installed:"
echo "  • GoGuardian"
echo "  • GoGuardian License"
echo "  • Snap&Read"
echo "  • CoWriter"
echo "  • Shitty Read&Write"
echo ""
echo "Policies Modified:"
echo "  • URL blocking: DISABLED"
echo "  • Incognito mode: ENABLED"
echo "  • Developer tools: ENABLED"
echo "  • Browser history deletion: ENABLED"
echo "  • Guest mode: ENABLED"
echo "  • Extension blocking: DISABLED"
echo "  • Safe browsing: DISABLED"
echo "  • Password manager: ENABLED"
echo "  • Printing: ENABLED"
echo "  • Download restrictions: NONE"
echo "  • Screen lock on idle: DISABLED"
echo "  • Power management: DISABLED"
echo "  • And many more user-level policies..."
echo ""
echo "=========================================="
echo ""

# Restart Chrome UI to apply policies
echo "[*] Restarting Chrome UI to apply changes..."
restart ui

echo ""
echo "[✓] Done! Policies and extensions have been applied."
echo ""
if mount | grep -q "ro,seclabel,nosuid,nodev,noexec"; then
    echo "[!] NOTE: These changes are TEMPORARY and will be lost on reboot!"
    echo "[!] To make them permanent, disable RootFS verification."
fi
echo ""
echo "Check chrome://policy to verify the changes."
echo "=========================================="
