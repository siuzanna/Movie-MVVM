//
//  Comments.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import Foundation

struct Comments : Codable, Hashable {
    let id : Int?
    let name : String?
    let comment : String?
    let picture : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case comment = "comment"
        case picture = "picture"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
    }
}
