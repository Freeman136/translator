//
//  GalleryLoadUIView.swift
//  FirstProject
//
//  Created by Andrew on 05.07.2024.
//

import UIKit

final class GalleryLoadUIView: UIView {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let imageLoad: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.badge.arrow.down")
        imageView.tintColor = .red.withAlphaComponent(0.7)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 42)
        imageView.preferredSymbolConfiguration = symbolConfiguration
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let fillImageLoad: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
   
    init(titleLabel: String) {
        super.init(frame: .zero)
        self.titleLabel.text = titleLabel
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubviews(imageLoad, titleLabel, fillImageLoad)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageLoad.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            imageLoad.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 5),
            imageLoad.heightAnchor.constraint(equalToConstant: 60),
            imageLoad.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.widthAnchor.constraint(equalToConstant: 176),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -35),
            
            fillImageLoad.topAnchor.constraint(equalTo: self.topAnchor),
            fillImageLoad.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            fillImageLoad.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            fillImageLoad.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

extension GalleryLoadUIView {
//    func setupLoadView(image name: String) {
//        let imageUI = UIImage(named: name)
//        imageLoad.image = imageUI
//    }
    
    var image: UIImage? {
        get  { fillImageLoad.image } set { fillImageLoad.image = newValue }
    }
}
