//
//  Organization.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-27.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation


/**
 * The Organization model.
 *
 * @see https://docs.datadoghq.com/api/?lang=python#organizations.
 */
public struct Organization: Codable
{
    // MARK: -- CodingKeys --
    
    private enum CodingKeys: String, CodingKey
    {
        case publicId = "public_id"
        case name
        case description
        case created
    }
    
    // MARK: -- Properties --
    
    public var publicId: Int
    public var name: String
    public var description: String
    public var created: Date
    
    
    // MARK: -- Lifecycle --

    /**
     * Default initializer which should never be used.  It will be called only in the case
     * of failure to file and decode the appropriate.
     */
    private init()
    {
        self.publicId = 0
        self.name = ""
        self.description = ""
        self.created = Date()
    }
}


/**
 * Extension implementing Codable.
 */
public extension Organization
{
    /**
     * Initialize from Dictionary of values.
     */
    init(from info: Dictionary<String, Any>)
    {
        self.publicId = info[CodingKeys.publicId.rawValue] as? Int ?? 0
    
        self.name = info[CodingKeys.name.rawValue] as? String ?? ""
        self.description = info[CodingKeys.description.rawValue] as? String ?? ""
        
        let createdValue: TimeInterval = info[CodingKeys.created.rawValue] as? TimeInterval ?? 0
        self.created = Date(timeIntervalSince1970: createdValue)
    }
    
    
    /**
     * Decodable initialzier.
     */
    init(from decoder: Decoder) throws
    {
        // Get our container for this subclass' coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.publicId = (try? container.decode(Int.self, forKey: .publicId)) ?? 0
        self.name = (try? container.decode(String.self, forKey: .name)) ?? "<not set>"
        self.description = (try? container.decode(String.self, forKey: .description)) ?? "<not set>"
        self.created = (try? container.decode(Date.self, forKey: .created)) ?? Date()
    }
    
    
    /**
     * Encodable writer.
     */
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
       
        try container.encode(self.publicId, forKey: .publicId)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.created, forKey: .created)
    }
}
