//
//  DataDog.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation
import Moya
import SwiftyBeaver

public let log = SwiftyBeaver.self


/**
 *
 */
public class DataDog
{
    /**
     * Start the initialization processes of the framework to provide common,
     * shared services both inside and outside the framework.
     */
    public static func start()
    {
        //
        // Logging
        //
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $N.$F():$l $L: $M"
        log.addDestination(console)
        
        //
        // Log startup state
        //
        log.info("\n\n" + self.debugStatus() + "\n\n")
    }
    
    /**
     * Retrieve the current debug values in a formatted String.
     *
     * @returns String.
     */
    public static func debugStatus() -> String
    {
        //
        // Log startup state
        //
        let debugStatus =
            "-- Application --" +
            "\n\nname: " + Bundle.appName() +
            "\nversion: " + Bundle.versionAndBuildNumber()
        
        return debugStatus
    }

}


/**
 *
 */
public enum DataDogEndpoint
{

}


/**
 *
 */
extension DataDogEndpoint: TargetType
{
//
    // Base URL
    //
    public var baseURL: URL { return URL(string: "https://api.datadoghq.com/api/v1")! }
    
    //
    // Paths
    //
    public var path: String
    {
        switch self
        {
            
        }
    }
    
    //
    // HTTP Methods
    //
    public var method: Moya.Method
    {
        switch self
        {
        
        }
    }
    
    //
    // Tasks
    //
    public var task: Task
    {
        switch self
        {
            
        }
    }
    
    //
    // Sample Data
    //
    public var sampleData: Data
    {
        switch self
        {
        
        }
    }
    
    //
    // Headers
    //
    public var headers: [String: String]?
    {
        return [
            "Content-type": "application/json"
        ]
    }
}
