

import UIKit


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
