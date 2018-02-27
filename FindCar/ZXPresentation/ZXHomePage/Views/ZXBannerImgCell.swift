//
//  ZXBannerImgCell.swift
//  FindCar
//
//  Created by 120v on 2017/12/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXBannerImgCell: UICollectionViewCell {
    
    static let ZXBannerImgCellID: String = "ZXBannerImgCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        self.contentView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

}
