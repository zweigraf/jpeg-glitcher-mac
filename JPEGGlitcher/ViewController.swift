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
                
                let newData = self.glitchData(data);
                
                guard let image = NSImage(data: newData) else {
                    print("could not create image from glitched data")
                    return
                }
                
                self.imageView.image = image;
                
                
            }
        }
    }
    
    func glitchData(data : NSData) -> NSData {
        let count = data.length / sizeof(UInt8);
        var bytes = [UInt8](count: count, repeatedValue : 0);
        
        data.getBytes(&bytes, length: data.length);
        
        let randomIndex = Int(drand48() * Double(count));
        let randomValue = UInt8(drand48() * Double(UInt8.max));
        
        bytes[randomIndex] = randomValue;
        
        let newData = NSData(bytes: &bytes, length: data.length);
        return newData;
    }

}

