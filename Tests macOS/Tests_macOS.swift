//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Michael Cardiff on 2/2/22.
//

import XCTest
import HW_2_Bessel_Funcs

class Tests_macOS: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testFirstSphBessel() throws {
        let xTestVal = 3.14159
        let exactVal = 0.000000844664578538733
        let myVal = sphericalBesselZero(x: xTestVal)
        XCTAssertEqual(exactVal, myVal, accuracy: 1.0e-15, "Print it should have been closer.")
    }
    
    func testSecondSphBessel() {
        let xValue = Double.pi
        var testValue = 0.0
        let exactValue = 0.3183098861837906715377675267450287240689192914809128974953346881
        testValue = sphericalBesselOne(x: xValue)
        XCTAssertEqual(testValue, exactValue, accuracy: 1.0e-15, "Print it should have been closer.")
    }
    
    func testDownBessel() {
        let xValue = 10*Double.pi
        var testValue = 0.0
        
        let order = 3
        let start = order+25
        
        let exactValue = 7.607191130573301e-17
        testValue = downwardRecurseBessel(x: xValue, order: order, start: start)
        XCTAssertEqual(testValue, exactValue, accuracy: 1.0e-15, "Print it should have been closer.")
    }
    
    func testUpBessel() {
        let xValue = 10*Double.pi
        var testValue = 0.0
        
        let order = 12
        
        let exactValue = 0.01946766930505029
        testValue = upwardRecurseBessel(x: xValue, order: order)
        XCTAssertEqual(testValue, exactValue, accuracy: 1.0e-15, "Print it should have been closer.")
    }
    

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
}
