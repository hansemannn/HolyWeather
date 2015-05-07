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
    
    /**
    Sets the location latitude
    
    :param: latitude    The new latitude
    
    :returns: No return value.
    */
    func setLatitude(latitude : Double) {
        self.latitude = latitude
    }
    
    /**
    Sets the location longitude
    
    :param: longitude    The new longitude
    
    :returns: No return value.
    */
    func setLongitude(longitude : Double) {
        self.longitude = longitude
    }
    
    /**
    Return the location latitude
    
    :returns: The location latitude
    */
    func getLatitude() -> Double {
        return self.latitude
    }
    
    /**
    Return the location longitude
    
    :returns: The location longitude
    */
    func getLongitude() -> Double {
        return self.longitude
    }
}