import Cocoa
import Network
import SystemConfiguration

class IPAddressMenuBarApp: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var timer: Timer?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupMenuBar()
        updateIPAddress()
        startPeriodicUpdate()
    }
    
    func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.title = "Getting IP..."
            button.target = self
            button.action = #selector(statusItemClicked)
        }
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Refresh IP", action: #selector(updateIPAddress), keyEquivalent: "r"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    @objc func statusItemClicked() {
        updateIPAddress()
    }
    
    @objc func updateIPAddress() {
        let ipInfo = getLocalIPAddress()
        
        DispatchQueue.main.async {
            if let button = self.statusItem.button {
                button.title = ipInfo ?? "No IP"
            }
        }
    }
    
    func getLocalIPAddress() -> String? {
        var ipInfo: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) {
                
                let name = String(cString: interface.ifa_name)
                if name == "en0" || name == "en1" || name == "wifi0" || name == "wlan0" || name.hasPrefix("tun") {
                    
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                              &hostname, socklen_t(hostname.count),
                              nil, socklen_t(0), NI_NUMERICHOST)
                    let address = String(cString: hostname)
                    ipInfo = "\(address) (\(name))"
                    break
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return ipInfo
    }
    
    func startPeriodicUpdate() {
        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { _ in
            self.updateIPAddress()
        }
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
}

let app = NSApplication.shared
let delegate = IPAddressMenuBarApp()
app.delegate = delegate
app.setActivationPolicy(.accessory)
app.run()