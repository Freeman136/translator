//
//  HttpMethod.swift
//  FirstProject
//
//  Created by Andrew on 20.07.2024.
//

import Foundation

enum HttpMethod: String {
    case get, post, delete, put
    
    var string: String {
        return rawValue.uppercased()
    }
}
