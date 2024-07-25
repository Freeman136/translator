//
//  UIView-Ext.swift
//  FirstProject
//
//  Created by Алмаз Рахматуллин on 02.05.2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func shadow(_ color: UIColor! = UIColor.black) {
        self.layer.shadowColor = color?.cgColor
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.5
    }
}
