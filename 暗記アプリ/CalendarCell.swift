//
//  CalendarCell.swift
//  暗記アプリ
//
//  Created by 藤原和矢 on 2017/05/03.
//  Copyright © 2017年 藤原和矢. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    var textLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // UILabelを生成
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        textLabel.textAlignment = NSTextAlignment.center
        // Cellに追加
        self.addSubview(textLabel!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    
}
