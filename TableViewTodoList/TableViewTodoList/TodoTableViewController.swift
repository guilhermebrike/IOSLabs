//
//  ViewController.swift
//  TodoListTableViewProgramatically
//
//  Created by Guilherme Wahlbrink on 2019-05-02.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

// delegate, and datasource automatically conformed if its a subclass of UITABLEVIEWCONTROLLER
// we have the -tableview (var)
class TodoTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var data: Dictionary<String,[String]> = [
        "Low Priority": [],
        "Medium Priority": [],
        "High Prioritay" : []
    ]
    
    private var todos: [String] = [String]()
    
    // MARK: - Constants
    
    private let cellId = "todoCell"
    private let headerId = "headerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(TodoTableViewHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        // editButtonItem comes with isEditing: Bool
        navigationItem.leftBarButtonItem = editButtonItem
        
        //adding a button to the navigation controller through navigationItem in the right side
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    @objc func addTodo() {
        
        // 1 go to add todo view controller
        let addTodoVC = AddTodoViewController()
        addTodoVC.delegate = self
        navigationController?.pushViewController(addTodoVC, animated: true)
    }
    
    
    
    // MARK: - tableview data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // how many rows? to display in a section
        let sectionCount = Array(data.keys)[section]
        return data[sectionCount]!.count
    }
    
    // MARK: - code for each Cell in the table view
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // what do do for each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoTableViewCell
        
        let sectionString = Array(data.keys)[indexPath.section]
        cell.todoItem.text = data[sectionString]![indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionString = Array(data.keys)[section]
        return sectionString
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
}

// MARK: - Table view

extension TodoTableViewController {
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // not working
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            break
        case .delete: // delete an Item
            let key = Array(data.keys)[indexPath.section] // key that represents the section
            let array = data[key]! // array of values in the key
            //let value = array[indexPath.row] // the value i wish to delete
            data[key]?.remove(at: indexPath.row)
            
            tableView.reloadData()
            break
        default: break
        }
    }
    
    //let key = Array(yourDictionary.keys)[indexPath.section]
    //let array = yourDictionary[key]
    //let value = array[indexPath.row]
}

extension TodoTableViewController: AddTodoViewControllerDelegate {
    
    func addTodoDidCancel() {
        
    }
    
    func addTodoDidFinish(itemTodo: String) {
        //todos.append(itemTodo)
        data["Low Priority"]?.append(itemTodo)
        tableView.reloadData() // refresh!
    }
}
