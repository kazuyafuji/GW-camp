//
//  ViewController.swift
//  暗記アプリ
//
//  Created by 藤原和矢 on 2017/05/03.
//  Copyright © 2017年 藤原和矢. All rights reserved.
//

import UIKit
import RealmSwift

extension UIColor {
    class func lightBlue() -> UIColor {
        return UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    }
    
    class func lightRed() -> UIColor {
        return UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
    }
    
    class func lightGreenBlue() -> UIColor {
        return UIColor(red: 80.0 / 255, green: 190.0 / 255, blue: 192.0 / 255, alpha: 1.0)
    }
    
    class func lightlightGray() -> UIColor {
        return UIColor(red: 170.0 / 255, green: 170.0 / 255, blue: 170.0 / 255, alpha: 0.76)
    }
}


class ViewController: UIViewController, UICollectionViewDelegate {
    
    let dateManager = DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate = NSDate()
    var today: NSDate!
    let weekArray = ["日", "月", "火", "水", "木", "金", "土"]
    let calendar = NSCalendar.current
    
    var cellTapped :Bool = false
    
    var todoes: Results<ScheduleDescription>!
    var todoes2 : Results<ScheduleDescription>!
    var todoes3 : Results<ScheduleDescription>!
    var todoes4 : Results<ScheduleDescription>!
    var todoes5 : Results<ScheduleDescription>!
    var todoes6 : Results<ScheduleDescription>!
    var todoes7 : Results<ScheduleDescription>!
    var todoes8 : Results<ScheduleDescription>!
    
    var selecttodo : ScheduleDescription!
    
    var selectedIndexPath = IndexPath()
    
    var status1:String = ScheduleDescription.ScheduleStatus.hukushuu.rawValue
    var status2:String = ScheduleDescription.ScheduleStatus.yoshuu.rawValue
    
    
    @IBOutlet var headerPrevBtn: UIBarButtonItem!
    @IBOutlet var headerNextBtn: UIBarButtonItem!
    @IBOutlet var headerTitle: UINavigationItem!
    @IBOutlet var calendarHeaderView : UIView!
    @IBOutlet var calendarCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        calendarCollectionView.backgroundColor = UIColor.white
        
        headerTitle.title = changeHeaderTitle(date: selectedDate) //追記
        self.loadtodoes()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //barbuttonitemのフォントを変えたい
        if let font = UIFont(name: "HiraginoSans-W6", size: 15) {
            headerNextBtn.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
            headerPrevBtn.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
        }
    }
    
    
    
    //headerの月を変更
    func changeHeaderTitle(date: NSDate) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "M/yyyy"
        let selectMonth = formatter.string(from: date as Date)
        return selectMonth
    }
    
    
    //①タップ時(前の月)
    @IBAction func tappedHeaderPrevBtn(sender: UIBarButtonItem) {
        selectedDate = dateManager.prevMonth(date: selectedDate)
        calendarCollectionView.reloadData()
        headerTitle.title = changeHeaderTitle(date: selectedDate)
    }
    
    //②タップ時(次の月)
    @IBAction func tappedHeaderNextBtn(sender: UIBarButtonItem) {
        selectedDate = dateManager.nextMonth(date: selectedDate)
        calendarCollectionView.reloadData()
        headerTitle.title = changeHeaderTitle(date: selectedDate)
    }
    
    
}

extension ViewController: UICollectionViewDataSource {
    
    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    //2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section毎にCellの総数を変える.
        if section == 0 {
            return 7
        } else {
            return dateManager.daysAcquisition() //ここは月によって異なる(後ほど説明します)
        }
    }
    //3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CalendarCell
        
        
        //テキストカラー
        if (indexPath.row % 7 == 0) {
            cell.textLabel.textColor = UIColor.lightRed()
        } else if (indexPath.row % 7 == 6) {
            cell.textLabel.textColor = UIColor.lightBlue()
        } else {
            cell.textLabel.textColor = UIColor.gray
        }
        //テキスト配置
        if indexPath.section == 0 {
            cell.textLabel.text = weekArray[indexPath.row]
            
        } else {
            cell.textLabel.text = dateManager.conversionDateFormat(indexPath: indexPath as NSIndexPath)
            //月によって1日の場所は異なる(後ほど説明します)
            
            //枠線 （いらないかも
            cell.frameLabel.layer.borderColor = UIColor.lightlightGray().cgColor
            cell.frameLabel.layer.borderWidth = 1
            cell.frameLabel.layer.cornerRadius = 8
            
            
            if todoes  == nil {
                cell.markLabel.isHidden = true
            } else if todoes2 == nil {
                cell.markLabel.isHidden = true
            } else if todoes3 == nil {
                cell.markLabel.isHidden = true
            } else if todoes4 == nil {
                cell.markLabel.isHidden = true
            } else if todoes5 == nil {
                cell.markLabel.isHidden = true
            } else if todoes6 == nil {
                cell.markLabel.isHidden = true
            } else if todoes7 == nil {
                cell.markLabel.isHidden = true
            } else if todoes8 == nil {
                cell.markLabel.isHidden = true
            } else {
             //丸
            cell.markLabel.layer.borderColor = UIColor.lightGreenBlue().cgColor
            cell.markLabel.layer.borderWidth = 1
            cell.markLabel.layer.cornerRadius = 5
            cell.markLabel.layer.backgroundColor = UIColor.lightGreenBlue().cgColor
            }
            
        }
        
        
        
        
        return cell
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toCalendarSchedule") {
            let controller = segue.destination as! CalendarScheduleViewController
            let array = sender as! [Int]
            controller.beginDate = beginningOfDay(with: array[0], month: array[1], day: array[2])
            controller.endDate = endOfDay(with: array[0], month: array[1], day: array[2])
            
            
            
        }
    }
    
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // SubViewController へ遷移するために Segue を呼び出す
        print("selectedDate"+String(describing: selectedDate))
        print(dateManager.conversionDateFormat(indexPath: indexPath as NSIndexPath))
        print(indexPath.row)
        var day = Int()
        var month = Int()
        var year = Int()
        let calendar = NSCalendar.current
        
        //日付ごとに記録されている内容を分類する
        year = calendar.component(.year, from: selectedDate as Date )
        day = Int(dateManager.conversionDateFormat(indexPath: indexPath as NSIndexPath))!
        if indexPath.row < 6 && day > 8{
            month = calendar.component(.month, from: selectedDate as Date) - 1
        } else if indexPath.row > 27 && day < 8 {
            month = calendar.component(.month, from: selectedDate as Date) + 1
        } else {
            month = calendar.component(.month, from: selectedDate as Date)
        }
        
        print(year)
        print(month)
        print(day)
        print(indexPath.row)
        
        cellTapped = true
        
        self.performSegue(withIdentifier: "toCalendarSchedule",sender: [year,month,day])
        
    }
    
    func endOfDay(with year:Int, month :Int, day :Int) -> NSDate {
        
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let dateString = String(year) + "/" + String(month) + "/" + String(day) + " 08:59:59"
        
        let yesterdaydate = dateFormatter.date(from: dateString)!  as NSDate
        
        var time = yesterdaydate.timeIntervalSince1970
        time += 60*60*24
        
        let newDate: NSDate = NSDate.init(timeIntervalSince1970: time)
        print("昨日" + dateFormatter.string(from: yesterdaydate as Date))
        print("明日" + dateFormatter.string(from: newDate as Date))
        
        return newDate
    }
    
    func beginningOfDay(with year:Int, month :Int, day :Int) -> NSDate {
        
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let dateString = String(year) + "/" + String(month) + "/" + String(day) + " 09:00:00"
        return dateFormatter.date(from: dateString)! as NSDate
    }
    
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    //セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height: CGFloat = width * 1.0
        return CGSize(width: width, height: height)
        
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    //日付に予定が入ってるかどうかを知る
    func loadtodoes() {
        todoes  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "dueDate <= %@ AND dueDate >= %@" ,                                                     argumentArray: [endOfDay, beginningOfDay])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        //日付Aをタップした時に　nextDayが日付Aになっているデータをこの中に入れる。
        todoes2  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "nextDay <= %@ AND nextDay >= %@ AND statusStr == %@" ,
                                                     argumentArray: [endOfDay,beginningOfDay,status1])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        //日付aをタップした時に　nextWeekが日付aになっているデータをこの中に入れる
        todoes3  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "nextWeek <= %@ AND nextWeek >= %@ AND statusStr == %@" ,
                                                     argumentArray: [endOfDay, beginningOfDay,status1])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes4  = {
            
            let realm = try! Realm()
            let Predicate: NSPredicate = NSPredicate(format: "nextMonth <= %@ AND nextMonth >= %@ AND statusStr == %@" ,
                                                     argumentArray: [endOfDay,beginningOfDay,status1])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes5 = {
            
            let realm = try! Realm()
            let Predicate:NSPredicate = NSPredicate(format: "dayBefore <= %@ AND dayBefore >= %@ AND statusStr == %@",
                                                    argumentArray:[endOfDay, beginningOfDay,status2])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes6 = {
            
            let realm = try! Realm()
            let Predicate:NSPredicate = NSPredicate(format: "monthBefore <= %@ AND monthBefore >= %@ AND statusStr == %@",
                                                    argumentArray:[endOfDay, beginningOfDay,status2])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes7 = {
            
            let realm = try! Realm()
            let Predicate:NSPredicate = NSPredicate(format: "monthBeforeDayNext <= %@ AND monthBeforeDayNext >= %@ AND statusStr == %@",
                                                    argumentArray:[endOfDay, beginningOfDay,status2])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        todoes8 = {
            
            let realm = try! Realm()
            let Predicate:NSPredicate = NSPredicate(format: "monthBeforeWeekNext <= %@ AND monthBeforeWeekNext >= %@ AND statusStr == %@",
                                                    argumentArray:[endOfDay, beginningOfDay,status2])
            return realm.objects(ScheduleDescription.self).filter(Predicate)
        }()
        
        
        
    }
    
    
}







