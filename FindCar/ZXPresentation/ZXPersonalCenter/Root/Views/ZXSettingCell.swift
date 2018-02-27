//
//  ZXSettingCell.swift
//  FindCar
//
//  Created by screson on 2017/12/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXSettingCell: ZXTableViewCell {
    static let height: CGFloat = 60
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTtitle: UILabel!
    @IBOutlet weak var lbArrow: UIImageView!
    @IBOutlet weak var sLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.sLine.backgroundColor = UIColor.zx_subTintColor
        self.lbTtitle.font = UIFont.zx_bodyFont
        self.lbTtitle.textColor = UIColor.zx_textColorBody
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
