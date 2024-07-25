
struct PhotoUnsplash: Decodable {
    let results: [UnsplashPhotoUrls]?
    let totalPages: Int?
    let total: Int?
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case total
    }
}


struct UnsplashPhotoUrls: Decodable {
    let urls: UnsplashPhotoURLs?
}

struct UnsplashPhotoURLs: Decodable {
    let regular: String?
    let full: String?
}

