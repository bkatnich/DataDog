//
//  String_Extension.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation


/**
 * Ease of us extensions to Foundation's Formatter class.
 */
public extension String
{
    /**
     * The URL escaped version of the String.
     */
    var urlEscaped: String
    {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    /**
     * The UTF8 encoded version of the String as Data.
     */
    var utf8Encoded: Data
    {
        return data(using: .utf8)!
    }
}
