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
    func load(method: Alamofire.Method, url: String, completion: (AnyObject) -> Void, failture : (String) -> Void) -> Void {
        let parameters = []
        var JSONSerializationError: NSError? = nil
        
        let req = Alamofire.request(method, url).responseJSON { (_, _, JSON, _) in
                        
            if(JSON == nil) {
                failture("The server is currently not available, please try again!")
            } else {
                completion(JSON!)
            }
        }
        
        debugPrintln(req)
    }
}