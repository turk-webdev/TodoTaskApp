//
//  TodoViewController.swift
//  TodoTasksApp
//
//  Created by Turk Erdin on 4/22/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {
    var todoTasks = [Task]()
    
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get all saved To-Do tasks
    }

    @IBAction func didTapAddButton(_ sender: Any) {
        let newTaskVC = storyboard?.instantiateViewController(identifier: "newEntry") as! NewEntryViewController
        newTaskVC.title = "New Task"
        navigationController?.pushViewController(newTaskVC, animated: true)
    }
}

extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        cell.textLabel?.text = todoTasks[indexPath.row].name
        
        return cell
    }
    
    
}
