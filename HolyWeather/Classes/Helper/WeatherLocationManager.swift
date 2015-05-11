//
//  WeatherLocationManager.swift
//  HolyWeather
//
//  Created by Hans Knöchel on 06.05.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol WeatherLocationDelegate {
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus)
}

class WeatherLocationManager : NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    internal var delegate : WeatherLocationDelegate?

    /**
    Initializes the WeatherLocationManager, sets the delegate and configures the diresed GPS accuracy.
    
    :returns: No return value.
    */
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.delegate?.locationManager(manager, didChangeAuthorizationStatus: status)
    }
    
    /**
    Checks the environment of the operating system, requests authorization if nessasary and instantiates the location updates.
    
    :returns: No return value.
    */
    func updateLocation(errorHandler : String -> Void) -> Void {
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
            errorHandler("Your location services are disabled. Please turn on location services and try again!")
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