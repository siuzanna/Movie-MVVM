//
//  MainScreenRouter.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import Foundation

enum MainScreenRouter: BaseRouter {
    case getAllPosts

    var path: String {
        switch self {
        case .getAllPosts:
            return "/v3/cbd74aa0-318f-4a38-a4d6-9b1b99a275cf"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getAllPosts:
                return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getAllPosts:
            return  .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getAllPosts:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAllPosts:
            return nil
        }
    }
}
