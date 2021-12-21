//
//  TopCell.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import UIKit
import SnapKit
import SDWebImage

class TopCell: UICollectionViewCell {
    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    var cellViewModel: MainScreenCellViewModel? {
        didSet {
            if let url = cellViewModel?.photo {
                self.imageView.sd_setImage(
                    with: URL(string: url),
                    placeholderImage: Icons.launchPhoto.image,
                    options: [.continueInBackground, .progressiveLoad],
                    completed: nil)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
