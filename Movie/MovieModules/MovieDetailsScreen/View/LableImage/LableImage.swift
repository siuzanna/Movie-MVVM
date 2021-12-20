//
//  LableImage.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import UIKit

class LableImage: UIView {
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let text = UILabel()
        text.textColor = Colors.title.color
        text.font = UIFont.boldSystemFont(ofSize: 13)
        text.numberOfLines = 0
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        addSubview(imageView)
        addSubview(nameLabel)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).inset(-5)
            make.centerY.equalToSuperview()
        }
    }
    
    func setUp(text: String, image: UIImage? = UIImage(), imageColor: UIColor) {
        nameLabel.text = text
        imageView.image = image
        imageView.tintColor = imageColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
