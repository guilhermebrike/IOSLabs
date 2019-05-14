//
//  CompaniesTableViewController.swift
//  CoreDataExample
//
//  Created by Guilherme Wahlbrink on 2019-05-14.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class CompaniesTableViewController: UITableViewController, AddCompanyControllerDelegate {
    
    // MARK: - constants
    
    private let reuseIdentifier = "companyCell"
    
    // MARK: - properties
    
    var companies = ["Apple", "Google", "Facebook", "Amazon", "Microsoft"]
    
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.title = "Company List"
        tableView.separatorColor = .spaceGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        setupRightAddButton()
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
    
    // MARK: - Add Company controller delegate
    
    func addCompanyDidFinish(company: String){
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
        cell.textLabel?.text = companies[indexPath.row]
        
        return cell
    }
    
}
