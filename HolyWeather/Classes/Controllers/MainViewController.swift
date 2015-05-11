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

class MainViewController: UIViewController, WeatherLocationDelegate, UITableViewDelegate {
    
    // MARK: Object Variables

    private var userLocation = UserLocation()
    private var forecast = [Forecast]()
    private let locationManager = WeatherLocationManager()
    
    // MARK: Interface Outlets

    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationTemperature: UILabel!
    
    // MARK: Interface Actions
    
    @IBAction func refreshButtonClicked(sender: UIBarButtonItem) {
        self.updateLocation()
    }

    // MARK: UIViewController Delegates

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var wormhole = MMWormhole()

        self.locationManager.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        self.updateLocation()
    }
    
    // MARK: WeatherLocationManager Delegates

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

    // MARK: UITableView Delegates
    
    /**
    Configures a new UITableViewCell
    
    :param: tableView   The corresponding tableView
    :param: indexPath   The indexPath of the current iteration
    
    :returns: The configured cell
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "ForecastCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        var cellData = self.forecast[indexPath.row]
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        cell!.textLabel!.text = cellData.dayValue
        cell!.detailTextLabel!.text = cellData.temperatureValue
        
        return cell!
    }
    
    /**
    Determinates the number of sections in the tableView
    
    :param: tableView   The corresponding tableView.
    
    :returns: The number of sections.
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /**
    Determinates the number of rows per section in the tableView.
    
    :param: tableView   The corresponding tableView.
    :param: section     The index of the section to be added to.
    
    :returns: The number of rows.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecast.count
    }
    
    // MARK: Object Methods
    
    /**
    Triggers new location updates to the WeatherLocationManager
    
    :returns: No return value.
    */
    func updateLocation() -> Void {
        self.locationName.hidden = true
        self.locationTemperature.hidden = true
        self.forecastTableView.hidden = true
        
        self.activityIndicator.startAnimating()
        self.locationManager.updateLocation(showError)
    }
    
    /**
    Loads the weather data from the json-based web service.
    
    :returns: No return value.
    */
    func loadData() -> Void {
        let req = RequestManager()
        let url = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(self.userLocation.getLatitude())&lon=\(self.userLocation.getLongitude())&units=metric&cnt=5"
        req.load(.GET, url: url, completion: updateUI, failture: showError)
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
        self.forecast.removeAll(keepCapacity: false)
        let json = JSON(response)
        
        var today = Forecast()
        today.dayValue = json["city"]["name"].stringValue
        today.temperatureValue = json["list"][0]["temp"]["day"].stringValue

        for(var i = 0; i < json["list"].count; i++) {
            var singleForecast = Forecast()
                        
            singleForecast.dayValue = self.getDayOfWeekByIncreasedNumber(i)
            singleForecast.temperatureValue = json["list"][i]["temp"]["day"].stringValue
            
            self.forecast.append(singleForecast)
        }
        
        self.locationName.text = today.dayValue
        self.locationTemperature.text = today.temperatureValue
        
        self.locationName.hidden = false
        self.locationTemperature.hidden = false
        self.forecastTableView.hidden = false
        
        self.forecastTableView.reloadData()
        self.activityIndicator.stopAnimating()
    }
    
    /**
    Increases the current date by the given number of days.
    
    :param: value    The days to be added.
    
    :returns: The increased day of the week.
    */
    func getDayOfWeekByIncreasedNumber(value : Int) -> String {
        
        let calendar = NSCalendar.currentCalendar()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        
        let date = NSDate()
        let components = NSDateComponents()
        components.day = value
        
        let forecastDate = calendar.dateByAddingComponents(components, toDate: date, options: nil)
        
        return formatter.stringFromDate(forecastDate!)
    }

}

