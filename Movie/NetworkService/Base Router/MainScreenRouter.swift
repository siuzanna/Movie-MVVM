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
            return "/v3/4675c33e-6e83-4b39-8d34-e2dafde60d26"
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
