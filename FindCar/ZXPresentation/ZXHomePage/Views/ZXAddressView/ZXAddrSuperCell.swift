//
//  ZXAddrSuperCell.swift
//  FindCar
//
//  Created by 120v on 2018/1/9.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXAddrSuperCell: UITableViewCell {
    
    static let ZXAddrSuperCellID: String = "ZXAddrSuperCell"
    
    @IBOutlet weak var titleLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLB.font = UIFont.zx_subTitleFont
        titleLB.textColor = UIColor.zx_textColorBody
    }
    
    func loadData(_ model: ZXProvince) {
        titleLB.text = model.shortName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            titleLB.textColor = UIColor.zx_tintColor
        }else{
            titleLB.textColor = UIColor.zx_textColorBody
        }
    }
}
