//
//  ZXTaskStatusHeaderCell.swift
//  FindCar
//
//  Created by screson on 2018/1/3.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

/// 任务进行中状态、剩余时间标题
class ZXTaskStatusHeaderCell: ZXTableViewCell {
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbTimeTitle: UILabel!
    @IBOutlet weak var lbLeaveTime: UILabel!
    
    @IBOutlet weak var vLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vLine.backgroundColor = UIColor.zx_tintColor
        
        self.lbStatus.font = UIFont.systemFont(ofSize: UIFont.zx_titleFontSize, weight: UIFont.Weight.medium)
        self.lbStatus.textColor = UIColor.zx_tintColor
        
        self.lbTimeTitle.textColor = UIColor.zx_textColorTitle
        self.lbTimeTitle.font = UIFont.zx_titleFont
        
        self.lbLeaveTime.textColor = UIColor.zx_tintColor
        self.lbLeaveTime.font = UIFont.zx_bodyFont
        
        self.lbStatus.text = ""
        self.lbLeaveTime.text = ""
    }
    
    func reloadData(model: ZXTaskModel?) {
        self.lbStatus.text = ""
        self.lbLeaveTime.text = ""
        self.lbTimeTitle.isHidden = true
        
        if let model = model {
            //if model.otherMatched {//
            if model.showExtralMsg{
                self.vLine.backgroundColor = UIColor.zx_customAColor
                self.lbStatus.textColor = UIColor.zx_customAColor
                if model.otherMatched {
                    self.lbStatus.text = "任务已被领取"
                } else {
                    self.lbStatus.text = model.zx_status.description()
                    if !model.taskRemainingTimeStr.isEmpty {
                        self.lbTimeTitle.isHidden = false
                        self.lbLeaveTime.text = model.taskRemainingTimeStr
                    }
                }
            } else {
                self.vLine.backgroundColor = UIColor.zx_tintColor
                self.lbStatus.textColor = UIColor.zx_tintColor
                self.lbStatus.text = model.zx_status.description()
                if !model.taskRemainingTimeStr.isEmpty {
                    self.lbTimeTitle.isHidden = false
                    self.lbLeaveTime.text = model.taskRemainingTimeStr
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
