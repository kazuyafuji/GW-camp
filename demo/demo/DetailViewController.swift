//
//  DetailViewController.swift
//  demo
//
//  Created by 藤原和矢 on 2017/05/04.
//  Copyright © 2017年 藤原和矢. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    var todo : ToDo!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        if let todo = self.todo {
            titleTextField.text = todo.title
            descriptionTextField.text = todo.detailDescription
            dueDatePicker.date = todo.dueDate as Date
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save() {
        if let title = titleTextField.text, let detailDescription = descriptionTextField.text {
            
            //追加するためのコード
            let todo = ToDo()
            todo.id = ToDo.lastId()
            todo.title = title
            todo.detailDescription = detailDescription
            
            let realm = try! Realm()
            try! realm.write {
                
                realm.add(todo)
            
            }
            
            print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
