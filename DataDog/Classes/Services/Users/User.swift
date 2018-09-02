//
//  User.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation


/**
 * The User model.
 *
 * @see https://docs.datadoghq.com/api/?lang=python#users
 */
public struct User: Codable
{
    // MARK: -- CodingKeys --
    
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
    
    // MARK: -- Properties --
    
    public var name: String
    public var handle: String
    public var email: String
    public var role: String
    public var accessRole: String
    
    public var isAdmin: Bool
    public var isVerified: Bool
    public var isDisabled: Bool
    
    public var icon: String?
    public var iconURL: URL?
    {
        get
        {
            if let iconValue = icon
            {
                return URL(fileURLWithPath: iconValue)
                
            } else { return nil }
        }
    }
    
    // MARK: -- Lifecycle --

    /**
     * Default initializer which should never be used.  It will be called only in the case
     * of failure to file and decode the appropriate.
     */
    private init()
    {
        self.name = ""
        self.handle = ""
        self.email = ""
        self.icon = ""
        self.role = ""
        self.accessRole = ""
        
        self.isAdmin = false
        self.isVerified = false
        self.isDisabled = true
    }
}


/**
 * Extension implementing Codable.
 */
public extension User
{
    /**
     * Initialize from Dictionary of values.
     */
    init(from info: Dictionary<String, Any>)
    {
        self.name = info[CodingKeys.name.rawValue] as? String ?? ""
        self.handle = info[CodingKeys.handle.rawValue] as? String ?? ""
        self.email = info[CodingKeys.email.rawValue] as? String ?? ""
        self.icon = info[CodingKeys.icon.rawValue] as? String ?? ""
        self.role = info[CodingKeys.role.rawValue] as? String ?? ""
        self.accessRole = info[CodingKeys.accessRole.rawValue] as? String ?? ""
        
        self.isAdmin = info[CodingKeys.isAdmin.rawValue] as? Bool ?? false
        self.isVerified = info[CodingKeys.isVerified.rawValue] as? Bool ?? false
        self.isDisabled = info[CodingKeys.isDisabled.rawValue] as? Bool ?? true
    }
    
    
    /**
     * Decodable initializer.
     */
    init(from decoder: Decoder) throws
    {
        // Get our container for this subclass' coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.handle = (try? container.decode(String.self, forKey: .handle)) ?? ""
        self.email = (try? container.decode(String.self, forKey: .email)) ?? ""
        self.icon = (try? container.decode(String.self, forKey: .icon)) ?? ""
        self.role = (try? container.decode(String.self, forKey: .role)) ?? ""
        self.accessRole = (try? container.decode(String.self, forKey: .accessRole)) ?? ""
        
        self.isAdmin = (try? container.decode(Bool.self, forKey: .isAdmin)) ?? false
        self.isVerified = (try? container.decode(Bool.self, forKey: .isVerified)) ?? false
        self.isDisabled = (try? container.decode(Bool.self, forKey: .isDisabled)) ?? true
    }
    
    
    /**
     * Encodable writer.
     */
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
       
        try container.encode(self.name, forKey: .name)
        try container.encode(self.handle, forKey: .handle)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.icon, forKey: .icon)
        try container.encode(self.role, forKey: .accessRole)
        
        try container.encode(self.isAdmin, forKey: .isAdmin)
        try container.encode(self.isVerified, forKey: .isVerified)
        try container.encode(self.isDisabled, forKey: .isDisabled)
    }
}
