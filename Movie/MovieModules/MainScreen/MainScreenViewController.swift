//
//  MainScreenViewController.swift
//  Movie
//
//  Created by siuzanna on 17/12/21.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {
    
    enum Section: String, CaseIterable {
        case topSlide = ""
        case mostPopular = "Most Popular"
        case comingSoon = "Coming Soon"
        case lastUpdate = "Last Updated"
        case bestSeries = "Best Series"
    }
    
    enum Item: Hashable {
        case topSlide(Movies)
        case mostPopular(Movies)
        case comingSoon(Movies)
        case lastUpdate(Movies)
        case bestSeries(Movies)
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    private var collectionView: UICollectionView! = nil
    private lazy var navigationBar = { NavigationBar() }()
    private var viewModel: MainScreenServiceProtocol
    
    init(viewModel: MainScreenServiceProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.bg.color
        view.addSubview(navigationBar)
        setupNavigationBar()
        setupResponses()
        viewModel.getMenu()
    }
    
    private func setupResponses() {
        viewModel.successResponse = { [weak self] in
            DispatchQueue.main.async {
                self?.configureCollectionView()
                self?.configureDataSource()
                self?.setupCollectionViewConstraints()
            }
        }
        
        viewModel.errorResponse = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(withTitle: "Error occurred", message: error)
            }
        }
    }
}

// MARK: Configure Constraints
extension MainScreenViewController {
    private func setupCollectionViewConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(85)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setupNavigationBar() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(92)
        }
    }
}

// MARK: Configure UICollectionView
extension MainScreenViewController {
    
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset.bottom = 20
        collectionView.contentInset.top = 20
        collectionView.register(cell: PhotoCell.self)
        collectionView.register(cell: TopCell.self)
        collectionView.register(header: HeaderView.self)
        self.collectionView = collectionView
    }
}

// MARK: UICollectionViewLayout
extension MainScreenViewController {
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
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
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.426))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
}

// MARK: UICollectionViewDiffableDataSource
extension MainScreenViewController {
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            switch item {
            case .topSlide(let photo):
                let cell: TopCell = collectionView.dequeue(for: indexPath)
                cell.configureCell(model: photo)
                return cell
            case .mostPopular(let photo), .comingSoon(let photo), .lastUpdate(let photo), .bestSeries(let photo):
                let cell: PhotoCell = collectionView.dequeue(for: indexPath)
                cell.configureCell(model: photo)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = {
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
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func snapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.topSlide, .mostPopular, .comingSoon, .lastUpdate, .bestSeries])
        snapshot.appendItems(viewModel.topCellViewModel.map({ Item.topSlide($0) }), toSection: .topSlide)
        snapshot.appendItems(viewModel.popularCellViewModel.map({ Item.mostPopular($0) }), toSection: .mostPopular)
        snapshot.appendItems(viewModel.comingSoonCellViewModel.map({ Item.comingSoon($0) }).suffix(1), toSection: .comingSoon)
        snapshot.appendItems(viewModel.lastUpdatedCellViewModel.map({ Item.lastUpdate($0) }), toSection: .lastUpdate)
        snapshot.appendItems(viewModel.bestSeriesCellViewModel.map({ Item.bestSeries($0) }), toSection: .bestSeries)
        return snapshot
    }
}

extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm: Movies
        
        switch Section.allCases[indexPath.section] {
        case .topSlide:
            vm = viewModel.topCellViewModel[indexPath.row]
        case .mostPopular:
            vm = viewModel.popularCellViewModel[indexPath.row]
        case .comingSoon:
            vm = viewModel.comingSoonCellViewModel[indexPath.row]
        case .lastUpdate:
            vm = viewModel.lastUpdatedCellViewModel[indexPath.row]
        case .bestSeries:
            vm = viewModel.bestSeriesCellViewModel[indexPath.row]
        }
        let view = MovieDetailedScreenViewController(viewModel: vm)
        view.modalPresentationStyle = .overCurrentContext
        self.present(view, animated: true, completion: nil)
    }
}
