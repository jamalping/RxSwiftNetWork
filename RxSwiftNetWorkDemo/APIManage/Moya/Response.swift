//
//  Response.swift
//  RxSwiftNetWorkDemo
//
//  Created by xp on 2018/4/13.
//  Copyright © 2018年 C. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper


// MARK: - 拓展请求响应
extension Response {
    // 将JSON解析为单个Model
    public func mapObject<T: BaseMappable>(_ type: T.Type) throws -> T {
        guard let jsonDic = try JSONSerialization.jsonObject(with: self.data, options: .allowFragments) as? [String: Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        guard let object = Mapper<T>().map(JSONObject: jsonDic) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    
    // 将JSON解析为Model数组，
//    public func mapArray<T: BaseMappable>(_ type: T.Type) throw -> [T] {
    
//    }
}


// MARK: - 扩展请求响应
extension ObservableType where E == Response {
    
    /// 将JSON解析为Observable类型的Model（可观察的model）
    public func mapObject<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap({ (response) -> Observable<T> in
            
            print(try response.mapObject(T.self))
            return Observable.just(try response.mapObject(T.self))
        })
    }
    
    /// 将JSON解析为Observable类型的model数组
//    public func mapArray<T: BaseMappable>(_ type: T.Type) -> Observable<[T]> {
//        return flatMap({ (response) -> Observable<[T]> in
//            print(try response.mapObject(T.self))
//            return Observable.just(try response.mapObject(T.self))
//        })
//    }
}
