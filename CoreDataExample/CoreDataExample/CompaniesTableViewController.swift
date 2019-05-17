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
        tableView.tableFooterView = UIView() // to remove the separators
        tableView.register(CompanyTableViewCellTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
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
        
        // NSManagedObjectContext: scratch pad
        // - viewContext:  ManagedObjectContext(main thread)
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try managedContext.fetch(fetchRequest)
            companies.forEach { (company) in
                self.companies.append(company)
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
    
    func editCompanyDidFinish(company: Company) {
        let row = companies.firstIndex(of: company)!
        let myIndexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [myIndexPath], with: .middle)
    }
    
    // MARK: - tableview data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CompanyTableViewCellTableViewCell
        cell.company = companies[indexPath.row]
        return cell
    }
    
    
    // MARK: - tableview delegate
    
    // method to edit the cells
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            //1. remove from the tableview
            let company = self.companies[indexPath.row]
            self.companies.remove(at: indexPath.row) // first remove from the model
            self.tableView.deleteRows(at: [indexPath], with: .automatic) // than remove from the tableview
            //2. remove from the tableview
            CoreDataManager.shared.persistentContainer.viewContext.delete(company)
            CoreDataManager.shared.saveContext()
        }
        // edit action
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // 1. navigate(modal) to AddCompnayViewController
            let editVC = AddCompanyViewController()
            editVC.delegate = self
            editVC.company = self.companies[indexPath.row]
            let editNVC = LightStatusBarNavigationController(rootViewController: editVC)
            // modal transition
            self.present(editNVC, animated: true, completion: nil)
            
        }
        
        return [deleteAction,editAction]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Please add some Companies..."
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .boldSystemFont(ofSize: 20)
        return descriptionLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ? view.frame.height : 0
    }
}
