//
//  NetworkActivityPlugin.swift
//  RxSwiftNetWorkDemo
//
//  Created by xp on 2018/4/13.
//  Copyright © 2018年 C. All rights reserved.
//

import Foundation
import Moya
import Result

/// Network activity change notification type.
public enum NetworkActivityChangeType {
    case began, ended
}

/// Notify a request's network activity changes (request begins or ends).
public final class NetworkActivityPlugin: PluginType {
    
    public typealias NetworkActivityClosure = (_ change: NetworkActivityChangeType) -> Void
    let networkActivityClosure: NetworkActivityClosure
    
    public init(networkActivityClosure: @escaping NetworkActivityClosure) {
        self.networkActivityClosure = networkActivityClosure
    }
    
    // MARK: Plugin
    
    /// Called by the provider as soon as the request is about to start
    public func willSend(_ request: RequestType, target: TargetType) {
        //print(target.isShow,target.path)
        guard let result = (target as? XPTargetType)?.isShow else {
            return
        }
        if(result){
            networkActivityClosure(.began)
        }
    }
    
    /// Called by the provider as soon as a response arrives, even if the request is cancelled.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        guard let result = (target as? XPTargetType)?.isShow else {
            return
        }
        if(result){
            networkActivityClosure(.ended)
        }
    }
}
