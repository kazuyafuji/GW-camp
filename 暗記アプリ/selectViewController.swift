//
//  selectViewController.swift
//  暗記アプリ
//
//  Created by 藤原和矢 on 2017/05/20.
//  Copyright © 2017年 藤原和矢. All rights reserved.
//

import UIKit

class selectViewController: UIViewController {
    
    var sDate : NSDate = NSDate()
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func cancel() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toDetail") {
            let controller = segue.destination as! ScheduleDetailViewController
            controller.sonoDate1 = self.sDate
        } else if (segue.identifier == "toDetail2") {
            let controller = segue.destination as! testScheduleViewController
            controller.sonoDate2 = self.sDate
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
