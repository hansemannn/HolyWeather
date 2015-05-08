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
    
    /**
    Manages simple POST and GET requests
    
    :param: method      The request method.
    :param: url         The remote api url.
    :param: completion  The completion handler on success.
    
    :returns: No return value.
    */
    func load(method: String, url: String, completion: (AnyObject) -> Void, errorHandler : (String) -> Void) -> Void {
        let URL = NSURL(string: url)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = method
        
        let parameters = []
        var JSONSerializationError: NSError? = nil
        
        let req = Alamofire.request(mutableURLRequest).responseJSON { (req, res, json, error) in
                        
            if(json == nil) {
                errorHandler("The server is currently not available, please try again!")
            } else {
                completion(json!)
            }
        }
    }
}