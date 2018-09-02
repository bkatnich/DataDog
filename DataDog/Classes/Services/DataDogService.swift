//
//  DataDogService.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-27.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation


/**
 *  The base Service for all API services.
 */
public class DataDogService
{
    //
    // Base Headers
    //
    public class func baseHeaders() -> [String : String]
    {
        return [
            "Content-type": "application/json"
        ]
    }
    
    //
    // Base Parameters
    //
    public class func baseParameters() -> [String : Any]
    {
        return [
            "api_key" : ",
            "application_key" : ""
        ]
    }
    
    //
    // Base URL
    //
    public class func baseUrl() -> URL
    {
        return URL(string: "https://api.datadoghq.com/api/v1")!
    }
}
