//
//  FirstTableViewController.swift
//  TableViewDemo1
//
//  Created by Derrick Park on 2019-04-26.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
/**
 UITableViewController, UICollectionViewController
 - Data source: how many rows / sections? , what kind of cell you will display?
 - Delegate: actions / behaviors (what should I do when I select a cell?...)
 */
class FirstTableViewController: UITableViewController {
  
  var names: [String] = [
    "Derrick", "Tom", "Gui", "Kazuya", "Juan", "Hao-tse", "Paulo",
    "Scott", "Ayana", "Shota", "Masa", "Enrique", "Mihail", "Ozan",
    "Daisuke", "Danilo"
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    /// Accessing your navigationBar
    // navigationController?.navigationBars
    /// Create your own custom UIBarButtonItem
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    
    /// Default editButtonItem
//    navigationItem.rightBarButtonItem = editButtonItem
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    if editing {
      print("I am currently editing my friends list")
    } else {
      print("Done!")
    }
  }
  
  // MARK: - DataSource protocol methods

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return names.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NameCell
    cell.nameCell?.text = names[indexPath.row]
    return cell
  }
  
  // MARK: - Delegate protocol methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Position at \(indexPath.row)")
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
      case .insert:
        
        print(".insert")
      case .delete:
        /// DataSource -> names
        /// 1. remove the friend from the names list.
        /// 2. refresh the tableView
        names.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        print(".delete")
      case .none:
        print(".none")
      default:
        break
    }
  }
  
  @objc func addFriend() {
    names.append("Justin Bieber")
    tableView.insertRows(at: [IndexPath(row: names.count - 1, section: 0)], with: .automatic)
  }
}
