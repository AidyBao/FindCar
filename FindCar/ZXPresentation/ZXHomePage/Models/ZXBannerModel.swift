//
//  ZXBannerModel.swift
//  FindCar
//
//  Created by 120v on 2018/1/12.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit
import HandyJSON

class ZXBannerModel: HandyJSON {
    required init(){}
    
    var bannerId: Int           = -1
    var title: String           = ""
    var titleUrl: String        = ""
    var level: String           = ""
    var status: String          = ""
    var operatorId: Int         = -1
    var operatorName: String    = ""
    var content: String         = ""
    var titleUrlStr: String     = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.bannerId <-- "id"
    }
}
