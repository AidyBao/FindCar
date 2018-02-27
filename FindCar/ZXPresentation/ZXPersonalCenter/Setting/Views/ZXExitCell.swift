//
//  ZXExitCell.swift
//  FindCar
//
//  Created by 120v on 2018/1/8.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXExitCell: UITableViewCell {
    
    static let ZXExitCellID: String = "ZXExitCell"
    @IBOutlet weak var tixtLB: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tixtLB.font = UIFont.zx_bodyFont
        self.tixtLB.textColor = UIColor.zx_tintColor
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
