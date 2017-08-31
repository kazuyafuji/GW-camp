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
    
    var sonoDate1 : NSDate = NSDate()
    
    
    
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var scheduleTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    
    var scheduledescription : ScheduleDescription!
    var scheduleStatus : ScheduleDescription.ScheduleStatus!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        scheduleTextField.delegate = self
        memoTextField.delegate = self
        if let scheduledescription = self.scheduledescription {
            scheduleTextField.text = scheduledescription.schedule
            memoTextField.text = scheduledescription.memo
            /*dueDatePicker.date = scheduledescription.dueDate as Date*/
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
        
        if let title = scheduleTextField.text, let detailDescription = memoTextField.text {
            
            if scheduleStatus == ScheduleDescription.ScheduleStatus.hukushuu {
               //let scheduledescription = self.scheduledescription
                
                //復習予定日を追加するためのコード
                let calendar = Calendar.current
                let oneDayNext = calendar.date(byAdding: .day, value: +1, to: (sonoDate1 as NSDate) as Date)
                
                let oneWeekNext = calendar.date(byAdding: .day, value: +7 ,to: (sonoDate1 as NSDate) as Date)
                
                let oneMonthNext = calendar.date(byAdding: .month,value: +1, to: (sonoDate1 as NSDate) as Date)
                
                
                
                let realm = try! Realm()
                try! realm.write {
                    print(scheduleStatus)
                    //追加するためのコード
                    scheduledescription = ScheduleDescription()
                    scheduledescription.schedule = String(title)
                    scheduledescription.memo = detailDescription
                    scheduledescription.dueDate = sonoDate1 as NSDate
                    scheduledescription.nextDay = oneDayNext! as NSDate
                    scheduledescription.nextWeek = oneWeekNext! as NSDate
                    scheduledescription.nextMonth = oneMonthNext! as NSDate
                    scheduledescription.status = scheduleStatus
            
                    
                    realm.add(scheduledescription, update: true)
                    
                }
                
                
                
            } else {
                
                
                //復習予定日を追加するためのコード
                let calendar = Calendar.current
                let oneDayNext = calendar.date(byAdding: .day, value: +1, to: (sonoDate1 as NSDate) as Date)
                
                let oneWeekNext = calendar.date(byAdding: .day, value: +7 ,to: (sonoDate1 as NSDate) as Date)
                
                let oneMonthNext = calendar.date(byAdding: .month,value: +1, to: (sonoDate1 as NSDate) as Date)
                
                
                //追加するためのコード
                let scheduledescription = ScheduleDescription()
                scheduledescription.id = ScheduleDescription.lastId()
                scheduledescription.schedule = title
                scheduledescription.memo = detailDescription
                scheduledescription.status = scheduleStatus
                scheduledescription.dueDate = sonoDate1 as NSDate
                scheduledescription.nextDay = oneDayNext! as NSDate
                scheduledescription.nextWeek = oneWeekNext! as NSDate
                scheduledescription.nextMonth = oneMonthNext! as NSDate
                print(scheduledescription.status)
                
                let realm = try! Realm()
                try! realm.write {
                    
                    realm.add(scheduledescription)
                    
                }
                
            }
            
                
                
        if scheduleStatus == ScheduleDescription.ScheduleStatus.yoshuu {
                //テスト勉強予定日を追加するためのコード
                let calendar = Calendar.current
                let oneDayBefore = calendar.date(byAdding: .day, value: -1, to: (sonoDate1 as NSDate)as Date)
                
                let oneMonthBefore = calendar.date(byAdding: .month,value: -1, to: oneDayBefore!)
                
                let oneDayNext = calendar.date(byAdding: .day, value: +1, to: oneMonthBefore!)
                
                let threeWeeksBefore = calendar.date(byAdding: .day, value: +7 ,to: oneMonthBefore!)
                
                
                
                let realm = try! Realm()
                try! realm.write {
                    //追加するためのコード
                    scheduledescription.schedule = title
                    scheduledescription.memo = detailDescription
                    scheduledescription.status = .yoshuu
                    scheduledescription.dueDate = sonoDate1 as NSDate
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
                let oneDayBefore = calendar.date(byAdding: .day, value: -1, to: (sonoDate1 as NSDate)as Date)
                
                let oneMonthBefore = calendar.date(byAdding: .month,value: -1, to: oneDayBefore!)
                
                let oneDayNext = calendar.date(byAdding: .day, value: +1, to: oneMonthBefore!)
                
                let threeWeeksBefore = calendar.date(byAdding: .day, value: +7 ,to: oneMonthBefore!)
                
                
                
                //追加するためのコード
                let scheduledescription = ScheduleDescription()
                scheduledescription.id = ScheduleDescription.lastId()
                scheduledescription.schedule = title
                scheduledescription.memo = detailDescription
                scheduledescription.dueDate = sonoDate1 as NSDate
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
                    self.plus()
                
            }
            )
        )
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func plus() {
        print(navigationController!.viewControllers.count)
        self.navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)
    }
    
    
    
    @IBAction func delete() {
        if let scheduledescription = scheduledescription {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(scheduledescription)
            }
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
