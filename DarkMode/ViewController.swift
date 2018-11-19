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
        
        // Initialise variables.
        let horizontalPadding = CGFloat(30)
        let verticalPadding = CGFloat(20)
        
        let titleFontSize = CGFloat(28)
        let headingFontSize = CGFloat(24)
        let captionFontSize = CGFloat(10)
        
        let viewWidth = 300
        let viewHeight = 400
        
        // Set up view size.
        self.view.frame.size = CGSize(width: viewWidth, height: viewHeight)
        
        // Set up title label.
        let titleLabel = NSTextField(labelWithString: "Night Owl")
        titleLabel.font = .boldSystemFont(ofSize: titleFontSize)
        titleLabel.sizeToFit()
        titleLabel.frame.origin = CGPoint(x: horizontalPadding, y: self.view.frame.maxY - titleLabel.frame.maxY - verticalPadding)
        self.view.addSubview(titleLabel)
        
        // Set up toggle button.
        let toggleButton = NSButton(title: "Toggle Dark Mode", target: self, action: #selector(toggleDarkMode(_:)))
        toggleButton.frame.origin = CGPoint(x: self.view.frame.midX - toggleButton.frame.midX, y: titleLabel.frame.minY - toggleButton.frame.maxY - verticalPadding)
        self.view.addSubview(toggleButton)
        
        // Set up status label.
        let statusLabel = NSTextField(labelWithString: "Status")
        statusLabel.font = .systemFont(ofSize: captionFontSize)
        statusLabel.sizeToFit()
        statusLabel.frame.origin = CGPoint(x: self.view.frame.midX - statusLabel.frame.midX, y: toggleButton.frame.minY - statusLabel.frame.maxY)
        self.view.addSubview(statusLabel)
        
        // Set up schedule checkbox.
        let scheduleCheckbox = NSButton()
        scheduleCheckbox.title = "Schedule"
        scheduleCheckbox.action = #selector(toggleSchedule(_:))
        scheduleCheckbox.font = .boldSystemFont(ofSize: headingFontSize)
        scheduleCheckbox.frame.size.height = scheduleCheckbox.fittingSize.height
        scheduleCheckbox.frame.size.width = scheduleCheckbox.fittingSize.width + 14
        scheduleCheckbox.frame.origin = CGPoint(x: horizontalPadding, y: statusLabel.frame.minY - scheduleCheckbox.frame.maxY - verticalPadding)
        scheduleCheckbox.setButtonType(.switch)
        self.view.addSubview(scheduleCheckbox)
        
        // Set up smart adjust checkbox.
        let smartAdjustCheckbox = NSButton()
        smartAdjustCheckbox.action = #selector(toggleSmartAdjust(_:))
        smartAdjustCheckbox.title = "Smart Adjust"
        smartAdjustCheckbox.font = .boldSystemFont(ofSize: headingFontSize)
        smartAdjustCheckbox.frame.size.height = smartAdjustCheckbox.fittingSize.height
        smartAdjustCheckbox.frame.size.width = smartAdjustCheckbox.fittingSize.width + 14
        smartAdjustCheckbox.frame.origin = CGPoint(x: horizontalPadding, y: scheduleCheckbox.frame.minY - smartAdjustCheckbox.frame.maxY - verticalPadding)
        smartAdjustCheckbox.setButtonType(.switch)
        self.view.addSubview(smartAdjustCheckbox)
        
        // Set up smart adjust label.
        let smartAdjustLabel = NSTextField(labelWithString: "Turn on dark mode based on screen brightness.")
        smartAdjustLabel.font = .systemFont(ofSize: captionFontSize)
        smartAdjustLabel.sizeToFit()
        smartAdjustLabel.frame.origin = CGPoint(x: horizontalPadding, y: smartAdjustCheckbox.frame.minY - smartAdjustLabel.frame.maxY * 1.5)
        self.view.addSubview(smartAdjustLabel)
    }
    
    @objc func toggleSchedule(_ sender: NSButton) {
        if sender.state == .on {
            print("Schedule on.")
        } else {
            print("Schedule off.")
        }
    }
    
    @objc func toggleSmartAdjust(_ sender: NSButton) {
        if sender.state == .on {
            print("Smart adjust on.")
        } else {
            print("Smart adjust off.")
        }
    }
    
    @objc func toggleDarkMode(_ sender: NSButton) {
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
