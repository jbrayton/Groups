//
//  Country.swift
//  Country
//
//  Created by John Brayton on 9/8/21.
//

import Foundation

struct Country {
    
    static let all = Country.readFile()
    
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
         case name = "name"
         case groups = "groups"
     }

}
