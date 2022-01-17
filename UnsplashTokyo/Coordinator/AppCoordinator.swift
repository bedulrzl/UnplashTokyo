//
//  AppCoordinator.swift
//  UnsplashTokyo
//
//  Created by Netzme on 14/01/22.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var window: UIWindow?
    private var mainViewController: MainViewController!
    
    init(window: UIWindow) {
        self.window = window
        self.mainViewController = MainViewController()
        self.mainViewController.viewModel = MainViewModel()
        self.navigationController = UINavigationController(rootViewController: self.mainViewController)
        mainViewController.title = "Unsplashtokyo"
        mainViewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        mainViewController.viewModel?.didSelectPhoto = { photos in
            self.navigateToDetail(with: photos)
        }
    }

    func start() {
        //MARK: Set root of window
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
}

extension AppCoordinator {
    func navigateToDetail(with photo: Photo) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, photo: photo)
        detailCoordinator.start()
    }
}
