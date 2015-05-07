//
//  RequestManager.swift
//  HolyWeather
//
//  Created by Hans Knöchel on 06.05.15.
//  Copyright (c) 2015 Hans Knoechel. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    func load(url: String, completion: (AnyObject) -> Void) {
        let URL = NSURL(string: url)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = "GET"
        
        let parameters = []
        var JSONSerializationError: NSError? = nil
        
        let req = Alamofire.request(mutableURLRequest).responseJSON { (req, res, json, error) in
                        
            if(json == nil) {
                println("Der Server ist aktuell nicht erreichbar. Bitte versuche es erneut!")
                completion("Error");
                return
            }
            
            completion(json!)
        }
    }
}