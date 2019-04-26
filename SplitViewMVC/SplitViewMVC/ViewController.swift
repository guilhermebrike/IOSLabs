//
//  ViewController.swift
//  SplitViewMVC
//
//  Created by Guilherme Wahlbrink on 2019-04-24.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        // make it open the correct page
        return true
    }


}

