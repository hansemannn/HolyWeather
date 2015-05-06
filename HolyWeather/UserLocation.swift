//
//  UserLocation.swift
//  HolyWeather
//
//  Created by Hans Knöchel on 06.05.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation
import CoreLocation

class UserLocation {
    private var latitude : Double!
    private var longitude : Double!
    
    func setLatitude(latitude : Double) {
        self.latitude = latitude
    }
    
    func setLongitude(longitude : Double) {
        self.longitude = longitude
    }
    
    func getLatitude() -> Double {
        return self.latitude
    }
    
    func getLongitude() -> Double {
        return self.longitude
    }
}