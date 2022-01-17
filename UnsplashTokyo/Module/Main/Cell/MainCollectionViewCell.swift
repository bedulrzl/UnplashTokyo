//
//  MainCollectionViewCell.swift
//  UnsplashTokyo
//
//  Created by Netzme on 15/01/22.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func bind(photo: Photo) {
        labelName.text = photo.user?.name
        labelDescription.text = photo.photoDescription
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        if let urls = URL(string: photo.urls?.regular ?? "") {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: urls,
                placeholder: nil,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]) { result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        self.imageView.image = UIImage(named: "placeholder")
                    }
                }
        }
    }
}
