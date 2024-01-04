//
//  Movies.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import Foundation

struct Movies: Codable, Hashable {
    let id: Int
    let type: Int
    let series: Bool
    let name: String
    let time: Int
    let genre: [String]
    let rating: String
    let votes: String
    let photo: String
    let miniPhoto: String
    let description: String
    let trailer: String
    let comments: [Comments]
}
