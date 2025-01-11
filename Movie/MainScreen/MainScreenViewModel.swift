//
//  MainScreenViewModel.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import Foundation
import UIKit.NSDiffableDataSourceSectionSnapshot

protocol MainScreenViewModelDelegate: AnyObject {
    func updateCollectionView()
    func showError(text: String)
}

protocol MainScreenServiceProtocol {
    var delegate: MainScreenViewModelDelegate? { get set }
    var dataSource: UICollectionViewDiffableDataSource<Section, MovieDTO>? { get set }
    
    func requestMovieList()
    func getMoviesBySection(_ indexPath: Int) -> [MovieDTO]
    func getMoviesBySection(_ section: Section) -> [MovieDTO]
}

final class MainScreenViewModel: MainScreenServiceProtocol {
    
    private let networkService: NetworkService
    private var movieList: [MovieDTO]
    
    public var dataSource: UICollectionViewDiffableDataSource<Section, MovieDTO>? = nil
    weak var delegate: MainScreenViewModelDelegate?
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        self.movieList = []
    }
}

extension MainScreenViewModel {
    
    func getByIndexPath(_ indexPath: IndexPath) -> MovieDTO {
        return movieList[indexPath.row]
    }
    
    func requestMovieList() {
        networkService.sendRequest(
            urlRequest: MainScreenRouter.getAllPosts.createURLRequest(),
            successModel: [MovieDTO].self
        ) { [weak self] (result) in
            guard let self else { return }
            switch result {
            case .success(let model):
                self.movieList = model
                self.delegate?.updateCollectionView()
            case .badRequest(let error):
                self.delegate?.showError(text: error.errors?.first ?? "Error occurred")
                debugPrint(#function, error)
                self.fetchLocalJsonMovies()
            case .failure(let error):
                self.delegate?.showError(text: error)
                debugPrint(#function, error)
                self.fetchLocalJsonMovies()
            }
        }
    }

    private func fetchLocalJsonMovies() {
        guard let path = Bundle.main.path(forResource: "movies", ofType: "json") else {
            debugPrint("Local JSON file 'move.json' not found.")
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let localMovies = try JSONDecoder().decode([MovieDTO].self, from: data)
            self.movieList = localMovies
            self.delegate?.updateCollectionView()
        } catch {
            debugPrint("Error decoding local JSON file: \(error)")
            self.delegate?.showError(text: "Failed to load data from the local file")
        }
    }

    func getMoviesBySection(_ indexPath: Int) -> [MovieDTO] {
        return movieList.filter { $0.type == indexPath }
    }
    
    func getMoviesBySection(_ section: Section) -> [MovieDTO] {
        switch section {
        case .topSlide:
            getMoviesBySection(0)
        case .mostPopular:
            getMoviesBySection(1)
        case .comingSoon:
            getMoviesBySection(2)
        case .lastUpdate:
            getMoviesBySection(3)
        case .bestSeries:
            getMoviesBySection(4)
        }
    }
}
