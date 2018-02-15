//
//  CalendarCell.swift
//  暗記アプリ
//
//  Created by 藤原和矢 on 2018/02/01.
//  Copyright © 2018年 藤原和矢. All rights reserved.
//

import UIKit


//枠線用にextensionを作る
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
}


class CalendarCell: UICollectionViewCell {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var frameLabel: UILabel!
    @IBOutlet var markLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        
        // UILabelを生成
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.baselineAdjustment = .alignBaselines
        
        frameLabel = UILabel(frame: CGRect(x: 0, y: 0 ,width: 50, height: 50))
        frameLabel.baselineAdjustment = .alignBaselines
        
        markLabel = UILabel(frame: CGRect(x: 27, y:5, width: 10, height: 10))
        markLabel.baselineAdjustment = .alignBaselines
       
        // Cellに追加
        self.addSubview(textLabel!)
        self.addSubview(frameLabel!)
        self.addSubview(markLabel!)
        
    }
    
   }
