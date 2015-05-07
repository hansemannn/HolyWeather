//
//  WeatherLocationManager.swift
//  HolyWeather
//
//  Created by Hans Knöchel on 06.05.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherLocationDelegate {
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
}

class WeatherLocationManager : NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var didUpdateLocation = false
    internal var delegate : WeatherLocationDelegate?

    /**
    Initializes the WeatherLocationManager, sets the delegate and configures the diresed GPS accuracy.
    
    :returns: No return value.
    */
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        self.updateLocation();
    }
    
    /**
    Checks the environment of the operating system, requests authorization if nessasary and instantiates the location updates.
    
    :returns: No return value.
    */
    func updateLocation() -> Void {
        if CLLocationManager.locationServicesEnabled() {
            if self.locationManager.respondsToSelector("requestWhenInUseAuthorization") {
                if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
                    self.locationManager.requestWhenInUseAuthorization()
                } else {
                    self.locationManager.startUpdatingLocation()
                }
            } else {
                self.locationManager.startUpdatingLocation()
            }
        } else {
            println("Location not granted")
        }
    }
    
    /**
    Is fired when locations were updated, delegates the result.
    
    :param: manager     The correspondig LocationManager to take the location data.
    :param: locations   The received locations.
    
    :returns: No return value.
    */
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        self.delegate?.locationManager(manager, didUpdateLocations: locations)
    }
}