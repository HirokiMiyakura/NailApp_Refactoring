//
//  SettingVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/02.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class SettingVM: NSObject, UITableViewDataSource {
    
    let settingOptions = [
        "プロフィール",
        "新規登録・ログイン",
        "ログアウト"
    ]
    
    
    //Table Viewのセルの数を指定
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptions.count
    }
    
    //各セルの要素を設定する
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        
        //        let img = UIImage(named:"\(imgArray[indexPath.row])")
        // Tag番号 1 で UIImageView インスタンスの生成
        //        let imageView = table.viewWithTag(1) as! UIImageView
        //        imageView.image = img
        
        // Tag番号 ２ で UILabel インスタンスの生成
        let label1 = table.viewWithTag(2) as! UILabel
//        label1.text = "No.\(indexPath.row + 1)"
        label1.text = settingOptions[indexPath.row]
        
        // Tag番号 ３ で UILabel インスタンスの生成
        //        let label2 = table.viewWithTag(3) as! UILabel
        //        label2.text = "\(label2Array[indexPath.row])"
        
        
        return cell
    }

}
