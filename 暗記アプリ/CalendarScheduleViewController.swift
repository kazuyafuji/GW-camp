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
    @IBOutlet var navigationBar : UINavigationBar!
    
    var beginDate : NSDate = NSDate()
    var endDate :NSDate = NSDate()
    
    var selectedDate: NSDate!
    
    
    var todoes: Results<ScheduleDescription>!
    var todoes2 : Results<ScheduleDescription>!
    var todoes3 : Results<ScheduleDescription>!
    var todoes4 : Results<ScheduleDescription>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        todoes  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "dueDate <= %@ AND dueDate >= %@" ,                                                     argumentArray: [endDate, beginDate])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes2  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "nextDay <= %@ AND nextDay >= %@" ,                                                     argumentArray: [endDate, beginDate])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes3  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "nextWeek <= %@ AND nextWeek >= %@" ,                                                     argumentArray: [endDate, beginDate])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes4  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "nextMonth <= %@ AND nextMonth >= %@" ,                                                     argumentArray: [endDate, beginDate])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        self.navigationItem.title = changeNavigationBarTitle(date: selectedDate)
    }
    
    func changeNavigationBarTitle(date: NSDate) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "M/dd"
        let selectMonth = formatter.string(from: date as Date)
        let selectDay = formatter.string(from: date as Date)
        return (selectMonth + selectDay)
        
    }
    
    @IBAction func add() {
        
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoes.count + todoes2.count + todoes3.count + todoes4.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if indexPath.row < todoes.count {
            cell?.textLabel?.text = todoes[indexPath.row].schedule
            
        } else if indexPath.row < todoes.count + todoes2.count {
            cell?.textLabel?.text = todoes2[indexPath.row - todoes.count].schedule
            
            
        } else if indexPath.row < todoes.count + todoes2.count + todoes3.count {
            cell?.textLabel?.text = todoes3[indexPath.row - todoes.count - todoes2.count].schedule
            
        } else if indexPath.row < todoes.count + todoes2.count + todoes3.count + todoes4.count {
            cell?.textLabel?.text = todoes4[indexPath.row - todoes.count - todoes2.count - todoes3.count].schedule
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: todoes[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            
            let controller = segue.destination as! ScheduleDetailViewController
            if let todo = sender as? ScheduleDescription {
                controller.scheduledescription = todo
            }
        }
    }
    
    
}
