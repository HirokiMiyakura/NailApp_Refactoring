//
//  EditProfileVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/04.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
//import NCMB

class EditImageDataVM: NSObject {
    
    dynamic var uploadDoneFlg = false
    func updateImageData(param1: Dictionary<String, AnyObject>) {
        
        let imageObject = NCMBObject(className: "image")
        
        imageObject.objectId = param1["objectId"] as? String
        imageObject.setObject(param1["textField"], forKey:"comment")
        
        imageObject.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
            print("イメージ情報更新完了")
            self.uploadDoneFlg = true
            
        })
    }
    
}