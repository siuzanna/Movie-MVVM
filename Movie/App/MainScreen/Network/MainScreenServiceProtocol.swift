//
//  MainScreenServiceProtocol.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import Foundation

protocol MainScreenServiceProtocol {
    func getMenu(completion: @escaping (_ success: Bool, _ results: [Movie]?, _ error: String?) -> ())
}

class MainScreenService: MainScreenServiceProtocol {
    var model: [Movie] = []
    
    func generate() {
        while model.count < 20 {
            model.append(Movie(id: model.count, url: "noting"))
        }
    }
    
    func getMenu(completion: @escaping (Bool, [Movie]?, String?) -> ()) {
        generate()
        if true {
            completion(true, model, nil)
        }
    }
    
}
