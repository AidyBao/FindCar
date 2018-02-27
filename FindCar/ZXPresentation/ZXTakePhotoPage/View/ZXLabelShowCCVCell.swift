//
//  ZXLabelShowCCVCell.swift
//  FindCar
//
//  Created by screson on 2018/1/9.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXLabelShowCCVCell: UICollectionViewCell {

    @IBOutlet weak var lbNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbNumber.layer.borderWidth = 1
        self.lbNumber.layer.cornerRadius = 2
        self.lbNumber.layer.borderColor = UIColor.zx_textColorMark.cgColor
    }

}
