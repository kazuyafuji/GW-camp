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
    dynamic var nextDay :NSDate = NSDate()
    dynamic var nextWeek :NSDate = NSDate()
    dynamic var nextMonth: NSDate = NSDate()
    dynamic var dayBefore: NSDate = NSDate()
    dynamic var monthBefore :NSDate = NSDate()
    dynamic var monthBeforeDayNext :NSDate = NSDate()
    dynamic var monthBeforeWeekNext :NSDate = NSDate()
    dynamic var statusStr: String!
    
    enum ScheduleStatus : String {
        case hukushuu = "hukushuu"
        case yoshuu = "yoshuu"
    }

    
    /// typeをEnumで扱うためのプロパティ
    var status:ScheduleStatus {
        get {
            return ScheduleStatus(rawValue: statusStr)!
        }
        set {
            statusStr = newValue.rawValue
        }
    }

    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func lastId() -> Int {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        if let scheduledescription = realm.objects(ScheduleDescription.self).sorted(byKeyPath: "id", ascending: false).first{
            return scheduledescription.id + 1
            
        } else {
            return 1
        }
        
    }

}

