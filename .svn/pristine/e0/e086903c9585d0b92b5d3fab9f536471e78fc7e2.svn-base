//
//  ZXTaskDetailViewController+Table.swift
//  FindCar
//
//  Created by screson on 2018/1/3.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

extension ZXTaskDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let model = taskModel {
            switch indexPath.section {
            case 0: return 55 //状态
            case 1: return UITableViewAutomaticDimension //审核文字说明
            case 2: return 70 //任务进度
            case 3:
                if self.commonMsgShowed {
                    return ZXTaskTableViewCell.height_noControl - 10
                }
                return 55
            case 4: return 0//只有Header
            case 5://交接单
                if model.zx_handoverSmallImgs.count > 1 {
                    return ZXUploadedMultiImageCell.height
                }
                return ZXUploadedMultiImageCell.singleImageHeight
            case 6...9://车辆图片（验证的车辆信息）
                var images: Array<String> = []
                switch indexPath.section {
                case 6://[验证]正面图片
                    images = model.zx_validateFrontSmallImgs
                case 7://[验证]驾驶室图片
                    images = model.zx_validateOpenSmallImgs
                case 8://[验证]中控图片
                    images = model.zx_validateControlSmallImgs
                case 9://[验证]车尾图片
                    images = model.zx_validateBackSmallImgs
                default:
                    break
                }
                if images.count > 1 {
                    return ZXUploadedMultiImageCell.height
                }
                return ZXUploadedMultiImageCell.singleImageHeight
            case 10...13://地址 联系人备注
                if indexPath.section == 10 || indexPath.section == 13 {//地址 备注
                    return UITableViewAutomaticDimension
                }
                return ZXUploadedTextInfoCell.height
            case 14...17://授权书 车辆图片（上传的车辆信息）
                var images: Array<String> = []
                switch indexPath.section {
                case 14://授权书
                    images = model.zx_authorizationDocumentSmallImgs
                case 15://车架号图片
                    images = model.zx_frameNumberSmallImgs
                case 16://车头/车尾图片
                    images = model.zx_carMatchImgSmallImgs
                case 17://重大问题图片
                    images = model.zx_problemSmallImgs
                default:
                    break
                }
                if images.count > 1 {
                    return ZXUploadedMultiImageCell.height
                }
                return ZXUploadedMultiImageCell.singleImageHeight
            case 18: return UITableViewAutomaticDimension//备注（上传的车辆信息）
            case 19: return 0//只有Footer
            default:
                break
            }
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let model = taskModel {
            switch section {
            case 0: return 20//状态
            case 1,2: return CGFloat.leastNormalMagnitude//附件说明 、任务进度
            case 3: return 20//任务基本信息 Header空白
            case 4://已传信息 Header 只有Header
                if model.zx_hasUploadData {
                    return 55
                } else {
                    break
                }
            case 5://交接单
                if self.detailMsgShowed, model.zx_handoverSmallImgs.count > 0 {
                    return 40
                } else {
                    break
                }
            case 6://验证车辆信息
                if self.detailMsgShowed, model.zx_validateFrontSmallImgs.count > 0 {
                    return 40
                } else {
                    break
                }
            case 7...9: return CGFloat.leastNormalMagnitude//车辆图片（验证的车辆信息）
            case 10...13: return CGFloat.leastNormalMagnitude //地址 联系人备注
            case 14://授权书
                if self.detailMsgShowed, model.zx_authorizationDocumentSmallImgs.count > 0 {
                    return 40
                } else {
                    break
                }
            case 15://（上传的车辆信息）
                if self.detailMsgShowed, model.zx_frameNumberSmallImgs.count > 0 {
                    return 40
                } else {
                    break
                }
            case 16...18: return CGFloat.leastNormalMagnitude//车辆图片 备注（上传的车辆信息）
            case 19: return CGFloat.leastNormalMagnitude//只有Footer 展开 收起
            default:
                break
            }
        }

        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let model = taskModel {
            switch section {
            case 3://基本信息 展开 收起
                if !model.otherMatched, model.zx_hasUploadData {
                    return 30
                } else {
                    break
                }
            case 19://展开 收起 只有Footer
                if !model.otherMatched, model.zx_hasUploadData {
                    return 30
                } else {
                    break
                }
            default:
                break
            }
        }
        return CGFloat.leastNormalMagnitude
    }
}

extension ZXTaskDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let model = taskModel, model.zx_hasUploadData {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ZXUploadedHeader.reuseIdentifier) as! ZXUploadedHeader
            header.lbTitle.text = ""
            header.lbSubTitle.text = ""
            header.lbLine.isHidden = true
            switch section {
            case 4://已传信息
                if !model.otherMatched {
                    header.lbTitle.text = "已传信息"
                    header.lbSubTitle.text = ""
                    header.lbLine.isHidden = false
                    return header
                } else {
                    return nil
                }
            case 5://车辆交接 时间
                if self.detailMsgShowed, model.zx_handoverSmallImgs.count > 0 {
                    header.lbTitle.text = "车辆交接"
                    header.lbSubTitle.text = model.zx_handOverCarTimeStr
                    return header
                }
                return nil
            case 6://（验证的车辆信息）
                if self.detailMsgShowed, model.zx_validateFrontSmallImgs.count > 0 {
                    header.lbTitle.text = "验证车辆信息"
                    header.lbSubTitle.text = model.zx_verifyCarInfoTimeStr
                    return header
                }
                return nil
            case 14://授权书
                if self.detailMsgShowed, model.zx_authorizationDocumentSmallImgs.count > 0 {
                    header.lbTitle.text = "获取授权"
                    header.lbSubTitle.text = model.zx_authorizeTimeStr
                    return header
                }
                return nil
            case 15://（上传的车辆信息）
                if self.detailMsgShowed, model.zx_frameNumberSmallImgs.count > 0 {
                    header.lbTitle.text = "补充车辆信息"
                    header.lbSubTitle.text = model.zx_uploadCarInfoTimeStr
                    return header
                }
            default:
                break
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let model = taskModel {
            switch section {
            case 3://基本信息 展开 收起
                if !model.otherMatched, model.zx_hasUploadData {
                    let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: ZXCloseFooterView.reuseIdentifier) as! ZXCloseFooterView
                    footer.delegate = self
                    footer.reloadExpaned(commonMsgShowed, section: section)
                    return footer
                } else {
                    return nil
                }
            case 19://展开 收起 只有Footer
                if !model.otherMatched, model.zx_hasUploadData {
                    let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: ZXCloseFooterView.reuseIdentifier) as! ZXCloseFooterView
                    footer.delegate = self
                    footer.reloadExpaned(detailMsgShowed, section: section)
                    return footer
                } else {
                    return nil
                }
            default:
                break
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = taskModel {
            switch indexPath.section {
            case 0://状态 剩余时间
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXTaskStatusHeaderCell.reuseIdentifier, for: indexPath) as! ZXTaskStatusHeaderCell
                cell.reloadData(model: self.taskModel)
                return cell
            case 1://待审核、已被领取 附加文字说明
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXTaskStatusInfoTextCell.reuseIdentifier, for: indexPath) as! ZXTaskStatusInfoTextCell
                if let model = taskModel, model.showExtralMsg {
                    cell.lbInfoText.text = model.extralMsg
                } else {
                    cell.lbInfoText.text = ""
                }
                return cell
            case 2://任务进度
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXTaskStatusProgressCell.reuseIdentifier, for: indexPath) as! ZXTaskStatusProgressCell
                cell.reloadProgress(list: taskModel?.zx_progressColorList)
                return cell
            case 3://任务基本信息
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXTaskTableViewCell.reuseIdentifier, for: indexPath) as! ZXTaskTableViewCell
                cell.contentView.clipsToBounds = true
                cell.zxContentView.clipsToBounds = true
                cell.reloadData(model: self.taskModel, type: .inTaskDetail)
                return cell
            case 4: break//只有Header
            case 5://交接单
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXUploadedMultiImageCell.reuseIdentifier, for: indexPath) as! ZXUploadedMultiImageCell
                cell.delegate = self
                cell.lbTitle.text = "点击查看交接单"
                cell.reloadData(model.zx_handoverSmallImgs)
                return cell
            case 6...9://车辆图片（验证的车辆信息）
                var images: Array<String> = []
                switch indexPath.section {
                case 6://[验证]正面图片
                    images = model.zx_validateFrontSmallImgs
                case 7://[验证]驾驶室图片
                    images = model.zx_validateOpenSmallImgs
                case 8://[验证]中控图片
                    images = model.zx_validateControlSmallImgs
                case 9://[验证]车尾图片
                    images = model.zx_validateBackSmallImgs
                default:
                    break
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXUploadedMultiImageCell.reuseIdentifier, for: indexPath) as! ZXUploadedMultiImageCell
                cell.delegate = self
                cell.lbTitle.text = ""
                switch indexPath.section {
                case 6: cell.lbTitle.text = "车辆正面照片"
                case 7: cell.lbTitle.text = "驾驶室照片 (车门打开45˚状态)"
                case 8: cell.lbTitle.text = "车辆中控照片"
                case 9: cell.lbTitle.text = "车辆尾部照片"
                default: break
                }
                cell.reloadData(images)
                return cell
            case 10...13://地址 联系人 联系方式 备注
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXUploadedTextInfoCell.reuseIdentifier, for: indexPath) as! ZXUploadedTextInfoCell
                cell.sLine.isHidden = false
                cell.lbTitle.text = ""
                cell.lbDetailInfo.text = ""
                switch indexPath.section {
                case 10:
                    cell.lbTitle.text = "提车地址"
                    cell.lbDetailInfo.text = model.receiveAddress
                case 11:
                    cell.lbTitle.text = "联系人"
                    cell.lbDetailInfo.text = model.validateContacts
                case 12:
                    cell.lbTitle.text = "联系方式"
                    cell.lbDetailInfo.text = model.validateContactsTel
                case 13:
                    cell.lbTitle.text = "备注"
                    cell.lbDetailInfo.text = model.validateRemark.isEmpty ? "无" : model.validateRemark
                default: break
                }
                return cell
            case 14...17://授权书 车辆图片（上传的车辆信息）

                var images: Array<String> = []
                switch indexPath.section {
                case 14://授权书
                    images = model.zx_authorizationDocumentSmallImgs
                case 15://车架号图片
                    images = model.zx_frameNumberSmallImgs
                case 16://车头/车尾图片
                    images = model.zx_carMatchImgSmallImgs
                case 17://重大问题图片
                    images = model.zx_problemSmallImgs
                default:
                    break
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXUploadedMultiImageCell.reuseIdentifier, for: indexPath) as! ZXUploadedMultiImageCell
                cell.delegate = self
                cell.lbTitle.text = ""
                switch indexPath.section {
                case 14: cell.lbTitle.text = "点击查看授权书"
                case 15: cell.lbTitle.text = "车辆车架号照片"
                case 16: cell.lbTitle.text = "车头或车尾照片"
                case 17: cell.lbTitle.text = "重大问题照片"
                default: break
                }
                cell.reloadData(images)
                return cell
            case 18://备注（上传的车辆信息）
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXUploadedTextInfoCell.reuseIdentifier, for: indexPath) as! ZXUploadedTextInfoCell
                cell.sLine.isHidden = true
                cell.lbTitle.text = "备注"
                cell.lbDetailInfo.text = model.remark.isEmpty ? "无" : model.remark
                return cell
            case 19: break//只有Footer
            default:
                break
            }
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = taskModel {
            switch section {
            case 0://状态
                return 1
            case 1://审核说明文字
                return (model.showExtralMsg ? 1 : 0)
            case 2://任务进度
                return (model.otherMatched ? 0 : 1)
            case 3://基本信息
                return 1
            case 4://已传信息
                return 0//只有Header
            case 5://交接单
                if self.detailMsgShowed, model.zx_handoverSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 6://[验证]正面图片
                if self.detailMsgShowed, model.zx_validateFrontSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 7://[验证]驾驶室图片
                if self.detailMsgShowed, model.zx_validateOpenSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 8:////[验证]中控图片
                if self.detailMsgShowed, model.zx_validateControlSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 9://[验证]车尾图片
                if self.detailMsgShowed, model.zx_validateBackSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 10://提车地址
                if self.detailMsgShowed, model.zx_validateFrontSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 11://联系人
                if self.detailMsgShowed, model.zx_validateFrontSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 12://联系方式
                if self.detailMsgShowed, model.zx_validateFrontSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 13://[验证]备注
                if self.detailMsgShowed, model.zx_validateFrontSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 14://授权文件
                if self.detailMsgShowed, model.zx_authorizationDocumentSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 15://车架号
                if self.detailMsgShowed, model.zx_frameNumberSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 16://车头/车尾照片
                if self.detailMsgShowed, model.zx_carMatchImgSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 17://重大问题
                if self.detailMsgShowed, model.zx_problemSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 18://[补充]备注
                if self.detailMsgShowed, model.zx_frameNumberSmallImgs.count > 0 {
                    return 1
                }
                return 0
            case 19:
                return 0//只有Footer 用于控制展开操作
            default:
                return 0
            }
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if taskModel != nil {
            return 20
        }
        return 0
    }
}


extension ZXTaskDetailViewController: ZXCloseFooteViewDelegate {
    func zxCloseFooterView(footerView: ZXCloseFooterView, expaned: Bool, section: Int) {
        if section == 3 {//基本信息
            self.commonMsgShowed = expaned
            self.tblList.reloadData()
        } else if section == 19 {//详细消息
            self.detailMsgShowed = expaned
            self.tblList.reloadData()
        }
    }
}
