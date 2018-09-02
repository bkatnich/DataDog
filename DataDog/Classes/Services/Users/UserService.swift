//
//  UserService.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-26.
//  Copyright © 2018 Britton Katnich. All rights reserved.
//

import Foundation
import Moya


/**
 * The service encapsulates all public facing REST API for the User.
 *
 * @see https://docs.datadoghq.com/api/?lang=python#users
 */
public class UserService: DataDogService
{
    // MARK: -- GET --
    
    /**
     * Get a specific user by their handle identifier.
     *
     * @param handle String handle name of the user.
     * @param completion (User?, Error?) -> Void.
     *
     * @see https://docs.datadoghq.com/api/?lang=python#get-user.
     */
    public class func getUser(handle: String, completion: @escaping (User?, Error?) -> Void)
    {
        let provider = MoyaProvider<UserTargetType>()
        provider.request(.getUser(handle: handle)) { result in
        
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
                        
                        let user = try filteredResponse.map(User.self,
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
     * Get all users.
     *
     * @param completion ([User]?, Error?) -> Void.
     *
     * @see https://docs.datadoghq.com/api/?lang=python#get-all-users
     */
    public class func getUsers(completion: @escaping ([User]?, Error?) -> Void)
    {
        let provider = MoyaProvider<UserTargetType>()
        
        provider.request(.getUsers) { result in
        
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
    case getUser(handle: String)
    case getUsers
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
            case .getUser(let handle):
            
                return "/user/\(handle)"
            
            //
            // Get All
            //
            case .getUsers:
            
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
            // Get & Get All
            //
            case .getUser, .getUsers:
            
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
            // Get & Get All
            //
            case .getUser, .getUsers:
            
                return .requestParameters(parameters: DataDogService.baseParameters(),
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
            case .getUser(let handle):
            
                return "User test data for \(handle)".utf8Encoded
            
            //
            // Get All
            //
            case .getUsers:
            
                return "Users test data".utf8Encoded
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
