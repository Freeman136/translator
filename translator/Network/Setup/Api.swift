
import Foundation


enum Api {
    case unsplashLoading
    case unsplashRandomPhoto
    var path: String {
        switch self {
        case .unsplashLoading: return "https://api.unsplash.com/search/photos" 
        case .unsplashRandomPhoto: return "https://api.unsplash.com/photos/random?"

        }
    }
    
    var method: HttpMethod {
        switch self {
        case .unsplashLoading, .unsplashRandomPhoto: return .get
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .unsplashLoading, .unsplashRandomPhoto: return  [
            "Accept-Version": "v1",
            "Authorization": "Client-ID Ip0XA55zY7b7-d19osq1L5btGg-YCeDZVpnnJjXqHxs",

        ] as [String: String] }
    }
}
