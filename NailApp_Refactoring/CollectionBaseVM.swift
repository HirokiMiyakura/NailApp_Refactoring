//
//  CollectionBaseVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/04/30.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class CollectionBaseVM: NSObject, CollectionProtocol {
    dynamic var imageInfo = []
//    dynamic var favInfo = []
    var favDic: [Int:Bool] = [:]
    var favInfo = [[Int:Bool]]()
    var userName: String = ""
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageInfo.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print("collectionViewの設定開始")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MyCollectionViewCell
        let targetImageData = self.imageInfo[indexPath.row]
        let url = NSURL(string: (targetImageData.objectForKey("imagePath") as? String)!)
        
        let placeholder = UIImage(named: "transparent.png")
        let imageView = UIImageView()
        //        imageView.frame = self.cellRect!
        imageView.frame = CGRect(x: 0,y: 0,width: 132,height: 132) // The size of one cell
        
        let rect:CGRect = CGRectMake(imageView.frame.width/3*2, imageView.frame.height/3*2, imageView.frame.width/3, imageView.frame.height/3)
        let favImageView = UIImageView()
        // didClickImageViewを有効化するための処理
        favImageView.userInteractionEnabled = true
        imageView.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target:self, action:#selector(CollectionVC.didClickImageView(_:)))
        favImageView.addGestureRecognizer(gesture)
        favImageView.tag = indexPath.row
        favImageView.frame = rect
        favImageView.image = UIImage(named: "heart_unlike.png")
        imageView.addSubview(favImageView)
        
        
        setFavImage(favImageView, targetImageData: targetImageData as! NCMBObject)

        cell.addSubview(imageView)
        imageView.setImageWithURL(url, placeholderImage: placeholder)
        return cell
    }
    
    func didClickImageView2(recognizer: UIGestureRecognizer) {
    }
    func updateFavData(imageView: UIImageView) {
        print("imageView.tag")
        print(imageView.tag)
        let targetFavData: AnyObject = self.imageInfo[imageView.tag]
//        updateFavData(targetFavData, imageView: imageView)
        
        print(targetFavData)
        // imageのobjectIdを取得。
        var objectIdOfImageInfo: String
//        if (tabKindSign == "3") {
//            objectIdOfImageInfo = targetFavData.objectForKey("imageObjectId")! as! String
//        } else {
            objectIdOfImageInfo = targetFavData.objectForKey("objectId")! as! String
//        }
        //        let objectIdOfImageInfo = targetFavData.objectForKey("objectId")!
        
        let imagePath = targetFavData.objectForKey("imagePath")!
        // ログイン中のユーザーの取得
        let carrentUser = NCMBUser.currentUser()
        let myName = carrentUser.userName
        // nifty_cloudのFavテーブルオブジェクトを取得。
        let queryFav: NCMBQuery = NCMBQuery(className: "Fav")
        // imageのobjectIdとFavのimageObjectIdが一致するものを抽出
        // つまり、タップしたimageに対応するレコードがFavにあるかどうか。
        queryFav.whereKey("imageObjectId", equalTo: objectIdOfImageInfo)
        queryFav.whereKey("myName", equalTo: myName)
        queryFav.findObjectsInBackgroundWithBlock({(items, error) in
            
            if error == nil {
                print("登録件数：\(items.count)")
                var saveError: NSError? = nil
                // items.countは1か0しかない。
                if items.count > 0 {
                    // Favに保存するためのオブジェクト生成
                    let objFav: NCMBObject = NCMBObject(className: "Fav")
                    // objectId
                    let objectId: String = (items[0].objectForKey("objectId") as? String)!
                    // favFlg
                    let favFlg: Bool = ((items[0].objectForKey("favFlg") as? Bool))!
                    // 画像の変更
                    if (favFlg) {
                        imageView.image = UIImage(named: "heart_unlike.png")
                        // imageコレクション内のkawaiine数も更新
                        let objImage: NCMBObject = NCMBObject(className: "image")
                        objImage.objectId = objectIdOfImageInfo 
                        objImage.fetchInBackgroundWithBlock({(error) in
                            var saveError: NSError? = nil
                            if (error == nil) {
                                objImage.incrementKey("kawaiine",byAmount: -1)
//                                objImage.setObject(!favFlg,forKey: "favFlg")
                                objImage.save(&saveError)
                                targetFavData.incrementKey("kawaiine", byAmount: -1)
                            } else {
                                print("favFlgがtrue時のkawaiine保存時にエラーが発生しました: \(error)")
                            }
                        })
                        
                    } else {
                        imageView.image = UIImage(named: "heart_like.png")
                        // imageコレクション内のkawaiine数も更新
                        let objImage: NCMBObject = NCMBObject(className: "image")
                        objImage.objectId = objectIdOfImageInfo 
                        objImage.fetchInBackgroundWithBlock({(error) in
                            var saveError: NSError? = nil
                            if (error == nil) {
                                objImage.incrementKey("kawaiine",byAmount: 1)
                                targetFavData.incrementKey("kawaiine", byAmount: 1)
//                                objImage.setObject(!favFlg,forKey: "favFlg")
                                objImage.save(&saveError)
                            } else {
                                print("favFlgがfalse時のkawaiine保存時にエラーが発生しました: \(error)")
                            }
                        })
                    }
                    // プロパティ設定
                    objFav.objectId = objectId
                    objFav.fetchInBackgroundWithBlock({(error) in
                        
                        if (error == nil) {
                            
                            // favFlgの反対を設定
                            objFav.setObject(!favFlg, forKey: "favFlg")
                            // 保存
                            objFav.save(&saveError)
                            
                        } else {
                            print("データ取得処理時にエラーが発生しました。!fav: \(error)")
                        }
                    })
                    
                    // 初めてかわいいねを押す場合
                } else {
                    let objFav: NCMBObject = NCMBObject(className: "Fav")
                    objFav.setObject(targetFavData.objectForKey("objectId"), forKey: "imageObjectId")
                    objFav.setObject(targetFavData.objectForKey("imagePath"), forKey: "imagePath")
                    objFav.setObject(targetFavData.objectForKey("userName"), forKey: "userName")
                    objFav.setObject(myName, forKey: "myName")
                    objFav.setObject(true, forKey: "favFlg")
                    objFav.save(&saveError)
                    
                    
                    // 画像の設定
                    imageView.image = UIImage(named: "heart_like.png")
                    // imageコレクション内のkawaiine数も更新
                    let objImage: NCMBObject = NCMBObject(className: "image")
                    objImage.objectId = objectIdOfImageInfo 
                    objImage.incrementKey("kawaiine",byAmount:1)
                    targetFavData.incrementKey("kawaiine", byAmount: 1)
                    objImage.save(&saveError)
                    
                }
            }
            
            
        })

        
    }
    //データのリロード
    func loadImageData() {
        
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
    
    func deleteImage(deleteObjects: [AnyObject]) {
        
        let obj: NCMBObject = NCMBObject(className: "image")
        var objectId = ""
        
        for item in deleteObjects {
            objectId = item.objectForKey("objectId") as! String
            obj.objectId = objectId
            
            obj.deleteInBackgroundWithBlock({(error) in
                self.loadImageData()
            })
            
        }
//        obj.objectId = deleteObjects.i
        //        obj.fetchInBackgroundWithBlock({(error) in
        //
        //            if (error == nil) {
        
//        obj.deleteInBackgroundWithBlock({(error) in
//            
//            if (error == nil) {
//                
//                //削除成功時に画像も一緒に削除する
//                let fileData = NCMBFile.fileWithName(self.targetFileName, data: nil) as! NCMBFile
//                fileData.deleteInBackgroundWithBlock({(error) in
//                    print("画像データ削除完了: \(self.targetFileName)")
//                })
//                
//            }
//        })
//        
//        //            } else {
//        //                print("データ取得処理時にエラーが発生しました: \(error)")
//        //            }
//        //        })
//        
//        //UITextFieldを空にする
//        self.titleField.text = ""
//        self.moneyField.text = ""
//        self.commnetField.text = ""
//        
//        //登録されたアラートを表示してOKを押すと戻る
//        let errorAlert = UIAlertController(
//            title: "完了",
//            message: "このデータは削除されました。",
//            preferredStyle: UIAlertControllerStyle.Alert
//        )
//        errorAlert.addAction(
//            UIAlertAction(
//                title: "OK",
//                style: UIAlertActionStyle.Default,
//                handler: saveComplete
//            )
//        )
//        presentViewController(errorAlert, animated: true, completion: nil)



    
    }
    
    func setFavImage(favImageView: UIImageView, targetImageData: NCMBObject) {
        print("setFavImageを実装しろや")
        if (NCMBUser.currentUser() == nil) {
            favImageView.image = UIImage(named: "heart_unlike.png")
            return
        }
        let objectIdOfImageInfo = targetImageData.objectForKey("objectId")
        
        // nifty_cloudのFavテーブルオブジェクトを取得。
        let queryFav: NCMBQuery = NCMBQuery(className: "Fav")
        // imageのobjectIdとFavのimageObjectIdが一致するものを抽出
        // つまり、タップしたimageに対応するレコードがFavにあるかどうか。
        queryFav.whereKey("imageObjectId", equalTo: objectIdOfImageInfo)
        // ログイン中のユーザーの取得
        let carrentUser = NCMBUser.currentUser()
        if(carrentUser != nil) {
            let userName = carrentUser.userName
            queryFav.whereKey("myName", equalTo: userName)
        }
        queryFav.findObjectsInBackgroundWithBlock({(items, error) in
            
            if error == nil {
                //                print("登録件数：\(items.count)")
                // items.countは1か0しかない。
                if items.count > 0 {
                    let favFlg: Bool = ((items[0].objectForKey("favFlg") as? Bool))!
                    
                    if (favFlg) {
                        
                        favImageView.image = UIImage(named: "heart_like.png")
//                        self.favInfo.append(favFlg)
//                        self.favDic[favImageView.tag:favFlg]
                        // 既に存在するkeyならupdateで存在しないkeyであればinsertになる
                        if let age = self.favDic.updateValue(favFlg, forKey: favImageView.tag) {
                            print("update")
                        } else {
                            print("insert")
                        }
                        
                        
                    } else {
                        
                        favImageView.image = UIImage(named: "heart_unlike.png")
//                        self.favInfo.append(favFlg)
                        // 既に存在するkeyならupdateで存在しないkeyであればinsertになる
                        if let age = self.favDic.updateValue(favFlg, forKey: favImageView.tag) {
                            print("update")
                        } else {
                            print("insert")
                        }
                        
                    }
                    
                    // いいねおしてない場合
                } else {
                    
                    favImageView.image = UIImage(named: "heart_unlike.png")
//                    self.favInfo.append(false)
                    // 既に存在するkeyならupdateで存在しないkeyであればinsertになる
                    if let age = self.favDic.updateValue(false, forKey: favImageView.tag) {
                        print("update")
                    } else {
                        print("insert")
                    }
                    
                }
            }
            
            
        })

    }
}
