//
//  CollectionMineVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/22.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
import NCMB

class CollectionMineVM: CollectionBaseVM {
    
    override func loadImageData() {
        
        /**
         * Just FYI
         *
         * Example: 文字列と一致する場合
         * query.whereKey("title", equalTo: "xxx")
         *
         * メソッドのインターフェイスについて:
         * NCMBQuery.hを参照するとNCMBQueryのインスタンスメソッドの引数にとるべき値等が見れます。
         *
         */
        var query: NCMBQuery?
        query = NCMBQuery(className: "image")
        query!.orderByDescending("createDate")
        query!.whereKey("userName", equalTo: gblUserName)
        query!.findObjectsInBackgroundWithBlock({(objects, error) in
            
            if error == nil {
                
                if objects.count > 0 {
                    
                    self.imageInfo = objects
                    
                }
                
            } else {
                print("エラー")
                print(error.localizedDescription)
            }
        })
    }

}
