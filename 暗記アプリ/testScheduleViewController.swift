//
//  testScheduleViewController.swift
//  暗記アプリ
//
//  Created by 藤原和矢 on 2017/05/20.
//  Copyright © 2017年 藤原和矢. All rights reserved.
//

import UIKit
import RealmSwift

class testScheduleViewController: UIViewController , UITextFieldDelegate {
    
    var sonoDate2 : NSDate = NSDate()
    
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var testScheduleTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    var scheduledescription : ScheduleDescription!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        testScheduleTextField.delegate = self
        memoTextField.delegate = self
        if let scheduledescription = self.scheduledescription {
            testScheduleTextField.text = scheduledescription.schedule
            memoTextField.text = scheduledescription.memo
        }
        
        if scheduledescription == nil {
            deleteButton.isHidden = true
        }
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        
        if let title = testScheduleTextField.text, let detailDescription = memoTextField.text {
            
            if let scheduledescription = self.scheduledescription {
                
                
                //テスト勉強予定日を追加するためのコード
                let calendar = Calendar.current
                let oneDayBefore = calendar.date(byAdding: .day, value: -1, to: (sonoDate2 as NSDate)as Date)
                
                let oneMonthBefore = calendar.date(byAdding: .month,value: -1, to: oneDayBefore!)
                
                let oneDayNext = calendar.date(byAdding: .day, value: +1, to: oneMonthBefore!)
                
                let threeWeeksBefore = calendar.date(byAdding: .day, value: +7 ,to: oneMonthBefore!)
                
                
                
                let realm = try! Realm()
                try! realm.write {
                    //追加するためのコード
                    scheduledescription.schedule = title
                    scheduledescription.memo = detailDescription
                    scheduledescription.status = .yoshuu
                    scheduledescription.dueDate = sonoDate2 as NSDate
                    //nextMonth　は登録したテスト日の前日の一ヶ月前の日
                    scheduledescription.nextMonth = oneMonthBefore! as NSDate
                    //nextDay は登録したテスト日の前日の一ヶ月前の日の次の日
                    scheduledescription.nextDay = oneDayNext! as NSDate
                    //nextWeek は　登録したテスト日の前日の一ヶ月前の日の次の週　テスト勉強の二週間目
                    scheduledescription.nextWeek = threeWeeksBefore! as NSDate
                    //dayBefore　は登録したテスト日の前日
                    scheduledescription.dayBefore = oneDayBefore! as NSDate
                    
                    
                    realm.add(scheduledescription, update: true)
                    
                }
                
                
                
            } else {
                
                
                //テスト勉強予定日を追加するためのコード
                let calendar = Calendar.current
                let oneDayBefore = calendar.date(byAdding: .day, value: -1, to: (sonoDate2 as NSDate)as Date)
                
                let oneMonthBefore = calendar.date(byAdding: .month,value: -1, to: oneDayBefore!)
                
                let oneDayNext = calendar.date(byAdding: .day, value: +1, to: oneMonthBefore!)
                
                let threeWeeksBefore = calendar.date(byAdding: .day, value: +7 ,to: oneMonthBefore!)
                
                
                
                //追加するためのコード
                let scheduledescription = ScheduleDescription()
                scheduledescription.id = ScheduleDescription.lastId()
                scheduledescription.schedule = title
                scheduledescription.memo = detailDescription
                scheduledescription.dueDate = sonoDate2 as NSDate
                //nextMonth　は登録したテスト日の前日の一ヶ月前の日
                scheduledescription.nextMonth = oneMonthBefore! as NSDate
                //nextDay は登録したテスト日の前日の一ヶ月前の日の次の日
                scheduledescription.nextDay = oneDayNext! as NSDate
                //nextWeek は　登録したテスト日の前日の一ヶ月前の日の次の週　テスト勉強開始日の一週間後
                scheduledescription.nextWeek = threeWeeksBefore! as NSDate
                //dayBefore　は登録したテスト日の前日
                scheduledescription.dayBefore = oneDayBefore! as NSDate
            
                
                let realm = try! Realm()
                try! realm.write {
                    
                    realm.add(scheduledescription)
                    
                }
                
                
                
            }
            
            
            print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "")
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            textField.resignFirstResponder()
            return true
        }
        
        let alert: UIAlertController = UIAlertController(title: "保存完了", message: "", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.default,
                handler: {action in
                   _ = self.performSegue(withIdentifier: "toYotei2", sender: nil)
            }
            )
        )
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func delete() {
        if let scheduledescription = scheduledescription {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(scheduledescription)
            }
        }
    }
    
}
