//
//  ZXCloseFooterView.swift
//  FindCar
//
//  Created by screson on 2018/1/22.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

protocol ZXCloseFooteViewDelegate: class {
    func zxCloseFooterView(footerView: ZXCloseFooterView, expaned: Bool, section: Int)
}

class ZXCloseFooterView: UITableViewHeaderFooterView {
    
    weak var delegate: ZXCloseFooteViewDelegate?

    @IBOutlet weak var btnExpand: UIButton!
    fileprivate var expaned = false
    fileprivate var zx_section = -1
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func reloadExpaned(_ expaned: Bool, section: Int) {
        self.expaned = expaned
        self.zx_section = section
        if self.expaned {
            self.btnExpand.setImage(#imageLiteral(resourceName: "shouqi"), for: .normal)
        } else {
            self.btnExpand.setImage(#imageLiteral(resourceName: "zhankai"), for: .normal)
        }
    }
    
    @IBAction func expandAction(_ sender: UIButton) {
        delegate?.zxCloseFooterView(footerView: self, expaned: !self.expaned, section: self.zx_section)
    }
    

}
