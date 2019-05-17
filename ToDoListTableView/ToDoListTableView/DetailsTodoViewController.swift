//
//  DetailsTodoViewController.swift
//  TableViewTodoList
//
//  Created by Guilherme Wahlbrink on 2019-05-03.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class DetailsTodoViewController: UIViewController {

    var todoItem: TodoItem!
    
    
    lazy var labelsStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 10
        return sv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(labelsStackView)
        
        if todoItem.isCompleted == true {
            labelsStackView.addArrangedSubview(DetailsTodoViewController.createUILabel(fontSize: 25,value: "(DONE) "+todoItem.title!))
            
        } else {
            labelsStackView.addArrangedSubview(DetailsTodoViewController.createUILabel(fontSize: 25,value: todoItem.title!))
        }
        //ask question as I had a lot of problems on acessing the city, also open the code for Assignment 1 Started to ask
        labelsStackView.addArrangedSubview(DetailsTodoViewController.createUILabel(fontSize: 25,value: todoItem.deadline!))
        labelsStackView.addArrangedSubview(DetailsTodoViewController.createUILabel(fontSize: 25,value: todoItem.priorityNumber!))
        
        NSLayoutConstraint.activate([
            labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
    
    fileprivate static func createUILabel(fontSize: CGFloat,value: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = value
        label.font = label.font.withSize(fontSize)
        return label
    }

}
