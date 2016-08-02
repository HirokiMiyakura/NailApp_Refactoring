//
//  CollectionUsersVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
//import NCMB
class CollectionSearchVM: CollectionBaseVM {
    
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
//        var query: NCMBQuery?
        var tmpQuery: NCMBQuery!
        var queryColArray: [NCMBQuery]
        var queryArray: [NCMBQuery] = []
        var queryCol: NCMBQuery!
//        query = NCMBQuery(className: "image")
//        query!.orderByDescending("createDate")
        
        for (colName,signArray) in gblParam {
            queryColArray = []
            for sign in signArray {
                tmpQuery = NCMBQuery(className: "image")
                tmpQuery.whereKey(colName, equalTo:String(sign))
                queryColArray.append(tmpQuery)

            }
            queryCol = NCMBQuery.orQueryWithSubqueries(queryColArray)
            queryArray.append(queryCol)
//            query!.whereKey(colName, equalTo: gblParam[colName])
            
        }
//        query!.whereKey("typeColor", equalTo: gblParam["typeColor"])
//        query!.whereKey("typeLength", equalTo: gblParam["typeLength"])
//        query!.whereKey("typeScene", equalTo: gblParam["typeScene"])
        let query = NCMBQuery.orQueryWithSubqueries(queryArray)
        query.orderByDescending("createDate")
        query.findObjectsInBackgroundWithBlock({(objects, error) in
            
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
