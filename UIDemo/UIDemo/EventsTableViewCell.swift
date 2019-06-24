//
//  EventsTableViewCell.swift
//  UIDemo
//
//  Created by Guilherme Wahlbrink on 2019-06-20.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {


    let eventDescription: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .blue
    
        return lb
    }()
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // overrided manually this init to place my priperties
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        // init your properties
        addSubview(eventDescription)
        eventDescription.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        eventDescription.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
