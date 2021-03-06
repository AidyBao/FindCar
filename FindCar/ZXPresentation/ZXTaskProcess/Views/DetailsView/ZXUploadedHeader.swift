//
//  ZXUploadedHeader.swift
//  FindCar
//
//  Created by screson on 2018/1/5.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

/// 已上传信息 抬头说明
class ZXUploadedHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubTitle: UILabel!
    @IBOutlet weak var lbLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .white
        self.lbLine.isHidden = true
        self.lbTitle.font = UIFont.boldSystemFont(ofSize: UIFont.zx_titleFontSize)
        self.lbTitle.textColor = UIColor.zx_textColorTitle
        
        self.lbSubTitle.font = UIFont.zx_bodyFont
        self.lbSubTitle.textColor = UIColor.zx_textColorTitle
        
        self.lbTitle.text = ""
        self.lbSubTitle.text = ""
        
    }
        
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
