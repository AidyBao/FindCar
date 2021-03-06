//
//  ZXDefaultView.swift
//  FindCar
//
//  Created by 120v on 2018/1/3.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

typealias ZXDefaultViewBlock = (ZXDefaultView, Int) -> Void

class ZXDefaultView: UIView {
    struct ZXDefaultBtnTag {
        static let deft          = 1211
        static let agency        = 1212
        static let new           = 1213
    }
    
    @IBOutlet weak var toolView: UIView!
    @IBOutlet weak var defaultBtn: ZXStatusButton!
    @IBOutlet weak var agencyBtn: ZXStatusButton!
    @IBOutlet weak var newIssueBtn: ZXStatusButton!
    @IBOutlet weak var toolViewH: NSLayoutConstraint!
    var block: ZXDefaultViewBlock?
    var defaultId: Int = 1
    
    static func loadNib() -> ZXDefaultView{
        let nibView:ZXDefaultView = Bundle.main.loadNibNamed("ZXDefaultView", owner: self, options: nil)?.first as! ZXDefaultView
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
        
        self.toolView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 44)
    }
    
    func setUIStyle() {
        self.defaultBtn.titleLabel?.font = UIFont.zx_subTitleFont
        self.agencyBtn.titleLabel?.font = UIFont.zx_subTitleFont
        self.newIssueBtn.titleLabel?.font = UIFont.zx_subTitleFont
    }
    
    func setDefaultValue(_ index: Int) {
        defaultId = index
        switch index {
        case 1:
            self.defaultBtn.zx_isSelected(true)
        case 2:
            self.agencyBtn.zx_isSelected(true)
        case 3:
            self.newIssueBtn.zx_isSelected(true)
        default:
            break
        }
    }
    
    func setAnima() {
        self.toolViewH.constant = 0
        self.toolView.alpha = 0
        UIView.animate(withDuration: 0.35, animations: {
            self.toolViewH.constant = 44.0
            self.toolView.alpha = 1.0
        }) { (finish) in
            self.alpha = 1.0
        }
    }
    
    @IBAction func toolBtnAction(_ sender: UIButton) {
        switch sender.tag {
        case ZXDefaultBtnTag.deft:
            defaultId = 1
        case ZXDefaultBtnTag.agency:
            defaultId = 2
        case ZXDefaultBtnTag.new:
            defaultId = 3
        default:
            break
        }
        if block != nil {
            block?(self,defaultId)
        }
        self.dismiss()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if block != nil {
            block?(self,defaultId)
        }
        
        self.dismiss()
    }
    
    func dismiss() {
        
        self.toolViewH.constant = 44
        self.toolView.alpha = 1
        UIView.animate(withDuration: 0.35, animations: {
            self.toolViewH.constant = 0.0
            self.toolView.alpha = 0.0
        }) { (finish) in
            self.alpha = 0.0
        }
        
        self.removeFromSuperview()
    }
}
