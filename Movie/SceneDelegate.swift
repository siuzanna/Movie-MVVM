//
//  SceneDelegate.swift
//  Movie
//
//  Created by siuzanna on 17/12/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = UIViewController()
            .embeddedInNavigationController()
            .makeTransparent()
            .removeTitle()
            .changeTintColor(to: .red)
        window.backgroundColor = UIColor.white
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }
}

