//
//  MyCollectionViewCell2.swift
//  NailApp_Refactoring
//
//  Created by DaichiSaito on 2016/06/06.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit

class MyCollectionViewCell2: UICollectionViewCell {
    
    @IBOutlet var nailImageView:UIImageView!
    @IBOutlet var checkImageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        image!.frame = self.contentView.frame
    }

}
