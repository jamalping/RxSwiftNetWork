//
//  MoyaResponseNetPlugin.swift
//  RxSwiftNetWorkDemo
//
//  Created by xp on 2018/4/20.
//  Copyright © 2018年 C. All rights reserved.
//

import Moya
import Foundation
import Result

/// reposne的处理(net)
public final class MoyaResponseNetPlugin: PluginType {
    /// 成功的错误码数组
    let normalCode = ["0001","20000"]
    
    //// 修改response的值
    public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError>{
        var result = result
        //JSONSerialization
        if case .success(let response) = result {
            
            let processedResponse = Response(statusCode: -1, data: response.data, request: response.request, response: response.response)
            
            guard let json = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String:Any] , let code = json["code"] as? String , let data = json["data"]   else{
                return .failure(.jsonMapping(processedResponse))
            }
            if( !normalCode.contains(code) ){
                result = .failure(.statusCode(processedResponse)) // 业务失败
            }else{
                guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) else{
                    return .failure(.jsonMapping(processedResponse))
                }
                result = .success(Response(statusCode: -1, data: jsonData, request: response.request, response: response.response))
            }
        }
        return result
    }
}
