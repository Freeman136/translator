

import UIKit

class RoundedImageCell: UICollectionViewCell {
    
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: 11, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 29
        return imageView
    }()
    
    private let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.shadow(.systemGray)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubviews(bgView)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(secondLabel)
        
        bgView.addSubviews(iconImageView, stackView)

        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            iconImageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 13.5),
            iconImageView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 59),
            iconImageView.widthAnchor.constraint(equalToConstant: 59),
            
            stackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 9),
            stackView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -5),
         
            stackView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -18),
        ])
    }
    
    func createStackView() {
   

    }
    
    func configure( firstLabelText: String, secondLabelText: String) {
        mainLabel.text = firstLabelText
        secondLabel.text = secondLabelText
    }
}
