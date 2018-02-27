//
//  AppDelegate+ZX.swift
//  FindCar
//
//  Created by 120v on 2018/1/11.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

extension AppDelegate {
    func zx_addNotice() {
        NotificationCenter.default.addObserver(self, selector: #selector(zx_loginInvalidAction), name: ZXNotification.Login.invalid.zx_noticeName(), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(zx_loginSuccessAction), name: ZXNotification.Login.success.zx_noticeName(), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(accountChanged), name: ZXNotification.Login.accountChanged.zx_noticeName(), object: nil)
    }
    
    @objc func zx_loginInvalidAction() {
        if !ZXGlobalData.loginProcessed {
            return
        }
        ZXUser.user.invalid()
        ZXUser.user.isLogin = false
        ZXUser.user.sync()
        ZXGlobalData.loginProcessed = false
        ZXAlertUtils.showAlert(wihtTitle: nil, message: "登录已失效,请重新登录", buttonText: nil) {
            ZXLoginViewController.show()
            ZXRootController.zx_tabbarVC().selectedIndex = 0
        }
    }
    
    @objc func zx_loginSuccessAction() {
        ZXGlobalData.loginProcessed = true
    }
    
    @objc func accountChanged() {
        let nav = ZXRootController.zx_tabbarVC().selectedViewController as! UINavigationController
        nav.popToRootViewController(animated: true)
        ZXRouter.tabbarSelect(at: 0)
    }
}
