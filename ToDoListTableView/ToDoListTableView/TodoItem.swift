//
//  TodoItem.swift
//  TableViewTodoList
//
//  Created by Guilherme Wahlbrink on 2019-05-03.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import Foundation


class TodoItem {
    var activity: String
    var deadline: String
    var priority: String
    var stripped: Bool
    
    init(activity: String, deadline: String, priority: String) {
        self.activity = activity
        self.deadline = deadline
        self.priority = priority
        self.stripped = false
    }
}
