//
//  BaseRouter.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import Foundation

struct HttpHeader {
    var field: String
    var value: String
}

protocol BaseRouter {
    var path: String { get }
    var queryParameter: [URLQueryItem]? { get }
    var method: HttpMethod { get }
    var httpBody: Data? { get }
    var httpHeader: [HttpHeader]? { get }
}

extension BaseRouter {
    
    var scheme: String {
        return "https"
    }

    var host: String {
        return "run.mocky.io"
    }
    
    func createURLRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryParameter
        guard let url = urlComponents.url else {
            fatalError(URLError(.unsupportedURL).localizedDescription)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = httpBody
        httpHeader?.forEach { (header) in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.field)
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
  
        return urlRequest
    }
}

