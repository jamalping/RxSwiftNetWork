//
//  ViewController.swift
//  RxSwiftNetWorkDemo
//
//  Created by C on 2018/4/12.
//  Copyright © 2018年 C. All rights reserved.
//

import UIKit
import RxSwift


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class ViewController: UIViewController {

    let window = UIWindow.init(frame: CGRect.init(origin: .zero, size: CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)))
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        HomeVM().requst().asObservable().subscribe(onNext: { (a) in
            print(a)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)

    }

    @IBAction func loginAction(_ sender: UIButton) {
//        HttpLoadServer.show()
        
//        let window = UIWindow.init(frame: CGRect.init(origin: .zero, size: CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)))
//        window.windowLevel = UIWindow.Level.statusBar
//        window.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
//        window.makeKeyAndVisible()
//
//        let view = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
//        view.center = window.center
//        view.backgroundColor = .red
//        window.addSubview(view)
        
        let log =  UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")

        let navg = UINavigationController.init(rootViewController: log)
        self.present(navg, animated: true, completion: nil)
    }
    
    
    @IBAction func trunpToAther(_ sender: Any) {
        print("跳转")
        
        let nav = UINavigationController.init(rootViewController: TestList.init())
        self.present(nav, animated: true, completion: nil)
    }
    
}

