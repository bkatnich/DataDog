//
//  UserService.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 DataDog. All rights reserved.
//

import Foundation
import Moya
import Result


/**
 *  The UserService encapsulates all public facing User API calls.
 */
public class UserService
{
    // MARK: Retrieve API
    
    /**
     * Retrieve all users.
     *
     * @param completion ([User]?, Error?) -> Void
     */
    public class func retrieveUsers(completion: @escaping ([User]?, Error?) -> Void)
    {
        log.debug("called")
        
        let provider = MoyaProvider<UserTargetType>()
        
        provider.request(.retrieveUsers) { result in
        
            if let response = result.value
            {
                log.debug("Request URL: \(String(describing: response.request?.url))")
            }
            else
            {
                log.debug("No response found!!")
            }
        
            switch result
            {
                //
                // Success
                //
                case let .success(response):
        
                    do
                    {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        
                        let users = try filteredResponse.map([User].self,
                            atKeyPath: "users",
                            using: decoder)
                    
                        completion(users, nil)
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
 * The User target enumeration types.
 */
public enum UserTargetType
{
    case retrieveUsers
}


/**
 * The User target type implementations.
 */
extension UserTargetType: TargetType
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
