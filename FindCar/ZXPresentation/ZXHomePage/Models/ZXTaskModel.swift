//
//  ZXTaskModel.swift
//  FindCar
//
//  Created by 120v on 2018/1/10.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit
import HandyJSON

class ZXTaskModel: HandyJSON {
    
    //
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.taskId <-- "id"
    }
    
    var taskId:String                          = ""
    var financialBranchId:Int                  = -1
    var financialCompanyId:Int                 = -1
    var financialCompanyName:String            = ""
    var carBranchId:Int                        = -1
    var carCompanyId:Int                       = -1
    var carCompanyName:String                  = ""
    var carBrand:String                        = ""
    var provinceId:Int                         = -1
    var provinceName:String                    = ""
    var cityId:Int                             = -1
    var cityName:String                        = ""
    var plateNumber:String                     = ""
    var frameNumber:Int                        = 0
    var carOwnerName:String                    = ""
    var identityCardNumber:Int                 = 0
    var drivingLicense:Int                     = 0
    var propertyRightCard:Int                  = 0
    var vehicleIdentificationNumber:Int        = 0
    var validateContacts:String                = ""
    var validateContactsTel:String             = ""
    var validateRemark:String                  = ""
    var expectedAgencyCost:String              = ""
    var actualAmount:Double                    = 0
    var purchasePrice:String                   = ""
    var loanAmount:Int                         = 0
    var surplusLoanAmount:Int                  = 0
    var spareKey:Int                           = 0
    var vehicleInvoice:Int                     = 0
    var loanContract:Int                       = 0
    var supplementaryInstructions:String       = ""
    var platformCommission:String              = ""
    var sendUserId:Int                         = -1
    var sendUserName:String                    = ""
    var sendDatetime:String                    = ""
    var sendDatetimeStr:String                 = ""
    var isTop:Int                              = 0
    var submitUserId:Int                       = -1
    var submitUserName:String                  = ""
    var submitDatetime:TimeInterval            = 0
    var submitDatetimeStr:String               = ""
    var plateNumberImg:String                  = ""
    var frameNumberImg:String                  = ""
    var carMatchImg:String                     = ""
    var problemImg:String                      = ""
    var authorizationDocumentImg:String        = ""
    var courierCompany:String                  = ""
    var courierNumber:Int                      = 0
    var validateFrontImg:String                = ""
    var validateOpenImg:String                 = ""
    var validateControlImg:String              = ""
    var validateBackImg:String                 = ""
    var receiveAddress:String                  = ""
    var receiptVoucherImg:String               = ""
    var handoverImg:String                     = ""
    var paymentVoucherImg:String               = ""
    var carReceiveComfirm:String               = ""
    var remark:String                          = ""
    var status:Int                             = 0
    var isOnAudit:Int                          = 0
    var isFinished:Int                         = 0
    var operatorId:String                      = ""
    var operatorName:String                    = ""
    var operationTime:TimeInterval             = 0
    var operationTimeStr:String                = ""
    var isFollow:Int                           = 0
    var adress:String                          = ""
    var submitUserNameStr:String               = ""
    var plateNumberStr:String                  = ""
    var taskRemainingTimeStr:String            = ""
    
    //消息列表任务标题说明
    var messageTitle: String                   = ""
    
    //Ext
    var isValidateCheckingCode: Int            = 0
    var taskOperateLogList: Array<ZXTaskOperateTimeModel> = []
    //图片 小图 （大图去掉 '_smart'）
    //未到状态右图也不显示
    //补充车辆信息
    var frameNumberImgSmartStrs: Array<String>              = []
    var carMatchImgSmartStrs: Array<String>                 = []
    var problemImgSmartStrs: Array<String>                  = []
    var authorizationDocumentImgSmartStrs: Array<String>    = []
    var validateFrontImgSmartStrs: Array<String>            = []
    var validateOpenImgSmartStrs: Array<String>             = []
    var validateControlImgSmartStrs: Array<String>          = []
    var validateBackImgSmartStrs: Array<String>             = []
    var handoverImgSmartStrs: Array<String>                 = []
    var zx_frameNumberSmallImgs: Array<String>//           = []//车架号图片
    {
        get{
            if self.status > 4 {
                return frameNumberImgSmartStrs
            }
            return []
        }

    }
    var zx_carMatchImgSmallImgs: Array<String>//              = []//车头/车尾图片
    {
        get{
            if self.status > 4 {
                return self.carMatchImgSmartStrs
            }
            return []
        }
    }
    var zx_problemSmallImgs: Array<String>//               = []//重大问题图片
    {
        get{
            if self.status > 4 {
                return self.problemImgSmartStrs
            }
            return []
        }
    }
    //授权文件
    var zx_authorizationDocumentSmallImgs: Array<String>// = []//授权文件图片
    {
        get{
            if self.status > 7 {
                return self.authorizationDocumentImgSmartStrs
            }
            return []
        }
    }
    //验证车辆信息
    var zx_validateFrontSmallImgs: Array<String>//         = []//车头图片
    {
        get{
            if self.status > 8 {
                return self.validateFrontImgSmartStrs
            }
            return []
        }
    }
    var zx_validateOpenSmallImgs: Array<String>//          = []//驾驶室图片
    {
        get{
            if self.status > 8 {
                return self.validateOpenImgSmartStrs
            }
            return []
        }
    }
    var zx_validateControlSmallImgs: Array<String>//       = []//中控图片
    {
        get{
            if self.status > 8 {
                return self.validateControlImgSmartStrs
            }
            return []
        }
    }
    var zx_validateBackSmallImgs: Array<String>//          = []//车尾图片
    {
        get{
            if self.status > 8 {
                return self.validateBackImgSmartStrs
            }
            return []
        }
    }
    var zx_handoverSmallImgs: Array<String>//              = []//交接单图片
    {
        get{
            if self.status > 10 {
                return self.handoverImgSmartStrs
            }
            return []
        }
    }
    
    ///审核、已领取等附加说明
    var extralMsg: String?
    ///任务已被他人领取
    var otherMatched: Bool      = false//
//    var hasBeenModified: Bool   = false//修改过车牌
    ///显示额外说明形象
    var showExtralMsg: Bool {
        get {
            if otherMatched {//已被他人领取
                return true
            }
            
            if isOnAudit == 1 {//审核中
                if status == 4 || status == 9 {
                    return true
                }
            }
//            if hasBeenModified {//修改过车牌
//                return true
//            }
            return false
        }
    }
    
    ///是否有上传等操作权限
    var zx_hasUploadAuthority: Bool {
        
        if status == 4 ||
            status == 8 ||
            status == 10 {
                return true
        }
        return false
    }
    
    //---
    fileprivate var zx_uploadCarInfoTime: String?//5
    var zx_uploadCarInfoTimeStr: String {
        get {//5 操作后的状态
            if zx_uploadCarInfoTime == nil {
                for m in self.taskOperateLogList {
                    if m.taskStatus == 5 {
                        zx_uploadCarInfoTime = m.operationTimeStr
                        break
                    }
                }
            }
            return zx_uploadCarInfoTime ?? ""
        }
    }
    fileprivate var zx_authorizeTime: String?//8
    var zx_authorizeTimeStr: String {
        get {
            if zx_authorizeTime == nil {
                for m in self.taskOperateLogList {
                    if m.taskStatus == 8 {
                        zx_authorizeTime = m.operationTimeStr
                        break
                    }
                }
            }
            return zx_authorizeTime ?? ""
        }
    }
    fileprivate var zx_verifyCarInfoTime: String?//9
    var zx_verifyCarInfoTimeStr: String {
        get {
            if zx_verifyCarInfoTime == nil {
                for m in self.taskOperateLogList {
                    if m.taskStatus == 9 {
                        zx_verifyCarInfoTime = m.operationTimeStr
                        break
                    }
                }
            }
            return zx_verifyCarInfoTime ?? ""
        }
    }
    fileprivate var zx_handOverCarTime: String?//11
    var zx_handOverCarTimeStr: String {
        get {
            if zx_handOverCarTime == nil {
                for m in self.taskOperateLogList {
                    if m.taskStatus == 11 {
                        zx_handOverCarTime = m.operationTimeStr
                        break
                    }
                }
            }
            return zx_handOverCarTime ?? ""
        }
    }
}
