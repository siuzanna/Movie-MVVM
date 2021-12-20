//
//  MainScreenViewModel.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import Foundation

class MainScreenViewModel: NSObject {
    
    private var menuService: MainScreenServiceProtocol
    
    var reloadDataSource: (() -> Void)?
    
    var movie = [Movies]()
    
    var menuCellViewModel = [MainScreenCellViewModel]() {
        didSet {
            reloadDataSource?()
        }
    }
    
    var topCellViewModel = [MainScreenCellViewModel]()
    var popularCellViewModel = [MainScreenCellViewModel]()
    var comingSoonCellViewModel = [MainScreenCellViewModel]()
    var lastUpdatedCellViewModel = [MainScreenCellViewModel]()
    var bestSeriesCellViewModel = [MainScreenCellViewModel]()
    
    init(menuService: MainScreenServiceProtocol = MainScreenService()) {
        self.menuService = menuService
    }
    
    func getMenu() {
        menuService.getMenu { success, model, error in
            if success, let movies = model {
                var model = [MainScreenCellViewModel]()
                for movie in movies {
                    model.append(self.createCellModel(movie: movie))
                    if movie.type == 0 {
                        self.topCellViewModel.append(self.createCellModel(movie: movie))
                    } else if movie.type == 1 {
                        self.popularCellViewModel.append(self.createCellModel(movie: movie))
                    } else if movie.type == 2 {
                        self.comingSoonCellViewModel.append(self.createCellModel(movie: movie))
                    } else if movie.type == 3 {
                        self.lastUpdatedCellViewModel.append(self.createCellModel(movie: movie))
                    } else if movie.type == 4 {
                        self.bestSeriesCellViewModel.append(self.createCellModel(movie: movie))
                    }
                }
                self.menuCellViewModel = model
            } else {
                print(error!)
            }
        }
    }
    
    func createCellModel(movie: Movies) -> MainScreenCellViewModel {
        let id = movie.id
        let type = movie.type
        let series = movie.series
        let name = movie.name
        let time = movie.time
        let genre = movie.genre
        let rating = movie.rating
        let votes = movie.votes
        let photo = movie.photo
        let miniPhoto = movie.miniPhoto
        let description = movie.description
        let trailer = movie.trailer
        let comments = movie.comments
        return MainScreenCellViewModel(
            id: id,
            type: type,
            series: series,
            name: name,
            time: time,
            genre: genre,
            rating: rating,
            votes: votes,
            photo: photo,
            miniPhoto: miniPhoto,
            description: description,
            trailer: trailer,
            comments: comments)
    }
    
    func getbyIndexPath(_ indexPath: IndexPath) -> MainScreenCellViewModel {
        return menuCellViewModel[indexPath.row]
    }
}
