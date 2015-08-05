//
//  ViewController.swift
//  FloatingHeads
//
//  Created by ricardo antonio cacho on 2015-08-05.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FloatingMenuDelegate {

    @IBOutlet weak var floatingMenuButton: FloatingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func presentFloatingMenu(sender: FloatingButton) {
        
        let floatingMenu = FloatingMenuController()
        floatingMenu.delegate = self
        floatingMenu.fromView = floatingMenuButton
        presentViewController(floatingMenu, animated: true, completion:nil)
    }
    
    func closeButtonSelected() {
        NSLog("The close button was pressed!")
    }
    
    func menuButtonSelected() {
        NSLog("One of the menu buttons was selected")
    }
    
    
}

