//
//  APIRoute.swift
//  UnsplashTokyo
//
//  Created by Netzme on 15/01/22.
//

import Foundation
import Alamofire

enum APIRoute {
    case listPhoto(page: Int)
    case searchPhoto(page: Int, query: String)
}

extension APIRoute: APIConfiguration {
    
    //MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .listPhoto, .searchPhoto:
            return .get
        }
    }
    //MARK: Path
    var path: String {
        switch self {
        case .listPhoto:
            return "/photos"
        case .searchPhoto:
            return "/search/photos"
        }
    }
    //MARK: Parameters
    var parameters: RequestParams {
        switch self {
        case .listPhoto(let page):
            return.url([
                "page": String(page)
            ])
        case .searchPhoto(let page, let query):
            return.url([
                "page": String(page),
                "query": query
            ])
        }
    }
    
    //MARK: ResponseType
    var responseType: ResponseType {
        switch self {
        case .listPhoto:
            return .array
        case .searchPhoto:
            return .object
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constant.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        //Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.authorization.rawValue, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        
        //Parameter
        switch parameters {
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        case .url(let params):
            var queries:[URLQueryItem] = []
            params.forEach { key, value in
                queries.append(URLQueryItem(name: key, value: "\(value)"))
            }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queries
            urlRequest.url = components?.url
        }
        return urlRequest
    }
}
