

import Foundation
import UIKit

extension Network {
    
    func unsplashLoading(_ query: String, lang: String, page: Int, completion: @escaping (Result <PhotoUnsplash, ErrorsNetwork>) -> Void) -> Void {
        // PARAMS
        let params = [
            "query": query,
            "lang": lang,
            "page": page,
            "per_page": 25
        ] as [String: Any]
        
        // dop headers
        //        let headers = ["1q231":"1312"]
        //        pushRequest(api: ApiUnsplash.unsplashLoading, params: params, /*headersAdditionally: headers,*/ completion: completion)
        pushRequest(api: Api.unsplashLoading,params: params, type: PhotoUnsplash.self, completion: completion)
    }
    
    // MARK: pushRequest
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error { DispatchQueue.main.async { completion(nil) }
                return }
            
            guard let data = data, let image = UIImage(data: data) else { DispatchQueue.main.async { completion(nil) }
                return }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }

    
    func resultData<T>(_ data: Data?, structure: T.Type) {
        guard let data = data else { return }
        print("--------\(structure.self)--------")
        print(String(data: data, encoding: .utf8))
        print("----------end------------")
        
    }
    
    func randomPhoto(_ query: String, lang: String, page: Int, completion: @escaping (Result <PhotoUnsplash, ErrorsNetwork>) -> Void) -> Void {
        let params = [
            "query": query,
            "lang": lang,
            "page": page,
            "per_page": 15
        ] as [String: Any]
        pushRequest(api: Api.unsplashLoading,params: params, type: PhotoUnsplash.self, completion: completion)

    }
}



