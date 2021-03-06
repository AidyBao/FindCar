//
//  ZXAllTaskViewController+TableView.swift
//  FindCar
//
//  Created by 120v on 2018/1/8.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

extension ZXAllTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell: ZXTaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZXTaskTableViewCell.reuseIdentifier, for: indexPath) as! ZXTaskTableViewCell
        taskCell.delegate = self
        if perArray.count > 0 {
            taskCell.reloadData(model: perArray[indexPath.row],canControl: true)
        }
        return taskCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return perArray.count
    }
}

extension ZXAllTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if perArray.count > 0 {
            let model = perArray[indexPath.row]
            let detail = ZXTaskDetailViewController()
            detail.taskId = model.taskId
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = perArray[indexPath.row]
        if model.zx_hasUploadAuthority {
            return ZXTaskTableViewCell.height
        }
        return ZXTaskTableViewCell.height_noControl
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension ZXAllTaskViewController: ZXTaskTableViewCellDelegate {
    
    func zxTaskTableViewCell(_ cell: ZXTaskTableViewCell, controlActionType: ZXTaskControlType, model: ZXTaskModel?) {
        self.controlModel = model
        if let model = model {
            switch model.zx_controlType {
            case .uploadCarInfo://上传车辆信息
                let uploadCarInfoVC = ZXUploadCarInfoViewController()
                uploadCarInfoVC.taskId = model.taskId
                self.navigationController?.pushViewController(uploadCarInfoVC, animated: true)
            case .verifyCarInfo://验证车辆信息
                //先验证车牌是否正确
                let checkvc = ZXTakePhotoPageViewController()
                checkvc.delegate = self
                self.present(checkvc, animated: true, completion: nil)
            case .handOverCar://交接车辆
                let verifyGetCarCode = ZXInputGetCarCodeViewController()
                verifyGetCarCode.taskId = model.taskId
                self.present(verifyGetCarCode, animated: true, completion: nil)
            case .uploadSheet://上传交接单
                let uploadHandOverSheet = ZXUploadTakeOverSheetViewController()
                uploadHandOverSheet.taskId = model.taskId
                self.navigationController?.pushViewController(uploadHandOverSheet, animated: true)
            default:
                break
            }
        } else {
            ZXHUD.showFailure(in: self.view , text: "无可操作数据", delay: ZXHUD.DelayTime)
        }
    }
    
   
    func zxTaskTableViewCellShareAction(_ cell: ZXTaskTableViewCell, model: ZXTaskModel?) {
        if model != nil {
            if WXApi.openWXApp() {
                ZXShare.shareToWX(taskModel: model!, wxScene: WXSceneSession, shareType:.help)
            }else{
                ZXHUD.showFailure(in: self.view, text: "未安装微信客户端！", delay: ZX.HUDDelay)
            }
        }
    }
    
    func zxTaskTableViewCell(_ cell: ZXTaskTableViewCell, mark: Bool, model: ZXTaskModel?) {
        ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: ZX.HUDDelay)
        ZXFocusCenter.requestForUpdateFocus(focusId: Int((model?.taskId)!)!, taskStatus: mark ? 1 : 0, completion: { (code, succ, str) in
            ZXHUD.hide(for: self.view, animated: true)
            if code == ZXAPI_SUCCESS {
                let succStr = mark ? "已关注" : "已取消关注"
                ZXHUD.showSuccess(in: self.view, text: succStr, delay: ZX.HUDDelay)
                let indexPath = self.tabList.indexPath(for: cell)
                if self.perArray.count > 0 {
                    self.perArray.remove(at: (indexPath?.row)!)
                    self.tabList.reloadData()
                }
            }else{
                let errStr = mark ? "已关注" : "已取消关注"
                ZXHUD.showSuccess(in: self.view, text: errStr, delay: ZX.HUDDelay)
            }
        })
    }
}

extension ZXAllTaskViewController: ZXPlateDetectDelegate {
    func zxPlateVerified(taskId: String, ocrNumber: String?, inputPlateNumber: String?, imageUrl: String) {
        if let nav = self.navigationController {
            var vcs = nav.viewControllers
            let _ = vcs.popLast()
            let verifyCarInfoVC = ZXVerifyCarInfoViewController()
            verifyCarInfoVC.taskId = taskId
            verifyCarInfoVC.plateImageUrl = imageUrl
            verifyCarInfoVC.ocrNumber = ocrNumber
            verifyCarInfoVC.inputNumber = inputPlateNumber
            vcs.append(verifyCarInfoVC)
            nav.setNavigationBarHidden(false, animated: true)
            nav.setViewControllers(vcs, animated: true)
        }
    }
    
    func zxPlateDetect(model: ZXLicenseModel, image: UIImage?) {
        let confirmVC = ZXCardPlateConfirmViewController()
        confirmVC.checkType = .verify
        confirmVC.taskId = self.controlModel?.taskId
        confirmVC.image = image
        confirmVC.plateModel = model
        confirmVC.delegate = self
        self.navigationController?.pushViewController(confirmVC, animated: true)
    }
}





