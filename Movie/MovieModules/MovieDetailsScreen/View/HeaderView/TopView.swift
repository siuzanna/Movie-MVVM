//
//  TopView.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import UIKit
import WebKit
import Kingfisher
import SnapKit

final class TopView: UICollectionReusableView {
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var gradientView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = Icons.gradient.image
        return image
    }()
    
    /// stats View
    private lazy var posterView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var statsView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, timeLabel, ganreLabel, starsLabel, ratingLabel])
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 21)
        text.numberOfLines = 0
        return text
    }()
    
    private lazy var timeLabel: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 13)
        text.numberOfLines = 0
        return text
    }()
    
    private lazy var ganreLabel: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 13)
        text.numberOfLines = 0
        return text
    }()
    
    private lazy var  starsLabel: LableImage = {
        let text = LableImage()
        return text
    }()
    
    private lazy var ratingLabel: LableImage = {
        let text = LableImage()
        return text
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Watch Now", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    /// stats View
    private lazy var descriptionLabel: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 13)
        text.numberOfLines = 0
        return text
    }()
    
    private lazy var trailerLabel: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.text = "Trailer"
        text.font = UIFont.boldSystemFont(ofSize: 21)
        text.numberOfLines = 0
        return text
    }()
    
    private lazy var trailerView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var commentsLabel: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.text = "Comments"
        text.font = UIFont.boldSystemFont(ofSize: 21)
        text.numberOfLines = 0
        return text
    }()
    
    private var webView = WKWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureTrailerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cellViewModel: Movies? {
        didSet {
            if let url = cellViewModel?.photo {
                self.imageView.kf.setImage(with: URL(string: url))
            }
            if let url = cellViewModel?.miniPhoto {
                self.posterView.kf.setImage(with: URL(string: url))
            }
            if let url = cellViewModel?.trailer {
                let webConfiguration = WKWebViewConfiguration()
                webConfiguration.allowsInlineMediaPlayback = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.webView = WKWebView(frame: self.trailerView.bounds, configuration: webConfiguration)
                    self.trailerView.addSubview(self.webView)
                    guard let videoURL = URL(string: url) else { return }
                    let request = URLRequest(url: videoURL)
                    self.webView.load(request)
                }
            }
            if let name = cellViewModel?.name,
               let time = cellViewModel?.time,
               let description = cellViewModel?.description,
               let genres = cellViewModel?.genre,
               let stars = cellViewModel?.rating,
               let votes = cellViewModel?.votes {

                self.nameLabel.text = name
                self.timeLabel.text = "\(time / 60) hour \(time / 360) minute(s)"
                self.descriptionLabel.text = description
                var string = ""
                for genre in genres {
                    string += "\(genre), "
                }
                string.removeLast()
                string.removeLast()
                self.ganreLabel.text = string
                self.starsLabel.setUp(
                    text: stars,
                    image: UIImage(systemName: "star.fill"),
                    imageColor: Colors.star.color)
                self.ratingLabel.setUp(
                    text: "\(votes)% from users",
                    image: UIImage(systemName: "hand.thumbsup"),
                    imageColor: Colors.title.color)
            }
        }
    }
    
    func configure() {
        addSubview(imageView)
        addSubview(gradientView)
        addSubview(statsView)
        addSubview(button)
        addSubview(posterView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(0.96)
        }
        gradientView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(0.96)
        }
        button.snp.makeConstraints { make in
            make.bottom.equalTo(posterView.snp.bottom)
            make.height.equalTo(30)
            make.width.equalTo(160)
            make.leading.equalToSuperview()
        }
        statsView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalTo((button.snp.top)).inset(-20)
            make.height.equalTo(120)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        posterView.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(posterView.snp.width).multipliedBy(1.2)
            make.width.equalToSuperview().multipliedBy(0.45)
            make.trailing.equalToSuperview()
        }
    }
    
    func configureTrailerView() {
        addSubview(trailerLabel)
        addSubview(trailerView)
        addSubview(descriptionLabel)
        addSubview(commentsLabel)
        webView.backgroundColor = .black
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
        }
        trailerLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        trailerView.snp.makeConstraints { make in
            make.top.equalTo(trailerLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(trailerView.snp.width).multipliedBy(0.5)
        }
        commentsLabel.snp.makeConstraints { make in
            make.top.equalTo(trailerView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
