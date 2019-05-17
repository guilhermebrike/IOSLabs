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
    func editCompanyDidFinish(company: Company)
}

class AddCompanyViewController: UIViewController {
    
    weak var delegate: AddCompanyControllerDelegate?
    
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
            if let imageData = company?.imageData {
                companyImageview.image = UIImage(data: imageData)
            }
            guard let founded = company?.founded else { return }
            datePicker.date = founded
        }
    }
    
    lazy var companyImageview: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "placeholder"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
        iv.backgroundColor = .white
        iv.layer.cornerRadius = 100
        iv.layer.borderWidth = 10
        iv.layer.borderColor = UIColor.spaceGray.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Company"
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .white
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
    
    let datePicker: UIDatePicker = {
        let d = UIDatePicker()
        d.translatesAutoresizingMaskIntoConstraints = false
        d.backgroundColor = .white
        d.datePickerMode = .date
        d.clipsToBounds = true
        return d
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigation()
        setupUI()
    }
    
    //  MARK: - helper UI
    private func setupUI() {
        
        view.addSubview(companyImageview)
        
        companyImageview.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        companyImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        companyImageview.widthAnchor.constraint(equalToConstant: 200).isActive = true
        companyImageview.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        let hStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hStackView)
        
        hStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        hStackView.topAnchor.constraint(equalTo: companyImageview.bottomAnchor, constant: 100).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        hStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(datePicker)
        
        datePicker.topAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 16).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    fileprivate func setupNavigation() {
        
        
        navigationItem.title = company == nil ? "Add Company" : "Edit Company"
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        cancelBtn.tintColor = .white
        navigationItem.leftBarButtonItem = cancelBtn
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePressed))
        saveBtn.tintColor = .white
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    @objc func selectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController,animated: true,completion: nil)
    }
    
    @objc func cancelPressed() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func savePressed() {
        // NSPersistentContainer: database
        
        // NSManagedObjectContext: scratch pad
        // - viewContext:  ManagedObjectContext(main thread)
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        // save or edit
        
        if company == nil { // insert

            let newCompany = NSEntityDescription.insertNewObject(forEntityName: "Company", into: managedContext)
            newCompany.setValue(nameTextField.text ?? "", forKey: "name")
            newCompany.setValue(datePicker.date, forKey: "founded")
            if let newCompanyImage = companyImageview.image {
                let imageData = newCompanyImage.jpegData(compressionQuality: 0.7)
                newCompany.setValue(imageData, forKey: "imageData")
            }
            CoreDataManager.shared.saveContext()
            dismiss(animated: true) {
                self.delegate?.addCompanyDidFinish(company: newCompany as! Company)
            }
        } else { // update
            
            company?.name = nameTextField.text
            company?.founded = datePicker.date
            if let companyImage = companyImageview.image {
                let imageData = companyImage.jpegData(compressionQuality: 0.7)
                company?.imageData = imageData
            }
            CoreDataManager.shared.saveContext()
            dismiss(animated: true) {
                self.delegate?.editCompanyDidFinish(company: self.company!)
            }
        }
    }
}


extension AddCompanyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true,completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            companyImageview.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            companyImageview.image = originalImage
        }
        dismiss(animated:true,completion:nil)
    }
}
