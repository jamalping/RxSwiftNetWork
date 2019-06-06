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
    func requst() -> Single<Any> {

        return MoyaHttp<HomeApi>().configRequest().rx.request(.getHomeMainList(parameters: ["channelNames": "APP-社群活动", "page": "1", "pageSize": "5", "city": "广州",]), callbackQueue: DispatchQueue.global()).mapJSON()
    }
}
