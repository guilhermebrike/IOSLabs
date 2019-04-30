//
//  CalculatorViewController.swift
//  TipCalculator
//
//  Created by Guilherme Wahlbrink on 2019-04-30.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    let billAmountTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .blue
        tf.widthAnchor.constraint(equalToConstant: 64).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 64).isActive = true
        tf.text = "bill"
        return tf
    }()
    
    let percentageAmountTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .blue
        tf.widthAnchor.constraint(equalToConstant: 64).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 64).isActive = true
        tf.text = "%"
        return tf
    }()
    
    let calculateTipButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("Calculate Tip", for: .normal)
        butt.backgroundColor = UIColor.darkGray
        butt.layer.cornerRadius = 10.0
        butt.addTarget(self, action: #selector(calculateTip), for: .touchUpInside)
        return butt
    }()
    
    let tipAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.text = "Tip Result"
        return label
    }()
    
    let myAppStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 10
        return sv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(myAppStackView)
        
        myAppStackView.addArrangedSubview(billAmountTextField)
        
        myAppStackView.addArrangedSubview(percentageAmountTextField)
        
        myAppStackView.addArrangedSubview(calculateTipButton)
        
        myAppStackView.addArrangedSubview(tipAmountLabel)
        
        
        NSLayoutConstraint.activate([
            myAppStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myAppStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
    
    @objc private func calculateTip() {
        let bill = Double(billAmountTextField.text!)!
        let percentage = Double(percentageAmountTextField.text!)!
        tipAmountLabel.text = String(bill * (percentage/100))
    }
    
    

}
