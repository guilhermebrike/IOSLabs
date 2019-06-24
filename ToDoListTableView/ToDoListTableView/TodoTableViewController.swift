//
//  ViewController.swift
//  TodoListTableViewProgramatically
//
//  Created by Guilherme Wahlbrink on 2019-05-02.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit
import CoreData
// delegate, and datasource automatically conformed if its a subclass of UITABLEVIEWCONTROLLER
// we have the -tableview (var)
class TodoTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var data: Dictionary<String,[TodoItem]> = [
        "Low Priority": [],
        "Medium Priority": [],
        "High Priority" : []
    ]
    
    private var todos: [String] = [String]()
    
    // MARK: - Constants
    
    
    private let cellId = "todoCell"
    private let headerId = "headerCell"
    
    /// DAMN I NEED TO PUT LAZY BECAUSE THE PROPERTIES DOES NOT START
    lazy var trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteFunction))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(TodoTableViewHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        // editButtonItem comes with isEditing: Bool
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.title = "Select"
        //adding a button to the navigation controller through navigationItem in the right side
        trashButton.isEnabled = false
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo)),trashButton]
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        fetchTodoItems()
    }
    
    
    private func fetchTodoItems() {
        
        // NSManagedObjectContext: scratch pad
        // - viewContext:  ManagedObjectContext(main thread)
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TodoItem>(entityName: "TodoItem")
        
        do {
            let items = try managedContext.fetch(fetchRequest)
            items.forEach { (item) in
                var keyPriority: String = String()
                switch item.priorityNumber! {
                case "1":
                    keyPriority = "High Priority"
                case "2":
                    keyPriority = "Medium Priority"
                case "3":
                    keyPriority = "Low Priority"
                default:
                    keyPriority = ""
                }
                data[keyPriority]?.append(item)
            }
        } catch let err {
            print("Failed to fetch items: \(err)")
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            //1. remove from the tableview
            
            let key = Array(self.data.keys)[indexPath.section]
            let todoItem = self.data[key]?.remove(at: indexPath.row) // first remove from the model
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            //2. remove from the database
            CoreDataManager.shared.persistentContainer.viewContext.delete(todoItem!)
            CoreDataManager.shared.saveContext()
        }
        // edit action
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // 1. navigate(modal) to AddCompnayViewController
            let editVC = AddTodoViewController()
            editVC.delegate = self
            let key = Array(self.data.keys)[indexPath.section]
            let todoItem = self.data[key]?[indexPath.row]
            editVC.todoItem = todoItem
            self.navigationController?.pushViewController(editVC, animated: true)
            // modal transition
        }
        return [deleteAction,editAction]
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        if editing {
            trashButton.isEnabled = true
        } else {
            trashButton.isEnabled = false
        }
    }
    
    @objc func deleteFunction() {
        
        if let selectedRows = tableView.indexPathsForSelectedRows {
            for indexPath in selectedRows  {
                let key = Array(data.keys)[indexPath.section]
                data[key]?.remove(at: indexPath.row)
            }
              tableView.reloadData()
        }
        
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
        cell.todoItem.text = data[sectionString]![indexPath.row].title
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionString = Array(data.keys)[section]
        return sectionString
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let detailVC = DetailsTodoViewController()
        let key = Array(data.keys)[indexPath.section]
        detailVC.todoItem = data[key]?[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Table view

extension TodoTableViewController {
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
        // example
        //let movedObject = self.headlines[sourceIndexPath.row]
        //headlines.remove(at: sourceIndexPath.row)
        //headlines.insert(movedObject, at: destinationIndexPath.row)
        
        let keyOfSourceItemMoved = Array(data.keys)[sourceIndexPath.section] // got the key item moved
        
        let valueOfItemMoved = data[keyOfSourceItemMoved]?.remove(at: sourceIndexPath.row)
        
        let keyOfDestinationItemMoved = Array(data.keys)[destinationIndexPath.section] // key of destination item moved
        
        data[keyOfDestinationItemMoved]?.insert(valueOfItemMoved!, at: destinationIndexPath.row)
        
        data[keyOfDestinationItemMoved]?[destinationIndexPath.row].priorityNumber = keyOfDestinationItemMoved
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            break
        case .delete: // delete an Item
            let key = Array(data.keys)[indexPath.section] // key that represents the section
            //let array = data[key]! // array of values in the key
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
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Done", handler: {(ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let cell = tableView.cellForRow(at: indexPath) as! TodoTableViewCell
            //self.setTextForCell(cell, self.taskArray, indexPath, isStrikethrough: true)
            let attribute = NSMutableAttributedString(string: cell.todoItem.text!)
            attribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, cell.todoItem.text!.count))
            cell.todoItem.attributedText = attribute
            
            let key = Array(self.data.keys)[indexPath.section]
            self.data[key]?[indexPath.row].isCompleted = true
            success(true)
        })
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
}

extension TodoTableViewController: AddTodoViewControllerDelegate {
    
    func addTodoDidCancel() {
        
    }
    
    func editTodoDidFinish(todoItem: TodoItem) {
        
        var keyPriority: String = String()
        switch todoItem.priorityNumber! {
        case "1":
            keyPriority = "High Priority"
        case "2":
            keyPriority = "Medium Priority"
        case "3":
            keyPriority = "Low Priority"
        default:
            keyPriority = ""
        }
        
        let row = data[keyPriority]?.firstIndex(of: todoItem)!
        
        let section = getKeyPos(keyToFind: keyPriority)
        
        
        let myIndexPath = IndexPath(row: row!, section: section)
        tableView.reloadRows(at: [myIndexPath], with: .middle)
    }
    
    
    func getKeyPos(keyToFind: String) -> Int{
        var pos = 0
        for (key, value) in data {
            if key == keyToFind {
                return pos
            }
            pos += 1
        }
        
        return -1
    }
    
    func addTodoDidFinish(todoItem: TodoItem) {
        
        var keyPriority: String = String()
        switch todoItem.priorityNumber! {
        case "1":
            keyPriority = "High Priority"
        case "2":
            keyPriority = "Medium Priority"
        case "3":
            keyPriority = "Low Priority"
        default:
            keyPriority = ""
        }
        
        data[keyPriority]?.append(todoItem)
        tableView.reloadData() // refresh!
        
    } 
}

