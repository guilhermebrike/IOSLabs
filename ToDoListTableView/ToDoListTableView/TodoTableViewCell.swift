//
//  TodoTableViewCell.swift
//  TodoListTableViewProgramatically
//
//  Created by Guilherme Wahlbrink on 2019-05-02.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    
    let todoItem: UILabel = UILabel(title: "", color: .blue, fontSize: 20, bold: true)
    //    let todoItem: UILabel = {
    //        let lb = UILabel()
    //        lb.translatesAutoresizingMaskIntoConstraints = false
    //        lb.font = UIFont.boldSystemFont(ofSize: 20)
    //        lb.textColor = .blue
    //
    //        return lb
    //    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //passing false, we do not highligh a cell
        super.setSelected(selected, animated: animated)
        
    }
    
    // overrided manually this init to place my priperties
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        // init your properties
        addSubview(todoItem)
        todoItem.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        todoItem.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
