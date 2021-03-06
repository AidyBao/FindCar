//
//  ZXAboutHeaderCell.swift
//  FindCar
//
//  Created by 120v on 2018/2/7.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXAboutHeaderCell: UITableViewCell {
    
    static let ZXAboutHeaderCellID: String = "ZXAboutHeaderCell"
    
    @IBOutlet weak var logoImg: ZXUIImageView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var vLB: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.zx_backgroundColor
        
        nameLB.font = UIFont.zx_titleFont(20.0)
        nameLB.textColor = UIColor.zx_textColorTitle
        
        vLB.font = UIFont.zx_bodyFont(12.0)
        vLB.textColor = UIColor.zx_textColorMark
        vLB.text = "当前版本：v\(ZXDevice.zx_getBundleVersion())"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
