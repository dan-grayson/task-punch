//
//  Task_Punch_CardTests.swift
//  Task Punch CardTests
//
//  Created by Daniel Grayson on 3/18/16.
//  Copyright © 2016 Daniel Grayson. All rights reserved.
//

import XCTest
@testable import Task_Punch_Card

class Task_Punch_CardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testNewTask() {
        let now = TimePair()
        let newTask = Task(name: "newTask", times: [now])
        XCTAssert(now.start.compare(newTask.times[0].start) == NSComparisonResult.OrderedSame)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
