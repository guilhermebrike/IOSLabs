//
//  AddTodoViewController.swift
//  TodoListTableViewProgramatically
//
//  Created by Guilherme Wahlbrink on 2019-05-02.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

protocol AddTodoViewControllerDelegate: class {
    func addTodoDidCancel()
    func addTodoDidFinish(itemTodo: String)
}


class AddTodoViewController: UIViewController {
    
    
    weak var delegate: AddTodoViewControllerDelegate?
    
    // label
    
    let descLabel: UILabel = UILabel(title: "What do you have to do? 😃", color: .black, fontSize: 20, bold: true)
    //    let descLabel: UILabel = {
    //        let lb = UILabel()
    //        lb.translatesAutoresizingMaskIntoConstraints = false
    //        lb.text = "What do you have to do? 😃"
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        navigationItem.title = "Add Todo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didAddTodo))
    }
    
    @objc fileprivate func didAddTodo() {
        // delegate! -> callback
        if let todoText = todoTextField.text {
            delegate?.addTodoDidFinish(itemTodo: todoText)
            navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [descLabel,todoTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        
        view.addSubview(stackView)
        
        // constraints
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        // no need to set the bottom
    }
    
}
