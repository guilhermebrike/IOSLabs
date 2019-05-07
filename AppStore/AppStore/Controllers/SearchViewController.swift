//
//  SearchViewController.swift
//  AppStore
//
//  Created by Thong Hoang Nguyen on 2019-04-25.
//  Copyright © 2019 Thong Hoang Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
  
  private let cellID = "resultCell"
  private var searchResults = [ResultApp]()
  fileprivate let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    collectionView.backgroundColor = .white
    setupSearchBar()
  }
  
  fileprivate func setupSearchBar() {
    definesPresentationContext = true
    navigationItem.searchController = self.searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.searchBar.delegate = self
  }
  
  var timer: Timer?
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // everytime user inputs something -> this delegate method gets called.
    // search throttling
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
      NetworkService.shared.fetchSearchResultApps(searchTerm: searchText) { (results, err) in
        self.searchResults = results
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    })
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 340 )
  }
  
  // MARK: - Data Source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.searchResults.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchCollectionViewCell
    
    cell.resultApp = searchResults[indexPath.item]
    
    return cell
  }
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
