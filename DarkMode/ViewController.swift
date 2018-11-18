//
//  ViewController.swift
//  DarkMode
//
//  Created by Adam Dorogi-Kaposi on 14/11/18.
//  Copyright © 2018 Adam Dorogi-Kaposi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame = NSRect(x: 0, y: 0, width: 300, height: 100)
        
        let button = NSButton(title: "Toggle", target: self, action: #selector(toggleDarkMode(_:)))
        self.view.addSubview(button)
    }
    
    @objc func toggleDarkMode(_ sender: Any) {
        //        let script = "tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode"
        let script = """
        tell application "System Events"
            tell appearance preferences
                set dark mode to not dark mode
            end tell
        end tell
        """
        
        NSAppleScript(source: script)?.executeAndReturnError(nil)
        
        if isEnabled() {
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.statusItem.button!.image = NSImage(named: "owlOpen")
        } else {
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.statusItem.button!.image = NSImage(named: "owlClosed")
        }
    }
    
    func isEnabled() -> Bool {
        return UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
    }
    
    override func loadView() {
        self.view = NSView()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
