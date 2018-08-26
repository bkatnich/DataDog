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
        case name
        case handle
        case email
        case icon
        case role
        case accessRole = "access_role"
        case isAdmin = "is_admin"
        case isVerified = "verified"
        case isDisabled = "disabled"
    }
    
    public var name: String
    
    public var isAdmin: Bool
    public var isVerified: Bool
    public var isDisabled: Bool
    
    
    // MARK: -- Lifecycle --

    /**
     * Default initializer which should never be used.  It will be called only in the case
     * of failure to file and decode the appropriate.
     */
    private init()
    {
        self.name = ""
        self.isAdmin = false
        self.isVerified = false
        self.isDisabled = true
    }
}


public extension User
{
    /**
     * Dictionary
     */
    init(from info: Dictionary<String, Any>)
    {
        self.name = info[CodingKeys.name.rawValue] as? String ?? ""
        
        self.isAdmin = info[CodingKeys.isAdmin.rawValue] as? Bool ?? false
        self.isVerified = info[CodingKeys.isVerified.rawValue] as? Bool ?? false
        self.isDisabled = info[CodingKeys.isDisabled.rawValue] as? Bool ?? true
    }
    
    
    /**
     * Decodable
     */
    init(from decoder: Decoder) throws
    {
        // Get our container for this subclass' coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
    
        self.isAdmin = (try? container.decode(Bool.self, forKey: .isAdmin)) ?? false
        self.isVerified = (try? container.decode(Bool.self, forKey: .isVerified)) ?? false
        self.isDisabled = (try? container.decode(Bool.self, forKey: .isDisabled)) ?? true
    }
    
    
    /**
     * Encodable
     */
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
       
        try container.encode(self.name, forKey: .name)
        
        try container.encode(self.isAdmin, forKey: .isAdmin)
        try container.encode(self.isVerified, forKey: .isVerified)
        try container.encode(self.isDisabled, forKey: .isDisabled)
    }
}
