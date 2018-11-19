//
//  AppDelegate.swift
//  DarkMode
//
//  Created by Adam Dorogi-Kaposi on 14/11/18.
//  Copyright © 2018 Adam Dorogi-Kaposi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let popover = NSPopover()
    var eventMonitor: Any?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create status bar item.
        if let button = statusItem.button {
            button.action = #selector(togglePopover(_:))
        }
        
        // Set up and show popover view controller.
        popover.contentViewController = ViewController()
        showPopover()
        
        // Add observer to detect change in dark mode.
        UserDefaults.standard.addObserver(self, forKeyPath: "AppleInterfaceStyle", options: [.initial, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "AppleInterfaceStyle", let button = statusItem.button {
            // Dark mode changed, update status item button image.
            if change?[.newKey] is NSNull {
                button.image = NSImage(named: "Moon")
            } else {
                button.image = NSImage(named: "MoonDark")
            }
        }
    }
    
    @objc func togglePopover(_ sender: NSStatusItem) {
        if popover.isShown {
            closePopover()
        } else {
            showPopover()
        }
    }
    
    func showPopover() {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            
            // Add event monitor to listen to mouse events.
            eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown, .keyDown], handler: { _ in
                self.closePopover()
            })
        }
    }
    
    func closePopover() {
        popover.close()
        NSEvent.removeMonitor(eventMonitor!)
    }
}
