//
//  ZXSearchCell.swift
//  FindCar
//
//  Created by 120v on 2018/1/5.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

protocol ZXSearchCellDelegate: NSObjectProtocol {
    func didSearchCellDeletedAction(_ index: Int)
}

class ZXSearchCell: UITableViewCell {
    
    static let ZXSearchCellID: String = "ZXSearchCell"
    weak var delegate: ZXSearchCellDelegate?
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var deletedBtn: UIButton!
    var cellIndex: Int = -1

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(_ nameStr: String,_ index: Int) {
        self.cellIndex = index
        self.nameLB.text = nameStr
    }

    @IBAction func deletedBtnAction(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didSearchCellDeletedAction(self.cellIndex)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
