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
        imageObject.setObject(param1["typeLength"]!, forKey: "typeLength")
        imageObject.setObject(param1["typeColor"]!, forKey: "typeColor")
        imageObject.setObject(param1["typeScene"]!, forKey: "typeScene")
        imageObject.setObject(param1["typeGenre"]!, forKey: "typeGenre")
        imageObject.setObject(param1["typeTaste"]!, forKey: "typeTaste")
        imageObject.setObject(param1["typeDesign"]!, forKey: "typeDesign")
        
        imageObject.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
            print("イメージ情報更新完了")
            self.uploadDoneFlg = true
            
        })
    }
    
}
