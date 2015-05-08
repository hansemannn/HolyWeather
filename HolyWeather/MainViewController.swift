//
//  MainViewController.swift
//  HolyWeather
//
//  Created by Hans Knöchel on 06.05.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire
import MMWormhole

class MainViewController: UIViewController, WeatherLocationDelegate {
    
    private let locationManager = WeatherLocationManager()
    private var userLocation = UserLocation()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationTemperature: UILabel!
    
    
    @IBAction func refreshButtonClicked(sender: UIBarButtonItem) {
        self.updateLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var wormhole = MMWormhole()

        self.locationManager.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        self.updateLocation()
    }
    
    /**
    Triggers new location updates to the WeatherLocationManager
    
    :returns: No return value.
    */
    func updateLocation() -> Void {
        self.locationName.hidden = true
        self.locationTemperature.hidden = true

        self.activityIndicator.startAnimating()
        self.locationManager.updateLocation(showError)
    }

    /**
    Represents the delegate of the LocationManager and is fired, locations were updated.
    
    :param: manager     The correspondig LocationManager to take the location data.
    :param: locations   The received locations.
    
    :returns: No return value.
    */
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) -> Void {
        var locationValue : CLLocationCoordinate2D = manager.location.coordinate
        
        self.locationManager.locationManager.stopUpdatingLocation()
        
        self.userLocation.setLatitude(locationValue.latitude)
        self.userLocation.setLongitude(locationValue.longitude)
        
        self.loadData()
        
        println("Found location!\n- Latitude = \(self.userLocation.getLatitude())\n- Longitude = \(self.userLocation.getLongitude())")
    }
    
    /**
    Represents the delegate of the LocationManager and is fired, when the authorization status is changed.
    
    :param: manager     The correspondig LocationManager to take the location data.
    :param: status      The new status.
    
    :returns: No return value.
    */
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.Denied) {
            self.showError("You denied the access to the location services. Please enable the location services and try again!")
        } else {
            self.locationManager.updateLocation(showError)
        }
    }
    
    /**
    Loads the weather data from the json-based web service.
    
    :returns: No return value.
    */
    func loadData() -> Void {
        let req = RequestManager()
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(self.userLocation.getLatitude())&lon=\(self.userLocation.getLongitude())&units=metric"
        req.load(.GET, url: url, completion: updateUI, errorHandler: showError)
    }
    
    /**
    Shows a network error.
    
    :param: error    The error message.
    
    :returns: No return value.
    */
    func showError(error : String) -> Void {
        self.activityIndicator.stopAnimating()
        Utilities().showAlert("Error", message: error, view: self)
    }

    /**
    Displays the dats received from the RequestManager completion handler.

    :param: response    The json response of the weather.
    
    :returns: No return value.
    */
    func updateUI(response : AnyObject) -> Void {
        let json = JSON(response)
        
        let name = json["name"].stringValue
        let temperature = String(Int(json["main"]["temp"].doubleValue))+"°"
        
        self.locationName.text = name
        self.locationTemperature.text = temperature
        
        self.locationName.hidden = false
        self.locationTemperature.hidden = false
        
        self.activityIndicator.stopAnimating()
    }

}

