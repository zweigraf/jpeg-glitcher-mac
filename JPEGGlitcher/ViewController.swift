//
//  ViewController.swift
//  JPEGGlitcher
//
//  Created by Luis Reisewitz on 26.02.16.
//  Copyright © 2016 ZweiGraf. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var loadImageButton: NSButton!
    @IBOutlet weak var imageView: NSImageView!
    
    var originalData : NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func loadImage(sender: NSButton) {
        let openPanel = NSOpenPanel();
        openPanel.canChooseDirectories = false;
        openPanel.allowsMultipleSelection = false;
        
        openPanel.beginWithCompletionHandler { (result) -> Void in
            if result == NSFileHandlingPanelOKButton {
                guard let url = openPanel.URLs.first else {
                    return;
                }
                
                guard let data = NSData(contentsOfURL: url) else {
                    return
                }
                
                self.originalData = data
                
                self.reglitch(sender)
                
            }
        }
    }
    
    @IBAction func reglitch(sender: NSButton) {
        guard let data = self.originalData else {
            return
        }
        
        guard let image = ViewController.createGlitchedImage(data) else {
            return
        }
        
        self.imageView.image = image;
    }
    
    static func createGlitchedImage(data : NSData) -> NSImage? {
        let newData = ViewController.glitchData(data);
        
        guard let image = NSImage(data: newData) else {
            print("could not create image from glitched data")
            return nil
        }
        
        return image
    }
    
    static func glitchData(data : NSData) -> NSData {
        let count = data.length / sizeof(UInt8);
        var bytes = [UInt8](count: count, repeatedValue : 0);
        
        data.getBytes(&bytes, length: data.length);
        
        let maxIndex = count - 1;
        
        let randomIndex = Int(drand48() * Double(maxIndex));
        
        let remainingIndices = maxIndex - randomIndex
        
        let randomCount = Int(drand48() * Double(remainingIndices)) + 1
        
        let upperBound = randomIndex + randomCount
        
        print("Glitching \(randomCount) times from \(randomIndex) to \(upperBound - 1)).")
        for i in randomIndex..<upperBound {
            let randomValue = UInt8(drand48() * Double(UInt8.max))
            bytes[i] = randomValue
            
//            print("Changing byte at index \(i) to value \(randomValue)")
        }
        
        let newData = NSData(bytes: &bytes, length: data.length);
        return newData;
    }

}

