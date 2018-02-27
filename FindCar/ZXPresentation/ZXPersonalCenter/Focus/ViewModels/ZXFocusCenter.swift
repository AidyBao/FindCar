//
//  ZXFocusCenter.swift
//  FindCar
//
//  Created by 120v on 2018/1/15.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXFocusCenter: NSObject {
    class func requestForFocusList( pageNum: Int,
                                   pageSize:Int,
                                   taskStatus: Int,
                                   completion:((_ code:Int,_ success:Bool,_ list:Array<ZXTaskModel>?,_ msg:String) -> Void)?) {
        var dict:Dictionary<String,Any> = [:]
        dict["pageNum"] = (pageNum <= 0 ? 0 : pageNum)
        dict["pageSize"] = (pageSize <= 0 ? 0 : pageSize)
        dict["flagStatus"] = taskStatus
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Personal.focusList), params: dict, method: .post) { (success, code, obj, _, error) in
            if success {
                if let data = obj["data"] as? Dictionary<String,Any> {
                    if let listData = data["listData"] as? Array<Any>,listData.count > 0 {
                        var list = [ZXTaskModel]()
                        list = [ZXTaskModel].deserialize(from: listData)! as! [ZXTaskModel]
                        completion?(code,true,list,"")
                    } else {
                        completion?(code,true,nil,error?.errorMessage ?? "")
                    }
                } else {
                    completion?(code,true,nil,error?.errorMessage ?? "")
                }
            } else {
                completion?(code,false,nil,error?.errorMessage ?? "")
            }
        }
    }
   
    class func requestForUpdateFocus( focusId: Int,
                                    taskStatus: Int,
                                    completion:((_ code:Int,_ success:Bool,_ msg:String) -> Void)?) {
        var dict:Dictionary<String,Any> = [:]
        dict["status"] = taskStatus
        dict["id"] = focusId
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Personal.updateFocus), params: dict, method: .post) { (success, code, obj, _, error) in
            if success {
                if code == ZXAPI_SUCCESS {
                    completion?(code,true,error?.errorMessage ?? "")
                }else{
                    completion?(code,true,error?.errorMessage ?? "")
                }
            } else {
                completion?(code,false,error?.errorMessage ?? "")
            }
        }
    }
}
