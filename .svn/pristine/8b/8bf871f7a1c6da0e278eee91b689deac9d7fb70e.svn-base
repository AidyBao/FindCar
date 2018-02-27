//
//  ZXImageInputModel.swift
//  FindCar
//
//  Created by screson on 2018/1/15.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXImageInputModel: NSObject {
    var serverUrl: String?
    var localFilePath: String?//subFoler+fileName
    var absolutePath: String? {
        if let filePath = localFilePath {
            return FileManager.ZX.imageCachesPath + "/" + filePath
        }
        return nil
    }
    var url: URL? {
        if let serverUrl = serverUrl {
            return URL.init(string: serverUrl)
        } else if let aPath = absolutePath {
            return URL.init(fileURLWithPath: aPath)
        }
        return nil
    }
}
