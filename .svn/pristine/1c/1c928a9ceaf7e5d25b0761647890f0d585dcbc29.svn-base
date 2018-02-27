//
//  ZXHistoryCache.swift
//  FindCar
//
//  Created by 120v on 2018/1/5.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXHistoryCache: NSObject {
    
    static let ZX_Cache_UserHistory     =   "ZXCacheUserHistroy"
    static let ZX_HistoryKey            =   "ZXHistoryKey"
    
    class func getCache() -> Array<String> {
        let userDefaults = UserDefaults.standard
        
        if let cacheList = userDefaults.object(forKey: ZX_Cache_UserHistory) as? Dictionary<String,Any> {
            if ((cacheList[ZX_HistoryKey] as? Array<String>) != nil) {
                return cacheList[ZX_HistoryKey] as! Array
            }
        }
        return Array.init()
    }
    
    class func saveCache(_ historyArray: Array<String>) -> () {
        var dicStoreList:Dictionary<String,Any> = [:]
        let userDefaults = UserDefaults.standard
        dicStoreList[ZX_HistoryKey] = historyArray
        userDefaults.set(dicStoreList, forKey: ZX_Cache_UserHistory)
        userDefaults.synchronize()
    }
    
    class func removeAllObjects() {
        let userDefaults = UserDefaults.standard
        if var cacheList = userDefaults.object(forKey: ZX_Cache_UserHistory) as? Dictionary<String,Any> {
            cacheList.removeValue(forKey: ZX_HistoryKey)
            userDefaults.removeObject(forKey: ZX_Cache_UserHistory)
        }
    }
}
