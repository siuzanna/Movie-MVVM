//
//  UITabBarController.swift
//  Movie
//
//  Created by siuzanna on 17/12/21.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        viewControllers = TabBar.allCases.map {$0.viewController}
        tabBar.barTintColor = .white
        addCustomTabBarView()
        hideTabBarBorder()
        self.selectedIndex = 0
        self.delegate = self
        self.tabBar.tintColor = Colors.logoRed.color
        self.tabBar.unselectedItemTintColor = Colors.icons.color
    }
    
    let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Colors.tabbar.color
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customTabBarView.frame = tabBar.frame
    }
    
    func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    func hideTabBarBorder() {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage.from(color: .clear)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
        tabBar.layer.masksToBounds = false
    }
}

enum TabBar: String, CaseIterable {
    
    case home
    
    var viewController: UINavigationController {
        var viewController = UINavigationController()
        switch self {
        case .home:
            let viewModel = MainScreenViewModel()
            viewController = UINavigationController(rootViewController: MainScreenViewController(viewModel: viewModel))
        }
        
        viewController.setNavigationBarHidden(true, animated: true)
        viewController.tabBarItem = tabBarItem
        viewController.tabBarItem.imageInsets.top = 5
        return viewController
    }
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .home:
            return .init(title: nil,
                         image: UIImage(named: TabBar.home.rawValue),
                         selectedImage: UIImage(named: TabBar.home.rawValue))
        }
    }
}
