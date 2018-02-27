//
//  ZXSettingCenter.swift
//  FindCar
//
//  Created by 120v on 2018/1/30.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXSettingCenter: NSObject {
    class func requestForLogout() {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Personal.logout), params: nil, method: .post) { (succ, code, content, string, errMsg) in
            if succ {
                if code == ZXAPI_SUCCESS {
                }
            }
        }
    }
}
