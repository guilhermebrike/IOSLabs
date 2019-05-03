//
//  MainViewController.swift
//  ToDoListTableView
//
//  Created by Guilherme Wahlbrink on 2019-05-02.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    

    var listTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(listTableView)
        view.backgroundColor = .red
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        listTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        listTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
    }

}
