//
//  MoyaHttp.swift
//  RxSwiftNetWorkDemo
//
//  Created by xp on 2018/4/13.
//  Copyright © 2018年 C. All rights reserved.
//

import Foundation
import Moya
import RxSwift

/// 网络请求类
public class MoyaHttp<T: TargetType> {
    /// 发送请求
    
    func configRequest() -> MoyaProvider<T> {
        return MoyaProvider<T>.init(endpointClosure: endPointClosure, requestClosure: requestClosure(endpoint:closure:), stubClosure: stubClosure, callbackQueue: DispatchQueue.global(), plugins: [loggerPlugin, spinerPlugin,accessTokenPlugin, KQMoyaResponsePlugin()], trackInflights: false)
    }
    
    
    
    /// 设置请求头信息
    let endPointClosure = { (target: T) -> Endpoint in
        
        var path = target.path
        let adapter = "/apiAdapter"
        var endPath = "" //加密
        if path.contains(adapter) && path != "/apiAdapter/api/city/getList.api" {
            path = path.replacingOccurrences(of: adapter, with: "")
            endPath = path
        }else {
            endPath = path
            path = "/crm" + path
        }
        // pinjie
        let url: String = target.baseURL.appendingPathComponent(path).absoluteString


        let timeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)

        let deviceId = "21212312323"

        var nsHeaders: [String: String] = [
            "url": endPath,
            "deviceType":"ios",
            "deviceId":deviceId,
            "version":"1.0",
            "timestamp":String.init(format: "%d", timeStamp)
        ]

        let keyvalueString = nsHeaders.sorted(by: { (element1, element2) -> Bool in
            return element1.key < element2.key
        }).reduce("", { (result, keyValue) -> String in
            return result + keyValue.key + keyValue.value
        })

        let hmacMD5 = keyvalueString.hmac(algorithm: .MD5, key: "homeplus")
        nsHeaders["sign"] = hmacMD5

        nsHeaders["Content-Type"] = "application/json;charset=UTF-8"
        nsHeaders["Accept"] = "application/json"

        return Endpoint.init(url: url,
                      sampleResponseClosure: { return .networkResponse(200, target.sampleData) },
                      method: target.method,
                      task: target.task,
                      httpHeaderFields: nsHeaders)
    }
    
    func requestClosure(endpoint: Endpoint, closure: MoyaProvider<T>.RequestResultClosure) {
        do {
            /// 判断是否有网络
            if KQNetworkMonitorHelper.share.isAvailableNetwork() {
                var urlRequest = try endpoint.urlRequest()
                urlRequest.timeoutInterval = 30 // 超时时长
                closure(.success(urlRequest))
            }else {
                closure(.failure(MoyaError.requestMapping("网络异常")))
            }
        } catch MoyaError.requestMapping(let url) {
            closure(.failure(MoyaError.requestMapping(url)))
        } catch MoyaError.parameterEncoding(let error) {
            closure(.failure(MoyaError.parameterEncoding(error)))
        } catch {
            closure(.failure(MoyaError.underlying(error, nil)))
        }
    }
    
    /// 单元测试代码
    func stubClosure(_ type: T) -> Moya.StubBehavior {
        return StubBehavior.never
    }
    
    /// 日志插件（moya提供）
    lazy var loggerPlugin = NetworkLoggerPlugin.init(verbose: true, requestDataFormatter: nil, responseDataFormatter: responseDataFormatter)
    
    
    
    /// tokenPlugin
    lazy var accessTokenPlugin = AccessTokenPlugin.init { () -> String in
//        return UserToken.token ?? ""
        return ""
    }
    
    /// 数据格式化输出
    ///
    /// - Parameter data: 原始数据
    /// - Returns: 格式化数据
    func responseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data
        }
    }
}

/// 日志的输出
private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

/// 指示灯的配置的初始化
let spinerPlugin = NetworkActivityPlugin { state in
//    guard let currentView = XYJLogVC.instance.currentVC?.view else {
//        return
//    }
    if state == .began {
//        MBProgressHUD.showAdded(to: currentView, animated: true)
        HttpLoadServer.show()
    } else {
        HttpLoadServer.hidden()
//        MBProgressHUD.hide(for: currentView, animated: true)
    }
}

class XYJLogVC {
    var currentVC: UIViewController?
    //声明一个单例对象
    static let instance = XYJLogVC()
    private init(){}
}


/// 是否显示加载中视图
public protocol XPTargetType {
    
    var isShow: Bool { get }
}
