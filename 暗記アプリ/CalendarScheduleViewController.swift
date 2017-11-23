//
//  CalendarScheduleViewController.swift
//  暗記アプリ
//
//  Created by 藤原和矢 on 2017/05/03.
//  Copyright © 2017年 藤原和矢. All rights reserved.
//

import UIKit
import RealmSwift

class CalendarScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var beginDate : NSDate = NSDate()
    var endDate :NSDate = NSDate()
    var status1:String = ScheduleDescription.ScheduleStatus.hukushuu.rawValue
    var status2:String = ScheduleDescription.ScheduleStatus.yoshuu.rawValue
    
    var todoes: Results<ScheduleDescription>!
    var todoes2 : Results<ScheduleDescription>!
    var todoes3 : Results<ScheduleDescription>!
    var todoes4 : Results<ScheduleDescription>!
    var todoes5 : Results<ScheduleDescription>!
    var todoes6 : Results<ScheduleDescription>!
    var todoes7 : Results<ScheduleDescription>!
    var todoes8 : Results<ScheduleDescription>!
    
    var selecttodo : ScheduleDescription!
    
    var selectedIndexPath = 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(beginDate)
        print(endDate)
        
        self.loadtodes()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadtodes() {
        todoes  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "dueDate <= %@ AND dueDate >= %@" ,                                                     argumentArray: [endDate, beginDate])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        //日付Aをタップした時に　nextDayが日付Aになっているデータをこの中に入れる。
        todoes2  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "nextDay <= %@ AND nextDay >= %@ AND statusStr == %@" ,
                argumentArray: [endDate, beginDate,status1]) 
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        //日付aをタップした時に　nextWeekが日付aになっているデータをこの中に入れる
        todoes3  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "nextWeek <= %@ AND nextWeek >= %@ AND statusStr == %@" ,                                                     argumentArray: [endDate, beginDate,status1])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes4  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "nextMonth <= %@ AND nextMonth >= %@ AND statusStr == %@" ,                                                     argumentArray: [endDate, beginDate,status1])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes5 = {
            
            let realm = try! Realm()
            let Predicate:NSPredicate = NSPredicate(format: "dayBefore <= %@ AND dayBefore >= %@ AND statusStr == %@", argumentArray:[endDate, beginDate,status2])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes6 = {
            
            let realm = try! Realm()
            let Predicate:NSPredicate = NSPredicate(format: "monthBefore <= %@ AND monthBefore >= %@ AND statusStr == %@", argumentArray:[endDate, beginDate,status2])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes7 = {
            
            let realm = try! Realm()
            let Predicate:NSPredicate = NSPredicate(format: "monthBeforeDayNext <= %@ AND monthBeforeDayNext >= %@ AND statusStr == %@", argumentArray:[endDate, beginDate,status2])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes8 = {
            
            let realm = try! Realm()
            let Predicate:NSPredicate = NSPredicate(format: "monthBeforeWeekNext <= %@ AND monthBeforeWeekNext >= %@ AND statusStr == %@", argumentArray:[endDate, beginDate,status2])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadtodes()
        tableView.reloadData()
        
        self.navigationItem.title = changeNavigationBarTitle(date: beginDate as Date)
        
        tableView.sectionHeaderHeight = 40
        
    }
    
    
    func changeNavigationBarTitle(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        let selectDate = formatter.string(from: date)
        return (selectDate)
        
    }
    
    
    @IBAction func add() {
        
        self.performSegue(withIdentifier: "toSelect", sender: nil)
    }
    
    //tableViewのcellを二つに分けるコード
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
    //sectionの間の題名をつける
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "予定"
        } else if section == 1 {
            return "やること"
        } else {
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoes.count + todoes2.count + todoes3.count + todoes4.count + todoes5.count + todoes6.count + todoes7.count + todoes8.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let scheduledescription = scheduleFrom(indexPath: indexPath)
        
        
        if indexPath.section == 0 {
            //予定のとき
            cell?.textLabel?.text = scheduledescription.schedule
        } else if indexPath.section == 1 {
            //やることのとき
            cell?.textLabel?.text = scheduledescription.memo
        }
        
        
        if scheduledescription.status == ScheduleDescription.ScheduleStatus.yoshuu {
            cell?.textLabel?.textColor = UIColor.blue
        } else if scheduledescription.status == ScheduleDescription.ScheduleStatus.hukushuu {
            cell?.textLabel?.textColor = UIColor.red
        }
        
        return cell!
    }
 ////エラーーのところ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selecttodo = scheduleFrom(indexPath: indexPath)
        
        self.performSegue(withIdentifier: "directDetail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "directDetail" {
            let controller = segue.destination as! ScheduleDetailViewController
            controller.editTodoes = todoes[selectedIndexPath.row]
        }
    }
    
    func scheduleFrom(indexPath : IndexPath) -> ScheduleDescription {
        
        if indexPath.row < todoes.count {
            return todoes[indexPath.row]
            
        } else if indexPath.row < todoes.count + todoes2.count {
            return todoes2[indexPath.row - todoes.count]
            
        } else if indexPath.row < todoes.count + todoes2.count + todoes3.count {
            return todoes3[indexPath.row - todoes.count - todoes2.count]
            
        } else if indexPath.row < todoes.count + todoes2.count + todoes3.count + todoes4.count {
            return todoes4[indexPath.row - todoes.count - todoes2.count - todoes3.count]
            
        } else if indexPath.row < todoes.count + todoes2.count + todoes3.count + todoes4.count + todoes5.count {
            return todoes5[indexPath.row - todoes.count - todoes2.count - todoes3.count - todoes4.count]
        } else if indexPath.row < todoes.count + todoes2.count + todoes3.count + todoes4.count + todoes5.count + todoes6.count {
            return todoes6[indexPath.row - todoes.count - todoes2.count - todoes3.count - todoes4.count - todoes5.count]
        } else if indexPath.row < todoes.count + todoes2.count + todoes3.count + todoes4.count + todoes5.count + todoes6.count + todoes7.count {
            return todoes7[indexPath.row - todoes.count - todoes2.count - todoes3.count - todoes4.count - todoes5.count - todoes6.count]
        } else  {
            return todoes8[indexPath.row - todoes.count - todoes2.count - todoes3.count - todoes4.count - todoes5.count - todoes6.count - todoes7.count]
        }
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelect" {
            
            let controller2 = segue.destination as! selectViewController
            controller2.sDate = self.beginDate
            
            
        } else if segue.identifier == "directDetail" {
            let controllerduedate = segue.destination as! ScheduleDetailViewController
            
            let scheduledescription = ScheduleDescription()
            
            controllerduedate.scheduledescription = scheduledescription
            
        }
    }
}




