//
//  CollectionNewVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/04/30.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
//import NCMB
class CollectionFavVM: CollectionBaseVM {
    
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
        var query: NCMBQuery = NCMBQuery(className: "Fav")
        let currentuser = NCMBUser.currentUser()
//        query = NCMBQuery(className: "Fav")
        query.whereKey("myName", equalTo: currentuser.userName)
        query.whereKey("favFlg", equalTo: true)
        query.orderByDescending("createDate")
        var imageQuery: NCMBQuery = NCMBQuery(className: "image")
        imageQuery.whereKey("imagePath", matchesKey:"imagePath", inQuery:query)
        imageQuery.findObjectsInBackgroundWithBlock({(objects, error) in
            
            if error == nil {
                
                if objects.count > 0 {
                    
                    
//                    self.getImageData(objects)
                    self.imageInfo = objects
                    
                    //コレクションビューをリロードする
                    //                    self.collectionView!.reloadData()
                }
                
            } else {
                print("エラー")
                print(error.localizedDescription)
            }
        })
    }
    
        override func setFavImage(favImageView: UIImageView, targetImageData: NCMBObject) {
            print("setFavImageを実装しろやCollectionFavVM")
//            if (NCMBUser.currentUser() == nil) {
                favImageView.image = UIImage(named: "heart_like.png")
                return
//            }
        }
    
    func getImageData() {
        var imageQuery: NCMBQuery = NCMBQuery(className: "image")
    }
    
    
}
