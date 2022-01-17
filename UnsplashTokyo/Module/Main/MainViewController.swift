//
//  MainViewController.swift
//  UnsplashTokyo
//
//  Created by Netzme on 14/01/22.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var coordinator : AppCoordinator?
    var viewModel: MainViewModel?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    func setupUI() {
        collectionView.registerCell(MainCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Photo"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
     
    }
    
    func bindViewModel(){
        viewModel?.bindPhotos = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        self.viewModel?.fetchPhoto()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(MainCollectionViewCell.self.self, indexPath: indexPath)
        if let photo = viewModel?.photos[indexPath.row] {
            cell.bind(photo: photo)
        }
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !(viewModel?.isLoading ?? false), distance < 20 {
            viewModel?.fetchPhoto(query: searchController.searchBar.text)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.processShowDetail(indexpath: indexPath)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }
}

extension MainViewController: UISearchResultsUpdating, UISearchControllerDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nil")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.viewModel?.isSearch = true
            self.viewModel?.PagePhoto = 1
            self.viewModel?.fetchPhoto(query: query)
        }
        
    }
    
    //MARK : when search close reload fetch listphoto
    func didDismissSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.viewModel?.isSearch = false
            self.viewModel?.PagePhoto = 1
            self.viewModel?.photos.removeAll()
            self.viewModel?.fetchPhoto()
        }
    }
}
