//
//  OperatorTest.swift
//  RxSwiftNetWorkDemo
//
//  Created by Apple on 2019/6/10.
//  Copyright © 2019 C. All rights reserved.
//

import UIKit
import RxSwift

class OperatorTest: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(button4)
        
        self.setClick()
    }
    
    func setClick() {
        self.button1.rx.tap.asObservable().throttle(RxTimeInterval.seconds(1), latest: false, scheduler: MainScheduler.instance).subscribe(onNext: { (_) in
            print("点击",Date())
        }).disposed(by: disposeBag)
        
        self.button2.rx.tap.asObservable().throttle(RxTimeInterval.seconds(1), latest: true, scheduler: MainScheduler.instance).subscribe(onNext: { (_) in
            print("点击",Date())
        }).disposed(by: disposeBag)
        
        self.button3.rx.tap.asObservable().debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).subscribe(onNext: { (_) in
            print("点击",Date())
        }).disposed(by: disposeBag)
        
        self.button4.rx.tap.asObservable().subscribe(onNext: { (_) in
            
            Observable<Int>.of(1,2,3,4,5,6).groupBy { (element) -> String in
                return element % 2 == 0 ? "偶数" : "奇数"
                }.subscribe(onNext: { (groupO) in
                    print(groupO.key)
                }).disposed(by: self.disposeBag)
//            print("点击",Date())
        }).disposed(by: disposeBag)
    }
    
    
    
    
    lazy var button1: UIButton = self.createButton(title: "规定时间内,多次点击只响应第一次", top: 110)
    
    lazy var button2: UIButton = self.createButton(title: "规定时间内,多次点击只响应第一次和最后一次", top: 170)
    
    lazy var button3: UIButton = self.createButton(title: "debounce 操作符将发出这种元素，在 Observable 产生这种元素后，一段时间内没有新元素产生。", top: 230)
    
    lazy var button4: UIButton = self.createButton(title: "取出特定的元素", top: 290)
    
    
    func createButton(title: String, top: CGFloat) -> UIButton {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 10, y: top, width: 300, height: 50)
        button.backgroundColor = .cyan
        button.setTitle(title, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.titleLabel?.numberOfLines = 0
        return button
    }
}
