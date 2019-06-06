//
//  KQNetworkMonitor.swift
//  FastContact
//
//  Created by Apple on 2019/3/21.
//  Copyright © 2019年 shaniaoge. All rights reserved.
//

import Foundation
import Alamofire

/// 网络监控类
class KQNetworkMonitorHelper {
    static let share: KQNetworkMonitorHelper = KQNetworkMonitorHelper()
    private init() {}
    
    /// 网络状态：默认无网络
    var status = NetworkReachabilityManager.NetworkReachabilityStatus.notReachable
    
    private let manage = NetworkReachabilityManager()
    
    /// 开始监控
    func startMonitor() {
        self.manage?.listener = { (status) -> Void in
            self.status = status
        }
        self.manage?.startListening()
    }
    
    /// 是否有网络
    func isAvailableNetwork() -> Bool {

        return self.manage?.isReachable ?? false
    }
}


