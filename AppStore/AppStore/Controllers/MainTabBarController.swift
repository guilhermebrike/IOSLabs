//
//  MainTabBarController.swift
//  AppStore
//
//  Created by Thong Hoang Nguyen on 2019-04-25.
//  Copyright © 2019 Thong Hoang Nguyen. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createViewController(viewController: SearchViewController(), title: "Search", imageName: "search"),
            createViewController(viewController: UIViewController(), title: "Today", imageName: "today"),
            createViewController(viewController: UIViewController(), title: "Games", imageName: "games"),
            createViewController(viewController: UIViewController(), title: "Apps", imageName: "apps")
        ]
    }
    fileprivate func createViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        viewController.view.backgroundColor = .white
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: imageName)
        return navigationController
    }
}
