//
//  MainScreenViewModel.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import Foundation

protocol MainScreenServiceProtocol {
    var successResponse: (() -> Void)? { get set }
    var errorResponse: ((String) -> Void)? { get set }
    
    var menuCellViewModel: [Movies] { get set }
    var topCellViewModel: [Movies] { get set }
    var popularCellViewModel: [Movies] { get set }
    var comingSoonCellViewModel: [Movies] { get set }
    var lastUpdatedCellViewModel: [Movies] { get set }
    var bestSeriesCellViewModel: [Movies] { get set }
    
    func requestMovies()
}

class MainScreenViewModel: MainScreenServiceProtocol {
    let networkService: NetworkService = NetworkService()
    
    var successResponse: (() -> Void)?
    var errorResponse: ((String) -> Void)?
    
    var menuCellViewModel = [Movies]()
    var topCellViewModel = [Movies]()
    var popularCellViewModel = [Movies]()
    var comingSoonCellViewModel = [Movies]()
    var lastUpdatedCellViewModel = [Movies]()
    var bestSeriesCellViewModel = [Movies]()
    
    func getByIndexPath(_ indexPath: IndexPath) -> Movies {
        return menuCellViewModel[indexPath.row]
    }
    
    func requestMovies() {
        self.requestItems { model, error in
            if  let movies = model {
                for movie in movies {
                    if movie.type == 0 {
                        self.topCellViewModel.append(movie)
                    } else if movie.type == 1 {
                        self.popularCellViewModel.append(movie)
                    } else if movie.type == 2 {
                        self.comingSoonCellViewModel.append(movie)
                    } else if movie.type == 3 {
                        self.lastUpdatedCellViewModel.append(movie)
                    } else if movie.type == 4 {
                        self.bestSeriesCellViewModel.append(movie)
                    }
                }
                self.menuCellViewModel = movies
                self.successResponse?()
            } else {
                self.errorResponse?(error ?? "Произошла ошибка")
            }
        }
    }
    
    func requestItems(completion: @escaping ([Movies]?, String?) -> Void) {
        networkService.sendRequest(
            urlRequest: MainScreenRouter.getAllPosts.createURLRequest(),
            successModel: [Movies].self
        ) { [weak self] (result) in
            guard self != nil else {return}
            switch result {
            case .success(let model):
                completion(model, nil)
            case .badRequest(let error):
                completion(nil, error.errors?.first)
                debugPrint(#function, error)
            case .failure(let error):
                completion(nil, error)
                debugPrint(#function, error)
            }
        }
    }
}
