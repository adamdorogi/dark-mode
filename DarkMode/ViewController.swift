//
//  ViewController.swift
//  DarkMode
//
//  Created by Adam Dorogi-Kaposi on 14/11/18.
//  Copyright © 2018 Adam Dorogi-Kaposi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var gridView: NSGridView!
    @IBOutlet weak var toggleButton: NSButton!
    @IBOutlet weak var scheduleCheckBox: NSButton!
    @IBOutlet weak var scheduleDropdown: NSPopUpButton!
    @IBOutlet weak var smartAdjustCheckBox: NSButton!
    
    @IBOutlet weak var datePickerFrom: NSDatePicker!
    @IBOutlet weak var brightnessSlider: NSSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleSchedule(scheduleCheckBox)
        changeScheduleDropdown(scheduleDropdown)
        toggleSmartAdjust(smartAdjustCheckBox)

        DistributedNotificationCenter.default().addObserver(self, selector: #selector(smartAdjust), name: Notification.Name("com.apple.AmbientLightSensorHID.PreferencesChanged"), object: nil)
        smartAdjust()
    }
    
    @IBAction func changeBrightnessThreshold(_ sender: Any) {
        smartAdjust()
    }
    
    func getBrightness() -> Float {
        var brightness: Float = 0.0
        
        var iterator: io_iterator_t = 0
        
        if IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"), &iterator) == kIOReturnSuccess {

            let service = IOIteratorNext(iterator)

            IODisplayGetFloatParameter(service, 0, kIODisplayBrightnessKey as CFString, &brightness)
            IOObjectRelease(service)
        }
        
        return brightness * 100
    }
    
    @objc func smartAdjust() {
        if smartAdjustCheckBox.state == .on {
            if getBrightness() <= brightnessSlider.floatValue {
                darkModeOn()
            } else {
                darkModeOff()
            }
        }
    }
    
    @IBAction func toggleDarkMode(_ sender: Any) {
        let toggleDarkModeScript = """
        tell application "System Events"
            tell appearance preferences
                set dark mode to not dark mode
            end tell
        end tell
        """

        NSAppleScript(source: toggleDarkModeScript)?.executeAndReturnError(nil)
    }
    
    func darkModeOff() {
        if isEnabled() {
            toggleDarkMode(self)
        }
    }
    
    func darkModeOn() {
        if !isEnabled() {
            toggleDarkMode(self)
        }
    }
    
    @IBAction func toggleSchedule(_ sender: NSButton) {
        if sender.state == .on {
            gridView.row(at: 4).isHidden = false
        } else {
            gridView.row(at: 4).isHidden = true
        }
        changeScheduleDropdown(scheduleDropdown)
    }
    
    @IBAction func changeScheduleDropdown(_ sender: NSPopUpButton) {
        if sender.title == "Custom" && scheduleCheckBox.state == .on {
            gridView.row(at: 5).isHidden = false
        } else {
            gridView.row(at: 5).isHidden = true
        }
    }
    
    @IBAction func toggleSmartAdjust(_ sender: NSButton) {
        gridView.row(at: 8).isHidden = (sender.state == .off)
        smartAdjust()
    }
    
    func isEnabled() -> Bool {
        return UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
    }
}
