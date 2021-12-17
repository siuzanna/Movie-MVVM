//
//  PhotoCell.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import UIKit
import SnapKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    
    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    var cellViewModel: PhotoCellViewModel? {
        didSet {
            if let url = cellViewModel?.url  {
                self.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(), options: [.continueInBackground,.progressiveLoad], completed: nil)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        layer.cornerRadius = 15
        configure()
    }
    
    func configure() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
