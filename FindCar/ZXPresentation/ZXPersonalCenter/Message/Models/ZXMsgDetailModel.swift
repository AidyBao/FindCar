//
//  ZXMsgDetailModel.swift
//  FindCar
//
//  Created by 120v on 2018/1/24.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit
import HandyJSON

class ZXMsgDetailModel: HandyJSON {
    required init() {}
    
    var detialId: Int           = -1
    var title:String            = ""
    var pushTargetType:String   = ""
    var pushProvinceId:String   = ""
    var pushProvinceName:String = ""
    var pushCityId:String       = ""
    var pushCityName:String     = ""
    var pushTel:String          = ""
    var pushContentType:String  = ""
    var contentImg:String       = ""
    var plateNumber:String      = ""
    var status:String           = ""
    var sendTime:String         = ""
    var operatorId:String       = ""
    var operatorName:String     = ""
    var operationTime:String    = ""
    var content:String          = ""
    var sendTimeStr:String      = ""
    var contentImgStr:String    = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
           self.detialId <-- "id"
    }
}
