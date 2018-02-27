//
//  ZXProvince.swift
//  FindCar
//
//  Created by 120v on 2018/1/10.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit
import HandyJSON

//MARK: - 区域
@objcMembers class ZXArea: HandyJSON {
    var areaId:Int                          = -1
    var name:String                         = ""
    var shortName:String                    = ""
    var status: Int                         = -1
    var taskNum: Int                        = 0
    var parentId:Int                        = -1
    var remark: String                      = ""
    var children:Array<ZXProvince>          = []
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.areaId <-- "id"
    }
}

//MARK: - 省
@objcMembers class ZXProvince: HandyJSON {
    var provinceId:Int                      = 0
    var name:String                         = ""
    var shortName:String                    = ""
    var status: Int                         = -1
    var taskNum: Int                        = 0
    var parentId:Int                        = -1
    var remark: String                      = ""
    var children:Array<ZXCity>              = []
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.provinceId <-- "id"
    }
}

//MARK: - 市
@objcMembers class ZXCity: HandyJSON {
    var cityId:Int                          = 0
    var name:String                         = ""
    var shortName:String                    = ""
    var status: Int                         = -1
    var taskNum: Int                        = 0
    var parentId:Int                        = -1
    var remark: String                      = ""
    var children:Array<ZXRegion>                 = []
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.cityId <-- "id"
    }
}

//MARK: - 区县
@objcMembers class ZXRegion: HandyJSON {
    var regionId:Int                          = -1
    var name:String                         = ""
    var shortName:String                    = ""
    var status: Int                         = -1
    var taskNum: Int                        = 0
    var parentId:Int                        = -1
    var remark: String                      = ""
    var children:Array<Any>                 = []
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.regionId <-- "id"
    }
}
