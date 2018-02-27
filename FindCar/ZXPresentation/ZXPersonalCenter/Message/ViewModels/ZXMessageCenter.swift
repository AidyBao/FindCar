//
//  ZXMessageCenter.swift
//  FindCar
//
//  Created by 120v on 2018/1/15.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXMessageCenter: NSObject {
    /// 系统消息列表
    ///
    /// - Parameters:
    ///   - pageNum:
    ///   - pageSize:
    ///   - completion:
    static func requestForMsgList(pageNum: Int,
                     pageSize: Int,
                     completion: ((_ success: Bool, _ code: Int, _ list: [ZXMsgListModel]?, _ errorMsg: String) -> Void)?) {
        var dicP: Dictionary<String, Any> = [:]
        dicP["pageNum"] = (pageNum <= 0 ? 1 : pageNum)
        dicP["pageSize"] = (pageSize <= 0 ? ZX.PageSize : pageSize)
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Personal.mesgList), params: dicP, method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String, Any>,let listData = data["listData"] as? Array<Dictionary<String, Any>> {
                    var tList: Array<ZXMsgListModel> = []
                    tList = [ZXMsgListModel].deserialize(from: listData)! as! Array<ZXMsgListModel>
                    completion?(true,code,tList,"")
                } else {
                    completion?(true,code,nil,"无相关数据")
                }
            } else {
                completion?(false,code,nil,error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    
    /// 消息详情
    ///
    /// - Parameters:
    ///   - mId:
    ///   - completion:
    static func requestForMsgDetail(with mId: String,
                       type: String,
                       completion:((_ success: Bool,_ model: ZXMsgNoticeModel?,_ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Personal.detail), params: ["id": mId,"type": type], method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String, Any> {
                    completion?(true,ZXMsgNoticeModel.deserialize(from: data),"")
                } else {
                    completion?(true,nil,"无相关数据")
                }
            } else {
                if code != ZXAPI_LOGIN_INVALID {
                    completion?(false,nil,error?.errorMessage ?? "未知错误")
                }
            }
        }
    }
}
