//
//  MainViewModel.swift
//  UnsplashTokyo
//
//  Created by Netzme on 15/01/22.
//

import Foundation
import UIKit
import Alamofire

class MainViewModel: NSObject {
    var manager: APIClient = APIClient.shared
    var responHandler: ((Swift.Result<(Photo?, [Photo]?), Error>) -> Void)!
    var didSelectPhoto: ((_ photo: Photo) -> ())?
    
    var photos: Photos = [] {
        didSet {
            self.bindPhotos?()
        }
    }
    var bindPhotos: (() -> ())?
    var PagePhoto: Int = 1
    var isLoading: Bool = false
    var isSearch: Bool = false
    
    func fetchPhoto(query: String? = nil) {
        if isLoading { return }
        isLoading = true
        if isSearch == true {
            var routes: APIRoute
            guard let querys = query else {return}
            routes = .searchPhoto(page: PagePhoto, query: querys)
            self.processSearchGetPhotos(route: routes)
        } else {
            self.processGetPhotos()
        }
    }
    
    
    func processGetPhotos() {
        self.manager.request(route: .listPhoto(page: PagePhoto), completion: { (result: Result<(Photo?, [Photo]?), Error>) in
            switch result {
            case .success(let response):
                if let temp = response.1 {
                    self.photos.append(contentsOf: temp)
                    self.PagePhoto += 1
                    self.isLoading = false
                }
            case .failure(let error):
                self.isLoading = false
                print(error.localizedDescription)
            }
            
        })
    }
    
    func processSearchGetPhotos(route: APIRoute) {
        self.manager.request(route: route, completion: { (result: Result<(SearcPhoto?, [SearcPhoto]?), Error>) in
            switch result {
            case .success(let response):
                if let temp = response.0, let searchTemp = temp.results {
                    if self.PagePhoto == 1 { self.photos.removeAll()}
                    self.photos.append(contentsOf: searchTemp)
                    self.PagePhoto += 1
                    self.isLoading = false
                }
            case .failure(let error):
                self.isLoading = false
                print(error.localizedDescription)
            }
        })
    }
    
    func processShowDetail(indexpath: IndexPath) {
        self.didSelectPhoto?(photos[indexpath.row])
    }
}
