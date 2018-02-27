//
//  AppDelegate+WX.swift
//  FindCar
//
//  Created by 120v on 2018/1/15.
//  Copyright © 2018年 screson. All rights reserved.
//  微信分享

import UIKit

let WX_KEY  =   "77870763a35a49e65333fb7ef8446b75"
let WX_ID   =   "wx94fa5ade22fdbe2b"

extension AppDelegate: WXApiDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func WXApiRegist() {
        WXApi.registerApp(WX_ID)
    }
    
    //onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
    func onReq(_ req: BaseReq!) {
        
    }
    
    //如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
    func onResp(_ resp: BaseResp!) {
        if resp.isKind(of: SendMessageToWXResp.self) {//确保是对我们分享操作的回调
            if resp.errCode == WXSuccess.rawValue{//分享成功
                print("分享成功")
            }else if resp.errCode == WXErrCodeCommon.rawValue {//普通错误类型
                print("分享失败：普通错误类型")
            }else if resp.errCode == WXErrCodeUserCancel.rawValue {//用户点击取消并返回
                print("分享失败：用户点击取消并返回")
            }else if resp.errCode == WXErrCodeSentFail.rawValue {//发送失败
                print("分享失败：发送失败")
            }else if resp.errCode == WXErrCodeAuthDeny.rawValue {//授权失败
                print("分享失败：授权失败")
            }else if resp.errCode == WXErrCodeUnsupport.rawValue {//微信不支持
                print("分享失败：微信不支持")
            }
        }
    }
}
