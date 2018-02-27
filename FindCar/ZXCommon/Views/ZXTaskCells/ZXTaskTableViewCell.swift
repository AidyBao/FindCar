//
//  ZXTaskTableViewCell.swift
//  FindCar
//
//  Created by screson on 2017/12/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

let ZX_PlateChecked_Notice  =   "ZX_PlateChecked_NoticeName"

enum ZXTaskControlType {
    case none
    case uploadCarInfo  //补充车辆信息
    case verifyCarInfo  //验证车辆信息
    case handOverCar    //交接车辆
    case uploadSheet    //上传交接单
    func description() -> String {
        switch self {
        case .uploadCarInfo:
            return "补充车辆信息"
        case .verifyCarInfo:
            return "验证车辆信息"
        case .handOverCar,.uploadSheet:
            return "交接车辆"
        default:
            return ""
        }
    }
}

enum ZXTaskCellType {
    case inCommonList
    case inTaskDetail
    case inMessageList
    case finished
}

protocol ZXTaskTableViewCellDelegate: class {
    
    /// 收藏、取消收藏操作
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - mark: true 收藏
    ///   - model: ZXTaskModel
    func zxTaskTableViewCell(_ cell: ZXTaskTableViewCell, mark: Bool, model: ZXTaskModel?)
    
    /// 分享操作
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - model: ZXTaskModel
    func zxTaskTableViewCellShareAction(_ cell: ZXTaskTableViewCell, model: ZXTaskModel?)
    
    /// 完善信息操作
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - controlActionType: ZXTaskConrolType
    ///   - model: ZXTaskModel
    func zxTaskTableViewCell(_ cell: ZXTaskTableViewCell, controlActionType: ZXTaskControlType, model: ZXTaskModel?)
}

extension ZXTaskTableViewCellDelegate {
    func zxTaskTableViewCell(_ cell: ZXTaskTableViewCell, mark: Bool, model: ZXTaskModel?){}
    func zxTaskTableViewCellShareAction(_ cell: ZXTaskTableViewCell, model: ZXTaskModel?){}
    func zxTaskTableViewCell(_ cell: ZXTaskTableViewCell, controlActionType: ZXTaskControlType, model: ZXTaskModel?) {}
}

/// 任务CELL
class ZXTaskTableViewCell: ZXTableViewCell {
    
    fileprivate var zxType: ZXTaskCellType = ZXTaskCellType.inCommonList
    weak var delegate: ZXTaskTableViewCellDelegate?
    
    static let height: CGFloat = 300            //有操作
    static let height_noControl: CGFloat = 243  //无操作
    static let msgHeight: CGFloat = 355         //消息中心 多一个Header
    
    //var showType: ZXTaskCellType = ZXTaskCellType.markShare
    
    //控制左右边距
    @IBOutlet weak var rightOffset: NSLayoutConstraint!
    @IBOutlet weak var leftOffset: NSLayoutConstraint!
    
    //
    @IBOutlet weak var zxContentView: UIView!
    
    //消息列表界面   最新状态说明
    @IBOutlet weak var msgHeaderView: UIView!
    @IBOutlet weak var msgVLine: UIView!
    @IBOutlet weak var msgHLine: UIView!
    @IBOutlet weak var msgHeaderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lbMsgTitle: UILabel!
    
    //Header Info 任务状态、代理费
    @IBOutlet weak var headerInfoView: UIView!
    @IBOutlet weak var vLine: UIView!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbStatus1: UILabel!
    @IBOutlet weak var lbControlTips1: UILabel!
    @IBOutlet weak var lbAgentPrice: UILabel!
    
    //Car Type 车辆类型
    @IBOutlet weak var carTypeInfoView: UIView!
    @IBOutlet weak var lbCarTypeTitle: UILabel!
    @IBOutlet weak var lbCarTypeInfo: UILabel!
    
    //RegistLocation License Plate 归属地、车牌号
    @IBOutlet weak var carPlateInfoView: UIView!
    @IBOutlet weak var lbLocationTitle: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbPlateTitle: UILabel!
    @IBOutlet weak var lbPlateNumber: UILabel!
    
    //Car Keys/Recipt 发票、钥匙、合同、产权证、行驶证
    @IBOutlet weak var carKeysInfoView: UIView!
    @IBOutlet weak var ccvList: UICollectionView!
    @IBOutlet weak var extrolInfoViewLine: UIView!
    
    //Info Upload 个人任务操作
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var btnControlAction: UIButton!
    @IBOutlet weak var lbLeaveTime: UILabel!
    
    //Mark Share 关注、分享
    @IBOutlet weak var markShareView: UIView!
    @IBOutlet weak var btnMark: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    //完成时间
    @IBOutlet weak var finishedView: UIView!
    @IBOutlet weak var lbFinishedTime: UILabel!
    
    
    @IBOutlet weak var bottomOffset: NSLayoutConstraint!
    
    
    let tagsTitle = ["行驶证扫描件", "产权证扫描件", "备用钥匙", "车辆发票", "借款合同"]
    
    
    @IBOutlet weak var btnShowCarTypePopTips: UIButton!
    @IBOutlet weak var btnShowPlacePopTips: UIButton!
    @IBOutlet weak var btnShowPlateNumPopTips: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnShowPlateNumPopTips.isEnabled = false
        self.lbStatus1.isHidden = true
        self.lbControlTips1.isHidden = true
        self.controlView.isHidden = true
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        //进行中、代理费信息
        self.vLine.backgroundColor = UIColor.zx_tintColor
        self.lbStatus.textColor = UIColor.zx_tintColor
        self.lbStatus.font = UIFont.boldSystemFont(ofSize: UIFont.zx_titleFontSize - 1)
        
        self.lbStatus1.textColor = UIColor.zx_tintColor
        self.lbStatus1.font = UIFont.boldSystemFont(ofSize: UIFont.zx_titleFontSize - 1)
        
        self.lbControlTips1.textColor = UIColor.zx_tintColor
        self.lbControlTips1.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 2)
        
        self.lbAgentPrice.font = UIFont.boldSystemFont(ofSize: UIFont.zx_titleFontSize - 1)
        self.lbAgentPrice.textColor = UIColor.zx_customAColor
        
        //车型
        self.lbCarTypeTitle.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 2)
        self.lbCarTypeTitle.textColor = UIColor.zx_textColorMark
        
        self.lbCarTypeInfo.font = UIFont.zx_bodyFont
        self.lbCarTypeInfo.textColor = UIColor.zx_textColorBody
        
        //归属地 车牌
        self.lbLocationTitle.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 2)
        self.lbLocationTitle.textColor = UIColor.zx_textColorMark
        
        self.lbLocation.font = UIFont.zx_bodyFont
        self.lbLocation.textColor = UIColor.zx_textColorBody
        
        self.lbPlateTitle.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 2)
        self.lbPlateTitle.textColor = UIColor.zx_textColorMark
        
        self.lbPlateNumber.font = UIFont.zx_bodyFont
        self.lbPlateNumber.textColor = UIColor.zx_textColorBody
        
        //相关额外信息
        self.ccvList.isUserInteractionEnabled = false
        self.ccvList.register(UINib.init(nibName: ZXTagsCCVCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXTagsCCVCell.reuseIdentifier)
        self.ccvList.delegate = self
        self.ccvList.dataSource = self
        self.ccvList.allowsSelection = false
        
        let flowLayout = ZXMaxSpacingCCVLayout.init()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        self.ccvList.collectionViewLayout = flowLayout

        
        //剩余时间
        self.lbLeaveTime.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 2)
        self.lbLeaveTime.textColor = UIColor.zx_textColorTitle
        
        //
        //self.reloadShowType(.markShare)
        
        //操作按钮
        self.btnControlAction.layer.cornerRadius = 15
        self.btnControlAction.layer.borderColor = UIColor.zx_tintColor.cgColor
        self.btnControlAction.layer.borderWidth = 1.0
        self.btnControlAction.setTitleColor(UIColor.zx_tintColor, for: .normal)
        self.btnControlAction.titleLabel?.font = UIFont.zx_titleFont(13)
        //
        self.btnMark.layer.cornerRadius = 14
        self.btnMark.layer.borderColor = UIColor.zx_tintColor.cgColor
        self.btnMark.layer.borderWidth = 1.0
        self.btnMark.setTitleColor(UIColor.zx_tintColor, for: .normal)
        self.btnMark.titleLabel?.font = UIFont.zx_titleFont(13)
        //
        self.msgHeaderViewHeight.constant = 0
        self.msgVLine.backgroundColor = UIColor.zx_tintColor
        self.lbMsgTitle.textColor = UIColor.zx_tintColor
        self.lbMsgTitle.text = ""
        
        self.lbFinishedTime.textColor = UIColor.zx_textColorMark
        self.lbFinishedTime.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.frame.size.height > ZXTaskTableViewCell.height_noControl {
            self.extrolInfoViewLine.isHidden = false
        } else {
            self.extrolInfoViewLine.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate var taskModel: ZXTaskModel?
    fileprivate var tagsList = [false, false, false, false, false]
    
    /// ReloadUI
    ///
    /// - Parameters:
    ///   - model: TaskModel
    ///   - canControl: 是否可操作数据
    ///   - type:   类型
    func reloadData(model: ZXTaskModel?, canControl: Bool = false,type: ZXTaskCellType = .inCommonList) {
        self.zxType = type
    
        self.headerInfoView.isHidden = true
        self.carTypeInfoView.isHidden = true
        self.carPlateInfoView.isHidden = true
        self.carKeysInfoView.isHidden = true
        self.controlView.isHidden = true
        self.markShareView.isHidden = true
        //
        self.msgHeaderViewHeight.constant = 0
        self.msgHeaderView.isHidden = true
        self.finishedView.isHidden = true
        
        self.taskModel = model
        if let model = model {
            tagsList = model.zx_extralTags
            self.ccvList.reloadData()
            self.headerInfoView.isHidden = false
            self.carTypeInfoView.isHidden = false
            self.carPlateInfoView.isHidden = false
            self.carKeysInfoView.isHidden = false
            if model.isFollow == 1 {//已关注
                self.btnMark.setImage(nil, for: .normal)
                self.btnMark.setTitle("取消关注", for: .normal)
            } else {
                self.btnMark.setImage(#imageLiteral(resourceName: "add"), for: .normal)
                self.btnMark.setTitle("关注", for: .normal)
            }
            self.bottomOffset.constant = 15
            if self.zxType == .inTaskDetail {//任务详情中
                self.bottomOffset.constant = 0
                self.leftOffset.constant = 0
                self.rightOffset.constant = 0
                self.vLine.isHidden = true
                self.lbStatus.text = "任务信息"
                self.lbStatus.textColor = UIColor.zx_textColorTitle
                self.lbAgentPrice.textColor = UIColor.zx_textColorTitle
                self.zxContentView.layer.cornerRadius = 0
            } else {

                self.zxContentView.layer.masksToBounds = false
                self.zxContentView.layer.cornerRadius = 5
                //self.zxContentView.layer.shadowColor = UIColor.init(red: 222, green: 227, blue: 237, alpha: 1.0).cgColor
                self.zxContentView.layer.shadowOffset = CGSize(width: 0, height: 0)
                self.zxContentView.layer.shadowOpacity = 0.08
                self.zxContentView.layer.shadowRadius = 8
                
                self.leftOffset.constant = 10
                self.rightOffset.constant = 10
                self.vLine.isHidden = false
                self.lbStatus.text = model.zx_statusInfoInList
                self.lbStatus.textColor = UIColor.zx_tintColor
                if canControl {
                    if model.zx_hasUploadAuthority {//待付款 前端无后续操作
                        self.controlView.isHidden = false
                        self.btnControlAction.isHidden = true
                        if model.zx_controlType != .none {
                           self.btnControlAction.isHidden = false
                            self.btnControlAction.setTitle(model.zx_controlType.description(), for: .normal)
                        }
                    } else {
                        self.controlView.isHidden = true
                    }
                } else {
                    self.markShareView.isHidden = false
                }
                self.lbAgentPrice.textColor = UIColor.zx_customAColor
                //
                switch self.zxType {
                case .inMessageList://消息列表中
                    self.controlView.isHidden = true
                    self.msgHeaderView.isHidden = false
                    self.lbMsgTitle.text = model.messageTitle
                    self.msgHeaderViewHeight.constant = 55
                    self.vLine.isHidden = true
                    self.lbStatus.textColor = UIColor.zx_textColorTitle
                    self.lbAgentPrice.textColor = UIColor.zx_textColorTitle
                case .finished:
                    self.controlView.isHidden = true
                    self.markShareView.isHidden = true
                    self.finishedView.isHidden = false
                    self.vLine.backgroundColor = UIColor.zx_textColorMark
                    self.lbAgentPrice.textColor = UIColor.zx_textColorMark
                    self.lbStatus.textColor = UIColor.zx_textColorMark
                    self.lbCarTypeInfo.textColor = UIColor.zx_textColorMark
                    self.lbPlateNumber.textColor = UIColor.zx_textColorMark
                    self.lbLocation.textColor = UIColor.zx_textColorMark
                    if model.zx_status == .finished {
                        self.lbFinishedTime.text = "完成时间: \(model.operationTimeStr)"
                    } else if model.zx_status == .closed {
                        self.lbFinishedTime.text = "下架时间: \(model.operationTimeStr)"
                    }
                default: break
                }
                
            }
            //状态 代理费
            self.lbAgentPrice.text = "\(model.actualAmount)".zx_priceString(true, true) + "代理费"
            //品牌类型
            self.lbCarTypeInfo.text = model.carBrand
            //归属地 车牌
            self.lbLocation.text = "\(model.provinceName) \(model.cityName)"
            //if inDetail, !model.otherMatched {
            if self.zxType == .inTaskDetail {//任务详情 不隐藏车牌
                self.lbPlateNumber.text = "\(model.plateNumber)"
            } else {
                self.lbPlateNumber.text = "\(model.plateNumberStr)"
            }
            //任务剩余时间
            if model.taskRemainingTimeStr.isEmpty {
                self.lbLeaveTime.text = ""
            } else {
                self.lbLeaveTime.text = "任务剩余时间:\(model.taskRemainingTimeStr)"
            }
            
        }
    }
    
    //ShowTipsAction
    
    
    @IBAction func showCarTypePopTips(_ sender: UIButton) {
        if self.zxType == .finished {
            return
        }
        if let model = taskModel {
            var frame = self.convert(sender.frame, to: ZXRootController.appWindow()!)
            frame.origin.y += 60
            if self.zxType == .inMessageList {
                frame.origin.y += 55
            }
            self.btnShowCarTypePopTips.isEnabled = false
            ZXPopTipsViewController.showTips(model.carBrand, from: frame, showFinished: {
                self.btnShowCarTypePopTips.isEnabled = true
            })
        }
    }
    
    @IBAction func showBelongingPlacePopTIps(_ sender: UIButton) {
        if self.zxType == .finished {
            return
        }
        if let model = taskModel {
            var frame = self.convert(sender.frame, to: ZXRootController.appWindow()!)
            frame.origin.y += 120
            if self.zxType == .inMessageList {
                frame.origin.y += 55
            }
            self.btnShowPlacePopTips.isEnabled = false
            ZXPopTipsViewController.showTips("\(model.provinceName) \(model.cityName)", from: frame, showFinished: {
                self.btnShowPlacePopTips.isEnabled = true
            })
        }
    }
    
    @IBAction func showPlateNumPopTips(_ sender: UIButton) {
        
    }
    
    //MARK: - Action
    //MARK: - Mark/UnMark
    @IBAction func markAction(_ sender: Any) {
        if let model = self.taskModel {
            delegate?.zxTaskTableViewCell(self, mark: (model.isFollow == 1) ? false : true, model: self.taskModel)
        }
    }
    //MAKR: - Share
    @IBAction func shareAction(_ sender: Any) {
        delegate?.zxTaskTableViewCellShareAction(self, model: self.taskModel)
    }
    //MARK: - Consummate Info
    @IBAction func controlAction(_ sender: Any) {
        if let model = taskModel {
            delegate?.zxTaskTableViewCell(self, controlActionType: model.zx_controlType, model: model)
        }
    }
}

extension ZXTaskTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textSize = tagsTitle[indexPath.row].zx_textRectSize(toFont: UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 3), limiteSize: CGSize.init(width: ZXBOUNDS_WIDTH - 40, height: 20))
        return CGSize.init(width: (5 + 20 + 5 + textSize.width), height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXTagsCCVCell.reuseIdentifier, for: indexPath) as! ZXTagsCCVCell
        cell.setName(tagsTitle[indexPath.row], own: self.tagsList[indexPath.row], enable: (self.zxType == .finished ? false : true))
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
}
