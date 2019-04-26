//
//  ViewController.swift
//  WeatherTabBar
//
//  Created by Guilherme Wahlbrink on 2019-04-24.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var city: City!
    
    // blueStackView
    let labelsStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 10
        return sv
    }()
    
    
    /*
     lazy var labelsStackView: UIStackView = {
     let sv = UIStackView()
     sv.translatesAutoresizingMaskIntoConstraints = false
     sv.axis = .vertical
     sv.distribution = .equalSpacing
     sv.alignment = .center
     sv.spacing = 10
     return sv
     }()
 
     */
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(labelsStackView)
        
        
        //ask question as I had a lot of problems on acessing the city, also open the code for Assignment 1 Started to ask
        labelsStackView.addArrangedSubview(DetailViewController.createUILabel(fontSize: 25,value: city.name))
        labelsStackView.addArrangedSubview(DetailViewController.createUILabel(fontSize: 15,value: "Temperature: "+String(city.temp)))
        labelsStackView.addArrangedSubview(DetailViewController.createUILabel(fontSize: 15,value: city.summary))
        
        NSLayoutConstraint.activate([
            labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate static func createUILabel(fontSize: CGFloat,value: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = value
        label.font = label.font.withSize(fontSize)
        return label
    }
}

