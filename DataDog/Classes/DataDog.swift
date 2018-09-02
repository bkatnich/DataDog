//
//  DataDog.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 Britton Katnich. All rights reserved.
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
#if DEBUG
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
#endif
    }


#if DEBUG
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

    /**
     * General debug output for a Response.
     *
     * @param response Response?
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
     * General debug output for a Response with a successful outcome.
     *
     * @param response Response?
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
