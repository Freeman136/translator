//
//  DetailCustomCell.swift
//  FirstProject
//
//  Created by Andrew on 30.04.2024.
//

import UIKit

class UIDetailView: UIView {
  
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .montserrat(ofSize: 10, weight: .regular)
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "текст"
        return field
    }()
    
    private let separatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray.withAlphaComponent(0.3)
        return separator
    }()
    
    init(title: String, subtitleLabel: String, text: String? = nil) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitleLabel
        textField.text = text
        textField.textColor = .black
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(titleLabel, subtitleLabel, textField, separatorView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            
            textField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            separatorView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2),
            separatorView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0)
        ])
    }
}


extension UIDetailView {
    
    var text: String? {
        get {
            textField.textColor = .black
            return textField.text
        }
        
        set {
            textField.textColor = UIColor.black
            textField.text = newValue
        }
    }
}

