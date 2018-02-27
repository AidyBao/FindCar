//
//  ZXComButton.swift
//  FindCar
//
//  Created by 120v on 2018/1/8.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

@IBDesignable
class ZXComButton: ZXUIButton {

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
        if isSelected {
            self.backgroundColor = UIColor.zx_subTintColor
            self.setTitleColor(UIColor.zx_tintColor, for: .selected)
        }else{
            self.backgroundColor = UIColor.white
            self.setTitleColor(UIColor.zx_textColorTitle, for: .normal)
        }
    }
    
    func setUI() {
        if isSelected {
            self.backgroundColor = UIColor.zx_subTintColor
            self.setTitleColor(UIColor.zx_tintColor, for: .selected)
        }else{
            self.backgroundColor = UIColor.white
            self.setTitleColor(UIColor.zx_textColorTitle, for: .normal)
        }
    }
}
