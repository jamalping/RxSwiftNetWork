//
//  LoginViewController.swift
//  RxSwiftNetWorkDemo
//
//  Created by xp on 2018/5/4.
//  Copyright © 2018年 C. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// 登录控制器
class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let loginVM: LoginVM = {
        let vm = LoginVM()
        vm.bind()
        return vm
    }()
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        
        bind()
        
//        phoneField.text = "18818790393"
//        pwdField.text = "qqqqqqqq"
    }
    
    // 事件绑定
    func bind() {
        // 手机号绑定
        phoneField.rx.text.orEmpty.bind(to: loginVM.phoneNum).disposed(by: disposeBag)
        // 密码绑定
        pwdField.rx.text.orEmpty.bind(to: loginVM.pwd).disposed(by: disposeBag)
        
        // 登录按钮点击事件输入绑定
        submitBtn.rx.tap.bind(to: loginVM.submitBtnTap).disposed(by: disposeBag)
        // 登录按钮点击事件输出绑定
        loginVM.submitBtnTapResult?.subscribe(onNext: { [weak self] (result) in
            switch result{
            case .InValid(let msg):
                print("输入不合法提示错误信息:",msg)
            case .Valid(let formDic):
                print("输入合法给出对应参数:",formDic)
                
                LoginVM.login(parameters: formDic).asObservable().subscribe(onNext: { (a) in
                    print(a)
                }, onError: { (error) in
                    print(error)
                }).disposed(by: (self?.disposeBag)!)
            }
        }).disposed(by: disposeBag)
    }
}
