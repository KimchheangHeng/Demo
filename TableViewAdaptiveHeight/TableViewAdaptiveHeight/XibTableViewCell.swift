//
//  XibTableViewCell.swift
//  TableViewAdaptiveHeight
//
//  Created by 星宇陈 on 15/1/25.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class XibTableViewCell: UITableViewCell {

  @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
      println("awakeFromNib")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
