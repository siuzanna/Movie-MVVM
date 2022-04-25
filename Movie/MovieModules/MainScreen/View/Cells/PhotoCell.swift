//
//  PhotoCell.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(model: Movies?) {
        if let url = model?.miniPhoto {
            self.imageView.kf.setImage(with: URL(string: url))
        } else {
            self.imageView.image = Icons.launchPhoto.image
        }
    }
}
