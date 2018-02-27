//
//  ZXUploadedMultiImageCell.swift
//  FindCar
//
//  Created by screson on 2018/1/5.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXUploadedMultiImageCell: ZXTableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    weak var delegate: ZXImageInputCellDelegate?
    
    static let height: CGFloat = ZXUploadedMultiImageCell.itemSize + 60
    ///单张图片高度
    static let singleImageHeight: CGFloat = 190
    
    static let itemSize: CGFloat = floor((ZXBOUNDS_WIDTH - 14 * 2 - 30 - 10 * 2 - 10 * 2) / 3)
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ccvList: UICollectionView!
    @IBOutlet weak var ccvHeight: NSLayoutConstraint!
    
    fileprivate var images: Array<String> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbTitle.font = UIFont.zx_bodyFont
        self.lbTitle.textColor = UIColor.zx_textColorMark
        
        self.ccvList.register(UINib.init(nibName: ZXImageControlCCVCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXImageControlCCVCell.reuseIdentifier)
        self.ccvList.delegate = self
        self.ccvList.dataSource = self
        self.ccvHeight.constant = ZXUploadedMultiImageCell.itemSize
    }
    
    func reloadData(_ images: Array<String>) {
        self.images = images
        self.ccvList.reloadData()
        if self.images.count > 1 {
            self.ccvHeight.constant = ZXUploadedMultiImageCell.itemSize
        } else {
            self.ccvHeight.constant = 130
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.zxImageInputCell(cell: self, selectAt: indexPath.row, pointView: self.ccvList.cellForItem(at: indexPath))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXImageControlCCVCell.reuseIdentifier, for: indexPath) as! ZXImageControlCCVCell
        cell.reloadImage(URL.init(string: images[indexPath.row]), type: .justShow, bigDefault: (self.images.count > 1) ? false: true)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if images.count > 1 {
            return CGSize(width: ZXUploadedMultiImageCell.itemSize, height: ZXUploadedMultiImageCell.itemSize)
        }
        return CGSize(width: ZXBOUNDS_WIDTH - ZXUploadedMultiImageCell.itemSize - 30, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
