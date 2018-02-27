//
//  ZXHomeManager.swift
//  FindCar
//
//  Created by 120v on 2018/1/9.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXHomeManager: NSObject {
    /**
     @pragma mark 每次启动获取一次区域数据
     @param
     */
    class func requestForGetArea(completion:@escaping (Array<ZXArea>) -> Void) -> Void {
        
        ZXNetwork.asyncRequest(withUrl:ZXAPI.api(address: ZXAPIConst.Home.getAreaList)
        , params: Dictionary(), method: .post) { (success, status, content, string, error) in
            var dataModelArr:Array<ZXArea> = []
            if success {
                if status == ZXAPI_SUCCESS {
                    if let data = content["data"] as? Array<Any> {
                        dataModelArr =  [ZXArea].deserialize(from: data)! as! Array<ZXArea>
                    }
                }
            }
            completion(dataModelArr)
        }
    }

    class func requestForTaskList( pageNum: Int,
                                   pageSize:Int,
                                   sortId: Int,
                                   taskId: Int,
                                   minValue: String?,
                                   maxValue: String?,
                                   proId: Int,
                                   cityId: Int,
                                   searchValue: String?,
                                   completion:((_ code:Int,_ success:Bool,_ list:Array<ZXTaskModel>?,_ msg:String) -> Void)?) {
        var dict:Dictionary<String,Any> = [:]
        dict["pageNum"] = (pageNum <= 0 ? 0 : pageNum)
        dict["pageSize"] = (pageSize <= 0 ? 0 : pageSize)
        if sortId != 1 {
            dict["sortFlag"] = sortId
        }
        if taskId != 0 {
            dict["statusFlag"] = taskId
        }
        if minValue?.isEmpty == false {
            dict["actualAmountStart"] = minValue
        }
        if maxValue?.isEmpty == false {
            dict["actualAmountEnd"] = maxValue
        }
        if proId != 0 {
            dict["provinceId"] = proId
        }
        if cityId != 0 {
            dict["cityId"] = cityId
        }
        if searchValue?.isEmpty == false {
            dict["searchValue"] = searchValue
        }
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Home.getTaskList), params: dict, method: .post) { (success, code, obj, _, error) in
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
    
    
    class func requestForUnreadMsg(completion:((_ msgCount:Int) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Home.getUnreadMeg), params: nil, method: .post) { (success, code, obj, jsonStr, error) in
            if success {
                if code == ZXAPI_SUCCESS {
                    let count: Int = obj["messageNum"] as! Int
                    
                    completion?(count)
                }
            }
        }
    }
}
