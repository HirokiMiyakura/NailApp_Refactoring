//
//  CollectionPopularVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/04/30.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class CollectionPopularVM: CollectionBaseVM {

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
        let currentuser = NCMBUser.currentUser()
        //        if (tabKindSign == "0") {
        //            query = NCMBQuery(className: "image")
        //            query!.whereKey("userName", equalTo: userName!)
        //            query!.orderByDescending("createDate")
        //        } else if (tabKindSign == "1") {
        //            query = NCMBQuery(className: "image")
        //            query!.orderByDescending(self.orderByKey!)
        //        } else if (tabKindSign == "2") {
        //            query = NCMBQuery(className: "image")
        //            query!.orderByDescending(self.orderByKey!)
        //        } else if (tabKindSign == "3") {
        query = NCMBQuery(className: "image")
        query!.orderByDescending("kawaiine")
        
        
        //            query = NCMBQuery(className: "Fav")
        // ここ要修正。curentuserがnilの場合を考慮できていない。
        // nilの場合というのはログインしていない場合
        // つまりログインしてねのダイアログ表示が必要。
        // TODO(4/25記載)
        // 解決(x/xx)
        //            query!.whereKey("myName", equalTo: currentuser.userName)
        //            query!.orderByDescending(self.orderByKey!)
        //        }
        //        if(userName == nil) {
        //            query.orderByDescending(self.orderByKey!)
        //            if (self.tabKindSign == "3") {
        //                query.whereKey("userName", equalTo: userName!)
        //            }
        //
        //        } else {
        //            // userNameがnilじゃない場合というのは、DetailUserViewControllerの場合なはず。
        //            query.whereKey("userName", equalTo: userName!)
        //            query.orderByDescending("createDate")
        //
        //        }
        //        query.orderByDescending("createDate")
        //        query.orderByDescending("kawaiine")
        //        query.orderByDescending(self.orderByKey!)
        query!.findObjectsInBackgroundWithBlock({(objects, error) in
            
            if error == nil {
                
                if objects.count > 0 {
                    
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
    
//    override func setFavImage(favImageView: UIImageView, targetImageData: NCMBObject) {
//        print("setFavImageを実装しろやCollectionPoplarVM")
//        if (NCMBUser.currentUser() == nil) {
//            favImageView.image = UIImage(named: "heart_unlike.png")
//            return
//        }
//        
//        let objectIdOfImageInfo = targetImageData.objectForKey("objectId")
//        
//        // nifty_cloudのFavテーブルオブジェクトを取得。
//        let queryFav: NCMBQuery = NCMBQuery(className: "Fav")
//        // imageのobjectIdとFavのimageObjectIdが一致するものを抽出
//        // つまり、タップしたimageに対応するレコードがFavにあるかどうか。
//        queryFav.whereKey("imageObjectId", equalTo: objectIdOfImageInfo)
//        // ログイン中のユーザーの取得
//        let carrentUser = NCMBUser.currentUser()
//        if(carrentUser != nil) {
//            let userName = carrentUser.userName
//            queryFav.whereKey("myName", equalTo: userName)
//        }
//        queryFav.findObjectsInBackgroundWithBlock({(items, error) in
//            
//            if error == nil {
//                //                print("登録件数：\(items.count)")
//                // items.countは1か0しかない。
//                if items.count > 0 {
//                    let favFlg: Bool = ((items[0].objectForKey("favFlg") as? Bool))!
//                    
//                    if (favFlg) {
//                        
//                        favImageView.image = UIImage(named: "heart_like.png")
//                        
//                        
//                    } else {
//                        
//                        favImageView.image = UIImage(named: "heart_unlike.png")
//                        
//                    }
//                    
//                    // いいねおしてない場合
//                } else {
//                    
//                    favImageView.image = UIImage(named: "heart_unlike.png")
//                    
//                }
//            }
//            
//            
//        })
//
//        
//        
//    }

}
