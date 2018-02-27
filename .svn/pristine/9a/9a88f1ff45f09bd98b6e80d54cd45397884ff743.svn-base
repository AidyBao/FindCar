//
//  ZXTagsCCVCell.swift
//  FindCar
//
//  Created by screson on 2017/12/29.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXTagsCCVCell: UICollectionViewCell {

    @IBOutlet weak var zxContentView: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.zxContentView.layer.cornerRadius = 10
        self.zxContentView.backgroundColor = UIColor.zx_subTintColor
        self.lbName.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 3)
        self.lbName.textColor = UIColor.zx_textColorMark
        self.lbName.highlightedTextColor = UIColor.zx_tintColor
    }
    
    func setName(_ name: String, own: Bool, enable: Bool) {
        self.lbName.text = name
        if own {
            if enable {
                self.zxContentView.backgroundColor = UIColor.zx_subTintColor
                self.imgIcon.highlightedImage = #imageLiteral(resourceName: "gou")
                self.lbName.isHighlighted = true
                self.imgIcon.isHighlighted = true
            } else {
                self.zxContentView.backgroundColor = UIColor.zx_colorRGB(243, 243, 243, 1.0)
                self.imgIcon.highlightedImage = #imageLiteral(resourceName: "zx_own_gray")
                self.lbName.isHighlighted = false
                self.imgIcon.isHighlighted = true
            }
        } else {
            self.zxContentView.backgroundColor = UIColor.zx_colorRGB(243, 243, 243, 1.0)
            self.lbName.isHighlighted = false
            self.imgIcon.isHighlighted = false
        }
    }
}
