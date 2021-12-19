//
//  NavigationBarBack.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import UIKit

class NavigationBarBack: UIView {

    private lazy var backButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle, scale: .medium)
        button.setBackgroundImage(UIImage(systemName: "chevron.backward", withConfiguration: config)?
                                    .withTintColor(Colors.title.color, renderingMode: .alwaysOriginal), for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle, scale: .medium)
        button.setBackgroundImage(UIImage( systemName: "bookmark", withConfiguration: config)?
                                    .withTintColor(Colors.title.color, renderingMode: .alwaysOriginal), for: .normal)
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
        addSubview(backButton)
        addSubview(saveButton)
    }

    private func setupContstraints() {
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
         }
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
         }
    }
    
    func addBackButtonTarget(_ target: Any?, action: Selector, forEvent: UIControl.Event) {
        backButton.addTarget(target, action: action, for: forEvent)
    }
    
    func addSaveButtonTarget(_ target: Any?, action: Selector, forEvent: UIControl.Event) {
        backButton.addTarget(target, action: action, for: forEvent)
    }
 }
