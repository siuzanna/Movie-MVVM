//
//  MainScreenViewModel.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import Foundation

class MainScreenViewModel: NSObject {
    var successResponse: (() -> Void)?
    var errorResponse: ((String) -> Void)?
    
    var menuCellViewModel = [Movies]()
    var topCellViewModel = [Movies]()
    var popularCellViewModel = [Movies]()
    var comingSoonCellViewModel = [Movies]()
    var lastUpdatedCellViewModel = [Movies]()
    var bestSeriesCellViewModel = [Movies]()
    
    private var menuService: MainScreenServiceProtocol

    init(menuService: MainScreenServiceProtocol = MainScreenService()) {
        self.menuService = menuService
    }
    
    func getMenu() {
        menuService.getMenu { success, model, error in
            if success, let movies = model {
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
    
    func getbyIndexPath(_ indexPath: IndexPath) -> Movies {
        return menuCellViewModel[indexPath.row]
    }
}
