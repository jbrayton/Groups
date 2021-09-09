//
//  GroupsTests.swift
//  GroupsTests
//
//  Created by John Brayton on 9/8/21.
//

import XCTest
@testable import Groups

class CountryTests: XCTestCase {

    func testParsing() throws {
        let countries = Country.all
        XCTAssert(countries.count > 0)
        for country in countries {
            XCTAssert(country.groups.count > 0)
        }
    }

}
