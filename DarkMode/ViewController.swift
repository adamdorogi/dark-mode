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
    
        // Initialise constants.
        let horizontalPadding = CGFloat(30)
        let verticalPadding = CGFloat(20)

        let titleFontSize = CGFloat(28)
        let headingFontSize = CGFloat(24)
        let captionFontSize = CGFloat(10)

        // Set up title label.
        let titleLabel = NSTextField(labelWithString: "Night Owl")
        titleLabel.font = .boldSystemFont(ofSize: titleFontSize)

        // Set up toggle button.
        let toggleButton = NSButton(title: "Toggle Dark Mode", target: self, action: #selector(toggleDarkMode(_:)))

        // Set up status label.
        let statusLabel = NSTextField(labelWithString: "Status")
        statusLabel.font = .systemFont(ofSize: captionFontSize)

        // Set up schedule checkbox.
        let scheduleCheckbox = NSButton(checkboxWithTitle: "Schedule", target: self, action: #selector(toggleSchedule(_:)))
        scheduleCheckbox.font = .boldSystemFont(ofSize: headingFontSize)

        // Set up smart adjust checkbox.
        let smartAdjustCheckbox = NSButton(checkboxWithTitle: "Smart Adjust", target: self, action: #selector(toggleSmartAdjust(_:)))
        smartAdjustCheckbox.font = .boldSystemFont(ofSize: headingFontSize)

        // Set up smart adjust label.
        let smartAdjustLabel = NSTextField(labelWithString: "Turn on dark mode based on screen brightness.")
        smartAdjustLabel.font = .systemFont(ofSize: captionFontSize)
        
        // Set up grid view to store subviews.
        let gridView = NSGridView(views: [[titleLabel], [toggleButton], [statusLabel], [scheduleCheckbox], [smartAdjustCheckbox], [smartAdjustLabel]])
        gridView.cell(atColumnIndex: 0, rowIndex: 1).xPlacement = .center
        gridView.cell(atColumnIndex: 0, rowIndex: 2).xPlacement = .center
        gridView.row(at: 3).height = 21
        gridView.row(at: 4).height = 21
        gridView.frame.size = gridView.fittingSize
        gridView.frame.origin = CGPoint(x: horizontalPadding, y: verticalPadding)
        
        self.view.frame.size = CGSize(width: gridView.frame.width + 2 * horizontalPadding, height: gridView.frame.height + 2 * verticalPadding)
        self.view.addSubview(gridView)
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
