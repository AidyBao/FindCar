//
//  ZXTaskBannerCell.swift
//  FindCar
//
//  Created by 120v on 2017/12/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXTaskBannerCellDelegate: NSObjectProtocol {
    func didSelectedBannerCell(_ bId: Int,_ title: String)
}

class ZXTaskBannerCell: UITableViewCell {
    
    static let ZXTaskBannerCellID: String = "ZXTaskBannerCell"
    weak var delegate: ZXTaskBannerCellDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    var bannerView: ZXBannerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addBannerView()

        self.backgroundColor = UIColor.zx_subTintColor
        
        self.contentView.layer.masksToBounds = true
    }
    
    func addBannerView() {
        bannerView = ZXBannerView.init(frame: CGRect.init(x: 0, y: 0, width: ZXBOUNDS_WIDTH, height: 146.0))
        contentView.addSubview(bannerView)
        bannerView.block = {(view: ZXBannerView, index: Int, urlStr: String) in
            if self.bannerArr.count > 0 {
                let model = self.bannerArr[index]
                if self.delegate != nil {
                    self.delegate?.didSelectedBannerCell(model.bannerId,model.title)
                }
            }
        }
    }
    
    func loadData(_ arr: Array<ZXBannerModel>) {
        bannerArr = arr
        var imgUrls: Array<String> = Array.init()
        for (_,model) in arr.enumerated() {
            if model.titleUrlStr.isEmpty == false {
                imgUrls.append(model.titleUrlStr)
            }
        }
        bannerView.loadData(imgUrls)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bannerView?.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: - Lazy
    lazy var bannerArr: Array<ZXBannerModel> = {
        let arr: Array<ZXBannerModel> = Array.init()
        return arr
    }()
}

