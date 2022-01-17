//
//  APIConfiguration.swift
//  UnsplashTokyo
//
//  Created by Netzme on 15/01/22.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var responseType: ResponseType { get }
}
