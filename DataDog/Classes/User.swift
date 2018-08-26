//
//  User.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation


/**
 *
 */
public struct User: Codable
{
    // MARK: -- Properties --
    
    private enum CodingKeys: String, CodingKey
    {
        case id
    }
    
    public var id: Int
    
    
    // MARK: -- Lifecycle --

    /**
     * Default initializer which should never be used.  It will be called only in the case
     * of failure to file and decode the appropriate.
     */
    private init()
    {
        self.id = 0
    }
}


public extension User
{
    /**
     * Dictionary
     */
    init(from info: Dictionary<String, Any>)
    {
        self.id = info[CodingKeys.id.rawValue] as? Int ?? 0
    }
    
    
    /**
     * Decodable
     */
    init(from decoder: Decoder) throws
    {
        // Get our container for this subclass' coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
    }
    
    
    /**
     * Encodable
     */
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
       
        try container.encode(self.id, forKey: .id)
    }
}
