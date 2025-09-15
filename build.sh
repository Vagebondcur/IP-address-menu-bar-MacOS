#!/bin/bash

# Build the IP Address Menu Bar App
echo "Building IP Address Menu Bar App..."

# Compile the Swift file
swiftc -o IPAddressApp main.swift

if [ $? -eq 0 ]; then
    echo "✅ Build successful! Run './IPAddressApp' to start the menu bar app."
else
    echo "❌ Build failed!"
    exit 1
fi