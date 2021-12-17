//
//  PhotoViewModel.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import Foundation

class PhotoViewModel: NSObject {
        
    private var menuService: MainScreenServiceProtocol

    var reloadDataSource: (() -> Void)?
    
    var movie = [Movie]()
    
    var menuCellViewModel = [PhotoCellViewModel](){
        didSet {
            print("hellp")
            reloadDataSource?()
        }
    }
    
    init(menuService: MainScreenServiceProtocol = MainScreenService()) {
        self.menuService = menuService
    }
    
    func getMenu() {
        menuService.getMenu { success, model, error in
            if success, let movies = model {
                var model = [PhotoCellViewModel]()
                for movie in movies {
                    model.append(self.createCellModel(movie: movie))
                }
                self.menuCellViewModel = model
            } else {
                print(error!)
            }
        }
    }
    
    func createCellModel(movie: Movie) -> PhotoCellViewModel {
        let id = movie.id
        let url = movie.url
        
        return PhotoCellViewModel(id: id, url: url)
    }
     
}
