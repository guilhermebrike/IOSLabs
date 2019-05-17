//
//  UIView+initializers.swift
//  TodoListTableViewProgramatically
//
//  Created by Guilherme Wahlbrink on 2019-05-02.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(title: String, color: UIColor, fontSize: CGFloat, bold: Bool = false) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        text = title
        textColor = color
        if bold {
            font = UIFont.boldSystemFont(ofSize: fontSize)
        } else {
            font = UIFont.init(descriptor: .init(), size: fontSize)
        }
    }
}
