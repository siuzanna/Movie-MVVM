//
//  HeaderView.swift
//  Movie
//
//  Created by siuzanna on 18/12/21.
//

import UIKit
import SnapKit

class HeaderView: UICollectionReusableView {

    public let label: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 21)
        text.numberOfLines = 0
        return text
    }()

    public let buttonLabel: UILabel = {
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
        addSubview(label)
        addSubview(buttonLabel)
        label.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        buttonLabel.snp.makeConstraints { make in
            make.centerY.equalTo(label.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
