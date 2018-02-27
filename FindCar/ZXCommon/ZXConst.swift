//
//  ZXURLConst.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation
import UIKit

let ZXBOUNDS_WIDTH      =   UIScreen.main.bounds.size.width
let ZXBOUNDS_HEIGHT     =   UIScreen.main.bounds.size.height

class ZX {
    
    static let PageSize:Int             =   12
    static let HUDDelay                 =   1.2
    static let CallDelay                =   0.5
    
    //定位失败 默认位置
    struct Location {
        static let latitude             =   30.592061
        static let longitude            =   104.063396
    }
}


/// 接口地址
class ZXURLConst {
//    struct Api {
//        static let url                  =   "http://192.168.0.171"
//        static let port                 =   "80"
//    }
//
//    struct Resource {
//        static let url                  =   "http://192.168.0.171"
//        static let port                 =   "80"
//    }

    struct Api {
        static let url                  =   "http://115.182.15.118"
        static let port                 =   "9092"
    }
    
    struct Resource {
        static let url                  =   "http://115.182.15.118"
        static let port                 =   "9091"
    }
    
    struct Web {
        static let about                =   "pages/about.html"                  //关于H5
        static let serviceItems         =   "pages/userAgreement.html"          //服务条款H5
    }
    
    struct Update {
        static let enterprise           =   "app/iOS/version.js"
    }
}

/// 功能模块接口
class ZXAPIConst {
    
    struct Common {
        static let dicList              =   "dict/getDictListByTypes"           //属性列表
    }
    
    struct Share {
        static let help                 = "/pages/help.html?"
        static let flaunt               = "/pages/flaunt.html?"
        static let down                 = "/pages/download.html"
    }
    
    struct Task {
        static let detail               =   "task/view"                         //任务详情
        static let plateMatch           =   "task/matchCar"                     //车辆匹配
        static let plateCheck           =   "task/matchCarAgain"                //验证车辆信息
        static let uploadInfo           =   "task/supplementCarInfo"            //上传相关数据
        static let verifyCode           =   "task/carCheckingCode"              //验证提车码
    }
    
    struct FileResouce {
        static let url                  =   "zcpt/pages/uploadFileApp"          //文件上传接口
        static let portraitFolder       =   "accountImgs"                       //头像存储文件夹
        static let carMatchFolder       =   "carMatchImgs"                      //车牌信息
        static let carInfoFolder        =   "carInfoImgs"                       //车辆信息
        static let verifyCarInfoFolder  =   "verifyCarInfoImgs"                 //验证车辆信息
        static let handoverSheetFolder  =   "handoverSheetImgs"                 //交接单
    }
    
    /// 个人
    struct Personal {
        static let mesgList             =   "messageCenter/list"        //消息列表
        static let detail               =   "notice/view"               //消息详情
        static let perTask              =   "task/personalTask"         //全部任务
        static let focusList            =   "followTask/list"           //关注列表
        static let updateFocus          =   "followTask/update"         //取消、关注
        static let baseInfo             =   "accountManage/baseInfoCount"  //账号基础信息统计
        static let getNewTask           =   "task/getNewTask"           //获取最新任务
        static let logout               =   "accountManage/logout"      //注销
    }
   
    //MARK: - User
    struct User {
        static let getSMSCode          =   "accountManage/getSMSVerificationCode"  //获取验证码
        static let login               =   "accountManage/login"                   //登录URL
        static let bindTel             =   "accountManage/bindingTel"              //绑定手机号
        static let verCode             =   "verificationCode/authVerificationCode" //校验验证码
        static let updateEqInfo        =   "accountManage/updateEquipmentInfo"     //更新设备信息
    }
    
    //MARK: - Home
    struct Home {
        static let getAreaList          =   "area/getAreaList"          //获取区域
        static let getTaskList          =   "task/list"                 //获取任务
        static let getBanner            =   "banner/list"               //Banner List
        static let getBannerDetail      =   "banner/view"               //Banner详情
        static let getUnreadMeg         =   "messageCenter/getUnreadMessageNum" //未读消息
    }
}
