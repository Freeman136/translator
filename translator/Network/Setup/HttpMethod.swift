

import Foundation

enum HttpMethod: String {
    case get, post, delete, put
    
    var string: String {
        return rawValue.uppercased()
    }
}
