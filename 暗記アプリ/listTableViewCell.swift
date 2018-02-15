//
//  listTableViewCell.swift
//  暗記アプリ
//
//  Created by 藤原和矢 on 2018/01/25.
//  Copyright © 2018年 藤原和矢. All rights reserved.
//

import UIKit

class listTableViewCell: UITableViewCell {
    
    @IBOutlet var yoteiLabel: UILabel!
    @IBOutlet var kaisuuLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
