//
//  ZXShare.swift
//  FindCar
//
//  Created by 120v on 2018/1/15.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXShare: NSObject {
    
    //MARK: -
    class func shareToWX(_ taskModel: ZXTaskModel) {
        let message = WXMediaMessage()
        message.title = "专访张小龙：产品之上的世界观"
        message.description = "微信的平台化发展方向是否真的会让这个原本简洁的产品变得臃肿？在国际化发展方向上，微信面临的问题真的是文化差异壁垒吗？腾讯高级副总裁、微信产品负责人张小龙给出了自己的回复。"
        message.setThumbImage(UIImage.init())
        
        let ext = WXWebpageObject()
        ext.webpageUrl = "http://tech.qq.com/zt2012/tmtdecode/252.htm"
        message.mediaObject = ext
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(WXSceneSession.rawValue)
        
        WXApi.send(req)        
    }
}
