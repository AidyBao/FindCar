//
//  ZXNotification.swift
//  rbstore
//
//  Created by screson on 2017/7/12.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation

class ZXNotification {
    struct Login {
        static let invalid          =   "ZXNOTICE_LOGIN_OFFLINE"                //登录失效通知
        static let success          =   "ZXNOTICE_LOGIN_SUCCESS"                //登录成功
        static let accountChanged   =   "ZXNOTICE_LOGIN_ACCOUNT_CHANGED"        //用户已切换
    }
    
    struct UI {
        static let reload           =   "ZXNOTICE_RELOAD_UI"
        static let badgeReload      =   "ZXNOTICE_RELOAD_BADGE"
        static let enterForeground  =   "ZXNOTICE_ENTERFOREGROUND"
    }
    
    struct Notice {
        static let open      = "ZXNOTICE_Notice_IsOpen"
    }
}


extension NotificationCenter {
    struct zxpost {
                
        static func accountChanged() {
            NotificationCenter.default.post(name: ZXNotification.Login.accountChanged.zx_noticeName(), object: nil)
        }
        
        static func loginSuccess() {
            NotificationCenter.default.post(name: ZXNotification.Login.success.zx_noticeName(), object: nil)
        }
        
        static func loginInvalid() {
            NotificationCenter.default.post(name: ZXNotification.Login.invalid.zx_noticeName(), object: nil)
        }
        
        static func reloadUI() {
            NotificationCenter.default.post(name: ZXNotification.UI.reload.zx_noticeName(), object: nil)
        }
        
        static func reloadBadge() {
            NotificationCenter.default.post(name: ZXNotification.UI.badgeReload.zx_noticeName(), object: nil)
        }
        
        static func openNotice(_ succ: Bool) {
            NotificationCenter.default.post(name: ZXNotification.Notice.open.zx_noticeName(), object: nil)
        }
    }
}
