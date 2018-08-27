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
            "\n\nname: \(Bundle.appName())" +
            "\nversion: \(Bundle.versionAndBuildNumber())\n\n"
        
        return debugStatus
    }
    
    #if DEBUG
    
    /**
     *
     */
    public static func debugResponse(response: Response?)
    {
        // Check for nil
        if response == nil
        {
            log.warning("No response object")
            return
        }
        
        log.debug("\n\nRequest URL: \(String(describing: response?.request?.url))")
    }
    
    /**
     *
     */
    public static func debugResponseSuccess(response: Response?)
    {
        // Check for nil
        if response == nil
        {
            log.warning("No response object")
            return
        }
        
        do
        {
            let json = try response?.mapJSON()
        
            log.debug("\n\nJSON returned: \(String(describing: json))")
        }
        catch let error
        {
            log.error(error)
        }
    }
    
    #endif
}
