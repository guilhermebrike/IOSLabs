//
//  SearchViewController.swift
//  AppStore
//
//  Created by Guilherme Wahlbrink on 2019-04-25.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellid = "resultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: cellid)
        
        fetchSearchResultApps()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 350)
    }
    
    // TODO DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! SearchCollectionViewCell
        return cell
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init (coder) has not been implemented")
    }
    
    fileprivate func fetchSearchResultApps() {
        // Get Request
        // 1. URL
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        
        guard let url = URL(string: urlString) else { return }
        
        //2. send a request
        
        
        // the Data?, URLResponse?,Error? is a Closure, search about that later
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                print("Failed to fetch apps: ", err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                // 3. parse response
                let searchResult = try JSONDecoder().decode(SearchResultApps.self, from: data)
                searchResult.results.forEach({ (result) in
                    print(result.trackName, result.primaryGenreName)
                })
            }catch let jsonError {
                print("Failed to decode JSON:", jsonError)
            }
            

        }.resume() // sends the request
        
        

    }
    
}
