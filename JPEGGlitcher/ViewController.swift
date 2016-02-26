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
                
                guard let image = NSImage(data: data) else {
                    return
                }
                
                self.imageView.image = image;
            }
        }
    }

}

