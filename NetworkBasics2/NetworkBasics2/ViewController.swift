//
//  ViewController.swift
//  NetworkBasics2
//
//  Created by Guilherme Wahlbrink on 2019-05-07.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private let reuseIdentifier = "repo"
    private var  repos: [Repo] = [Repo]()
    private let refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refreshRepos), for: .valueChanged)
        
        getRepositories(username: "guilhermebrike")
    }
    
    @objc func refreshRepos() {
        getRepositories(username: "guilhermebrike")
    }
    
    private func getRepositories(username: String) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else { return }
        
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Error:", err)
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let repos = try decoder.decode([Repo].self, from: data)
                    self.repos = repos
                    
                    // update UI (main thread)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    debugPrint("Error", error)
                }
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
            }
            return cell
        }()
        
        cell.textLabel?.text = repos[indexPath.row].name
        cell.detailTextLabel?.text = repos[indexPath.row].created_at.description
        return cell
    }

}

