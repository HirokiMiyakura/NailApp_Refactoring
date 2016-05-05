//
//  DetailUserVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/02.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class DetailUserVM: NSObject {
    dynamic var profileInfo = []
    var userName: String?
    
    
    init(userName: String) {
        self.userName = userName
        
    }
    func loadProfileInfo() {
//        var dic: Dictionary<String, AnyObject>?
        let userQuery = NCMBUser.query()
        userQuery.whereKey("userName", equalTo: self.userName)
        userQuery.findObjectsInBackgroundWithBlock({(items, error) in
            
            if error == nil {
                print("登録件数：\(items.count)")
                // items.countは1か0しかない。
                if items.count > 0 {
                    
                    self.profileInfo = items
//                    let comment: String = ((items[0].objectForKey("comment") as? String))!
//                    let nickName: String = ((items[0].objectForKey("nickName") as? String))!
//                    let imagePath: String = ((items[0].objectForKey("imagePath") as? String))!
//                    self.ProfileComment.text = comment
//                    self.nickName.text = nickName
//                    
//                    let url = NSURL(string: imagePath)
//                    let placeholder = UIImage(named: "transparent.png")
//                    self.profileImage.setImageWithURL(url, placeholderImage: placeholder)
                    
                } else {
                    
                    
                }
            }
            
            
        })
//        return dic!
    }
    
//    func getProfileComment() -> Dictionary {
//        let userQuery = NCMBUser.query()
//        userQuery.whereKey("userName", equalTo: self.tmpUserName)
//        userQuery.findObjectsInBackgroundWithBlock({(items, error) in
//            
//            if error == nil {
//                print("登録件数：\(items.count)")
//                // items.countは1か0しかない。
//                if items.count > 0 {
//                    let comment: String = ((items[0].objectForKey("comment") as? String))!
//                    let nickName: String = ((items[0].objectForKey("nickName") as? String))!
//                    let imagePath: String = ((items[0].objectForKey("imagePath") as? String))!
//                    self.ProfileComment.text = comment
//                    self.nickName.text = nickName
//                    
//                    let url = NSURL(string: imagePath)
//                    let placeholder = UIImage(named: "transparent.png")
//                    self.profileImage.setImageWithURL(url, placeholderImage: placeholder)
//                    
//                } else {
//                    
//                    
//                }
//            }
//            
//            
//        })
//    }

}
