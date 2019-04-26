//
//  ViewController.swift
//  Assignment1Starter
//
//  Created by Guilherme Wahlbrink on 2019-04-17.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mainView: UIView = GreenView()
    
    
    //create 3 buttons in stack view
//    let squareButt: UIButton = {
//        let butt = UIButton(type: .system)
//        butt.setTitle("Square", for: .normal)
//        butt.translatesAutoresizingMaskIntoConstraints = false
//        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        butt.addTarget(self, action: #selector(squareTapped), for: .touchUpInside)
//        return butt
//    }()
//
//    let portraitButt: UIButton = {
//        let butt = UIButton(type: .system)
//        butt.setTitle("Portrait", for: .normal)
//        butt.translatesAutoresizingMaskIntoConstraints = false
//        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        butt.addTarget(self, action: #selector(portraitTapped), for: .touchUpInside)
//        return butt
//    }()
//
//    let landscapeButt: UIButton = {
//        let butt = UIButton(type: .system)
//        butt.setTitle("Landscape", for: .normal)
//        butt.translatesAutoresizingMaskIntoConstraints = false
//        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        butt.addTarget(self, action: #selector(landscapeTapped), for: .touchUpInside)
//        return butt
//    }()
    
    
    var activeConstraints: [NSLayoutConstraint] = [] {
        willSet {
            NSLayoutConstraint.deactivate(activeConstraints)
        }
        didSet {
            NSLayoutConstraint.activate(activeConstraints)
        }
    }
    
    fileprivate func setupLayout() {
        view.addSubview(mainView)
        //set constraints for the mainView (x, y, w, h)
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        activeConstraints = [
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ]
        
        //3. create a stackview for Buttons
        let buttStackView = UIStackView(arrangedSubviews: [
            createButton(title: "Square", fontSize: 14, selector: Selector(("squareTapped"))),
            createButton(title: "Portrait", fontSize: 14, selector: Selector(("portraitTapped"))),
            createButton(title: "Landscape", fontSize: 14, selector: Selector(("landscapeTapped")))])
        buttStackView.translatesAutoresizingMaskIntoConstraints = false
        buttStackView.axis = .horizontal
        buttStackView.alignment = .center
        buttStackView.distribution = .fillEqually
        
        view.addSubview(buttStackView)
        
        NSLayoutConstraint.activate([
            buttStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            buttStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
    
    fileprivate func createButton(title: String, fontSize: CGFloat, selector: Selector) -> UIButton {
        let butt = UIButton(type: .system)
        butt.setTitle(title, for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        butt.addTarget(self, action: selector, for: .touchUpInside)
        return butt
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        view.backgroundColor = .white
        setupLayout()
        
    }
    
    @objc private func squareTapped() {
        // 5. animate mainView (Square)
        //  - change width, height constraint (w: 70% w, h: 80% w)
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2.0) {
            // what do you want to animate
            
            self.activeConstraints = [
                self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
                self.mainView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
            ]
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func portraitTapped() {
        // 5. animate mainView (portrait)
        //  - change width, height constraint (w: 70% w, h: 80% h)
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2.0) {
            //change the properties
            self.activeConstraints = [
                self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
                self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
            ]
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func landscapeTapped() {
        // 5. animate mainView (landscape)
        //  - change width, height constraint (w: 95% w, h: 40% h)
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2.0) {
            //change the properties
            
            self.activeConstraints = [
                self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.94),
                self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
            ]

            self.view.layoutIfNeeded()
        }
    }
    
}
