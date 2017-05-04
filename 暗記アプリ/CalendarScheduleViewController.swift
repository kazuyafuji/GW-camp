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
    
    var monthYear : NSDate = NSDate()
    
    var todoes: Results<ScheduleDescription> = {
        
        let realm = try! Realm()
        return realm.objects(ScheduleDescription.self)/*.filter()*/
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    }
    
    @IBAction func add() {
        
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = todoes[indexPath.row].schedule
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
