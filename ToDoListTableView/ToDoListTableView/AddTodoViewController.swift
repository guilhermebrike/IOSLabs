//
//  AddTodoViewController.swift
//  TodoListTableViewProgramatically
//
//  Created by Guilherme Wahlbrink on 2019-05-02.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit
import CoreData
protocol AddTodoViewControllerDelegate: class {
    func addTodoDidCancel()
    func addTodoDidFinish(todoItem: TodoItem)
    func editTodoDidFinish(todoItem: TodoItem)
}


class AddTodoViewController: UIViewController {
    
    
    weak var delegate: AddTodoViewControllerDelegate?
    
    // label
    
    var todoItem: TodoItem? {
        didSet {
            todoTextField.text = todoItem?.title
            todoDescTextField.text = todoItem?.todoDescription
            deadLineTextField.text = todoItem?.deadline
            priorityTextField.text = todoItem?.priorityNumber
        }
    }
    
    let descLabel: UILabel = UILabel(title: "What do you have to do?", color: .black, fontSize: 20, bold: true)
    //    let descLabel: UILabel = {
    //        let lb = UILabel()
    //        lb.translatesAutoresizingMaskIntoConstraints = false
    //        lb.text = "What do you have to do?"
    //        lb.font = UIFont.boldSystemFont(ofSize: 20)
    //        lb.textColor = .black
    //        return lb
    //    }()
    
    // textfield
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
    
    let pickDatePickerView: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        return dp
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        navigationItem.title = "Add Todo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didAddTodo))
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc fileprivate func didAddTodo() { // clicked done
        
        // delegate! -> callback
        
        // database manager
        
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        if todoItem == nil { // insert
        
            guard let todoText = todoTextField.text else { return }
            guard let descriptionText = todoDescTextField.text else { return }
            guard let deadlineText = deadLineTextField.text else { return }
            guard let priorityText = priorityTextField.text else { return }
            
            let newTodoItem = NSEntityDescription.insertNewObject(forEntityName: "TodoItem", into: managedContext)
            newTodoItem.setValue(todoText, forKey: "title")
            newTodoItem.setValue(descriptionText, forKey: "title")
            newTodoItem.setValue(deadlineText, forKey: "deadline")
            newTodoItem.setValue(priorityText, forKey: "priorityNumber")
            newTodoItem.setValue(false, forKey: "isCompleted")
            CoreDataManager.shared.saveContext()
            delegate?.addTodoDidFinish(todoItem: newTodoItem as! TodoItem)
            navigationController?.popViewController(animated: true)

        }else {
            
            todoItem?.title = todoTextField.text
            todoItem?.todoDescription = todoDescTextField.text
            todoItem?.deadline = deadLineTextField.text
            todoItem?.priorityNumber = priorityTextField.text
            CoreDataManager.shared.saveContext()
            self.delegate?.editTodoDidFinish(todoItem: self.todoItem!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func setupUI() {
        
        let stackView = UIStackView(arrangedSubviews: [descLabel,todoTextField,todoDescTextField,deadLineTextField,priorityTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        deadLineTextField.inputView = pickDatePickerView
        
        view.addSubview(stackView)
        
        // constraints
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        // no need to set the bottom
    }

    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour, let minute = components.minute {
            deadLineTextField.text = "\(day)/\(month)/\(year) at \(hour):\(minute)"
        }
    }
}


extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
