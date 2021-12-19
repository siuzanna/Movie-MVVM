//
//  CommentsCell.swift
//  Movie
//
//  Created by siuzanna on 20/12/21.
//

import UIKit

class CommentsCell: UICollectionViewCell {
    
    public lazy var pictureView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.image = UIImage(systemName: "person.circle.fill")
        image.layer.cornerRadius = image.frame.height/2
        image.contentMode = .scaleAspectFill
        image.tintColor = Colors.title.color
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let text = UILabel()
        text.textColor = Colors.title.color
        text.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        text.numberOfLines = 1
        return text
    }()
    
    private lazy var commentLabel: UILabel = {
        let text = UILabel()
        text.textColor = Colors.title.color
        text.font = UIFont.systemFont(ofSize: 11, weight: .light)
        text.numberOfLines = 0
        return text
    }()
    
    let seperatorView = UIView()
    
    let containerView = UIView()
    
    var cellViewModel: Comments? {
        didSet {
            nameLabel.text = cellViewModel?.name
            commentLabel.text = cellViewModel?.comment
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure() {
        containerView.addSubview(nameLabel)
        containerView.addSubview(commentLabel)
        containerView.addSubview(pictureView)
        containerView.addSubview(seperatorView)
        contentView.addSubview(containerView)
        seperatorView.backgroundColor = .lightGray
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        pictureView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(25)
            make.leading.equalToSuperview().inset(15)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureView.snp.trailing).offset(10)
            make.centerY.equalTo(pictureView)
        }
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(pictureView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        seperatorView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
