//
//  ZXPersonalInfoCell.swift
//  FindCar
//
//  Created by screson on 2017/12/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 个人信息CELL
class ZXPersonalInfoCell: ZXTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static let height: CGFloat = 180
    @IBOutlet weak var lbTel: UILabel!
    @IBOutlet weak var lbCompany: UILabel!
    
    @IBOutlet weak var ccvList: UICollectionView!
    var perModel: ZXBaseInfoModel = ZXBaseInfoModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ccvList.register(UINib.init(nibName: ZXMatchInfoCCVCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXMatchInfoCCVCell.reuseIdentifier)
        self.ccvList.delegate = self
        self.ccvList.dataSource = self
        
        self.lbTel.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        self.lbTel.textColor = UIColor.zx_textColorTitle
        
        self.lbCompany.font = UIFont.zx_bodyFont
        self.lbCompany.textColor = UIColor.zx_textColorMark
    }
    
    func loadData(_ baseModel: ZXBaseInfoModel) {
        perModel = baseModel
        ccvList.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXMatchInfoCCVCell.reuseIdentifier, for: indexPath) as! ZXMatchInfoCCVCell
        switch indexPath.row {
        case 0:
            cell.lbType.text = "上传照片"
            cell.setMatchValue("\(perModel.uploadImgTimes)", unit: "次")
        case 1:
            cell.lbType.text = "匹配成功"
            cell.setMatchValue("\(perModel.getTaskNumber)", unit: "次")
        case 2:
            cell.lbType.text = "完成任务"
            cell.setMatchValue("\(perModel.finishTaskNumber)", unit: "次")
        case 3:
            cell.lbType.text = "任务总金额"
            cell.setMatchValue("\(perModel.sumTaskPrice)", unit: "万元")
        default:
            cell.lbType.text = ""
            cell.lbValue.text = ""
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: ZXMatchInfoCCVCell.width, height: ZXMatchInfoCCVCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
