

import Foundation

enum ErrorsNetwork: Error {
    case  urlFailed
    case noData
    case `default`(_ error: Error)
    
    var localizedDescription: String {
        switch self {
        case .urlFailed: return "this URL is not valid"
            
        case .noData: return "This data is empty"
            
        case .`default`(let error): return error.localizedDescription
        }
    }
}

extension ErrorsNetwork: LocalizedError {
    var errorDescription: String? {
        return localizedDescription
    }
}

enum NetworkErrors: Error {
    case badURL, badRequest, badResponse, noData, pageDoNotExist
}
