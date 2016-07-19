//
//  DetailVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
//import NCMB
class DetailVM: NSObject {
    dynamic var imageCollectionObject: NCMBObject?
    dynamic var favFlg: Bool = false
    dynamic var nickName: String?
    
    init(imageCollectionObject: NCMBObject) {
        super.init()
        self.imageCollectionObject = imageCollectionObject
        
    }


    func getComment() -> String {
        
        return (self.imageCollectionObject!.objectForKey("comment") as? String)!
        
    }
    
    func getKawaiineCount() -> Int {
        
        return (self.imageCollectionObject!.objectForKey("kawaiine") as? Int)!
        
    }
    
    func getURL() -> NSURL {
        return NSURL(string: (self.imageCollectionObject!.objectForKey("imagePath") as? String)!)!
    }
    
    func getAllSign() -> Dictionary<String,String> {
        let allSign = [
            "typeColor" : self.imageCollectionObject!.objectForKey("typeColor") as! String,
            "typeLength" : self.imageCollectionObject!.objectForKey("typeLength") as! String,
            "typeScene" : self.imageCollectionObject!.objectForKey("typeScene") as! String,
            
            ] as Dictionary<String,String>
        return allSign
        
    }
    
    func setImage(detailImage: UIImageView) {
        
        let url = NSURL(string: (self.imageCollectionObject!.objectForKey("imagePath") as? String)!)
        let placeholder = UIImage(named: "transparent.png")
        detailImage.setImageWithURL(url, placeholderImage: placeholder)
        detailImage.frame = CGRectZero

        let imageHeight = detailImage.image!.size.height*screenWidth/detailImage.image!.size.width
        detailImage.frame = CGRectMake(0, 0, screenWidth, imageHeight)

        
    }
    
    func getNailistName() {
        let userQuery = NCMBUser.query()
        userQuery.whereKey("userName", equalTo: self.imageCollectionObject!.objectForKey("userName") as? String!)
        userQuery.findObjectsInBackgroundWithBlock({(items, error) in
            
            if error == nil {
                print("登録件数：\(items.count)")
                // items.countは1か0しかない。
                if items.count > 0 {
                    self.nickName = (items[0].objectForKey("nickName") as? String)!
//                    return items[0].objectForKey("nickName") as String
                    
                } else {
                    
                    
                }
            }
            
            
        })

//        return (self.imageCollectionObject!.objectForKey("userName") as? String!)!
    }
    
    func checkFavFlg() {
        
        if (NCMBUser.currentUser() == nil) {
            self.favFlg = false
            return
        }
//        print("imageView.tag")
//        print(imageView.tag)
//        let targetFavData: AnyObject = self.imageInfo[imageView.tag]
        //        updateFavData(targetFavData, imageView: imageView)
        
//        print(targetFavData)
        // imageのobjectIdを取得。
        var objectIdOfImageInfo: String
        //        if (tabKindSign == "3") {
        //            objectIdOfImageInfo = targetFavData.objectForKey("imageObjectId")! as! String
        //        } else {
        objectIdOfImageInfo = imageCollectionObject!.objectForKey("objectId")! as! String
        //        }
        //        let objectIdOfImageInfo = targetFavData.objectForKey("objectId")!
        
//        let imagePath = targetFavData.objectForKey("imagePath")!
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
//                    let objFav: NCMBObject = NCMBObject(className: "Fav")
//                    // objectId
//                    let objectId: String = (items[0].objectForKey("objectId") as? String)!
                    // favFlg
                    let favFlg: Bool = ((items[0].objectForKey("favFlg") as? Bool))!
                    
                    self.favFlg = favFlg
//                    // 画像の変更
//                    if (favFlg) {
//                        imageView.image = UIImage(named: "heart_unlike.png")
//                        // imageコレクション内のkawaiine数も更新
//                        let objImage: NCMBObject = NCMBObject(className: "image")
//                        objImage.objectId = objectIdOfImageInfo
//                        objImage.fetchInBackgroundWithBlock({(error) in
//                            var saveError: NSError? = nil
//                            if (error == nil) {
//                                objImage.incrementKey("kawaiine",byAmount: -1)
//                                objImage.save(&saveError)
//                                targetFavData.incrementKey("kawaiine", byAmount: -1)
//                            } else {
//                                print("favFlgがtrue時のkawaiine保存時にエラーが発生しました: \(error)")
//                            }
//                        })
//                        
//                    } else {
//                        imageView.image = UIImage(named: "heart_like.png")
//                        // imageコレクション内のkawaiine数も更新
//                        let objImage: NCMBObject = NCMBObject(className: "image")
//                        objImage.objectId = objectIdOfImageInfo
//                        objImage.fetchInBackgroundWithBlock({(error) in
//                            var saveError: NSError? = nil
//                            if (error == nil) {
//                                objImage.incrementKey("kawaiine",byAmount: 1)
//                                targetFavData.incrementKey("kawaiine", byAmount: 1)
//                                objImage.save(&saveError)
//                            } else {
//                                print("favFlgがfalse時のkawaiine保存時にエラーが発生しました: \(error)")
//                            }
//                        })
//                    }
//                    // プロパティ設定
//                    objFav.objectId = objectId
//                    objFav.fetchInBackgroundWithBlock({(error) in
//                        
//                        if (error == nil) {
//                            
//                            // favFlgの反対を設定
//                            objFav.setObject(!favFlg, forKey: "favFlg")
//                            // 保存
//                            objFav.save(&saveError)
//                            
//                        } else {
//                            print("データ取得処理時にエラーが発生しました。!fav: \(error)")
//                        }
//                    })
                    
                    // 初めてかわいいねを押す場合
                } else {
//                    let objFav: NCMBObject = NCMBObject(className: "Fav")
//                    objFav.setObject(targetFavData.objectForKey("objectId"), forKey: "imageObjectId")
//                    objFav.setObject(targetFavData.objectForKey("imagePath"), forKey: "imagePath")
//                    objFav.setObject(targetFavData.objectForKey("userName"), forKey: "userName")
//                    objFav.setObject(myName, forKey: "myName")
//                    objFav.setObject(true, forKey: "favFlg")
//                    objFav.save(&saveError)
//                    
//                    
//                    // 画像の設定
//                    imageView.image = UIImage(named: "heart_like.png")
//                    // imageコレクション内のkawaiine数も更新
//                    let objImage: NCMBObject = NCMBObject(className: "image")
//                    objImage.objectId = objectIdOfImageInfo
//                    objImage.incrementKey("kawaiine",byAmount:1)
//                    targetFavData.incrementKey("kawaiine", byAmount: 1)
//                    objImage.save(&saveError)
                    self.favFlg = false
                    
                }
            }
            
            
        })
        
        
    }
    
    func updateFavData() {
        var objectIdOfImageInfo: String
        //        if (tabKindSign == "3") {
        //            objectIdOfImageInfo = targetFavData.objectForKey("imageObjectId")! as! String
        //        } else {
        objectIdOfImageInfo = imageCollectionObject!.objectForKey("objectId")! as! String
        //        }
        //        let objectIdOfImageInfo = targetFavData.objectForKey("objectId")!
        
        //        let imagePath = targetFavData.objectForKey("imagePath")!
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
//                        imageView.image = UIImage(named: "heart_unlike.png")
                        // imageコレクション内のkawaiine数も更新
                        
                        let objImage: NCMBObject = NCMBObject(className: "image")
                        objImage.objectId = objectIdOfImageInfo
                        objImage.fetchInBackgroundWithBlock({(error) in
                            var saveError: NSError? = nil
                            if (error == nil) {
                                objImage.incrementKey("kawaiine",byAmount: -1)
                                print(self.imageCollectionObject!.objectForKey("kawaiine"))
                                self.imageCollectionObject!.incrementKey("kawaiine", byAmount: -1)
                                self.favFlg = !self.favFlg
                                print(self.imageCollectionObject!.objectForKey("kawaiine"))
                                objImage.save(&saveError)
//                                targetFavData.incrementKey("kawaiine", byAmount: -1)
                            } else {
                                print("favFlgがtrue時のkawaiine保存時にエラーが発生しました: \(error)")
                            }
                        })
                        
                    } else {
//                        imageView.image = UIImage(named: "heart_like.png")
                        // imageコレクション内のkawaiine数も更新
                        let objImage: NCMBObject = NCMBObject(className: "image")
                        objImage.objectId = objectIdOfImageInfo
                        objImage.fetchInBackgroundWithBlock({(error) in
                            var saveError: NSError? = nil
                            if (error == nil) {
                                objImage.incrementKey("kawaiine",byAmount: 1)
                                self.imageCollectionObject!.incrementKey("kawaiine", byAmount: 1)
                                self.favFlg = !self.favFlg
//                                self.imageCollectionObject = nil
//                                targetFavData.incrementKey("kawaiine", byAmount: 1)
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
                    objFav.setObject(self.imageCollectionObject!.objectForKey("objectId"), forKey: "imageObjectId")
                    objFav.setObject(self.imageCollectionObject!.objectForKey("imagePath"), forKey: "imagePath")
                    objFav.setObject(self.imageCollectionObject!.objectForKey("userName"), forKey: "userName")
                    objFav.setObject(myName, forKey: "myName")
                    objFav.setObject(true, forKey: "favFlg")
                    objFav.save(&saveError)
                    
                    
                    // 画像の設定
//                    imageView.image = UIImage(named: "heart_like.png")
                    // imageコレクション内のkawaiine数も更新
                    let objImage: NCMBObject = NCMBObject(className: "image")
                    objImage.objectId = objectIdOfImageInfo
                    objImage.incrementKey("kawaiine",byAmount:1)
                    self.imageCollectionObject!.incrementKey("kawaiine", byAmount: 1)
                    self.favFlg = true
//                    targetFavData.incrementKey("kawaiine", byAmount: 1)
                    objImage.save(&saveError)
                    
                }
            }
            
            
        })

        
    }

}
