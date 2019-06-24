//
//  EventsTableViewController.swift
//  UIDemo
//
//  Created by Guilherme Wahlbrink on 2019-06-19.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit
import CoreData

class EventsTableViewController: UITableViewController {

    var events: [Event] = []
    
    private let reuseIdentifier = "eventCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        editButtonItem.title = "Select"
        //adding a button to the navigation controller through navigationItem in the right side
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))]
        
        fetchEventsFromDatabase()
    }

    
    @objc func addEvent() {
        // 1 go to add todo view controller
        let addEventVC = AddEventViewController()
        addEventVC.delegate = self
        navigationController?.pushViewController(addEventVC, animated: true)
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EventsTableViewCell

        cell.eventDescription.text = events[indexPath.row].name
        return cell
    }


    private func fetchEventsFromDatabase() {
        
        // NSManagedObjectContext: scratch pad
        // - viewContext:  ManagedObjectContext(main thread)
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
        
        do {
            let items = try managedContext.fetch(fetchRequest)
            items.forEach { (item) in
                events.append(item)
            }
        } catch let err {
            print("Failed to fetch items: \(err)")
        }

    }

}



extension EventsTableViewController: AddEventViewControllerDelegate {

     func addEventDidFinish(event: Event) {
        events.append(event)
        tableView.reloadData() // refresh!
    }
}

