//
//  MainScreenViewController.swift
//  Movie
//
//  Created by siuzanna on 17/12/21.
//

import UIKit
import SnapKit

enum Section: String, CaseIterable {
    case topSlide = ""
    case mostPopular = "Most Popular"
    case comingSoon = "Coming Soon"
    case lastUpdate = "Last Updated"
    case bestSeries = "Best Series"
}

final class MainScreenViewController: UIViewController {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieDTO>
    
    private var viewModel: MainScreenServiceProtocol
    private lazy var contentView = Mainview()
    
    init(viewModel: MainScreenServiceProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.delegate = self
        viewModel.delegate = self
        
        contentView.activityControl.startAnimating()
        viewModel.requestMovieList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainScreenViewController: MainScreenViewModelDelegate {
    
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.configureDataSource()
            self.contentView.activityControl.stopAnimating()
        }
    }
    
    func showError(text: String) {
        DispatchQueue.main.async {
            self.showAlert(withTitle: "Error occurred", message: text)
            self.contentView.activityControl.stopAnimating()
        }
    }
}

extension MainScreenViewController {
    
    func configureDataSource() {
        viewModel.dataSource = UICollectionViewDiffableDataSource<Section, MovieDTO>(collectionView: contentView.collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: MovieDTO) -> UICollectionViewCell? in
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .topSlide:
                let cell: TopCell = collectionView.dequeue(for: indexPath)
                cell.configureCell(model: item)
                return cell
            case .mostPopular, .comingSoon, .lastUpdate, .bestSeries:
                let cell: PhotoCell = collectionView.dequeue(for: indexPath)
                cell.configureCell(model: item)
                return cell
            }
        }
        
        viewModel.dataSource?.supplementaryViewProvider = {
            ( collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .topSlide:
                let header: UICollectionReusableView = collectionView.dequeue(for: indexPath, kind: kind)
                return header
            case .comingSoon:
                let header: HeaderView = collectionView.dequeue(for: indexPath, kind: kind)
                header.label.text = Section.allCases[indexPath.section].rawValue
                header.buttonLabel.text = ""
                return header
            case .mostPopular, .lastUpdate, .bestSeries:
                let header: HeaderView = collectionView.dequeue(for: indexPath, kind: kind)
                header.label.text = Section.allCases[indexPath.section].rawValue
                return header
            }
        }
        
        let snapshot = snapshot()
        viewModel.dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func snapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.topSlide, .mostPopular, .comingSoon, .lastUpdate, .bestSeries])
        snapshot.appendItems(viewModel.getMoviesBySection(.topSlide), toSection: .topSlide)
        snapshot.appendItems(viewModel.getMoviesBySection(.mostPopular), toSection: .mostPopular)
        snapshot.appendItems(viewModel.getMoviesBySection(.comingSoon).suffix(1), toSection: .comingSoon)
        snapshot.appendItems(viewModel.getMoviesBySection(.lastUpdate), toSection: .lastUpdate)
        snapshot.appendItems(viewModel.getMoviesBySection(.bestSeries), toSection: .bestSeries)
        return snapshot
    }
}

extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model: MovieDTO = viewModel.getMoviesBySection(indexPath.section)[indexPath.row]
        let viewController = MovieDetailedScreenViewController(viewModel: model)
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: true, completion: nil)
    }
}
