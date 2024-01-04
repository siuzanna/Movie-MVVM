//
//  CollectionReusableView.swift
//  Movie
//
//  Created by siuzanna on 20/12/21.
//

import UIKit

class CommentsViewFooter: UICollectionReusableView {
  
    private let buttonLabel: UILabel = {
        let text = UILabel()
        text.text = "See All >"
        text.textColor = UIColor(red: 0.467, green: 0.467, blue: 0.467, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 15)
        return text
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(buttonLabel)
        buttonLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setTitle(_ text: String) {
        buttonLabel.text = text
    }
}
