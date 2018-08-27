//
//  DataDog.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation
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
            "\nversion: " + Bundle.versionAndBuildNumber() +
            "\n\n"
        
        return debugStatus
    }
}
