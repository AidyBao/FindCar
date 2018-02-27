//
//  ZXAddrSubCell.swift
//  FindCar
//
//  Created by 120v on 2018/1/9.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXAddrSubCell: UITableViewCell {
    
    static let ZXAddrSubCellID: String = "ZXAddrSubCell"
    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var countLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLB.font = UIFont.zx_subTitleFont
        titleLB.textColor = UIColor.zx_textColorBody
        
        countLB.font = UIFont.zx_subTitleFont
        countLB.textColor = UIColor.zx_textColorBody
    }
    
    func loadData(_ cityModel: ZXCity) {
        self.titleLB.text = cityModel.shortName
        self.countLB.text = "\(cityModel.taskNum)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            titleLB.textColor = UIColor.zx_tintColor
            countLB.textColor = UIColor.zx_tintColor
        }else{
            titleLB.textColor = UIColor.zx_textColorBody
            countLB.textColor = UIColor.zx_textColorBody
        }
    }
}
