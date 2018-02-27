//
//  ZXStatusButton.swift
//  FindCar
//
//  Created by 120v on 2018/1/3.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

@IBDesignable
class ZXStatusButton: ZXUIButton {
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUI()
    }
    
    func zx_isSelected(_ selected: Bool) {
        self.isSelected = selected
        self.backgroundColor = UIColor.white
        if isSelected {
            self.setTitleColor(UIColor.zx_tintColor, for: .selected)
        }else{
            self.setTitleColor(UIColor.zx_textColorTitle, for: .normal)
        }
    }

    func setUI() {
//        self.backgroundColor = UIColor.white
//        if isSelected {
//            self.setTitleColor(UIColor.zx_tintColor, for: .selected)
//        }else{
//            self.setTitleColor(UIColor.zx_textColorTitle, for: .normal)
//        }
    }
}
