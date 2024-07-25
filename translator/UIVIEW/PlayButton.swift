//
//  PlayButton.swift
//  FirstProject
//
//  Created by Andrew on 10.05.2024.
//

import UIKit

class PlayButton: UIView {
    
    let label:UILabel = {
        let label = UILabel()
        label.text = "Воспроизвести"
        label.font = .montserrat(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let  circleImage: UIImageView = {
        let image = UIImageView()
        let circleImage = UIImage(systemName: "circle")
        image.tintColor = AppUIColors.orangeColor
        image.image = circleImage
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24)
        image.preferredSymbolConfiguration = symbolConfig
        return image
    }()
    
    var triangleImage: UIImageView = {
        let image = UIImageView()
        let triangleImage = UIImage(systemName: "play.fill")
        image.tintColor = AppUIColors.orangeColor
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 7.95)
        image.preferredSymbolConfiguration = symbolConfiguration
        image.image = triangleImage
        return image
    }()
    
    let containerView = UIView()

    let buttonPlay = UIButton(type: .custom)
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupContainerView()
        setupConstraints()
    }
    
    private func setupContainerView() {
        addSubviews(label, buttonPlay)
        buttonPlay.addSubviews(containerView)
        containerView.addSubviews(circleImage, triangleImage)
    }
    
    private func setupButton() {
        buttonPlay.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        buttonPlay.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
//            label.heightAnchor.constraint(equalTo: heightAnchor),
                    
            buttonPlay.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            buttonPlay.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: -5),
            buttonPlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonPlay.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            containerView.topAnchor.constraint(equalTo: buttonPlay.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: buttonPlay.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: buttonPlay.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: buttonPlay.trailingAnchor),
                    
            triangleImage.centerXAnchor.constraint(equalTo: circleImage.centerXAnchor),
            triangleImage.centerYAnchor.constraint(equalTo: circleImage.centerYAnchor),
        ])
    }
    
    @objc func buttonPressed() {
        print("play sound")
    }
}


//MARK: - SwiftUI
