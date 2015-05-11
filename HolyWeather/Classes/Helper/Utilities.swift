//
//  Utilities.swift
//  HolyWeather
//
//  Created by Hans Knöchel on 08.05.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit

public class Utilities: NSObject {
    
    /** 
    Show an alert wherever you want

    :param: title The title of the dialog
    :param: message The message of the dialog
    :param: view The parent view controller to show the dialog
    */
    public func showAlert(title : String, message : String, view : UIViewController) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        alertController.addAction(OKAction)
        
        view.presentViewController(alertController, animated: true) {}
    }
}
