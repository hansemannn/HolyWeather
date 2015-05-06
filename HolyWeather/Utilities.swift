//
//  Utilities.swift
//  HolyWeather
//
//  Created by Hans Knöchel on 06.05.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    func isiOS8orGreater(value : AnyObject) -> Bool {
        let version = NSString(string: UIDevice.currentDevice().systemVersion).doubleValue
        
        return version >= 8
    }
}