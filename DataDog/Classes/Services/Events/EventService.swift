//
//  EventService.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation
import Moya


/**
 * The service encapsulates all public facing REST API for the Event.
 *
 * @see https://docs.datadoghq.com/api/?lang=python#events.
 */
public class EventService: DataDogService
{
    // MARK: -- GET --
    
    /**
     * Get a specific user by their handle identifier.
     *
     * @param handle String handle name of the user.
     * @param completion (Event?, Error?) -> Void.
     *
     * @see https://docs.datadoghq.com/api/?lang=python#get-organization
     */
    public class func getEvent(id: Int, completion: @escaping (Event?, Error?) -> Void)
    {
        let provider = MoyaProvider<EventTargetType>()
        
        provider.request(.getEvent(id: id)) { result in
        
            #if DEBUG
            DataDog.debugResponse(response: result.value)
            #endif
        
            //
            // Handle result
            //
            switch result
            {
                //
                // Success
                //
                case let .success(response):
        
                    do
                    {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        
                        #if DEBUG
                        DataDog.debugResponseSuccess(response: filteredResponse)
                        #endif
                        
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        
                        let user = try filteredResponse.map(Event.self,
                            atKeyPath: "user",
                            using: decoder)
                    
                        completion(user, nil)
                        return
                    }
                    catch let error
                    {
                        completion(nil, error)
                        return
                    }
                
                //
                // Failure
                //
                case let .failure(error):
        
                    completion(nil, error)
                    return
            }
        }
    }
    
    
    /**
     * Get all events.
     *
     * @param start The starting date of the range. (required)
     * @param end The ending date of the range. (required)
     * @param priority The EventPriority to filter by. (optional)
     * @param sources The sources to filter by. (optional)
     * @param tags The tags to filter by. (optional)
     * @param completion ([Event]?, Error?) -> Void
     *
     * @see https://docs.datadoghq.com/api/?lang=python#query-the-event-stream
     */
    public class func getEvents(start: Date,
        end: Date,
        priority: EventPriority? = nil,
        sources: Array<String>? = nil,
        tags: Array<String>? = nil,
        completion: @escaping ([Event]?, Error?) -> Void)
    {
        let provider = MoyaProvider<EventTargetType>()
        
        let startTime = String(describing: Int(start.timeIntervalSince1970))
        let endTime = String(describing: Int(end.timeIntervalSince1970))
        
        provider.request(.getEvents(
            start: startTime,
            end: endTime,
            priority: priority,
            sources: sources,
            tags: tags)) { result in
        
            #if DEBUG
            DataDog.debugResponse(response: result.value)
            #endif
            
            //
            // Handle result
            //
            switch result
            {
                //
                // Success
                //
                case let .success(response):
        
                    do
                    {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        
                        #if DEBUG
                        DataDog.debugResponseSuccess(response: filteredResponse)
                        #endif
                        
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        
                        let events = try filteredResponse.map([Event].self,
                            atKeyPath: "events",
                            using: decoder)
                    
                        completion(events, nil)
                        return
                    }
                    catch let error
                    {
                        completion(nil, error)
                        return
                    }
                
                //
                // Failure
                //
                case let .failure(error):
        
                    completion(nil, error)
                    return
            }
        }
    }
}


/**
 * The Event target enumeration types.
 */
public enum EventTargetType
{
    /**
     * Get a single event by it's identifier
     */
    case getEvent(id: Int)
    
    /**
     * Get events by various filtering options.
     */
    case getEvents(start: String,
        end: String,
        priority: EventPriority?,
        sources: Array<String>?,
        tags: Array<String>?)
}


/**
 * The Event target type implementations.
 */
extension EventTargetType: TargetType
{
    //
    // Base URL
    //
    public var baseURL: URL
    {
        return DataDogService.baseUrl()
    }
    
    //
    // Endpoint Paths
    //
    public var path: String
    {
        switch self
        {
            //
            // Get
            //
            case .getEvent(let id):
            
                return "/events/\(id)"
            
            //
            // Get All
            //
            case .getEvents(_, _, _, _, _):
            
                return "/events"
        }
    }
    
    //
    // HTTP Methods
    //
    public var method: Moya.Method
    {
        switch self
        {
            //
            // Get & Get All
            //
            case .getEvent, .getEvents:
            
                return .get
        }
    }
    
    //
    // Tasks
    //
    public var task: Task
    {
        switch self
        {
            //
            // Get
            //
            case .getEvent:
            
                return .requestParameters(parameters: DataDogService.baseParameters(),
                    encoding: URLEncoding.queryString)
            
            //
            // Get All
            //
            case .getEvents(let start, let end, let priority, let sources, let tags):
            
                // Required
                var parameters = DataDogService.baseParameters()
                parameters["start"] = start
                parameters["end"] = end
                
                // Optional
                
                if priority != nil
                {
                    parameters["priority"] = priority!.rawValue
                }
                
                if sources != nil
                {
                    parameters["sources"] = sources!.joined(separator: ",")
                }
                
                if tags != nil
                {
                    parameters["tags"] = tags!.joined(separator: ",")
                }
                
                return .requestParameters(parameters: parameters,
                    encoding: URLEncoding.queryString)
        }
    }
    
    //
    // Sample Data
    //
    public var sampleData: Data
    {
        switch self
        {
            //
            // Get
            //
            case .getEvent(let id):
            
                return "Event test data for \(id)".utf8Encoded
            
            //
            // Get All
            //
            case .getEvents:
            
                return "Events test data".utf8Encoded
        }
    }
    
    //
    // Headers
    //
    public var headers: [String: String]?
    {
        return DataDogService.baseHeaders()
    }
}
