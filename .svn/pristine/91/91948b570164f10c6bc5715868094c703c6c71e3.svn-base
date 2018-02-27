//
//  String+Predicate.swift
//  rbstore
//
//  Created by 120v on 2017/8/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension String {
    
    //可使用汉字、英文、数字及下划线,不包含汉字符合、英文符号
    public func zx_predicateNickname() -> Bool {
        let pattern = "(^[\\u4E00-\\u9FA5A-Za-z0-9_]+$)"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: self)
    }
    
    //返回包含汉字、英文、数字、不包括标点符号的字符串
    public func zx_predicateSearch() -> String {
        let pattern = "[^\\u4e00-\\u9fa5A-Za-z0-9]"
        let str = self.replacingOccurrences(of: pattern, with: "", options: .regularExpression, range: nil)
        return str
    }
    
    //是否包含汉字、英文、数字、不包括标点符号
    public func zx_predicateSearchForBool() -> Bool {
        let pattern = "[^\\u4e00-\\u9fa5A-Za-z0-9]"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: self)
    }
}
