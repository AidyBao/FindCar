//
//  ZXLoginManager.swift
//  FindCar
//
//  Created by 120v on 2018/1/4.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXLoginManager: NSObject {
    
    //MARK: - 启动登录
    class func requestForLogin(_ tel: String,success:((_ success: Bool,_ code:Int,_ content: Dictionary<String,Any>,_ errMsg: String) -> Void)?,failed:((_ code: Int,_ errMsg: String)->Void)?) {
        var dic: Dictionary<String,Any> = Dictionary.init()
        if tel.count != 0 {
            dic["tel"] = tel
        }
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.User.login), params: dic, method: .post, completion: { (s, status, content, string, error) in
            if status == ZXAPI_SUCCESS {
                success?(s,status,content,error?.errorMessage ?? "")
            }else{
                failed?(status,error?.errorMessage ?? "")
            }
        })
    }
    
    //MARK: - 获取设备信息
    class func requestForEquipment() {
        var dic: Dictionary<String,Any> = Dictionary.init()
        dic["mobileSystemType"] = ZXDevice.zx_deviceSystem()
        dic["mobileSystemVersion"] = ZXDevice.zx_deviceVersion()
        dic["mobileModel"] = ZXDevice.zx_deviceType()
        if ZXDevice.zx_deviceToken().isEmpty == false {
            dic["deviceToken"] = ZXDevice.zx_deviceToken()
        }
        dic["packageName"] = ZXDevice.zx_getBundleId()
        dic["appVersion"] = ZXDevice.zx_getBundleVersion()
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.User.updateEqInfo), params: dic, method: .post, completion: { (success, status, content, string, errMsg) in
        })
    }
    
    //MARK: - 获取验证码
    class func requestForGetCode(_ tel: String,callBack:((_ success: Bool,_ code:Int,_ content: Dictionary<String,Any>,_ errMsg: String?)-> Void)?) {
        var dict: Dictionary<String,Any> = Dictionary()
        if tel.isEmpty == false {
            dict["tel"] = tel
        }
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.User.getSMSCode), params: dict, method: .post) { (success, status, content, string, errMsg) in
            callBack?(success, status, content, errMsg?.errorMessage)
        }
    }
    
    /// 获取电话数据字典
    ///
    /// - Parameter completion: -
    static func requestForGetTel(_ completion:((_ success: Bool, _ code: Int, _ errorMsg: String,_ tel: String) -> Void )?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Common.dicList), params: ["types": "4"], method: .post) { (success, code, dic, objString, error) in
            if code == ZXAPI_SUCCESS {
                if let data = dic["data"] as? Array<Dictionary<String,Any>>, data.count > 0 {
                    var telStr: String = ""
                    for m in data {
                        if let m = ZXDictListModel.deserialize(from: m) {
                            if m.type == 4 {//省
                                telStr = m.value
                            }
                        }
                    }
                    completion?(true, code, "", telStr)
                } else {
                    completion?(false, code, "无相关数据", "")
                }
            } else {
                completion?(false, code, (error?.description) ?? ZX_UNKNOWN_ERROR_TEXT, "")
            }
        }
    }
}
