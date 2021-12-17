//
//  ViewController.swift
//  Movie
//
//  Created by siuzanna on 17/12/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    private var collectionView: UICollectionView! = nil
    
    private lazy var menuViewModel = {
        PhotoViewModel()
    }()
    
    enum Section: String, CaseIterable {
        case topSlide = ""
        case mostPopular = "Most Popular"
        case comingSoon = "Coming Soon"
        case lastUpdate = "Last Updated"
        case bestSeries = "Best Series"
    }
    
    enum Item: Hashable {
        case topSlide(PhotoCellViewModel)
        case mostPopular(PhotoCellViewModel)
        case comingSoon(PhotoCellViewModel)
        case lastUpdate(PhotoCellViewModel)
        case bestSeries(PhotoCellViewModel)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.bg.color
        self.configureCollectionView()
        initViewModel()
        self.configureDataSource()
    }
    
    func initViewModel() {
        menuViewModel.getMenu()
        
        menuViewModel.reloadDataSource = { [weak self] in
            DispatchQueue.main.async {
                self?.configureDataSource()
            }
        }
    }
}

extension ViewController {
    
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset.top = 92
        collectionView.register(cell: PhotoCell.self)
        collectionView.register(header: HeaderView.self)
        collectionView.contentInset.bottom = 56
        self.collectionView = collectionView
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            switch item {
                case .topSlide(let photo):
                    let cell: PhotoCell = collectionView.dequeue(for: indexPath)
                    cell.cellViewModel = photo
                    return cell
                case .mostPopular(let photo):
                    let cell: PhotoCell = collectionView.dequeue(for: indexPath)
                    cell.cellViewModel = photo
                    return cell
                case .comingSoon(let photo):
                    let cell: PhotoCell = collectionView.dequeue(for: indexPath)
                    cell.cellViewModel = photo
                    return cell
                case .lastUpdate(let photo):
                    let cell: PhotoCell = collectionView.dequeue(for: indexPath)
                    cell.cellViewModel = photo
                    return cell
                case .bestSeries(let photo):
                    let cell: PhotoCell = collectionView.dequeue(for: indexPath)
                    cell.cellViewModel = photo
                    return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
                case .topSlide:
                    let supplementaryView: UICollectionReusableView = collectionView.dequeue(for: indexPath, kind: kind)
                    return supplementaryView
                case .mostPopular:
                    let supplementaryView: HeaderView = collectionView.dequeue(for: indexPath, kind: kind)
                    supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
                    return supplementaryView
                case .comingSoon:
                    let supplementaryView: HeaderView = collectionView.dequeue(for: indexPath, kind: kind)
                    supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
                    supplementaryView.buttonLable.text = ""
                    return supplementaryView
                case .lastUpdate:
                    let supplementaryView: HeaderView = collectionView.dequeue(for: indexPath, kind: kind)
                    supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
                    return supplementaryView
                case .bestSeries:
                    let supplementaryView: HeaderView = collectionView.dequeue(for: indexPath, kind: kind)
                    supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
                    return supplementaryView
            }
        }
        
        let snapshot = snapshot()
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch (sectionLayoutKind) {
                case .topSlide: return self.generateTopSlideLayout()
                case .mostPopular: return self.generateCustomLayout()
                case .comingSoon: return self.generateComingSoonLayout()
                case .lastUpdate: return self.generateCustomLayout()
                case .bestSeries: return self.generateCustomLayout()
            }
        }
        return layout
    }
    
    func generateTopSlideLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.78),
            heightDimension: .fractionalWidth(0.576))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func generateCustomLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.43),
            heightDimension: .fractionalWidth(0.533))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(59))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        sectionHeader.zIndex = 2
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func generateComingSoonLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.91),
            heightDimension: .fractionalWidth(0.426))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(59))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        sectionHeader.zIndex = 2
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    
    func snapshot() -> Snapshot {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.topSlide, .mostPopular, .comingSoon, .lastUpdate, .bestSeries])
        snapshot.appendItems(menuViewModel.menuCellViewModel.map({ Item.topSlide($0) }), toSection: .topSlide)
        snapshot.appendItems(menuViewModel.menuCellViewModel.map({ Item.mostPopular($0) }), toSection: .mostPopular)
        snapshot.appendItems(menuViewModel.menuCellViewModel.map({ Item.comingSoon($0) }), toSection: .comingSoon)
        snapshot.appendItems(menuViewModel.menuCellViewModel.map({ Item.lastUpdate($0) }), toSection: .lastUpdate)
        snapshot.appendItems(menuViewModel.menuCellViewModel.map({ Item.bestSeries($0) }), toSection: .bestSeries)
        return snapshot
    }
}
 
