//
//  AddEventViewController.swift
//  UIDemo
//
//  Created by Guilherme Wahlbrink on 2019-06-20.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit
import CoreData
protocol AddEventViewControllerDelegate: class {
    //func addTodoDidCancel()
    func addEventDidFinish(event: Event)
    //func editTodoDidFinish(todoItem: TodoItem)
}



class AddEventViewController: UIViewController {
    
    weak var delegate: AddEventViewControllerDelegate?

    let todoTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter here..."
        return tf
    }()
    
    let todoDescTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter Desc here..."
        return tf
    }()
    
    let deadLineTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Click to set the Deadline..."
        return tf
    }()
    
    let priorityTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Write Down the priority..."
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = UIStackView(arrangedSubviews: [todoTextField,todoDescTextField,deadLineTextField,priorityTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        view.addSubview(stackView)
        // constraints
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true

        view.backgroundColor = .orange
        
        
        navigationItem.title = "Add Todo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
    }
    
    
    @objc fileprivate func doneClicked() { // clicked done
        
        // delegate! -> callback
        
        // database manager
        
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
            
        guard let todoText = todoTextField.text else { return }
//        guard let descriptionText = todoDescTextField.text else { return }
//        guard let deadlineText = deadLineTextField.text else { return }
//        guard let priorityText = priorityTextField.text else { return }
        
        let newEvent = NSEntityDescription.insertNewObject(forEntityName: "Event", into: managedContext)
        newEvent.setValue(todoText, forKey: "name")
//            newTodoItem.setValue(descriptionText, forKey: "title")
//            newTodoItem.setValue(deadlineText, forKey: "deadline")
//            newTodoItem.setValue(priorityText, forKey: "priorityNumber")
//            newTodoItem.setValue(false, forKey: "isCompleted")
        CoreDataManager.shared.saveContext()
        delegate?.addEventDidFinish(event: newEvent as! Event)
        navigationController?.popViewController(animated: true)
    }

}
