//
//  loginVM.swift
//  RxSwiftNetWorkDemo
//
//  Created by xp on 2018/5/4.
//  Copyright © 2018年 C. All rights reserved.
//

import UIKit; import RxSwift; import RxCocoa

class LoginVM {
    /// MARK -- 手机号码
    var phoneNum = Variable<String>("")
    
    /// MARK -- 密码
    var pwd = Variable<String>("")
    
    /// MARK -- 提交按钮
    var submitBtnTap = PublishSubject<Void>()
    var submitBtnEnable: Observable<Bool>?
    var submitBtnTapResult: Observable<FormValidateReuslt>?
    
    /// 绑定
    func bind() {
        let pwdAndPhoneNum = Observable.combineLatest(phoneNum.asObservable(), pwd.asObservable()) { ($0, $1) }
        submitBtnTapResult = submitBtnTap.asObservable().withLatestFrom(pwdAndPhoneNum).map({ (phone,pwd) -> FormValidateReuslt in
            
            return  self.validateForm(phone, pwd)
        })
    }
    
    /// MARK -- 表单验证
    /// 验证表单
    ///
    /// - Parameters:
    ///   - phone: 手机号码
    ///   - pwd: 密码
    /// - Returns: 返回表单枚举
    func validateForm(_ phone: String,_ pwd: String) -> FormValidateReuslt{
        if(!validateMobile(phone)){
            return  FormValidateReuslt.InValid("请输入有效手机号")
        }
        if pwd.count == 0 {
            return  FormValidateReuslt.InValid("请输入您的密码")
        }
        return FormValidateReuslt.Valid(["userName":phone,"password":pwd])
    }
    
    // 登录请求
    class func login(parameters: [String: Any]) -> Single<UserInfo>{
        return MoyaHttp<LoginAPI>().configRequest().rx.request(.login(parameters: parameters), callbackQueue: DispatchQueue.global()).mapObject(UserInfo.self)
    }
}

// MARK: 表单验证有效
/// - InValid: 无效  返回无效提示
/// - Valid: 有效 返回字典
enum FormValidateReuslt {
    case InValid(String)
    case Valid([String:Any])
}
