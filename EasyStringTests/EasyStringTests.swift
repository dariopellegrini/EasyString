//
//  EasyStringTests.swift
//  EasyStringTests
//
//  Created by Dario Pellegrini on 02/06/2020.
//  Copyright © 2020 Dario Pellegrini. All rights reserved.
//

import EasyString
import XCTest
@testable import EasyString

class EasyStringTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSubstring() throws {
        var result = "Hello".substring(from: 1)
        XCTAssert(result == "ello")
        
        result = "Hello".substring(to: 1)
        XCTAssert(result == "H")
        
        result = "Hello".substring(range: 0..<2)
        XCTAssert(result == "He")
        
        result = "Hello".substring(before: "e")
        XCTAssert(result == "H")
        
        result = "Hello".substring(after: "l")
        XCTAssert(result == "lo")
        
        result = "<Hello>".between("<", ">")
        XCTAssert(result == "Hello")
        
        result = "<Hello>".replace("<", ">", with: "a")
        XCTAssert(result == "aHelloa")
        
        XCTAssert("Hello".isNumber == false)
        
        XCTAssert("123".isNumber == true)
        
        XCTAssert("Hello5-".isAlphabetic == false)
        
        XCTAssert("Hello5".isAlphabetic == false)
        
        XCTAssert("Hello".isAlphabetic == true)
        
        XCTAssert("Hello123".isAlphanumeric == true)
        
        XCTAssert("123".isAlphanumeric == true)
        
        XCTAssert("123-".isAlphanumeric == false)
        
        result = "Hello1".numberString
        XCTAssert(result == "1")
        
        result = "Hello1".alphabeticString
        XCTAssert(result == "Hello")
        
        result = "Hello@1".alphanumericString
        XCTAssert(result == "Hello1")
        
        result = "1,2,3,4,5".split(",").joined(separator: ";")
        XCTAssert(result == "1;2;3;4;5")
        
        result = "1,2-3_4|5".split(",-_|".set).joined(separator: ";")
        XCTAssert(result == "1;2;3;4;5")
        
        XCTAssert("123451".firstIndex(of: "1") == 0)
        
        XCTAssert("123451".lastIndex(of: "1") == 5)
        
        result = "Hello I-am_here".camelCase
        XCTAssert(result == "HelloIAmHere")
        
        result = "Hello I-am_here".snakeCase
        XCTAssert(result == "hello_i_am_here")
        
        result = "šÜįéïöç".latin
        XCTAssert(result == "sUieioc")
        
        result = "Hello name šÜįéïöç".slugify()
        XCTAssert(result == "hello-name-suieioc")
        
        result = " "
        XCTAssert(result.isEmpty == true)
        
        result = "A "
        XCTAssert(result.isEmpty == false)
        
        result = "Hello Planet   \n\n\n\r    Name".collapseWhiteSpaces()
        XCTAssert(result == "Hello Planet Name")
        
        result = "XCHello"
        XCTAssert(result.has(prefix: "XC") == true)
        
        result = "XCHello".remove(prefix: "XC")
        XCTAssert(result == "Hello")
        
        result = "XC/Hello".removePrefix(before: "/", included: true)
        XCTAssert(result == "Hello")
        
        result = "Hello.png"
        XCTAssert(result.has(suffix: ".png") == true)
        
        result = "Hello.png".remove(suffix: ".png")
        XCTAssert(result == "Hello")
        
        result = "Hello.png".removeSuffix(after: ".", included: true)
        XCTAssert(result == "Hello")
        
        result = "  Hello   ".trim()
        XCTAssert(result == "Hello")
        
        result = "  Hello   ".trimLeft()
        XCTAssert(result == "Hello   ")
        
        result = "  Hello   ".trimRight()
        XCTAssert(result == "  Hello")
        
        result = "Hello".pad("A", times: 3)
        XCTAssert(result == "AAAHelloAAA")
        
        result = "Hello".padLeft("A", times: 3)
        XCTAssert(result == "AAAHello")
        
        result = "Hello".padRight("A", times: 3)
        XCTAssert(result == "HelloAAA")
        
        XCTAssert("Hello".count(string: "l") == 2)
        
        XCTAssert("true".toBool() == true)
        
        XCTAssert("1".toInt() == 1)
        
        XCTAssert("1.1".toFloat() == 1.1)
        
        XCTAssert("3.14".toDouble() == 3.14)
        
        result = "Hello Fir_st".initials
        XCTAssert(result == "H F S")
        
        result = "Hello"[3]
        XCTAssert(result == "l")
        
        result = "Hello"[2...3]
        XCTAssert(result == "ll")
    }
    
    func testRun() throws {
        
        // Subscript substring
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
