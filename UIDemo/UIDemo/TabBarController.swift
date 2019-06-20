//
//  TabBarController.swift
//  UIDemo
//
//  Created by Guilherme Wahlbrink on 2019-06-19.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainViewController = MainViewController()
        mainViewController.view.backgroundColor = .blue
        mainViewController.tabBarItem.title = "Home"
        mainViewController.tabBarItem.image = UIImage(named: "home")
        
        
        
        
        let eventViewController = UINavigationController(rootViewController: EventsTableViewController())
        eventViewController.view.backgroundColor = .red
        eventViewController.tabBarItem.title = "Events"
        eventViewController.tabBarItem.image = UIImage(named: "event")
        

        
        let flowLayout = UICollectionViewFlowLayout()
        let gamesCollectionViewController = GamesCollectionViewController(collectionViewLayout: flowLayout)
        gamesCollectionViewController.collectionView.backgroundColor = .green
        gamesCollectionViewController.tabBarItem.title = "Games"
        gamesCollectionViewController.tabBarItem.image = UIImage(named: "roullete")
        

        viewControllers = [
            mainViewController,
            eventViewController,
            gamesCollectionViewController
        ]
    }

}
