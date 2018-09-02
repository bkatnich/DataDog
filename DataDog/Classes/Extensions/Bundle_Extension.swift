//
//  Bundle.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 Britton Katnich. All rights reserved.
//

import UIKit


/**
 * Ease of us extensions to Foundation's Bundle class.
 */
public extension Bundle
{
    // MARK: -- Main Bundle Additions --
    
    /**
     * Retrieve the containing application's name.
     *
     * @returns String
     */
    static func appName() -> String
    {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
    
    /**
     * Return the containing application's build number.
     *
     * @returns String
     */
    static func buildNumber() -> String
    {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
    
    
    /**
     * Retrieve the version String.
     *
     * @returns String.
     */
    static func version() -> String
    {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    
    /**
     * Retrieve the combined version and builder number.
     *
     * For example, if the version is "1.5.11" and the builder number is "4" the
     * returned value will be in the format "1.5.11 (4)"
     *
     * @returns String
     */
    static func versionAndBuildNumber() -> String
    {
        return self.version() + " (" + self.buildNumber() + ")"
    }
}
