//
//  DataDogTests.swift
//  DataDogTests
//
//  Created by Britton Katnich on 2018-08-30.
//  Copyright © 2018 DataDog. All rights reserved.
//

import XCTest
@testable import DataDog


/**
 *
 */
class DataDogTests: XCTestCase
{
    // MARK -- Lifecycle --
    
    /**
     * Put setup code here. This method is called before
     * the invocation of each test method in the class.
     */
    override func setUp()
    {
        super.setUp()
        
        DataDog.start()
    }
    
    /**
     * Put teardown code here. This method is called after
     * the invocation of each test method in the class.
     */
    override func tearDown()
    {
        super.tearDown()
    }
    
    
    // MARK -- Tests --
    
    func testExample()
    {
    
    }
    
    
    func testPerformanceExample()
    {
        self.measure
        {
            
        }
    }
    
}
