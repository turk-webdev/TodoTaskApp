//
//  Created by Turk Erdin on 4/21/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit

// Since structs are values, we can easily code/decode it
struct Task: Codable {
    var name: String?
    var description: String?
    var isComplete: Bool
    
    init(name: String, description: String, isComplete: Bool) {
        self.name = name
        self.description = description
        self.isComplete = isComplete
    }
}


class AppViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
