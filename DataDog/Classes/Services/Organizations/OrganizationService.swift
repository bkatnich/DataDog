//
//  OrganizationService.swift
//  DataDog
//
//  Created by Britton Katnich on 2018-08-27.
//  Copyright © 2018 DataDog. All rights reserved.
//

import UIKit
import Moya


/**
 * The service encapsulates all public facing REST API for the Organization.
 *
 * @see https://docs.datadoghq.com/api/?lang=python#events.
 */
public class OrganizationService: DataDogService
{
    // MARK: -- GET ---
    
    /**
     * Get a specific Organization by their public identifier.
     *
     * @param publicId Int public identifier of the Organization.
     * @param completion (Organiztion?, Error?) -> Void
     *
     * @see https://docs.datadoghq.com/api/?lang=python#get-organization
     */
    public class func getOrganization(publicId: Int, completion: @escaping (Organization?, Error?) -> Void)
    {
        let provider = MoyaProvider<OrganizationTargetType>()
        provider.request(.getOrganization(publicId: publicId)) { result in
        
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
                        
                        let organization = try filteredResponse.map(Organization.self,
                            atKeyPath: "org",
                            using: decoder)
                    
                        completion(organization, nil)
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
     * Get all organizations.
     *
     * @param completion ([Organization]?, Error?) -> Void
     */
    public class func getOrganizations(completion: @escaping ([Organization]?, Error?) -> Void)
    {
        let provider = MoyaProvider<OrganizationTargetType>()
        provider.request(.getOrganizations) { result in
        
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
                        
                        let organizations = try filteredResponse.map([Organization].self,
                            atKeyPath: "orgs",
                            using: decoder)
                    
                        completion(organizations, nil)
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
 * The Organization target enumeration types.
 */
public enum OrganizationTargetType
{
    case getOrganization(publicId: Int)
    case getOrganizations
}


/**
 * The Organization target type implementations.
 */
extension OrganizationTargetType: TargetType
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
            case .getOrganization(let publicId):
            
                return "/org/\(publicId)"
            
            //
            // Get All
            //
            case .getOrganizations:
            
                return "/org"
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
            case .getOrganization, .getOrganizations:
            
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
            case .getOrganization, .getOrganizations:
            
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
            case .getOrganization(let publicId):
            
                return "Organization test data for \(publicId)".utf8Encoded
            
            //
            // Get All
            //
            case .getOrganizations:
            
                return "Organizations test data".utf8Encoded
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
