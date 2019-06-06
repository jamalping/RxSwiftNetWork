//
//  HomeAPI.swift
//  RxSwiftNetWorkDemo
//
//  Created by xp on 2018/4/13.
//  Copyright © 2018年 C. All rights reserved.
//

import Foundation
import Moya

enum HomeApi {
    case getHomeMainList(parameters: [String: Any])
    case commonfig
}

extension HomeApi: TargetType, XPTargetType {
    var headers: [String : String]? {
        return nil
    }
    
    /// The target's base `URL`.
    var baseURL: URL {
        switch self {
        case .getHomeMainList(parameters: _):
            return URL.init(string: hostUrl)!
        case .commonfig:
            return URL.init(string: "https://xej.ixinyongjia.com/api-gateway-guider/xinejia/")!
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getHomeMainList(parameters: _):
            return "/apiAdapterapi/content/showList.api"
//            return "/apiAdapter/api/content/indexList.api"
        case .commonfig:
            return "common/configs"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .getHomeMainList(parameters: _):
            return .post
        case .commonfig:
            return .get
        }

    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .getHomeMainList(parameters: let dic):
            return dic
        case .commonfig:
            return nil
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .requestPlain
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
    
    var isShow: Bool {
        return true
    }
}
