//
//  DetailVM.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/05/01.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class DetailVM: NSObject {
    var imageCollectionObject: NCMBObject?
    
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
    
    func setImage(detailImage: UIImageView) {
        
        let url = NSURL(string: (self.imageCollectionObject!.objectForKey("imagePath") as? String)!)
        let placeholder = UIImage(named: "transparent.png")
        detailImage.setImageWithURL(url, placeholderImage: placeholder)
        detailImage.frame = CGRectZero

        let imageHeight = detailImage.image!.size.height*screenWidth/detailImage.image!.size.width
        detailImage.frame = CGRectMake(0, 0, screenWidth, imageHeight)

        
    }
    
    func getNailistName() -> String {
        return (self.imageCollectionObject!.objectForKey("userName") as? String!)!
    }
}
