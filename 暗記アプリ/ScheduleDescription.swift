//
//  ScheduleDescription.swift
//  暗記アプリ
//
//  Created by 藤原和矢 on 2017/05/04.
//  Copyright © 2017年 藤原和矢. All rights reserved.
//

import UIKit
import RealmSwift


class ScheduleDescription: Object {
    
    dynamic var id : Int = 0
    dynamic var schedule :String = ""
    dynamic var memo :String = ""
    dynamic var createdAt : NSDate = NSDate()
    dynamic var dueDate: NSDate = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func lastId() -> Int {
        let realm = try! Realm()
        if let scheduledescription = realm.objects(ScheduleDescription.self).sorted(byKeyPath: "id", ascending: false).first{
            return scheduledescription.id + 1
            
        } else {
            return 1
        }
        
    }

}
