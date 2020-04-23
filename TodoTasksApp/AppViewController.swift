//
//  Created by Turk Erdin on 4/21/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit

// Since structs are values, we can easily code/decode it
struct Task: Codable {
    var name: String?
    var isComplete: Bool
    
    init(name: String, isComplete: Bool) {
        self.name = name
        self.isComplete = isComplete
    }
}


class AppViewController: UIViewController {
    var uuids = [String]()
    var tasksTodo = [Task]()
    var tasksCompleted = [Task]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //DEBUG ONLY
        print("Check")
        uuids.append("Testing")
        
        let todoTableVC = storyboard?.instantiateViewController(identifier: "todoTableView") as! TodoViewController
        todoTableVC.uuids = self.uuids
        
    }

}
