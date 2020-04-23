//
//  NewEntryViewController.swift
//  TodoTasksApp
//
//  Created by Turk Erdin on 4/21/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var newTaskText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        newTaskText.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        
        return true
    }
    
    func saveTask() {}
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPressed(_ sender: Any) {
    }
    
}
