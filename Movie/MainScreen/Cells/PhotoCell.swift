//
//  PhotoCell.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        image.backgroundColor = Colors.commentsView.color
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    public func configureCell(model: MovieDTO?) {
        if let url = model?.miniPhoto {
            self.imageView.kf.setImage(with: URL(string: url))
        } else {
            self.imageView.image = Icons.launchPhoto.image
        }
    }
    
    private func configure() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
