//
//  NavigationBar.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import UIKit

class NavigationBar: UIView {

    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = Icons.logo.image
        return image
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Icons.Navigation.search.image.withTintColor(Colors.logoRed.color), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Icons.Navigation.filter.image.withTintColor(Colors.title.color), for: .normal)
        button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Icons.Navigation.menu.image.withTintColor(Colors.title.color), for: .normal)
        button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    private func setup() {
        setupSubviews()
        setupContstraints()
    }

    private func setupSubviews() {
        addSubview(logoImageView)
        addSubview(searchButton)
        addSubview(filterButton)
        addSubview(menuButton)
    }

    private func setupContstraints() {
        logoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(73)
            make.height.equalTo(55)
        }
        menuButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(27)
        }
        filterButton.snp.makeConstraints { make in
            make.trailing.equalTo(menuButton.snp.leading).inset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(27)
        }
        searchButton.snp.makeConstraints { make in
            make.trailing.equalTo(filterButton.snp.leading).inset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(27)
        }
    }

    @objc private func tapped(_ sender: UIButton) {
        if sender == filterButton {

         } else if sender == searchButton {

         } else if sender == menuButton {

         }
    }
}
