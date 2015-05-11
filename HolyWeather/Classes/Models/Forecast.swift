//
//  Forecast.swift
//  HolyWeather
//
//  Created by Hans Knöchel on 09.05.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation

class Forecast {
    private var day : String!
    private var temperature : Double!
    
    var dayValue : String {
        get {
            return self.day
        }
        
        set {
            self.day = newValue
        }
    }
    
    var temperatureValue : String {
        get {
            return String(Int(self.temperature))+"°"
        }
        
        set {
            self.temperature = NSNumberFormatter().numberFromString(newValue)?.doubleValue
        }
        
    }
}