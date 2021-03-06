//
//  InterfaceController.swift
//  BmwApp WatchKit Extension
//
//  Created by Rodolfo Castillo on 16/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var messageLabel: WKInterfaceLabel!
    
    @IBOutlet weak var button: WKInterfaceButton!
    
    let sharedData = NSUserDefaults(suiteName: "group.motoRide")
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.changing()
        self.messageLabel.setText(sharedData?.objectForKey("status") as? String)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.changing()
        self.messageLabel.setText(sharedData?.objectForKey("status") as? String)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        self.changing()
        self.messageLabel.setText(sharedData?.objectForKey("status") as? String)
    }
    
    func changing(){
        if (self.sharedData?.valueForKey("status") as! String == "Danger"){
            self.button.setTitle("Dont Worry")
            self.button.setBackgroundColor(UIColor.greenColor());
        } else {
            self.button.setTitle("Cancel Alarm")
            self.button.setBackgroundColor(UIColor.redColor());
        }
    }
    
    
    @IBAction func actionS() {
        println(":P")
        self.sharedData!.setObject("M", forKey: "L")
        self.sharedData!.synchronize()
        
    }
    
}

