#!/bin/bash

echo "Installing IP Address Menu Bar App for startup..."

# Create LaunchAgents directory if it doesn't exist
mkdir -p ~/Library/LaunchAgents

# Copy the plist file to LaunchAgents
cp com.ipaddress.menubar.plist ~/Library/LaunchAgents/

# Load the launch agent
launchctl load ~/Library/LaunchAgents/com.ipaddress.menubar.plist

echo "✅ IP Address Menu Bar App installed for startup!"
echo "The app will now start automatically when you log in."
echo ""
echo "To uninstall startup, run: ./uninstall_startup.sh"