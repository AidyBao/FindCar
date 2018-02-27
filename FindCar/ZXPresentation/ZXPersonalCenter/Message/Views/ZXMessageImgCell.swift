//
//  ZXMessageImgCell.swift
//  FindCar
//
//  Created by 120v on 2018/1/8.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXMessageImgCell: UITableViewCell {
    
    static let ZXMessageImgCellID: String = "ZXMessageImgCell"

    
    @IBOutlet weak var bottonView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var detailLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.zx_subTintColor
        
        self.backView.backgroundColor = UIColor.clear

        
        self.bottonView.layer.cornerRadius = 6.0
        self.bottonView.layer.masksToBounds = false
        self.bottonView.layer.shadowColor = UIColor.darkGray.cgColor
        self.bottonView.layer.shadowRadius = 6.0
        self.bottonView.layer.shadowOffset = CGSize.init(width: 0, height: 3.0)
        self.bottonView.layer.shadowOpacity = 0.25
        
        self.backView.layer.cornerRadius = 6.0
        self.backView.layer.masksToBounds = true
        
        self.imgView.backgroundColor = UIColor.clear
        self.imgView.clipsToBounds = true
        
        self.detailLB.font = UIFont.zx_bodyFont
    }
    
    override func layoutSubviews() {

    }
    
    func loadData(_ model: ZXMsgNoticeModel) {
        self.imgView.kf.setImage(with: URL.init(string: model.contentImgStr), placeholder: UIImage.Default.big, options: nil, progressBlock: nil, completionHandler: nil)
        self.detailLB.text = model.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
