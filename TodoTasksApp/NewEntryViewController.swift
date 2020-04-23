//
//  NewEntryViewController.swift
//  TodoTasksApp
//
//  Created by Turk Erdin on 4/21/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var newEntryTextField: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newEntryTextField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
        guard let
            text = newEntryTextField.text,
            !text.isEmpty
        else {
            print("err1")
            return
        }
        
        guard let count = UserDefaults.standard.value(forKey: "count") as? Int else {
            print("err2")
            return
        }
        
        UserDefaults.standard.set(count+1, forKey: "count")
        
        // Encode our Task object
        let encoder = JSONEncoder()
        
        do {
            let taskData: Data = try encoder.encode(Task(name: text, isComplete: false, id: count+1))
            UserDefaults.standard.set(taskData, forKey: "task_\(count+1)")
        } catch {
            print("ERROR -- NewEntryViewController.52::Something went wrong with saving:\n\(error)")
        }
        
        update?()
        navigationController?.popViewController(animated: true)
        
    }
    
}
