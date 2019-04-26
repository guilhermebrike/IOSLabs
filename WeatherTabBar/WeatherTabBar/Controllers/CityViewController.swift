//
//  CityViewController.swift
//  WeatherTabBar
//
//  Created by Guilherme Wahlbrink on 2019-04-24.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
    
    
    // button to go to details
    let goDetailsButt: UIButton = {
        let butt = UIButton(type: .system)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("Go see details...", for: .normal)
        butt.backgroundColor = UIColor.darkGray
        butt.layer.cornerRadius = 10.0
        butt.addTarget(self, action: #selector(showDetailVC), for: .touchUpInside)
        return butt
    }()
    
    @objc private func showDetailVC() {
        let detailVC = DetailViewController()
        detailVC.city = city
        detailVC.view.backgroundColor = .cyan
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // depedency injection
    // you have to initialize all properties
    var city: City! {
        didSet {
            tabBarItem = UITabBarItem(title: city.name, image: UIImage(named: city.icon), selectedImage: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = city.name
        view.addSubview(goDetailsButt)
        
        NSLayoutConstraint.activate([
            goDetailsButt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goDetailsButt.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
}
