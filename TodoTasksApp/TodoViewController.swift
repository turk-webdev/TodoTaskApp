//
//  Created by Turk Erdin on 4/21/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit
/**
 * **class Task** - We use this to dictate how our individual tasks will behave. If we ever want to go back and add more parameters to tasks, it is easy to add new fields.
 */
class Task {
    var name: String?
    var description: String?
    var complete: Bool?
    
    init(name: String, description: String, complete: Bool) {
        self.name = name
        self.description = description
        self.complete = complete
    }
}


class TodoViewController: UIViewController {
    @IBOutlet weak var todoTableView: UITableView!
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To-Do Tasks"
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        performSegue(withIdentifier: "toNewTaskView", sender: self)
    }


    func addNewTask(task: Task) {
        tasks.append(task)
    }

}


extension TodoViewController: UITableViewDelegate {
    
}



extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") ?? UITableViewCell()
        
        todoCell.textLabel?.text = tasks[indexPath.row].name
        
        return todoCell
        
    }
    
}

