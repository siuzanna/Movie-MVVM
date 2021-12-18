//
//  ProResult.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import Foundation

enum ProResult<Success> {
    case success(Success)
    case badRequest(FailureModel)
    case failure(String)
}

struct FailureModel: Codable {
    let statusCode: Int?
    let errors: [String]?

    enum CodingKeys: String, CodingKey {
        case statusCode
        case errors
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try? values.decodeIfPresent(Int.self, forKey: .statusCode)
        errors = try? values.decodeIfPresent([String].self, forKey: .errors)
    }
}
