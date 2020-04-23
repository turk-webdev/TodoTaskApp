//
//  CompletedViewController.swift
//  TodoTasksApp
//
//  Created by Turk Erdin on 4/22/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit

class CompletedViewController: UIViewController {
    var tasks = [Task]()
    
    @IBOutlet weak var completedTableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        update()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UserDefaults to hold our data
        if !UserDefaults.standard.bool(forKey: "setup") {
            UserDefaults.standard.set(true, forKey: "setup")
            UserDefaults.standard.set(0, forKey: "count")
        }
        
        self.title = "Completed Tasks"
        
        completedTableView.delegate = self
        completedTableView.dataSource = self
        
        
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
                 
                 if decodedTask.isComplete {
                     tasks.append(decodedTask)
                 }
             } catch {
                 print("ERROR -- TodoViewController.67::\(error)")
             }
             
         }
         
         completedTableView.reloadData()
     }
    
    @objc func updateTaskObjectFromArray(index: Int, isComplete: Bool) {
        let key: String = "task_\(tasks[index].id)"
        tasks[index].isComplete = isComplete
        let encoder = JSONEncoder()
        
        do {
            let taskData: Data = try encoder.encode(tasks[index])
            UserDefaults.standard.set(taskData, forKey: key)
        } catch {
            print("ERROR -- TodoViewController.97::Something went wrong with saving:\n\(error)")
        }
    }
    
    @objc func deleteTaskObjectFromArray(index: Int) {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        let removedId = tasks[index].id
        tasks.remove(at: index)
        
        guard let oldCount = UserDefaults.standard.value(forKey: "count") as? Int else {
            print("ERROR -- TodoViewController.105::Could not find count as Int")
            return
        }
        
        for i in removedId..<oldCount {
            do {
                guard let nextTaskData: Data = UserDefaults.standard.data(forKey: "task_\(i+1)") else {
                    print("ERROR -- TodoViewController.124::Couldn't find data for 'task_\(i+1)'")
                    continue
                }
                // Check to make sure the "new" id matches for object
                var decodedTask: Task = try decoder.decode(Task.self, from: nextTaskData)
                decodedTask.id = i
                let newCurrTaskData: Data = try encoder.encode(decodedTask)
                UserDefaults.standard.set(newCurrTaskData, forKey: "task_\(i)")
            } catch {
                print("ERROR -- TodoViewController.132::\(error)")
            }
        }
        
        UserDefaults.standard.set(oldCount-1, forKey: "count")
    }
    
    
}

extension CompletedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "'\(tasks[indexPath.row].name)'", message: "", preferredStyle: .actionSheet)
        
        let undone = UIAlertAction(title: "Mark as To-Do", style: .default, handler: { _ in
            self.updateTaskObjectFromArray(index: indexPath.row, isComplete: false)
            self.update()
        })
        
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.deleteTaskObjectFromArray(index: indexPath.row)
            self.update()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(undone)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated:true, completion: { self.update() })
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CompletedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue = using template over and over to get instance of cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row].name
        
        return cell
    }
    
    
}
