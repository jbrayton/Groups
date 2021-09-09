//
//  ContentIdentifierTests.swift
//  GroupsTests
//
//  Created by John Brayton on 9/9/21.
//

import XCTest
@testable import Groups

class ContentIdentifierTests: XCTestCase {

    func testParsing() throws {
        XCTAssertEqual(ContentIdentifier.countryList, ContentIdentifier.parse(ContentIdentifier.countryList.identifierString))
        XCTAssertEqual(ContentIdentifier.groupListByCountry(countryIdentifier: "country1"), ContentIdentifier.parse(ContentIdentifier.groupListByCountry(countryIdentifier: "country1").identifierString))
        XCTAssertEqual(ContentIdentifier.groupDetails(countryIdentifier: "country1", groupIdentifier: "group1"), ContentIdentifier.parse(ContentIdentifier.groupDetails(countryIdentifier: "country1", groupIdentifier: "group1").identifierString))
    }

}
