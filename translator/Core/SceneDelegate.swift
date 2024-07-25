//
//  SceneDelegate.swift
//  FirstProject
//
//  Created by Andrew on 26.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow.init(windowScene: windowScene)
//        let navigationController = GalleryCollectionView()
//        let navigationController = AppNavigationController(rootViewController: LaunchScreenViewController())
        let navigationController = AppNavigationController(rootViewController: UIAllWordViewController())

        window?.rootViewController = navigationController

        window?.backgroundColor = .systemGray6

        window?.makeKeyAndVisible()

    }
}
