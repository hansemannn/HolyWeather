//
//  InterfaceController.swift
//  HolyWeather WatchKit Extension
//
//  Created by Hans Knöchel on 08.05.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var locationName: WKInterfaceLabel!
    @IBOutlet weak var locationTemperature: WKInterfaceLabel!

    @IBAction func refreshButtonClicked() {
        self.refreshUI()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()
        self.refreshUI()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func refreshUI() -> Void {
        let dictionary = ["Desired Word":""]

        WKInterfaceController.openParentApplication(dictionary) {
            (replyInfo, error) -> Void in
            
        }
    }

}
