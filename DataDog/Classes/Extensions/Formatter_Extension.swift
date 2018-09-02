//
//  Formatter_Extension.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 Britton Katnich. All rights reserved.
//

import Foundation


/**
 * Ease of us extensions to Foundation's Formatter class.
 */
public extension Formatter
{
    /**
     * ISO8601 formatting in UTC format "yyyy-MM-dd'T'HH:mm:ss'Z'".  Z == Zulu.
     */
    public static let iso8601Zulu: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }()
    
    /**
     * ISO8601 formatting in UTC format with fractional seconds "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX".
     */
    public static let iso8601: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    
    /**
     * ISO8601 formatting in UTC format with NO fractional seconds "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX".
     */
    public static let iso8601noFS: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        return formatter
    }()
}
