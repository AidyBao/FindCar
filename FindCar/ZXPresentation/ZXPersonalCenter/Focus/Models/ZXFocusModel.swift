//
//  ZXFocusModel.swift
//  FindCar
//
//  Created by 120v on 2018/1/18.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit
import HandyJSON

class ZXFocusModel: HandyJSON {
    required init(){}
    
    var focusId: Int                    = -1
    var accountId: Int                  = -1
    var taskId: Int                     = -1
    var status: Int                     = -1
    var operatorId: Int                 = -1
    var provinceId: Int                 = -1
    var cityId: Int                     = -1
    var drivingLicense: Int             = -1
    var propertyRightCard: Int          = -1
    var spareKey: Int                   = -1
    var vehicleInvoice: Int             = -1
    var loanContract: Int               = -1
    var taskStatus: Int                 = -1
    var isFollow: Int                   = -1
    var operatorName: String            = ""
    var operationTime: TimeInterval     = 0
    var carBrand: String                = ""
    var provinceName: String            = ""
    var cityName: String                = ""
    var plateNumber: String             = ""
    var actualAmount: String            = ""
    var submitDatetime: String          = ""
    var plateNumberStr: String          = ""
    var taskRemainingTimeStr: String    = ""
    var taskStatusStr: String           = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.focusId <-- "id"
    }
}
