//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Guilherme Wahlbrink on 2019-05-22.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit


class ToDoCell: UITableViewCell {

    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: ToDoCellDelegate?
    
    @IBAction func completeButtonTapped() {
        delegate?.checkmarkTapped(sender: self)
    }

}
