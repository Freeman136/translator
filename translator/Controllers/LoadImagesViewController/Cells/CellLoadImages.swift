//
//  CellLoadImages.swift
//  FirstProject
//
//  Created by Andrew on 29.05.2024.
//

import UIKit
import SDWebImage

class CellLoadImages: UICollectionViewCell {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private let checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .orange
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubviews(iconImageView, checkMarkImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            checkMarkImageView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            checkMarkImageView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            checkMarkImageView.widthAnchor.constraint(equalToConstant: 20),
            checkMarkImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        layer.borderColor = UIColor.orange.cgColor
        layer.borderWidth = 0
    }
    
//    func configure(with url: URL) {
//        iconImageView.sd_setImage(with: url, completed: nil)
//    }
//    
    func setCheckmarkVisible(_ visible: Bool) {
        checkMarkImageView.isHidden = !visible
    }
    
    func setSelected(_ selected: Bool) {
        layer.borderWidth = selected ? 2 : 0
        iconImageView.alpha = selected ? 0.75 : 1.0
    }
}

extension CellLoadImages {
    var imageView: UIImageView {
        get { return iconImageView }
    }
}
