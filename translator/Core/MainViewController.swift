//
//  ViewController.swift
//  FirstProject
//
//  Created by Andrew on 26.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)

    }
}

//#Preview {
//    ViewController()
//}

//MARK: - SwiftUI
//import SwiftUI
//struct Provider_ViewController : PreviewProvider {
//    static var previews: some View {
//        ContainterView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainterView: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        typealias UIViewControllerType = UIViewController
//
//
//        let viewController = ViewController()
//        func makeUIViewController(context: UIViewControllerRepresentableContext<Provider_ViewController.ContainterView>) -> ViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: Provider_ViewController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<Provider_ViewController.ContainterView>) {
//
//        }
//    }
//}
