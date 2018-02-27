//
//  ZXFocusViewController+TableView.swift
//  FindCar
//
//  Created by 120v on 2018/1/8.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

extension ZXFocusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell: ZXTaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZXTaskTableViewCell.reuseIdentifier, for: indexPath) as! ZXTaskTableViewCell
        taskCell.delegate = self
        if focusArray.count > 0 {
            taskCell.reloadData(model: focusArray[indexPath.row])
        }
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return focusArray.count
    }
}

extension ZXFocusViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ZXTaskTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension ZXFocusViewController: ZXTaskTableViewCellDelegate {
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
                if let indexPath = self.tableView.indexPath(for: cell) {
                    if self.focusArray.count > 0 {
                        if self.focusArray.count == 1 {
                            self.requestForFocusList(true)
                        }
                        self.focusArray.remove(at: indexPath.row)
                        self.tableView.reloadData()
                    }
                }
            }else{
                let errStr = mark ? "已关注" : "已取消关注"
                ZXHUD.showSuccess(in: self.view, text: errStr, delay: ZX.HUDDelay)
            }
        })
    }
}
