//
//  GamesCollectionViewController.swift
//  UIDemo
//
//  Created by Guilherme Wahlbrink on 2019-06-19.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GamesCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    let names = ["Roullete","BlackJack","Poker"]
    let images = ["roulleteCardImage","roulleteCardImage","roulleteCardImage"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GameCollectionViewCell
        
        cell.categoryLabel.text = names[indexPath.item]
        cell.backgroundImageView.image = UIImage(named: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.1, height: 100) // using this to try to put side by side
    }
    

}
