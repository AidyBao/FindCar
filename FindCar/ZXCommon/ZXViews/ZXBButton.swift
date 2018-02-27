//
//  ZXBButton.swift
//  YDHYK
//
//  Created by 120v on 2017/11/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@IBDesignable
class ZXBButton: ZXStatusButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)

    }
    
    override func setUI() {
        if isSelected {
            self.setImage(#imageLiteral(resourceName: "icon-shou"), for: .selected)
            self.setTitleColor(UIColor.zx_tintColor, for: .selected)
        }else{
            self.setImage(#imageLiteral(resourceName: "icon-more"), for: .normal)
            self.setTitleColor(UIColor.zx_textColorTitle, for: .normal)
        }
        sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.frame.origin.x = self.frame.size.width*0.5 - (self.titleLabel?.frame.size.width)!*0.5
        self.imageView?.frame.origin.x = self.titleLabel!.frame.maxX + 2
    }
}
