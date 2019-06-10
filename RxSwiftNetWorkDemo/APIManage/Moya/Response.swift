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


// MARK: - 拓展请求响应
extension Response {
    // 将JSON解析为单个Model
    public func mapObject<T: Codable>(_ type: T.Type) throws -> T {
        return try JSONDecoder().decode(T.self, from: self.data)
    }
    
    // 将JSON解析为Model数组，
//    public func mapArray<T: BaseMappable>(_ type: T.Type) throw -> [T] {
    
//    }
}


// MARK: - 扩展请求响应
extension ObservableType where Element == Response {
    
    /// 将JSON解析为Observable类型的Model（可观察的model）
    public func mapObject<T: Codable>(_ type: T.Type) -> Observable<T> {
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

extension PrimitiveSequenceType where Trait == SingleTrait, Element == Moya.Response {
    func mapObject<T: Codable>(_ t: T.Type) -> Single<T> {
        return flatMap { (response) -> Single<T> in
            print(response)
            return Single<T>.just(try response.mapObject(T.self), scheduler: CurrentThreadScheduler.instance)
        }
//        return flatMap { (response) -> Single<T> in
//
//           return Single<T>.just(response.mapObject(T.self), scheduler: CurrentThreadScheduler)
//        }
    }
    
//    func mapArray<T: Codable>(_ t: T.Type) -> Single<[T]> {
//        return flatMap({ (response) -> Single<[T]> in
//            return Single<[T]>.just(try response.mapArray(t: T.self))
//        })
//    }
}
