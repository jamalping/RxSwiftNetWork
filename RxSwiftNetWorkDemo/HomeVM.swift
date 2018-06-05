//
//  HomeVM.swift
//  RxSwiftNetWorkDemo
//
//  Created by xp on 2018/4/18.
//  Copyright © 2018年 C. All rights reserved.
//

import Foundation
import Moya
import RxSwift

struct HomeVM {
    // 发送请求
    func requst() -> Observable<Any> {
//        return MoyaHttp<HomeApi>().configRequest().request(.getHomeMainList(parameters: ["cityCode": "440100"])).mapJSON()
        return MoyaHttp<HomeApi>().configRequest().request(.getHomeMainList(parameters: ["channelNames": "APP-社群活动",
                                                                                         "page": "1",
                                                                                         "pageSize": "5",
                                                                                         "city": "广州",])).mapJSON()
    }
}
