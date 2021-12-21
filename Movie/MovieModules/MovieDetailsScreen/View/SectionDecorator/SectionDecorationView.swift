//
//  SectionDecorationView.swift
//  Movie
//
//  Created by siuzanna on 20/12/21.
//

import UIKit

class SectionBackgroundDecorationView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure() {
        backgroundColor = Colors.commetsView.color
        layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
