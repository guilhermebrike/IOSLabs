//
//  GreenView.swift
//  Assignment1Starter
//
//  Created by Guilherme Wahlbrink on 2019-04-18.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class GreenView: UIView {

    // purpleView
    let purpleView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .purple
        return v
    }()
    
    // blueStackView
    let blueStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [UIView(), createBlueView(),createBlueView(),createBlueView(),UIView()])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        return sv
    }()
    
    // redView
    let redView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        
        // creating the orange view
        let orangeView1 = UIView(frame: CGRect(x: 10, y: 10, width: 140, height: 60))
        orangeView1.backgroundColor = .orange
        
        // creating the orange view
        let orangeView2 = UIView(frame: CGRect(x: 160, y: 10, width: 90, height: 60))
        orangeView2.backgroundColor = .orange
        
        v.addSubview(orangeView1)
        v.addSubview(orangeView2)
        
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .green
        setupPurpleView()
        setupBlueStackView()
        setupRedView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupPurpleView() {
        addSubview(purpleView)
        NSLayoutConstraint.activate([
            purpleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            purpleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            purpleView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            purpleView.heightAnchor.constraint(equalToConstant: 80)
            ])
    }
    
    fileprivate func setupBlueStackView() {
        addSubview(blueStackView)
        NSLayoutConstraint.activate([
            blueStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            blueStackView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
    }
    
    fileprivate func setupRedView() {
        addSubview(redView)
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            redView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ])
        redView.anchorSize(width: 260, height: 80)
    }
    
    fileprivate static func createBlueView() -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .blue
        v.anchorSize(width: 80, height: 80)
        return v
    }
    
}

extension UIView {
    func anchorSize(width: CGFloat, height: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
