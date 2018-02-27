//
//  ZXTaskNavView.swift
//  FindCar
//
//  Created by 120v on 2018/1/19.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

protocol ZXTaskNavViewDelegate: NSObjectProtocol {
    func searchAction()
    func messageAction()
}

class ZXTaskNavView: UITableViewHeaderFooterView {
    
    static let ZXTaskNavViewID: String = "ZXTaskNavView"
    weak var delegate: ZXTaskNavViewDelegate?
    @IBOutlet weak var redDot: ZXUIView!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        redDot.isHidden = true
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        if delegate != nil {
            delegate?.searchAction()
        }
    }
    
    @IBAction func msgAction(_ sender: UIButton) {
        if delegate != nil {
            delegate?.messageAction()
        }
    }
    
    func reload(_ msgCount: Int) {
        if msgCount > 0 {
            redDot.isHidden = false
        }else{
            redDot.isHidden = true
        }
    }
}
