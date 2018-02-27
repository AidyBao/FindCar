//
//  ZXTaskStatusView.swift
//  FindCar
//
//  Created by 120v on 2018/1/3.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

typealias ZXTaskStatusViewBlock = (ZXTaskStatusView, Int) -> Void

class ZXTaskStatusView: UIView {
    
    struct ZXStatusBtnTag {
        static let all          = 1241
        static let wait         = 1242
        static let ongoing      = 1243
        static let finish       = 1244
    }

    var block: ZXTaskStatusViewBlock?
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backViewH: NSLayoutConstraint!
    @IBOutlet weak var allBtn: ZXStatusButton!
    @IBOutlet weak var waitBtn: ZXStatusButton!
    @IBOutlet weak var ongoingBtn: ZXStatusButton!
    @IBOutlet weak var finishBtn: ZXStatusButton!
    var taskId: Int = 0
    
    static func loadNib() -> ZXTaskStatusView{
        let nibView:ZXTaskStatusView = Bundle.main.loadNibNamed("ZXTaskStatusView", owner: self, options: nil)?.first as! ZXTaskStatusView
        return nibView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.setAnima()
        
        self.setUIStyle()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.setAnima()
        
        self.setUIStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = CGRect.init(x: 0, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        
        self.backView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 44.0)
    }
    
    func setUIStyle() {
        self.allBtn.titleLabel?.font = UIFont.zx_subTitleFont
        self.waitBtn.titleLabel?.font = UIFont.zx_subTitleFont
        self.ongoingBtn.titleLabel?.font = UIFont.zx_subTitleFont
        self.finishBtn.titleLabel?.font = UIFont.zx_subTitleFont
    }
    
    func setAnima() {
        self.backViewH.constant = 0
        self.backView.alpha = 0
        UIView.animate(withDuration: 0.35, animations: {
            self.backViewH.constant = 44.0
            self.backView.alpha = 1.0
        }) { (finish) in
            self.alpha = 1.0
        }
    }
    
    func setDefaultValue(_ defaultId: Int) {
        taskId = defaultId
        switch defaultId {
        case 0:
            self.allBtn.zx_isSelected(true)
        case 1:
            self.waitBtn.zx_isSelected(true)
        case 2:
            self.ongoingBtn.zx_isSelected(true)
        case 3:
            self.finishBtn.zx_isSelected(true)
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if block != nil {
            block?(self,taskId)
        }
        
        self.dismiss()
    }
    
    func dismiss() {
        
        self.backViewH.constant = 44.0
        self.backView.alpha = 1
        UIView.animate(withDuration: 0.35, animations: {
            self.backViewH.constant = 0.0
            self.backView.alpha = 0.0
        }) { (finish) in
            self.alpha = 0.0
        }
        
        self.removeFromSuperview()
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case ZXStatusBtnTag.all:
            taskId = 0
        case ZXStatusBtnTag.wait:
            taskId = 1
        case ZXStatusBtnTag.ongoing:
            taskId = 2
        case ZXStatusBtnTag.finish:
            taskId = 3
        default:
            break
        }
        if block != nil {
            block?(self,taskId)
        }
        
        self.dismiss()
    }
}
