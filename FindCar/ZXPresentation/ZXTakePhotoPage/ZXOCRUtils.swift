//
//  ZXOCRUtils.swift
//  FindCar
//
//  Created by screson on 2017/12/19.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import HandyJSON

enum ZXOCRErrorCode: Int, HandyJSONEnum {
    case unknowerror            =   1
    case serviceUnavailable     =   2
    case unsupportedApi         =   3
    case limitReached           =   4
    case noPremission           =   6       //集群超限额
    case certificationFailed    =   14      //IAM鉴权失败
    case dailyRequestLimit      =   17      //每天请求量超限额
    case qpsLimit               =   18      //QPS超限额
    case totalRequestLimit      =   19
    case invalidParameter       =   100
    case accessTokenInvalid     =   110
    case accessTokenExpired     =   111
    case internalError          =   282000  //服务器内部错误，如果您使用的是高精度接口，报这个错误码的原因可能是您上传的图片中文字过多，识别超时导致的，建议您对图片进行切割后再识别，其他情况请再次请求， 如果持续出现此类错误
    case invalidParam           =   216100
    case notEnoughParam         =   216101
    case serviceNotSupport      =   216102
    case paramTooLong           =   216103
    case appidNotExist          =   216110
    case emptyImage             =   216200
    case imageFormatError       =   216201
    case imageSizeError         =   216202
    case recognizeError         =   216630
    case recognizeBankCardError =   216631
    case recognizeIdCardError   =   216633
    case detectError            =   216634
    case missingParameters      =   282003
    case batchProcessingError   =   282005
    case batchTaskLimitReached  =   282006
    case urlsNotExist           =   282110
    case urlFormatIllegal       =   282111
    case urlDownloadTimeout     =   282112
    case urlResponseInvalid     =   282113
    case urlSizeError           =   282114
    case requestIdNotExist      =   282808
    case resultTypeError        =   282809
    case imageRecognizeError    =   282810
    case zxUnknown              =   999999
    
    func description() -> String {
        switch self {
        case .unknowerror            : return "服务器内部错误,请再次请求"
        case .serviceUnavailable     : return "服务暂不可用,请再次请求"
        case .unsupportedApi         : return "调用的API不存在"
        case .limitReached           : return "集群超限额"
        case .noPremission           : return "无权限访问该用户数据"
        case .certificationFailed    : return "AM鉴权失败"
        case .dailyRequestLimit      : return "每天请求量超限额"
        case .qpsLimit               : return "QPS超限额"
        case .totalRequestLimit      : return "请求总量超限额"
        case .invalidParameter       : return "无效的Access_token参数"
        case .accessTokenInvalid     : return "Access_token无效"
        case .accessTokenExpired     : return "Access token过期"
        //case .internalError          : return "服务器内部错误"
        case .internalError          : return "未识别到车牌"
        case .invalidParam           : return "非法参数"
        case .notEnoughParam         : return "缺少必须的参数"
        case .serviceNotSupport      : return "不支持的服务"
        case .paramTooLong           : return "参数过长"
        case .appidNotExist          : return "Appid不存在"
        case .emptyImage             : return "图片为空"
        case .imageFormatError       : return "图片格式错误"
        case .imageSizeError         : return "图片大小错误"
        case .recognizeError         : return "识别错误"
        case .recognizeBankCardError : return "识别银行卡错误"
        case .recognizeIdCardError   : return "识别身份证错误"
        case .detectError            : return "检测错误"
        case .missingParameters      : return "参数缺失"
        case .batchProcessingError   : return "批量任务错误"
        case .batchTaskLimitReached  : return "批量任务处理数量超出限制"
        case .urlsNotExist           : return "URL参数不存在"
        case .urlFormatIllegal       : return "URL格式非法"
        case .urlDownloadTimeout     : return "URL下载超时"
        case .urlResponseInvalid     : return "URL返回无效参数"
        case .urlSizeError           : return "URL长度错误"
        case .requestIdNotExist      : return "ID不存在"
        case .resultTypeError        : return "返回结果格式错误"
        case .imageRecognizeError    : return "图像识别错误"
        default: return "未知错误"
        }
    }
}

enum ZXPlateColor: String, HandyJSONEnum {
    case blue       =   "blue"
    case yellow     =   "yellow"
    case green      =   "green"
    case black      =   "black"
    case white      =   "white"
    case unkown     =   "unkown"
    case none       =   "none"
    
    func description() -> String {
        switch self {
        case .blue:
            return "蓝色"
        case .yellow:
            return "黄色"
        case .green:
            return "绿色"
        case .black:
            return "黑色"
        case .white:
            return "白色"
        case .unkown:
            return "未知"
        default:
            return "未知"
        }
    }
}

class ZXLicenseModel: HandyJSON {
    var color: ZXPlateColor?
    var number: String = ""
    
    ///不包含 省市简称
    var zx_number: String? {
        if number.count > 2 {
            return number.substring(from: 2)
        }
        return nil
    }
    ///省市简称
    var zx_location: String? {
        if number.count > 2 {
            return number.substring(to: 2)
        }
        return nil
    }
    ///省
    var zx_place: String? {//省简称
        if number.count > 2 {
            return number.substring(to: 1)
        }
        return nil
    }
    ///市编码
    var zx_type: String? {//市编码
        if number.count > 2 {
            return number.substring(with: 1..<2)
        }
        return nil
    }
    
    required init() {}
}

class ZXOCRModel: HandyJSON {
    var log_id: String?
    var error_code: ZXOCRErrorCode?
    var error_msg: String?
    
    var words_result: ZXLicenseModel?
    
    required init() {}
}


class ZXOCRUtils {
    static var ACCESS_TOKEN:String?
    static let API_KEY      =   "WoUCZMSplKykXozMuOGnlfIg"
    static let SECRET_KEY   =   "3fEvK5k16uqlvHBEeiYOXLsgds5dz2oj"
    
    /// 获取AccessToke
    ///
    /// - Parameter completion: -
    static func getToken(completion: ((_ token: String?, _ error: String?) -> Void)?) {
        ZXNetwork.zx_asyncRequest(withUrl: "https://aip.baidubce.com/oauth/2.0/token", params: ["grant_type": "client_credentials", "client_id": API_KEY, "client_secret": SECRET_KEY], method: .post, completion: { (obj, jsonString) in
            if let obj = obj as? Dictionary<String,Any> {
                if let error = obj["error"] as? String, !error.isEmpty {
                    completion?(nil,obj["error_description"] as? String)
                } else {
                    let token = obj["access_token"] as? String
                    ACCESS_TOKEN = token
                    completion?(token, nil)
                }
            } else {
                completion?(nil, "数据无法解析")
            }
        }, timeOut: { (timeOut) in
            completion?(nil,timeOut)
        }) { (code, errorMsg) in
            completion?(nil,errorMsg)
        }
    }
    
    static func license_plate(imageData: Data,
                              access_token: String,
                              completion:((_ model: ZXLicenseModel?,_ error: String?) -> Void)?) {
        let dataStr = imageData.base64EncodedString().addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "+/=").inverted) ?? ""
        ZXNetwork.zx_asyncRequest(withUrl: "https://aip.baidubce.com/rest/2.0/ocr/v1/license_plate", params: ["access_token": access_token, "image": dataStr], method: .post, detectHeader: true, completion: { (obj, jsonString) in
            //print(jsonString ?? "")
            if let obj = obj as? Dictionary<String,Any>, let model = ZXOCRModel.deserialize(from: obj) {
                if let error = model.error_code {
                    completion?(nil,error.description())
                } else {
                    completion?(model.words_result,nil)
                }
            } else {
                completion?(nil, "数据无法解析")
            }
        }, timeOut: { (timeOut) in
            completion?(nil,timeOut)
        }) { (code, error) in
            completion?(nil,error)
        }
    }
}

