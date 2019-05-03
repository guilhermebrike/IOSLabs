//
//  ManualViewController.swift
//  TableViewDemo1
//
//  Created by Derrick Park on 2019-04-26.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "manual", for: indexPath)
    cell.textLabel?.text = "Hello"
    return cell
  }
  
  
}
