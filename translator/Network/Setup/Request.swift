//
//  Request.swift
//  FirstProject
//
//  Created by Andrew on 20.07.2024.
//

import Foundation
import UIKit





final class Network: NetworkManager {
    
    private init() {}
    
    static var shared: NetworkManager = Network()
    
    // MARK: - Func pushRequest
    
    func pushRequest<T>(api: Api,
                        params: [String: Any] = [:],
                        headersAdditionally: [String:String] = [:],
                        httpBody: Data? = nil,
                        type: T.Type,
                        isMain: Bool = true,
                        completion: @escaping (Result <T, ErrorsNetwork>) -> Void) -> Void where T: Decodable {
        
        // MARK: - func push

        push(api: api, params: params, headersAdditionally: headersAdditionally, httpBody: httpBody, type: type) { result in
            if isMain {
                DispatchQueue.main.async {
                    completion(result)
                }
            } else {
                completion(result)
            }
        }
    }
    // MARK: - Func
    private func push<T>(api: Api,
                         params: [String: Any] = [:],
                         headersAdditionally: [String:String] = [:],
                         httpBody: Data? = nil,
                         type: T.Type,
                         completion: @escaping (Result <T, ErrorsNetwork>) -> Void) -> Void where T: Decodable {
        // 1 components
        guard var components = URLComponents(string: api.path) else { return completion(.failure(ErrorsNetwork.urlFailed))}
        // 2 queryItems
        let queryItems = params.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }
        // 3 components
        components.queryItems = queryItems
        //4 url
        guard let url = components.url else { return completion(.failure(ErrorsNetwork.urlFailed))}
        // 5 request
        var request = URLRequest(url: url)
        // 5 request-httpMethod
        request.httpMethod = api.method.string
        //6 headers
        api.headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        //6.1 headers
        //        headersAdditionally.forEach { key, value in
        //            request.addValue(value, forHTTPHeaderField: key)
        //        }
        //
        request.httpBody = httpBody
        //7 task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                return completion(.failure(ErrorsNetwork.default(error)))
            }
            // TODO - верно ?
            self.resultData(data, structure: type.self)
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(ErrorsNetwork.noData))
                return
            }
            
//            response.allHeaderFields.forEach {
//                print("__________________________")
//                
//
//                print($0.key, $0.value)
//                print("__________________________")
//            }
//
            do {
                let decode = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decode))
                
            } catch let error {
                completion(.failure(ErrorsNetwork.default(error)))
            }
        }
        task.resume()
    }
}
