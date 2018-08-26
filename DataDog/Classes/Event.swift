//
//  Event.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation


/**
 *
 */
public struct Event: Codable
{
    // MARK: -- Properties --
    
    private enum CodingKeys: String, CodingKey
    {
        case alertType = "alert_type"
        case comments
        case dateHappened = "date_happened"
        case deviceName = "device_name"
        case host
        case id
        case isAggregate = "is_aggregate"
        case payload
        case priority
        case resource
        case tags
        case text
        case title
        case url
    }
    
    public var alertType: EventStatus
    public var comments: Array<String>
    public var dateHappened: Date
    public var deviceName: String
    public var host: String
    public var id: Int
    public var isAggregate: Bool
    public var payload: String
    public var priority: EventPriority
    public var resource: String
    public var tags: Array<String>
    public var text: String
    public var title: String
    public var url: String
    
    
    // MARK: -- Lifecycle --

    /**
     * Default initializer which should never be used.  It will be called only in the case
     * of failure to file and decode the appropriate.
     */
    private init()
    {
        self.alertType = EventStatus.info
        self.comments = Array<String>()
        self.dateHappened = Date()
        self.deviceName = "<not set>"
        self.host = "<not set>"
        self.id = 0
        self.isAggregate = false
        self.payload = "{}"
        self.priority = EventPriority.normal
        self.resource = "<not set>"
        self.tags = Array<String>()
        self.text = "<not set>"
        self.title = "<not set>"
        self.url = "<not set>"
    }
}


public extension Event
{
    /**
     * Dictionary
     */
    init(from info: Dictionary<String, Any>)
    {
        let alertTypeValue: String = info[CodingKeys.alertType.rawValue] as? String ?? EventStatus.info.rawValue
        self.alertType = EventStatus(rawValue: alertTypeValue)!
        
        let dateHappenedValue: TimeInterval = info[CodingKeys.dateHappened.rawValue] as? TimeInterval ?? 0
        self.dateHappened = Date(timeIntervalSince1970: dateHappenedValue)
        
        let eventPriorityValue: String = info[CodingKeys.priority.rawValue] as? String ?? EventPriority.normal.rawValue
        self.priority = EventPriority(rawValue: eventPriorityValue)!
        
        self.comments = info[CodingKeys.comments.rawValue] as? Array<String> ?? Array<String>()
        self.deviceName = info[CodingKeys.deviceName.rawValue] as? String ?? "<not set>"
        self.host = info[CodingKeys.host.rawValue] as? String ?? "<not set>"
        self.id = info[CodingKeys.id.rawValue] as? Int ?? 0
        self.isAggregate = info[CodingKeys.isAggregate.rawValue] as? Bool ?? false
        self.payload = info[CodingKeys.payload.rawValue] as? String ?? "<not set>"
        self.resource = info[CodingKeys.resource.rawValue] as? String ?? "<not set>"
        self.tags = info[CodingKeys.deviceName.rawValue] as? Array<String> ?? Array<String>()
        self.text = info[CodingKeys.text.rawValue] as? String ?? "<not set>"
        self.title = info[CodingKeys.title.rawValue] as? String ?? "<not set>"
        self.url = info[CodingKeys.url.rawValue] as? String ?? "<not set>"
    }
    
    
    /**
     * Decodable
     */
    init(from decoder: Decoder) throws
    {
        // Get our container for this subclass' coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.alertType = (try? container.decode(EventStatus.self, forKey: .alertType)) ?? EventStatus.info
        self.comments = (try? container.decode(Array<String>.self, forKey: .comments)) ?? Array<String>()
        self.dateHappened = (try? container.decode(Date.self, forKey: .dateHappened)) ?? Date()
        self.deviceName = (try? container.decode(String.self, forKey: .deviceName)) ?? "<not set>"
        self.host = (try? container.decode(String.self, forKey: .host)) ?? "<not set>"
        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
        self.isAggregate = (try? container.decode(Bool.self, forKey: .isAggregate)) ?? false
        self.payload = (try? container.decode(String.self, forKey: .payload)) ?? "<not set>"
        self.priority = (try? container.decode(EventPriority.self, forKey: .priority)) ?? EventPriority.normal
        self.resource = (try? container.decode(String.self, forKey: .resource)) ?? "<not set>"
        self.tags = (try? container.decode(Array<String>.self, forKey: .tags)) ?? Array<String>()
        self.text = (try? container.decode(String.self, forKey: .text)) ?? "<not set>"
        self.title = (try? container.decode(String.self, forKey: .title)) ?? "<not set>"
        self.url = (try? container.decode(String.self, forKey: .url)) ?? "<not set>"
    }
    
    
    /**
     * Encodable
     */
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
       
        try container.encode(self.alertType, forKey: .alertType)
        try container.encode(self.comments, forKey: .comments)
        try container.encode(self.dateHappened, forKey: .dateHappened)
        try container.encode(self.deviceName, forKey: .deviceName)
        try container.encode(self.host, forKey: .host)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.isAggregate, forKey: .isAggregate)
        try container.encode(self.payload, forKey: .payload)
        try container.encode(self.priority, forKey: .priority)
        try container.encode(self.resource, forKey: .resource)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.text, forKey: .text)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.url, forKey: .url)
    }
}


/**
 * The EventFrom enumeration type defines the origin source of a given event.
 * This can be used to filter events in client applications.
 */
public enum EventFrom: String, Codable
{
    /**
     * The default type that includes all other types.
     */
    case all = "All"
    
    /**
     * Indicates the event is from DataDog.
     */
    case datadog = "DataDog"
    
    /**
     * Indicates the event is from a monitor alert.
     */
    case monitorAlert = "Monitor Alert"
    
    /**
     * Indicates the event is from the customer application.
     */
    case myApps = "My Apps"
}


/**
 * The EventPriority enumeration type defines the priority level of a given event.
 * This can be used to filter events in client applications.
 */
public enum EventPriority: String, Codable
{
    /**
     * The default type that includes all other types.
     */
    case all = "all"
    
    /**
     * Indicates the event is at a normal level of priority.
     */
    case normal = "normal"
    
    /**
     * Indicates the event is at a low level of priority.
     */
    case low = "low"
}


/**
 * The EventStatus enumeration type defines the status level of a given event.
 * This can be used to filter events in client applications.
 */
public enum EventStatus: String, Codable
{
    /**
     * The default type that includes all other types.
     */
    case all = "all"
    
    /**
     * Indicates the event is indicating an error message.
     */
    case error = "error"
    
    /**
     * Indicates the event is indicating a warning message.
     */
    case warning = "warning"
    
    /**
     * Indicates the event is indicating a success message.
     */
    case success = "success"
    
    /**
     * Indicates the event is indicating an informational message.
     */
    case info = "info"
}
