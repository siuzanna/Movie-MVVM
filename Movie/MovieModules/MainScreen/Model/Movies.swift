//
//  Movies.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import Foundation

struct Movies : Codable {
    let id : Int?
    let type : Int?
    let series : Bool?
    let name : String?
    let time : Int?
    let genre : [String]?
    let rating : String?
    let votes : String?
    let photo : String?
    let miniPhoto : String?
    let description : String?
    let trailer : String?
    let comments : [Comments]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case type = "type"
		case series = "series"
		case name = "name"
		case time = "time"
		case genre = "genre"
		case rating = "rating"
		case votes = "votes"
		case photo = "photo"
		case miniPhoto = "miniPhoto"
		case description = "description"
		case trailer = "trailer"
		case comments = "comments"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		type = try values.decodeIfPresent(Int.self, forKey: .type)
		series = try values.decodeIfPresent(Bool.self, forKey: .series)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		time = try values.decodeIfPresent(Int.self, forKey: .time)
		genre = try values.decodeIfPresent([String].self, forKey: .genre)
		rating = try values.decodeIfPresent(String.self, forKey: .rating)
		votes = try values.decodeIfPresent(String.self, forKey: .votes)
		photo = try values.decodeIfPresent(String.self, forKey: .photo)
		miniPhoto = try values.decodeIfPresent(String.self, forKey: .miniPhoto)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		trailer = try values.decodeIfPresent(String.self, forKey: .trailer)
		comments = try values.decodeIfPresent([Comments].self, forKey: .comments)
	}

}
