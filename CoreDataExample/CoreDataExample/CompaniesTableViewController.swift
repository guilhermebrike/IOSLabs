//
//  CompaniesTableViewController.swift
//  CoreDataExample
//
//  Created by Guilherme Wahlbrink on 2019-05-14.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit
import CoreData

class CompaniesTableViewController: UITableViewController, AddCompanyControllerDelegate {
    
    // MARK: - constants
    
    private let reuseIdentifier = "companyCell"
    
    // MARK: - properties
    
    var companies = [Company]()
    
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.title = "Company List"
        tableView.separatorColor = .spaceGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        setupRightAddButton()
        fetchCompanies()
    }
    
    // MARK: - helper methods
    
    private func setupRightAddButton() {
        let addButton = UIBarButtonItem(image: UIImage(named: "add2"), style: .plain, target: self, action: #selector(navigateAddCompany))
        addButton.tintColor = .white
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc func navigateAddCompany() {
        let addVC = AddCompanyViewController()
        addVC.delegate = self
        let addNVC = LightStatusBarNavigationController(rootViewController: addVC)
        // modal transition
        present(addNVC, animated: true, completion: nil)
    }
    
    private func fetchCompanies() {
        
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
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        
        do {
            let companies = try managedContext.fetch(fetchRequest)
            companies.forEach { (company) in
                print(company.name ?? "")
            }
        } catch let err {
            print("Failed to fetch companies: \(err)")
        }
        
    }
    
    
    // MARK: - Add Company controller delegate
    
    func addCompanyDidFinish(company: Company){
        companies.append(company)
        let insertPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [insertPath], with: .automatic)
    }
    
    func addCompanyDidCancel() {
        // cancel
    }
    
    
    // MARK: - tableview data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.textLabel?.text = companies[indexPath.row].name
        return cell
    }
    
}
