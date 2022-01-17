//
//  Constant.swift
//  UnsplashTokyo
//
//  Created by Netzme on 15/01/22.
//

import Foundation
import Alamofire

struct Constant {
    static let baseUrl = "https://api.unsplash.com"
    static let keyAccess = "nf0vTyy7nT6p5a5MNg4LDIky2J8BIcA9uKSeHhg3VzI"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case string = "String"
}

enum ContentType: String {
    case json = "Application/json"
    case authorization = "Client-ID nf0vTyy7nT6p5a5MNg4LDIky2J8BIcA9uKSeHhg3VzI"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
}

enum ResponseType {
    case array
    case object
}
