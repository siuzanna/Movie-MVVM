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
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension SectionBackgroundDecorationView {
    func configure() {
        backgroundColor = Colors.commetsView.color
        layer.cornerRadius = 12
    }
}
