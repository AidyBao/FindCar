//
//  ZXTaskNavCell.swift
//  FindCar
//
//  Created by 120v on 2018/1/4.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

protocol ZXTaskNavCellDelegate: NSObjectProtocol {
    func didSearchAction()
    func didMessageAction()
}

class ZXTaskNavCell: UITableViewCell {
    
     static let ZXTaskNavCellID: String = "ZXTaskNavCell"
    
    weak var delegate: ZXTaskNavCellDelegate?
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didSearchAction()
        }
    }
    
    @IBAction func messageBtnAction(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageAction()
        }
    }
    
    
}
