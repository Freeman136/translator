//
//  RootViewController.swift
//  FirstProject
//
//  Created by Andrew on 29.04.2024.
//

import UIKit

//class RootViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let mainVC = MainViewController()
//        let navigationController = UINavigationController(rootViewController: mainVC)
//        navigationController.modalPresentationStyle = .fullScreen
//        self.present(navigationController, animated: true, completion: nil)
//    }
//}

//let navigationController = AppNavigationController()

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .orange
    }

    func presentLaunchScreen() {
        
//        let launchScreenVC = GalleryCollectionView()//MainViewController()

//        viewControllers = [launchScreenVC]
    }
}
