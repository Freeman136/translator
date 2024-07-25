//
//  LaunchScreen.swift
//  FirstProject
//
//  Created by Andrew on 27.04.2024.
//

import UIKit


class LaunchScreenViewController: UIViewController {

    private let iconImageView: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "Image"))
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        let color = UIColor(red: 33/255, green: 50/255, blue: 58/255, alpha: 1)
        titleLabel.textColor = color
        titleLabel.font = .montserrat(ofSize: 30, weight: .bold)
        titleLabel.text = "L e a r n"
        return titleLabel
    }()
    
    private let secondLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = .montserrat(ofSize: 11, weight: .bold)
        titleLabel.text = "Учи слова вместе снами"
        return titleLabel
    }()

    override func loadView() {
        super.loadView()
        setupView()
    }

    override func viewDidLoad() {
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            self.presentMainViewController()
        }
    }

    private func presentMainViewController() {
//        let mainVC = GalleryCollectionView()
//        self.present(mainVC, animated: true)
//        navigationController?.pushViewController(mainVC, animated: true)
//        navigationController?.viewControllers = [mainVC]
    }

    private func setupView() {
        view.addSubviews(iconImageView)
        view.addSubviews(titleLabel)
        view.addSubviews(secondLabel)
    }

    private func setupConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 137),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1 / 1),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 42),

            secondLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            secondLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18)
        ])
    }
}


