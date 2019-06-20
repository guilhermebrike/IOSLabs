//
//  GameCollectionViewCell.swift
//  UIDemo
//
//  Created by Guilherme Wahlbrink on 2019-06-19.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    
    let categoryLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor(white: 0.5, alpha: 0.7)
        return lb
    }()
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: - initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.addSubview(backgroundImageView)
        backgroundImageView.matchParent()
        
        let labelStackView = UIStackView(arrangedSubviews: [
            categoryLabel,
            ])
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalSpacing
        
        backgroundImageView.addSubview(labelStackView)
        
    }
    
    required init?(coder aDecodrer: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


