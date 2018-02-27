//
//  ZXShare.swift
//  FindCar
//
//  Created by 120v on 2018/1/15.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

//分享帮助：http://115.182.15.118:9092/pages/help.html?plate_number=川A5****&car_brand=2015款 起亚K2 三厢 1.4L MT GL
//分享炫耀：http://115.182.15.118:9092/pages/flaunt.html?plate_number=川A5****&car_brand=2015款 起亚K2 三厢 1.4L MT GL
//分享下载：http://115.182.15.118:9092/pages/download.html

enum ZXShareType {
    case help
    case flaunt
    case download
    case none
}

class ZXShare: NSObject {
    
    //MARK: -
    class func shareToWX(taskModel: ZXTaskModel,wxScene: WXScene,shareType: ZXShareType) {
        var title = ""
        var description = ""
        var pageUrl = ""
        switch shareType {
        case .help,.flaunt:
            if taskModel.status == 12 {//分享炫耀
                pageUrl = "\(ZXURLConst.Api.url):\(ZXURLConst.Api.port)\(ZXAPIConst.Share.flaunt)" + "plate_number=" + "\(taskModel.plateNumberStr)" + "&" + "car_brand=" + "\(taskModel.carBrand)"
                title = "看，我又找到一辆车！"
                description = "完成任务，赏金到手，猜猜收益多少？简直不要太开心！"
            }else{//分享帮助
                pageUrl = "\(ZXURLConst.Api.url):\(ZXURLConst.Api.port)\(ZXAPIConst.Share.help)" + "plate_number=" + "\(taskModel.plateNumberStr)" + "&" + "car_brand=" + "\(taskModel.carBrand)"
                title = "快，帮我找辆车！"
                description = "找到该车，拍照告诉好友，帮助好友更快完成任务!"
            }
        case .download://分享下载
            pageUrl = "\(ZXURLConst.Api.url):\(ZXURLConst.Api.port)\(ZXAPIConst.Share.down)"
            title = "找车快拍，更专业的找车平台"
            description = "下载找车快拍，找车更省事！"
        default:
            break
        }
        
        let wxMsg = WXMediaMessage()
        
        let page = WXWebpageObject()
        page.webpageUrl = pageUrl
        
        wxMsg.setThumbImage(#imageLiteral(resourceName: "logo3"))
        wxMsg.mediaObject = page
        wxMsg.title = title
        wxMsg.description = description
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = wxMsg
        
        switch wxScene {
        case WXSceneSession://发送至微信的会话内
            req.scene = Int32(WXSceneSession.rawValue)
        case WXSceneTimeline://发送至朋友圈
            req.scene = Int32(WXSceneTimeline.rawValue)
        case WXSceneFavorite://发送到“我的收藏”中
            req.scene = Int32(WXSceneFavorite.rawValue)
        default:
            req.scene = Int32(WXSceneSession.rawValue)
        }
        WXApi.send(req)        
    }
}
