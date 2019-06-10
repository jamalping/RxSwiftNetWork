//
//  KQMoyaResponsePlugin.swift
//  FastContact
//
//  Created by Apple on 2019/3/21.
//  Copyright © 2019年 shaniaoge. All rights reserved.
//

import Moya
import Result

public final class KQMoyaResponsePlugin: PluginType {
    /// 成功的错误码数组
//    let normalCode = [400]
    
    //// 修改response的值
    public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError>{
        var result = result
        //JSONSerialization
        if case .success(let response) = result {
            
            let processedResponse = Response(statusCode: response.statusCode, data: response.data, request: response.request, response: response.response)
            
            guard let json = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String:Any], let status = json["status"] as? Bool else{
                return .failure(.jsonMapping(processedResponse))
            }
            if(!status){
//                /// 如果有错误信息message
//                if let msg = self.processErrorMessage(result: json) {
//                    result = .failure(.underlying(NSError.init(domain: processedResponse.request?.url?.absoluteString ?? "", code: json?["code"] as? Int ?? 9999, userInfo: [NSLocalizedDescriptionKey:msg]), processedResponse))
//                }else{
//                    result = .failure(.statusCode(processedResponse)) // 业务失败
//                }
                result = .failure(.statusCode(processedResponse)) // 业务失败
            }else{
                let data = json["data"]
                if let jsonDatas = data as? Data {
                    guard  let jsonData = try? JSONSerialization.data(withJSONObject: jsonDatas, options: []) else{
                        return .failure(.jsonMapping(processedResponse))
                    }
                    result = .success(Response(statusCode: response.statusCode, data: jsonData, request: response.request, response: response.response))
                }else{
                    result = .success(Response(statusCode:response.statusCode, data: response.data, request: response.request, response: response.response))
                }
            }
        }
        return result
    }
    
    private func processErrorMessage(result: [String:Any]?) -> String? {

        // josn -> ["message": "value"]
        if let responseInfoDic = result, let message = responseInfoDic["message"] as? String {
            return message
        }
        return nil
    }
    
}
