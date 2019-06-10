//
//  CheckValue.swift
//  RxSwiftNetWorkDemo
//
//  Created by xp on 2018/5/4.
//  Copyright © 2018年 C. All rights reserved.
//

import Foundation
// MARK: - 正则表达式判断
public extension String {
    
    /// 共用方法，传参数正则表达试
    func isValidRegexString(regexString: String) ->Bool {
        
        do {
            
            let pattern = regexString
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.count))
            return matches.count > 0
            
        } catch {
            
            return false
            
        }
    }
    
}


/// 是否是有效的手机号
func validateMobile(_ phone: String) -> Bool { //
//    return phone.isValidRegexString(regexString: "^1[3-9]{1}[0-9]{9}$")
    return phone.isValidRegexString(regexString: "^1+[0-9]+\\d{9}")
}
