//
//  TableController.swift
//  TodoTasksApp
//
//  Created by Turk Erdin on 4/22/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit

class TableController: UITableViewController {

   var eightThousandersPeaks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationItem.title = "Peaks"
        eightThousandersPeaks += ["Mount Everest", "K2", "Kangchenjunga",
                                  "Lhotse","Makalu", "Cho Oyu",
                                  "Dhaulagiri","Manaslu", "Nanga Parbat",
                                  "Annapurna I", "Gasherbrum I", "Broad Peak",
                                  "Gasherbrum II", "Shishapangma"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eightThousandersPeaks.count;
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueFromTable", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("test")
        // Trick to get static variable in Swift
        struct staticVariable { static var tableIdentifier = "TableIdentifier" }
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(
            withIdentifier: staticVariable.tableIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: staticVariable.tableIdentifier)
        }
        
        cell?.textLabel?.text = eightThousandersPeaks[indexPath.row]
        return cell!
    }

}
