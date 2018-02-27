//
//  ZXUploadedTextInfoCell.swift
//  FindCar
//
//  Created by screson on 2018/1/5.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit


/// 录入的文字信息
class ZXUploadedTextInfoCell: ZXTableViewCell {
    
    static let height: CGFloat = 65
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDetailInfo: UILabel!
    
    @IBOutlet weak var sLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbTitle.font = UIFont.zx_bodyFont
        self.lbTitle.textColor = UIColor.zx_textColorMark

        self.lbDetailInfo.font = UIFont.zx_titleFont
        self.lbDetailInfo.textColor = UIColor.zx_textColorTitle

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
