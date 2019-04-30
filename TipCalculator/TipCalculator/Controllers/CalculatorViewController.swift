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
        tf.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tf.text = "0"
        tf.addTarget(self, action: #selector(anyValueChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    let percentageAmountTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .blue
        tf.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tf.text = "0"
        tf.addTarget(self, action: #selector(anyValueChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    
    let percentageAmountSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.minimumTrackTintColor = .green
        slider.maximumTrackTintColor = .cyan
        slider.thumbTintColor = .black
        slider.isContinuous = true
        slider.widthAnchor.constraint(equalToConstant: 200).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        slider.addTarget(self, action: #selector(changeValueSlider(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(anyValueChanged(_:)), for: .valueChanged)
        return slider
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
        
        myAppStackView.addArrangedSubview(percentageAmountSlider)
        
        myAppStackView.addArrangedSubview(calculateTipButton)
        
        myAppStackView.addArrangedSubview(tipAmountLabel)
        
        
        NSLayoutConstraint.activate([
            myAppStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myAppStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("notification: Keyboard will show")
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = 0
        }
    }
    
    @objc private func calculateTip() {
        let bill = Double(billAmountTextField.text!)!
        let percentage = Double(percentageAmountTextField.text!)!
        tipAmountLabel.text = String(bill * (percentage/100))
    }
    
    
    @objc func changeValueSlider(_ sender: UISlider) {
        percentageAmountTextField.text = String(Int(sender.value))
    }
    
    @objc func anyValueChanged(_ sender: UISlider) {
        guard let bill = Double(billAmountTextField.text ?? "0") else { return }
        guard let percentage = Double(percentageAmountTextField.text ?? "0") else { return }
        tipAmountLabel.text = "\(bill * percentage / 100)"
    }
}


extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
