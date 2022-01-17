//
//  SearchPhoto.swift
//  UnsplashTokyo
//
//  Created by Netzme on 16/01/22.
//

import Foundation
// MARK: - SearchPhoto
struct SearcPhoto: Codable {
    let total, totalPages: Int?
    let results: [Photo]?

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
