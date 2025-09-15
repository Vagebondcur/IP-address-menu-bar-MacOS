#!/bin/bash

echo "Uninstalling IP Address Menu Bar App from startup..."

# Unload the launch agent
launchctl unload ~/Library/LaunchAgents/com.ipaddress.menubar.plist 2>/dev/null

# Remove the plist file
rm -f ~/Library/LaunchAgents/com.ipaddress.menubar.plist

echo "✅ IP Address Menu Bar App removed from startup!"
echo "The app will no longer start automatically when you log in."