//
//  SwitchLanguage.swift
//  FirstProject
//
//  Created by Andrew on 12.05.2024.
//

import UIKit

class SwitchLanguage: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Язык перевода"
        label.font = .montserrat(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let imageView = UIImageView()
        let uiImage = UIImage(named: "rightArrow")
        imageView.image = uiImage
        return imageView
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.text = LanguageSwitchEnum.RawValue("en")
        label.textColor = AppUIColors.orangeColor
        return label
    }()
    
    init( languageLabel: LanguageSwitchEnum) {
        super.init(frame: .zero)
        self.languageLabel.text = languageLabel.rawValue
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubviews(titleLabel, arrowImage, languageLabel)
    }
    
    func changeLanguage() {
        if languageLabel.text == LanguageSwitchEnum.RawValue("en") {
            languageLabel.text = LanguageSwitchEnum.RawValue("ru")
        } else {
            languageLabel.text = LanguageSwitchEnum.RawValue("en")
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),
            titleLabel.widthAnchor.constraint(equalToConstant: 174),
            
            languageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            languageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor),
            languageLabel.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -7),
            
            arrowImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowImage.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

enum LanguageSwitchEnum: String {
    case en = "Английский"
    case ru = "Русский"
}
