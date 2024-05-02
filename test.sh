#!/bin/sh

# Script name (replace with your desired name)
SCRIPT_NAME="your_script"

# Script path (replace with the actual path to your script)
SCRIPT_PATH="/path/to/your/script.sh"

# Description for the service and desktop file
SCRIPT_DESC="Your Script Description"

# Check if root privileges are present
if [ "$(whoami)" != "root" ]; then
  echo "This script requires root privileges. Please run with sudo."
  exit 1
fi

# Create the systemd service file
echo "[Unit]
Description=$SCRIPT_DESC
After=multi-user.target

[Service]
Type=simple
User=your_username  # Replace with your actual username
ExecStart=$SCRIPT_PATH

[Install]
WantedBy=multi-user.target" > "/etc/systemd/system/$SCRIPT_NAME.service"

# Reload systemd
systemctl daemon-reload

# Enable the service to start at boot
systemctl enable $SCRIPT_NAME.service

# Create the basic .desktop file (replace paths and customize)
echo "[Desktop Entry]
Type=Application
Name=$SCRIPT_DESC
Comment=Run $SCRIPT_DESC (You will be prompted for password)
Exec=gksu /path/to/this/script.sh  # Important! Path to this script
Terminal=false
Categories=Utility" > "/home/$USER/Desktop/$SCRIPT_NAME.desktop"

echo "Script setup complete. Please review and customize the .desktop file at: ~/Desktop/$SCRIPT_NAME.desktop"
