//
//  UserInfo.swift
//  RxSwiftNetWorkDemo
//
//  Created by xp on 2018/5/4.
//  Copyright © 2018年 C. All rights reserved.
//

import Foundation
import ObjectMapper

class UserInfo: Mappable {
    var apiKey: String?
    var mobile: String?
    var resourceUrl: String?
    var userId: String?
    var userName: String?
    var token: String?
    var bucketName: String?
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        apiKey <- map["apiKey"]
        mobile <- map["mobile"]
        resourceUrl <- map["resourceUrl"]
        userId <- map["userId"]
        userName <- map["userName"]
        bucketName <- map["bucketName"]
    }
}
