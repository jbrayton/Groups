//
//  Group.swift
//  Group
//
//  Created by John Brayton on 9/8/21.
//

import Foundation

struct Group {
    
    let identifier: String
    let name: String
    let meetingText: String
    
}

extension Group : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "name"
        case meetingText = "meeting_text"
     }

}

extension Array where Element == Group {
    
    func with( identifier: String ) -> Group? {
        for group in self {
            if group.identifier == identifier {
                return group
            }
        }
        return nil
    }
    
}
