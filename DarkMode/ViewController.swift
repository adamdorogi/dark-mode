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
        
        let button = NSButton(title: "Toggle Dark Mode", target: self, action: #selector(toggleDarkMode(_:)))
        self.view.addSubview(button)
    }
    
    @objc func toggleDarkMode(_ sender: Any) {
        let toggleDarkModeScript = """
        tell application "System Events"
            tell appearance preferences
                set dark mode to not dark mode
            end tell
        end tell
        """
        
        NSAppleScript(source: toggleDarkModeScript)?.executeAndReturnError(nil)
    }
    
    func isEnabled() -> Bool {
        return UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
    }
    
    override func loadView() {
        self.view = NSView()
    }
}
