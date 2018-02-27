//
//  ZXGlobalData.swift
//  rbstore
//
//  Created by screson on 2017/8/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXGlobalData: NSObject {
    
    static var loginProcessed = true
    
    static var serviceTel:String?
    
    static var deadDate:Date?
    static var activeDate:Date?
    static func enterBackground() {
        self.deadDate = Date()
    }
    
    static func enterForeground() {
        self.activeDate = Date()
        NotificationCenter.default.post(name: ZXNotification.UI.enterForeground.zx_noticeName(), object: nil)
    }
    
    static var inoutCount:Int {
        get {
            if let d = deadDate,let a = activeDate {
                return Int(a.timeIntervalSince(d))
            }
            return 0
        }
    }
    //车牌归属地
    static var placeList: Array<String> = []
    static var typeList: Array<String> = []
}
