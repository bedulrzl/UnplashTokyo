//
//  DetailViewController.swift
//  UnsplashTokyo
//
//  Created by Netzme on 17/01/22.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photo: Photo?
    
    convenience init() {
        self.init(photos: nil)
    }
    
    init(photos: Photo?) {
        super.init(nibName: nil, bundle: nil)
        photo = photos
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        scrollView.delegate = self
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
    }
    
    func setupUI() {
        let processor = DownsamplingImageProcessor(size: detailImage.bounds.size)
        if let urls = URL(string: photo?.urls?.regular ?? "") {
            detailImage.kf.indicatorType = .activity
            detailImage.kf.setImage(
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
                        self.detailImage.image = UIImage(named: "placeholder")
                    }
                }
        }
    }

}

extension DetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailImage
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = detailImage.image {
                let ratioW = detailImage.frame.width / image.size.width
                let ratioH = detailImage.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                
                let conditionLeft = newWidth*scrollView.zoomScale > detailImage.frame.width
                
                let left = 0.5 * (conditionLeft ? newWidth - detailImage.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                
                let confitionTop = newHeight*scrollView.zoomScale > detailImage.frame.height
                
                let top = 0.5 * (confitionTop ? newHeight - detailImage.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
