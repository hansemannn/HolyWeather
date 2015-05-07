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

    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
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
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        self.delegate?.locationManager(manager, didUpdateLocations: locations)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        println("Location changed: \(newLocation)")
    }
}