//
//  ZXMatchInfoCCVCell.swift
//  FindCar
//
//  Created by screson on 2017/12/29.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 匹配任务CELL
class ZXMatchInfoCCVCell: UICollectionViewCell {
    
    static let width: CGFloat = CGFloat(floor((ZXBOUNDS_WIDTH - 20 * 2) / 4))
    static let height: CGFloat = 70
    
    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbValue.font = UIFont.zx_numberFont(UIFont.zx_titleFontSize + 2)
        self.lbType.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 2)
        self.lbValue.textColor = UIColor.zx_textColorTitle
        self.lbType.textColor = UIColor.zx_textColorMark
    }
    
    func setMatchValue(_ value: String, unit: String) {
        let str = value + unit
        let attrStr = NSMutableAttributedString.init(string: str)
        attrStr.zx_appendFont(font: UIFont.zx_bodyFont(12), at: NSMakeRange(value.count, unit.count))
        self.lbValue.attributedText = attrStr
        
    }
}
