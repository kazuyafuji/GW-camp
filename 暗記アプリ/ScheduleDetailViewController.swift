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
    
    //編集用のデータの受け渡し先
    var editTodoes : ScheduleDescription!
    
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
        
        if let editscheduledescription = self.editTodoes {
            scheduleTextField.text = editscheduledescription.schedule
            memoTextField.text = editscheduledescription.memo
        }
        
        if editTodoes == nil {
            deleteButton.isHidden = true
            scheduledescription = ScheduleDescription()
        }
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        
        if var title = scheduleTextField.text, let detailDescription = memoTextField.text {
            
            if scheduleStatus == ScheduleDescription.ScheduleStatus.hukushuu {
                
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
                    scheduledescription.id = ScheduleDescription.lastId()
                    scheduledescription.status = scheduleStatus
                    
                    
                    realm.add(scheduledescription, update: true)
                    
                }
                
                
                
            } else if scheduleStatus == ScheduleDescription.ScheduleStatus.yoshuu {
                //テスト勉強予定日を追加するためのコード
                let calendar = Calendar.current
                let oneDayBefore = calendar.date(byAdding: .day, value: -1, to: (sonoDate1 as NSDate)as Date)
                
                let oneMonthBefore = calendar.date(byAdding: .month,value: -1, to: oneDayBefore!)
                
                let oneMonthBeforeDayNext = calendar.date(byAdding: .month, value: -1, to: sonoDate1 as NSDate as Date)
                
                let oneMonthBeforeWeekNext = calendar.date(byAdding: .day, value: +7 ,to: oneMonthBefore!)
                
                
                
                let realm = try! Realm()
                try! realm.write {
                    print(scheduleStatus)
                    //追加するためのコード
                    scheduledescription.schedule = title
                    scheduledescription.memo = detailDescription
                    scheduledescription.status = .yoshuu
                    scheduledescription.dueDate = sonoDate1 as NSDate
                    scheduledescription.monthBefore = oneMonthBefore! as NSDate
                    scheduledescription.monthBeforeDayNext = oneMonthBeforeDayNext! as NSDate
                    scheduledescription.monthBeforeWeekNext = oneMonthBeforeWeekNext! as NSDate
                    scheduledescription.dayBefore = oneDayBefore! as NSDate
                    scheduledescription.id = ScheduleDescription.lastId()
                    scheduledescription.status = scheduleStatus
                    
                    
                    realm.add(scheduledescription, update: true)
                    
                }
          
            } else if scheduleStatus == ScheduleDescription.ScheduleStatus.edit {
                print (scheduleStatus)
                let realm = try! Realm()
                
                
                try! realm.write {
                    let editscheduledescription = self.editTodoes
                    print(detailDescription)
                    print(title)
                    editscheduledescription!.schedule = title
                    editscheduledescription!.memo = detailDescription
                    
                    
                }
            }
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
                    self.move()
                    
            }
            )
        )
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func move() {
        print(navigationController!.viewControllers.count)
        self.navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)
    }
    
       
    @IBAction func delete() {
        let alert: UIAlertController = UIAlertController(title: "確認", message: "この予定を削除してもよろしいですか？", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "削除する",
                style: UIAlertActionStyle.default,
                handler: {action in
                    self.move()
                    self.Delete()
                    
            }
            )
        )
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: UIAlertActionStyle.cancel,
                handler: {action in
                    
                    
            }
            )
        )
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func Delete() {
        let realm = try! Realm()
        
        
            try! realm.write() {
                realm.delete(editTodoes)
            }
            scheduleTextField.text = ""
            memoTextField.text = ""

        
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
