//
//  ZXTaskStatusProgressCell.swift
//  FindCar
//
//  Created by screson on 2018/1/3.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit


/// 任务进度
class ZXTaskStatusProgressCell: ZXTableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    fileprivate let arrTitles = ["匹配成功", "公司确认", "获取授权", "取到车辆", "车辆交接", "完成任务"]
    fileprivate var colors: Array<ZXTaskProgressColor> = []
    @IBOutlet weak var ccvList: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ccvList.delegate = self
        self.ccvList.dataSource = self
        self.ccvList.register(UINib.init(nibName: ZXTaskProcesseCCVCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXTaskProcesseCCVCell.reuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadProgress(list: [ZXTaskProgressColor]?) {
        self.colors = list ?? []
        self.ccvList.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXTaskProcesseCCVCell.reuseIdentifier, for: indexPath) as! ZXTaskProcesseCCVCell
        var color = ZXTaskProgressColor.gray
        var isHightlighted = false
        if colors.count > 0 {
            color = self.colors[indexPath.row]
            if indexPath.row >= 5 {//最后一个
                if color != .gray {
                    isHightlighted = true
                }
            } else {
                let nextColor = colors[indexPath.row + 1]
                if color != .gray , nextColor == .gray {//自己已开始，下一个未开始
                    isHightlighted = true//文字高亮
                }
            }
        }
        cell.reloadStatus(progressColor: color, title: arrTitles[indexPath.row], titleHighlighted: isHightlighted)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ZXTaskProcesseCCVCell.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
