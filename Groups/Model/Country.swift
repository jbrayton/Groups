//
//  Country.swift
//  Country
//
//  Created by John Brayton on 9/8/21.
//

import Foundation

struct Country {
    
    static let all = Country.readFile()
    
    let identifier: String
    let name: String
    let groups: [Group]
    
    private static func readFile() -> [Country] {
        let decoder = JSONDecoder()
        let url = Bundle.main.url(forResource: "groups", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! decoder.decode([Country].self, from: data)
    }
    
}

extension Country : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "name"
        case groups = "groups"
     }

}

extension Array where Element == Country {
    
    func with( identifier: String ) -> Country? {
        for country in self {
            if country.identifier == identifier {
                return country
            }
        }
        return nil
    }
    
}
