//
//  Coordinator.swift
//  UnsplashTokyo
//
//  Created by Netzme on 14/01/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
