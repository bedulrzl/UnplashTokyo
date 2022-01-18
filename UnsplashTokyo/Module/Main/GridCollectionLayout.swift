//
//  GridCollectionLayout.swift
//  UnsplashTokyo
//
//  Created by Netzme on 18/01/22.
//

import UIKit
//MARK: CollectionView Style
enum CollectionStyle {
    case list
    case grid
}

class TokyoCollectionLayout : UICollectionViewFlowLayout {
    
    var display : CollectionStyle = .list {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    convenience init(display: CollectionStyle) {
        self.init()
        
        self.display = display
        self.minimumLineSpacing = 1
        self.minimumInteritemSpacing = 1
        self.configLayout()
    }
    
    func configLayout() {
        switch display {
        case .grid:
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                let optimisedWidth = (collectionView.frame.width - minimumInteritemSpacing) / 2
                let height = collectionView.frame.height / 2
                self.itemSize = CGSize(width: optimisedWidth , height: height) // keep as square
            }
        case .list:
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                self.itemSize = CGSize(width: collectionView.frame.width , height: 250)
            }
        }
    }
    //MARK: Reload collectionView UI
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
}
