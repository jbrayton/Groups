//
//  ContentIdentifier.swift
//  ContentIdentifier
//
//  Created by John Brayton on 9/9/21.
//

import Foundation

enum ContentIdentifier : Equatable {
    
    case countryList
    case groupListByCountry(countryIdentifier: String)
    case groupDetails(countryIdentifier: String, groupIdentifier: String)
    
    var countryIdentifier: String? {
        get {
            switch self {
            case .countryList:
                return nil
            case .groupListByCountry(let countryIdentifier):
                return countryIdentifier
            case .groupDetails(let countryIdentifier, _):
                return countryIdentifier
            }
        }
    }
    
    var groupIdentifier: String? {
        get {
            switch self {
            case .countryList:
                return nil
            case .groupListByCountry:
                return nil
            case .groupDetails(_, let groupIdentifier):
                return groupIdentifier
            }
        }
    }
    
    var identifierString: String {
        switch self {
        case .countryList:
            return "countries"
        case .groupListByCountry(let countryIdentifier):
            return String(format: "countries/%@", countryIdentifier)
        case .groupDetails(let countryIdentifier, let groupIdentifier):
            return String(format: "countries/%@/groups/%@", countryIdentifier, groupIdentifier)
        }
    }
    
    static func parse( _ input: String ) -> ContentIdentifier? {
        let components = input.components(separatedBy: "/")
        if components.count == 1, components[0] == "countries" {
            return .countryList
        }
        if components.count == 2, components[0] == "countries" {
            return .groupListByCountry(countryIdentifier: components[1])
        }
        if components.count == 4, components[0] == "countries", components[2] == "groups" {
            return .groupDetails(countryIdentifier: components[1], groupIdentifier: components[3])
        }
        return nil
    }
    
}
