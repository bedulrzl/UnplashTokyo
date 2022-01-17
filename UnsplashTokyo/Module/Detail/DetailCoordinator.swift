//
//  DetailCoordinator.swift
//  UnsplashTokyo
//
//  Created by Netzme on 17/01/22.
//

import Foundation
import UIKit

class DetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private var photos: Photo
    internal var detailController: DetailViewController?
    
    init(navigationController: UINavigationController, photo: Photo) {
        self.navigationController = navigationController
        self.photos = photo
    }
    
    func start() {
        self.detailController = DetailViewController(photos: photos)
        if let controller = detailController {
            navigationController.pushViewController(controller, animated: true)
        }
        
    }
}
