//
//  ToDo.swift
//  demo
//
//  Created by 藤原和矢 on 2017/05/04.
//  Copyright © 2017年 藤原和矢. All rights reserved.
//

import UIKit
import RealmSwift

class ToDo: Object {
    
    dynamic var id : Int = 0
    dynamic var title : String = ""
    dynamic var detailDiscripition: String = ""
    dynamic var createdAt :NSDate = NSDate()
    dynamic var dueDate: NSDate = NSDate()
    
    override static func primaryKey() -> String? {
        
        return"id"
    }
    
    static func lastId() -> Int {
        
        let realm = try! Realm()
        if let todo = realm.objects(ToDo.self).sorted(byKeyPath: "id",ascending: false).first {
            
            return todo.id + 1
        } else {
            
            return 1
        }
    }

}
