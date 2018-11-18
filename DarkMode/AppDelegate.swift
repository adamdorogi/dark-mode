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
        let image = NSImage(named: "owlOpen")
        image?.size = NSSize(width: 20, height: 15)
        if let button = statusItem.button {
            button.image = image
            button.action = #selector(togglePopover(_:))
        }
        
        // Set up popover view controller.
        popover.contentViewController = ViewController()
    }
    
    @objc func togglePopover(_ sender: Any) {
        if popover.isShown {
            closePopover()
        } else {
            showPopover()
        }
    }
    
    func showPopover() {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            
            // Add event monitor.
            eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown], handler: { _ in
                self.closePopover()
            })
        }
    }
    
    func closePopover() {
        popover.close()
        NSEvent.removeMonitor(eventMonitor!)
    }
}
