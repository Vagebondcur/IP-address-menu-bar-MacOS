# IP Address Menu Bar Widget

A simple macOS menu bar application that displays your local IP address in the top-right menu bar.

## Features

- Shows your local IP address in the menu bar
- Auto-refreshes every 30 seconds
- Click to manually refresh
- Right-click for context menu with refresh and quit options
- Lightweight and fast

## Usage

**Quick setup (build + install for startup):**
```bash
./build.sh && ./install_startup.sh
```

**Manual steps:**

1. **Build the app:**
   ```bash
   ./build.sh
   ```

2. **Run the app:**
   ```bash
   ./IPAddressApp
   ```

3. **Install for startup (optional):**
   ```bash
   ./install_startup.sh
   ```

The app will appear in your menu bar showing your local IP address and interface (e.g., `192.168.1.100 (en0)`).

## Menu Options

- **Click the IP address**: Manual refresh
- **Right-click**: Access menu with:
  - Refresh IP (⌘R)
  - Quit (⌘Q)

## Startup Installation

To have the app start automatically when you log in:

```bash
./install_startup.sh
```

To remove from startup:

```bash
./uninstall_startup.sh
```

## How it works

The app uses Swift's network APIs to detect your local IP address by checking network interfaces (en0, en1, wifi0, wlan0). It automatically updates every 30 seconds to reflect any network changes.# IP-address-menu-bar-MacOS
