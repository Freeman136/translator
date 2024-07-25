//
//  NetworkManagerProtocol.swift
//  FirstProject
//
//  Created by Andrew on 23.07.2024.
//

import Foundation
import UIKit

protocol NetworkManager: AnyObject {
    
    static var shared: NetworkManager { get set }
    
    func unsplashLoading(_ query: String, lang: String, page: Int, completion: @escaping (Result <PhotoUnsplash, ErrorsNetwork>) -> Void) -> Void
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
    func randomPhoto(_ query: String, lang: String, page: Int, completion: @escaping (Result <PhotoUnsplash, ErrorsNetwork>) -> Void) -> Void
    
}
