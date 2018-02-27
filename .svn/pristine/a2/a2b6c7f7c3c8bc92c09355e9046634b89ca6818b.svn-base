//
//  ZXAboutRootCell.swift
//  FindCar
//
//  Created by 120v on 2018/2/7.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXAboutRootCell: UITableViewCell {
    
    static let ZXAboutRootCellID: String = "ZXAboutRootCell"
    
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var geliLine: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLb.font = UIFont.zx_bodyFont
        nameLb.textColor = UIColor.zx_textColorBody
        
        geliLine.backgroundColor = UIColor.groupTableViewBackground
    }
    
    override func layoutSubviews() {
        
    }
    
    func loadData(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            nameLb.text = "联系我们"
        case 2:
            nameLb.text = "用户协议"
        case 3:
            nameLb.text = "分享App"
        default:
            break
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
