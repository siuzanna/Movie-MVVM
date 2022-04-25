//
//  MovieDetailedScreenViewController.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import UIKit

class MovieDetailedScreenViewController: UIViewController {

    enum Section: String, CaseIterable {
        case comments = "Comments"
        case recommend = ""
    }
    
    enum Item: Hashable {
        case comments(Comments)
        case recommend(Comments)
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    private lazy var navigationBar = { NavigationBarBack() }()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    private var collectionView: UICollectionView! = nil
    private var viewModel: Movies
    
    init(viewModel: Movies) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        self.configureCollectionView()
        self.configureDataSource()
        self.setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.bg.color
        navigationBar.addBackButtonTarget(self, action: #selector(dismissView), forEvent: .touchUpInside)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: Configure Constraints
extension MovieDetailedScreenViewController {
    
    private func setupNavigationBar() {
        view.addSubview(collectionView)
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(92)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: Configure UICollectionView
extension MovieDetailedScreenViewController {
    
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset.bottom = 50
        collectionView.bounces = false
        collectionView.register(header: TopView.self)
        collectionView.register(header: HeaderView.self)
        collectionView.register(cell: CommentsCell.self)
        collectionView.register(footer: CommentsViewFooter.self)
        self.collectionView = collectionView
    }
}

// MARK: UICollectionViewLayout
extension MovieDetailedScreenViewController {
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .comments: return self.generateEmtyCellLayout()
            case .recommend: return self.generateCommentsLayout()
            }
        }
        layout.register(
            SectionBackgroundDecorationView.self,
            forDecorationViewOfKind: "NSCollectionLayoutDecorationItem")
        return layout
    }
    
    func generateEmtyCellLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.43),
            heightDimension: .absolute(10))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(685))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        sectionHeader.zIndex = 2
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func generateCommentsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(82))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitems: [item])
        
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(52))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom)
        sectionFooter.zIndex = 2
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
            elementKind: "NSCollectionLayoutDecorationItem" )
        sectionBackgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.decorationItems = [sectionBackgroundDecoration]
        
        section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.boundarySupplementaryItems = [sectionFooter]
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
}

// MARK: UICollectionViewDiffableDataSource
extension MovieDetailedScreenViewController {
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            switch item {
            case .comments(let comments):
                print(comments)
                return  UICollectionViewCell()
            case .recommend(let photo):
                let cell: CommentsCell = collectionView.dequeue(for: indexPath)
                cell.cellViewModel = photo
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = {
            ( collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .comments:
                let supplementaryView: TopView = collectionView.dequeue(for: indexPath, kind: kind)
                supplementaryView.cellViewModel = self.viewModel
                return supplementaryView
            case .recommend:
                let supplementaryView: CommentsViewFooter = collectionView.dequeue(for: indexPath, kind: kind)
                return supplementaryView
            }
        }
        
        let snapshot = snapshot()
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func snapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.comments, .recommend])
        let comments = viewModel.comments
        snapshot.appendItems(comments.map({ Item.recommend($0) }), toSection: .recommend)
        snapshot.appendItems(comments.map({ Item.comments($0) }).suffix(0), toSection: .comments)
        
        return snapshot
    }
}
