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
    
    private var todos: [String] = [String]()
    
    // MARK: - Constants
    
    private let cellId = "todoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
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
        // how many rows? to display
        return todos.count
    }
    
    // MARK: - code for each Cell in the table view
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // what do do for each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoTableViewCell
        cell.todoItem.text = "TODO \(indexPath.row)"
        return cell
    }
    
    
    
}

// MARK: - Table vie

extension TodoTableViewController {
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 1. editButton
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            break
        case .delete:
            break
        default: break
        }
    }
    
}

extension TodoTableViewController: AddTodoViewControllerDelegate {
    
    func addTodoDidCancel() {
        
    }
    
    func addTodoDidFinish(itemTodo: String) {
        todos.append(itemTodo)
        tableView.reloadData() // refresh!
    }
}
