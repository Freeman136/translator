
import UIKit

class MainTableViewCell: UITableViewCell {
    static let identifier = "MainCell"
    
    private let mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.font = .montserrat(ofSize: 16, weight: .bold)
        return mainLabel
    }()
    
    private let secondLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.font = .montserrat(ofSize: 13, weight: .bold)
        return mainLabel
    }()

    var circleImage: UIImageView = {
        let image = UIImageView()
        let circleImage = UIImage(systemName: "circle")
        image.tintColor = AppUIColors.orangeColor
        image.image = circleImage
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 24)
        image.preferredSymbolConfiguration = symbolConfiguration
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
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        setupPlayButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(mainLabel)
        contentView.addSubview(secondLabel)
        contentView.addSubview(stackView)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        triangleImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            secondLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor),

            secondLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            secondLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -36),
        ])
    }
    
    func setupPlayButton() {
        stackView.addSubviews(circleImage)
        circleImage.addSubviews(triangleImage)
        NSLayoutConstraint.activate([
            circleImage.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            triangleImage.centerXAnchor.constraint(equalTo: circleImage.centerXAnchor),
            triangleImage.centerYAnchor.constraint(equalTo: circleImage.centerYAnchor)
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureCell(mainLabelText: String, secondLabelText: String) {
        mainLabel.text = mainLabelText
        secondLabel.text = secondLabelText
    }
}

