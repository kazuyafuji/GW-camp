//
//  ScheduleDetailViewController.swift
//  暗記アプリ
//
//  Created by 藤原和矢 on 2017/05/04.
//  Copyright © 2017年 藤原和矢. All rights reserved.
//

import UIKit
import RealmSwift

class ScheduleDetailViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet var scheduleTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    var scheduledescription : ScheduleDescription!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        scheduleTextField.delegate = self
        memoTextField.delegate = self
        if let scheduledescription = self.scheduledescription {
            scheduleTextField.text = scheduledescription.schedule
            memoTextField.text = scheduledescription.memo
            dueDatePicker.date = scheduledescription.dueDate as Date
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        if let title = scheduleTextField.text, let detailDescription = memoTextField.text {
            
            //追加するためのコード
            let scheduledescription = ScheduleDescription()
            scheduledescription.id = ScheduleDescription.lastId()
            scheduledescription.schedule = title
            scheduledescription.memo = detailDescription
            
            let realm = try! Realm()
            try! realm.write {
                
                realm.add(scheduledescription)
                
            }
            
            print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "")
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            textField.resignFirstResponder()
            return true
        }
        

        
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
