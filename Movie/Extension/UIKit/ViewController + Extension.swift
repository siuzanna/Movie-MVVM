//
//  ViewController + Extension.swift
//  Movie
//
//  Created by siuzanna on 17/12/21.
//

import UIKit


extension UIViewController {
    
    func embeddedInNavigationController() -> UINavigationController {
        return BaseNavigationController(rootViewController: self)
    }
    
    func setNavigationBarAppearance(style: UIBarStyle) {
        navigationController?.navigationBar.barStyle = style
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = .clear
    }
    
    func removeBackButtonTitle() {
        navigationItem.backButtonTitle = ""
    }
}


class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


