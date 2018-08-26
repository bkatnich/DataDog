//
//  UserService.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation
import Moya


/**
 *
 */
public class UserService
{
    // MARK: Retrieve API
    
    /**
     *
     */
    public class func retrieveUsers()
    {
        let provider = MoyaProvider<UserEndpoint>()
        provider.request(.retrieveUsers) { result in
        
            switch result
            {
                case let .success(response):
        
                    print("\n\nSuccess:")
                    print("\n\n\tRequest URL: \(String(describing: response.request!))")
                    
                    do
                    {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let json = try filteredResponse.mapJSON()
                        
                        print("\n\t\(String(describing: json))\n\n")
                        
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        
                        let users = try filteredResponse.map([User].self, atKeyPath: "users", using: decoder)
                    
                        print("\n\tEvents: \(String(describing: users))")
                    }
                    catch let error
                    {
                        print("\n\nFailure on successful response: \(error)\n\n")
                    }
                
                case let .failure(error):
        
                    print("\n\nFailure on initial call: \(error)\n\n")
            }
        }
    }
}


/**
 *
 */
public enum UserEndpoint
{
    case retrieveUsers
}


/**
 *
 */
extension UserEndpoint: TargetType
{
    //
    // Base URL
    //
    public var baseURL: URL
    {
        return URL(string: "https://api.datadoghq.com/api/v1")!
    }
    
    //
    // Endpoint Paths
    //
    public var path: String
    {
        switch self
        {
            //
            // Retreive
            //
            case .retrieveUsers:
            
                return "/user"
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
            // Retrieve
            //
            case .retrieveUsers:
            
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
            // Retrieve
            //
            case .retrieveUsers:
            
                return .requestParameters(parameters:
                    [
                        "api_key" : "c1289ee5efac116b8970f19104c78825",
                        "application_key" : "7a1ebbde114adfc527833ad10af4016525213884"
                    ],
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
            // Retrieve
            //
            case .retrieveUsers:
            
                return "Users test data".utf8Encoded
        }
    }
    
    //
    // Headers
    //
    public var headers: [String: String]?
    {
        return [
            "Content-type": "application/json"
        ]
    }
}
