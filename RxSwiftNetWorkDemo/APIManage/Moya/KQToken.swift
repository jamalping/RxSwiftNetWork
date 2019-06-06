//
//  KQToken.swift
//  FastContact
//
//  Created by Apple on 2019/3/26.
//  Copyright © 2019年 shaniaoge. All rights reserved.
//

import Foundation
import Moya

/// 用户token
struct UserToken {
    static let tokenKey = "userTokenKey"
    
    static var token: String? {
        get {
            guard let tk: String = KQKeychainTool.value(forKey: tokenKey) else {
                return nil
            }
            return tk
        }
        set {
            if let tk = newValue {
                KQKeychainTool.set(tk, forKey: tokenKey)
            }
        }
    }
    
    static func removeUserToken() {
        KQKeychainTool.removeValue(forKey: tokenKey)
    }
}

///新增IM Token
struct UserIMToken {
    static let IM_Token_Key = "User_IM_Token_Key"
    
    static var token: String? {
        get {
            guard let tk: String = KQKeychainTool.value(forKey: IM_Token_Key) else {
                return nil
            }
            return tk
        }
        set {
            if let tk = newValue {
                KQKeychainTool.set(tk, forKey: IM_Token_Key)
            }
        }
    }
    
    static func removeUserIMToken() {
        KQKeychainTool.removeValue(forKey: IM_Token_Key)
    }
}

extension MultiTarget: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType {
        return AuthorizationType.bearer
    }
}
