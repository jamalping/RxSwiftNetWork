//
//  TestList.swift
//  RxSwiftNetWorkDemo
//
//  Created by Apple on 2019/6/10.
//  Copyright © 2019 C. All rights reserved.
//

import UIKit

class TestList: UITableViewController {
    var data: [String] = ["各种操作符的使用"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RxSwift使用导航"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
    }
}

extension TestList {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.data[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("选中了", self.data[indexPath.row])
        
       let operatorTest = OperatorTest()
        operatorTest.title = self.data[indexPath.row]
        self.navigationController?.pushViewController(operatorTest, animated: true)
    }
}
