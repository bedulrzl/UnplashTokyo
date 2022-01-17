//
//  UICollectionView+Extension.swift
//  UnsplashTokyo
//
//  Created by Netzme on 16/01/22.
//

import UIKit

extension UICollectionView {
    
    func registerCell<T>(_ cell: T.Type) where T: UICollectionViewCell {
        let nib = UINib(nibName: String(describing: cell.self), bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: String(describing: cell.self))
    }

    func registerHeader<T>(_ header: T.Type) where T: UICollectionReusableView {
        let className = header.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }

    func registerFooter<T>(_ footer: T.Type) where T: UICollectionReusableView {
        let nib = UINib(nibName: String(describing: footer.self), bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: footer.self))
    }

    // MARK: Register Cell in cell for at
    
    func dequeueCell<T>(_ cell: T.Type, indexPath: IndexPath) -> T where T: UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: cell.self), for: indexPath)
        guard let vcell = cell as? T else { fatalError() }
        return vcell
    }

    func dequeueHeader<T>(_ header: T.Type, indexPath: IndexPath) -> T where T: UICollectionReusableView {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header.className, for: indexPath) as! T
    }
    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                                 for indexPath: IndexPath,
                                                                 ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as! T
    }
    func dequeueFooter<T>(_ footer: T.Type, indexPath: IndexPath) -> T where T: UICollectionReusableView {
        let view = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: footer.self), for: indexPath)
        guard let _view = view as? T else { fatalError("FOOTER VIEW NOT FOUND") }
        return _view
    }
    
}
