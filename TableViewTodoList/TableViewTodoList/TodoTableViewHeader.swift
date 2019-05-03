//
//  TodoTableViewHeader.swift
//  TableViewTodoList
//
//  Created by Guilherme Wahlbrink on 2019-05-03.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class TodoTableViewHeader: UITableViewHeaderFooterView {

    let todoHeaderLow: UILabel = UILabel(title: "Low", color: .blue, fontSize: 20, bold: true)
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(todoHeaderLow)
        todoHeaderLow.translatesAutoresizingMaskIntoConstraints = false
        todoHeaderLow.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        todoHeaderLow.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
