//
//  APIClient.swift
//  UnsplashTokyo
//
//  Created by Netzme on 15/01/22.
//

import Foundation
import Alamofire

class APIClient {
    private var dataRequest: DataRequest?
    let sessionManager: Session
    static let shared: APIClient = APIClient()
    
    init() {
        sessionManager = Session()
    }
    
    @discardableResult
    private func _dataRequest(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil
    )
    -> DataRequest {
        return sessionManager.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
    }
    
    func request<T: Codable>(route: APIRoute, completion:@escaping (Swift.Result<(T?, [T]?), Error>) -> Void) {
        if let request = try? route.asURLRequest() {
            AF.request(request).responseData(completionHandler: { (response) in
                guard let itemsData = response.data else {
                    completion(.failure(Error.self as! Error))
                    return
                }
                do {
                    let jsonDecoder = JSONDecoder()
                    if route.responseType == .object {
                        let model = try jsonDecoder.decode(T.self, from: itemsData )
                        completion(.success((model, nil)))
                    } else {
                        let model = try jsonDecoder.decode([T].self, from: itemsData )
                        completion(.success((nil, model)))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
            })
            
        }
    }
}
