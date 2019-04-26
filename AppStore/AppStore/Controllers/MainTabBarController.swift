//
//  MainTabBarController.swift
//  AppStore
//
//  Created by Guilherme Wahlbrink on 2019-04-25.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createViewController(viewController: UIViewController(), title: "Today", imageName: "today"),
            createViewController(viewController: UIViewController(), title: "Games", imageName: "games"),
            createViewController(viewController: UIViewController(), title: "Apps", imageName: "apps"),
            createViewController(viewController: SearchViewController(), title: "Search", imageName: "search"),
        ]
    }
    
    
    
    // function that will return a navigation bar that contains a viewController
    fileprivate func createViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        // embedded inside a navigation controller
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.tabBarItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
        
    }

}
