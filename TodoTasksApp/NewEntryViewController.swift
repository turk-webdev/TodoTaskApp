//
//  NewEntryViewController.swift
//  TodoTasksApp
//
//  Created by Turk Erdin on 4/21/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add New Task"
        
        descTextField.delegate = self
        nameTextField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNewTask))
    }
    
    // Found the solution for corner rounding on StackOverflow
    // Source: https://stackoverflow.com/questions/5047818/how-to-round-the-corners-of-a-button
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        anyButton.layer.cornerRadius = anyButton.frame.height / 2
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
    }
    
    @IBAction func savePressed(_ sender: Any) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveNewTask()
        
        return true
    }
    
    @objc func saveNewTask() {
        guard let descText = descTextField.text, !descText.isEmpty else {
            return
        }
        guard let nameText = nameTextField.text, !nameText.isEmpty else {
            return
        }
        
        
        
    }
    
    

}
