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
        configureDataSource()
        DispatchQueue.global().async {
            self.viewModel.requestMovieList()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainScreenViewController: MainScreenViewModelDelegate {
    
    func updateCollectionView() {
        DispatchQueue.main.async {
            let snapshot = self.snapshot()
            self.viewModel.dataSource?.apply(snapshot, animatingDifferences: true)
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
            let cell: PhotoCell = collectionView.dequeue(for: indexPath)
            switch sectionType {
            case .topSlide, .comingSoon:
                cell.configureCell(model: item, invertImage: true)
            case .mostPopular, .lastUpdate, .bestSeries:
                cell.configureCell(model: item)
            }
            return cell
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

        let sections: [Section] = [.topSlide, .mostPopular, .comingSoon, .lastUpdate, .bestSeries]

        for section in sections {
            let items = viewModel.getMoviesBySection(section)
            if !items.isEmpty {
                snapshot.appendSections([section])
                if section == .comingSoon {
                    snapshot.appendItems(items.suffix(1), toSection: section)
                } else {
                    snapshot.appendItems(items, toSection: section)
                }
            }
        }

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
