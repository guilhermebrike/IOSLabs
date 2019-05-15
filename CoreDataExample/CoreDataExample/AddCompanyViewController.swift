//
//  AddCompanyViewController.swift
//  CoreDataExample
//
//  Created by Guilherme Wahlbrink on 2019-05-14.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit
import CoreData

// protocol for passing data back to companyTableViewController
protocol AddCompanyControllerDelegate: class {
    func addCompanyDidFinish(company: Company)
    func addCompanyDidCancel()
}

class AddCompanyViewController: UIViewController {
    
    weak var delegate: AddCompanyControllerDelegate?
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Company"
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return lb
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " Enter company name..."
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupUI()
    }
    
    private func setupUI() {
        let hStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hStackView)
        
        hStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        hStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        hStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    fileprivate func setupNavigation() {
        navigationItem.title = "Add Company"
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        cancelBtn.tintColor = .white
        navigationItem.leftBarButtonItem = cancelBtn
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePressed))
        saveBtn.tintColor = .white
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    @objc func cancelPressed() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func savePressed() {
        
        // NSPersistentContainer: database
        let persistentContainer = NSPersistentContainer(name: "CompanyTracker")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let err = error {
                fatalError("Loading of persistant store failed: \(err)")
            }
        }
        
        // NSManagedObjectContext: scratch pad
        // - viewContext:  ManagedObjectContext(main thread)
        let managedContext = persistentContainer.viewContext
        
        let newCompany = NSEntityDescription.insertNewObject(forEntityName: "Company", into: managedContext)
        
        newCompany.setValue(nameTextField.text ?? "", forKey: "name")
        
        do {
            try managedContext.save()
        } catch let err {
            print("Failed to save new company: \(err)")
        }
        
        //delegate?.addCompanyDidFinish(company: nameTextField.text ?? "")
        dismiss(animated: true) {
            let company = Company(context: managedContext)
            company.name = self.nameTextField.text ?? ""
            self.delegate?.addCompanyDidFinish(company: company)
        }
    }
}
