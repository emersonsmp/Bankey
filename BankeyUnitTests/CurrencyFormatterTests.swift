//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Emerson Sampaio on 06/04/23.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, " 929.466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatterd() throws {
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$ 929.466,23") //white space is 160 -> Non-breaking space
        XCTAssertEqual(result, "$ 929.466,23") //white space is 32 -> space
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0.00)
        XCTAssertEqual(result, "$ 0,00") //white space is 160 -> Non-breaking space
    }
}
