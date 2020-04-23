//
//  TodoViewController.swift
//  TodoTasksApp
//
//  Created by Turk Erdin on 4/22/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {
    var tasks = [Task]()
    var uuids = [String]()
    
    @IBOutlet weak var todoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UserDefaults to hold our data
        if !UserDefaults.standard.bool(forKey: "setup") {
            UserDefaults.standard.set(true, forKey: "setup")
            UserDefaults.standard.set(0, forKey: "count")
        }
        
        self.title = "To-Do Tasks"
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        
        update()
    }
    
    
    func update() {
        tasks.removeAll()
        let decoder = JSONDecoder()
        
        guard let count = UserDefaults.standard.value(forKey: "count") as? Int else {
            return
        }
        
        for i in 0..<count {
            guard let taskData: Data = UserDefaults.standard.data(forKey: "task_\(i+1)") else {
                continue
            }
            
            do {
                let decodedTask: Task = try decoder.decode(Task.self, from: taskData)
                tasks.append(decodedTask)
            } catch {
                print(error)
            }
            
            
        }
        
        todoTableView.reloadData()
    }
    
    func markDone(_ i: Int) {
        
    }
    
    
    @IBAction func didTapAdd(_ sender: Any) {
        let newEntryVC = storyboard?.instantiateViewController(identifier: "newEntryView") as! NewEntryViewController
        
        newEntryVC.title = "New Task"
        newEntryVC.update = {
            DispatchQueue.main.async {
                self.update()
            }
        }
        
        navigationController?.pushViewController(newEntryVC, animated: true)
    }
    
    
}

extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: tasks[indexPath.row].name, message: "", preferredStyle: .actionSheet)
        
        let done = UIAlertAction(title: "Mark as Done", style: .default, handler: { _ in
            self.tasks[indexPath.row].isComplete = true
            self.update()
        })
        
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.tasks.remove(at: indexPath.row)
            
            guard let oldCount = UserDefaults.standard.value(forKey: "count") as? Int else {
                return
            }
            let newCount = oldCount-1
            
            for i in indexPath.row..<self.tasks.count {
                UserDefaults.standard.set(self.tasks[i].name, forKey: "task_\(i+1)")
            }
            
            UserDefaults.standard.removeObject(forKey: "task_\(oldCount)")
            UserDefaults.standard.set(newCount, forKey: "count")
            
            self.update()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(done)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated:true, completion: { self.update() })
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue = using template over and over to get instance of cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        return cell
    }
    
    
}
