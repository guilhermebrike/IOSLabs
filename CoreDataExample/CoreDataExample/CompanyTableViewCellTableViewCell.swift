//
//  CompanyTableViewCellTableViewCell.swift
//  CoreDataExample
//
//  Created by Guilherme Wahlbrink on 2019-05-16.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class CompanyTableViewCellTableViewCell: UITableViewCell {
    
    var company: Company! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            if let name = company.name, let applied = company.founded {
                companyLabel.text = "\(name)"
                foundedDateLabel.text = "Founded: \(dateFormatter.string(from: applied))"
            }
            if let imageData = company.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    let companyImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "placeholder"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.spaceGray.cgColor
        iv.layer.borderWidth = 5
        return iv
    }()
    
    let companyLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Company Name"
        lb.font = .boldSystemFont(ofSize: 18)
        lb.textColor = .white
        
        return lb
    }()
    
    let foundedDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "May 16, 2019"
        lb.font = UIFont.italicSystemFont(ofSize: 14)
        lb.textColor = .white
        
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        addSubview(companyImageView)
        companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let vStackView = UIStackView(arrangedSubviews: [companyLabel, foundedDateLabel])
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        vStackView.spacing = 5
        
        addSubview(vStackView)
        vStackView.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 10).isActive = true
        vStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
