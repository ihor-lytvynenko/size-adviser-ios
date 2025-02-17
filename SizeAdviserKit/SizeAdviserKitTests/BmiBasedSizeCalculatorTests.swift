//
//  SizeAdviserKitTests.swift
//  SizeAdviserKitTests
//
//  Created by Igor Litvinenko on 17.02.2025.
//

import XCTest
@testable import SizeAdviserKit

final class BmiBasedSizeCalculatorTests: XCTestCase {

    private let subject = BmiBasedSizeCalculator()
    
    func testInvalidInputData() {
        var result = subject.calculate(.init(height: -1, weight: -1))
        XCTAssertEqual(result, .failure(.innvalidInput))
        
        result = subject.calculate(.init(height: 0, weight: 0))
        XCTAssertEqual(result, .failure(.innvalidInput))
        
        result = subject.calculate(.init(height: -1, weight: 1))
        XCTAssertEqual(result, .failure(.innvalidInput))
        
        result = subject.calculate(.init(height: 1, weight: -1))
        XCTAssertEqual(result, .failure(.innvalidInput))
    }
    
    func testCalulations() {
        //S = <18.5
        var result = subject.calculate(.init(height: 1, weight: 10))
        XCTAssertEqual(result, .success(.s))
        
        result = subject.calculate(.init(height: 1, weight: 18.4))
        XCTAssertEqual(result, .success(.s))
        
        //M = 18.5–24.9
        result = subject.calculate(.init(height: 1, weight: 18.5))
        XCTAssertEqual(result, .success(.m))
        
        result = subject.calculate(.init(height: 1, weight: 20))
        XCTAssertEqual(result, .success(.m))
        
        result = subject.calculate(.init(height: 1, weight: 24.9))
        XCTAssertEqual(result, .success(.m))
        
        //L = 25–29.9
        result = subject.calculate(.init(height: 1, weight: 25))
        XCTAssertEqual(result, .success(.l))
        
        result = subject.calculate(.init(height: 1, weight: 27))
        XCTAssertEqual(result, .success(.l))
        
        result = subject.calculate(.init(height: 1, weight: 29.9))
        XCTAssertEqual(result, .success(.l))
        
        //XL = >=30
        result = subject.calculate(.init(height: 1, weight: 30))
        XCTAssertEqual(result, .success(.xl))
        
        result = subject.calculate(.init(height: 1, weight: 100))
        XCTAssertEqual(result, .success(.xl))
    }

}
